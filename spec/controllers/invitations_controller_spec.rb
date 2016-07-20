describe InvitationsController do
  describe '#create' do
    let(:valid_params) do
      {
        respondent_email: 'test@example.com',
        requester_email: 'test2@example.com',
        domain_ids: ['POS-PQ']
      }
    end

    context 'with valid params' do
      subject { post :create, valid_params }
      it 'returns status created' do
        subject
        expect(response.status).to eq 201
      end

      it 'creates the invitation_sent event' do
        expect { subject }.to change { Events::InvitationSent.count }.by(1)
      end

      it 'sends the email' do
        expect(InvitationMailer).to receive(:invitation_email).and_call_original
        subject
      end
    end

    context 'missing params' do
      it 'returns status bad request' do
        post :create, {}
        expect(response.status).to eq 400
      end
    end
  end

  describe '#accept' do
    let(:invitation_sent) do
      SendInvitation.run! respondent_email: 'some@respondent.dev',
                          requester_email: 'some@doctor.dev',
                          domain_ids: ['POS-PQ']
    end

    subject { post :accept, invitation_uuid: invitation_sent.invitation_uuid }

    it 'calls AcceptInvitation' do
      expect(AcceptInvitation).to receive(:run!).with(invitation_uuid: invitation_sent.invitation_uuid)
      subject
    end

    it 'redirects to the newly created response\'s ID'
  end
end
