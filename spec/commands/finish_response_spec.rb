describe FinishResponse do
  let!(:invitation_uuid) { SecureRandom.uuid }
  let!(:response_uuid) { SecureRandom.uuid }

  before do
    Events::InvitationSent.create!(
      invitation_uuid: invitation_uuid,
      requester_email: 'requester@example.dev',
      domain_ids: ['POS-PQ']
    )

    Events::InvitationAccepted.create!(
      invitation_uuid: invitation_uuid,
      response_uuid: response_uuid
    )
  end

  subject { described_class.run(params) }

  context 'with valid parameters' do
    let(:params) { { response_uuid: response_uuid } }

    it 'creates an ReponseFinished event ' do
      expect { subject }.to change { Events::ResponseFinished.count }.by(1)
    end
  end

  context 'with invalid parameters' do
    let(:params) { { response_uuid: response_uuid } }

    context 'response_uuid is invalid' do
      it 'has an error when uuid is missing' do
        params[:response_uuid] = ''
        expect(subject).to have(2).errors_on(:response_uuid)
      end

      it 'has an error when uuid is unkown' do
        params[:response_uuid] = 'FOOBAR'
        expect(subject).to have(1).errors_on(:response_uuid)
      end
    end
  end

  context 'when response is already finished' do
    let(:params) { { response_uuid: response_uuid } }

    before do
      Events::ResponseFinished.create!(
        invitation_uuid: invitation_uuid,
        response_uuid: response_uuid
      )
    end

    it 'does not create another ResponseFinished event' do
      expect(subject).to have(1).errors_on(:response_uuid)
    end
  end
end
