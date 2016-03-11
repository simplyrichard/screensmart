describe Response, vcr: { cassette_name: 'screensmart', allow_playback_repeats: true } do
  let(:response) { Response.new }

  describe '#next_question' do
    it 'returns the next question from opencpu' do
      expect(response.next_question.key).to eq 'EL02'
    end
  end
end
