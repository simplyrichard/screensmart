describe AcceptInvitation do
  subject { described_class.run(params) }

  context 'with valid parameters' do
    let(:invitation_sent) do
      SendInvitation.run! respondent_email: 'some@respondent.dev',
                          requester_email: 'some@doctor.dev',
                          domain_ids: ['POS-PQ']
    end

    let(:params) { { invitation_uuid: invitation_sent.invitation_uuid } }
    it 'creates an InvitationAccepted event' do
      expect { subject }.to change { Events::InvitationAccepted.count }.by(1)
    end
  end

  context 'invitation_uuid is missing' do
    let(:params) { { invitation_uuid: '' } }
    it { is_expected.to have(1).errors_on :invitation_uuid }
  end
end
