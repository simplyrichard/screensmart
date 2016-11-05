describe StartAdhocResponse do
  let(:params) { { domain_ids: ['POS-PQ'] } }

  subject { described_class.run(params) }

  context 'with valid parameters' do
    it 'creates an AdhocResponseStarted event' do
      expect { subject }.to change { Events::AdhocResponseStarted.count }.by 1
    end

    it 'returns the created event' do
      expect(subject.result).to be_kind_of Events::AdhocResponseStarted
    end
  end

  context 'domain is invalid' do
    it 'has an error when an unknown domain is given' do
      params[:domain_ids] = ['whatever']
      expect(subject).to have(1).errors_on(:domain_ids)
    end

    it 'has an error when domain_ids is empty' do
      params[:domain_ids] = []
      expect(subject).to have(1).errors_on(:domain_ids)
    end
  end
end
