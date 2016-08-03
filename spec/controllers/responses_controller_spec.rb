describe ResponsesController do
  let!(:invitation_sent) do
    SendInvitation.run! requester_email: 'some@doctor.dev',
                        respondent_email: 'some@patient.dev',
                        domain_ids: ['POS-PQ']
  end

  describe '#create' do
    subject { post :create, invitation_uuid: invitation_sent.invitation_uuid }

    it 'accepts the invitation' do
      expect { subject }.to change { Events::InvitationAccepted.count }.by 1
    end
  end

  describe '#show' do
    let!(:invitation_accepted) do
      AcceptInvitation.run! invitation_uuid: invitation_sent.invitation_uuid
    end

    subject { get :show, id: invitation_accepted.response_uuid }

    it 'renders the response as JSON' do
      subject
      model = Response.find invitation_accepted.response_uuid
      expect(response.body).to eq ResponseSerializer.new(model).as_json.to_json
    end
  end

  describe '#update' do
    let!(:invitation_accepted) do
      AcceptInvitation.run! invitation_uuid: invitation_sent.invitation_uuid
    end

    subject { put :update, id: invitation_accepted.response_uuid }

    it 'finishes the response' do
      expect { subject }.to change { Events::ResponseFinished.count }.by 1
    end
  end
end
