describe Question, vcr: { cassette_name: 'screensmart', allow_playback_repeats: true } do
  let(:questions) { described_class.all }
  let(:question) { questions.first }

  describe '.all' do
    it 'returns parsed questions for all domains' do
      expect(question).to be_a Question
      expect(question.key).to eq 'EL02'
      expect(question.text).to eq 'De tijd lijkt onnatuurlijk veel sneller of langzamer te gaan dan anders.'
    end

    it 'parses the answer\'s option set' do
      answer_option_set = question.answer_option_set
      expect(answer_option_set).to be_a AnswerOptionSet
      expect(answer_option_set.id).to eq 2
    end

    it 'parses the options in the answer option set' do
      answer_option = question.answer_option_set.first
      expect(answer_option).to be_a AnswerOption
      expect(answer_option.value).to eq 0
      expect(answer_option.text).to eq 'Oneens'
    end
  end

  describe '.find_by_key' do
    it 'finds a question by key' do
      expect(described_class.find_by_key('EL02')).to be_a Question
    end

    it 'raises an exception when the key is not found' do
      expect { described_class.find_by_key('bananentaart') }.to raise_exception 'question `bananentaart` not found'
    end
  end
end
