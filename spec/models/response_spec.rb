describe Response, vcr: { cassette_name: 'screensmart', allow_playback_repeats: true } do
  let(:response) { Response.new }

  def r(args)
    Response.new(args)
  end

  describe '#next_question' do
    it 'returns the next question from opencpu' do
      expect(response.next_question.key).to eq 'EL02'
    end
  end

  describe 'validations' do
    describe 'old_estimate' do
      it 'must be a float' do
        expect(r(old_estimate: 'a')).to have(2).errors_on :old_estimate
      end

      it 'must be between -1.0 and 1.0' do
        expect(r(old_estimate: -1.1)).to have(1).errors_on :old_estimate
      end
    end

    describe 'old_variance' do
      it 'must be a float' do
        expect(r(old_variance: 'a')).to have(2).errors_on :old_variance
      end

      it 'must be between 0 and 1.0' do
        expect(r(old_estimate: 1.1)).to have(1).errors_on :old_estimate
      end
    end

    describe 'answers' do
      it 'must have all integer values' do
        expect(r(answers: { 'EL02' => '1.0' })).to have(1).errors_on :answers
      end
    end
  end
end
