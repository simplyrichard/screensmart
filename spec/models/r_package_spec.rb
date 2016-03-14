describe RPackage, vcr: { cassette_name: 'screensmart', allow_playback_repeats: true,
                          match_requests_on: [:body, :uri, :method] } do
  let(:described_module) { RPackage }

  describe '.data_for' do
    context 'with no answers' do
      it 'returns the first question, estimate and variance' do
        expect(described_module.data_for({}, 1.0, 0.5)).to eq \
          next_question_key: 'EL02',
          estimate: 1.0,
          variance: 0.5
      end
    end

    context 'with answers' do
      it 'returns a new next_question estimate and variance' do
        expect(described_module.data_for({ 'EL02' => '1' }, 1.0, 0.5)).to eq \
          next_question_key: 'EL03',
          estimate: 0.7,
          variance: 0.6
      end
    end
  end

  describe '.answers_for_r' do
    context 'with answers' do
      it 'converts answer keys to integers' do
        raw_answers = {
          'EL02' => '1',
          'EL03' => '0'
        }
        expect(described_module.answers_for_r(raw_answers)).to eq [
          'EL02' => 1,
          'EL03' => 0
        ]
      end
    end

    context 'with non-integer values' do
      it 'raises an exception' do
        expect { described_module.answers_for_r('EL02' => '1.0') }.to \
          raise_error 'answers keys must all be integer strings'
      end
    end

    context 'with no answers' do
      it 'returns an empty array' do
        expect(described_module.answers_for_r({})).to eq []
      end
    end
  end
end
