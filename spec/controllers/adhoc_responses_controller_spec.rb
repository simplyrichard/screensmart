describe AdhocResponsesController do
  describe '#create' do
    let(:domain_ids) { ['POS-PQ'] }
    let(:uuid) { 'c8d56681-03be-495e-a78d-472c84098e75' }

    subject { post :create, domain_ids: domain_ids }

    it 'starts the ad hoc response' do
      expect { subject }.to change { Events::AdhocResponseStarted.count }.by 1
    end

    it 'redirects to responses#show' do
      allow(SecureRandom).to receive(:uuid).and_return uuid
      expect(subject).to redirect_to "/responses/#{uuid}"
    end
  end
end
