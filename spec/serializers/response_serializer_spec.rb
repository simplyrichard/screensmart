describe ResponseSerializer, vcr: { cassette_name: 'screensmart', allow_playback_repeats: true,
                                    match_requests_on: [:body, :uri, :method] } do
  subject do
    response = Response.new(answers: { 'EL02' => 1 }, old_estimate: 1.0, old_variance: 0.5)
    JSON.parse(ResponseSerializer.new(response).to_json)['response']
  end

  it 'includes id and next_question' do
    expect(subject).to eq({
      estimate: 0.7,
      variance: 0.6,
      questions: [
        {
          key: 'EL02',
          text: 'De tijd lijkt onnatuurlijk veel sneller of langzamer te gaan dan anders.',
          answer_option_set: [
            {
              value: 0,
              text: 'Oneens'
            },
            {
              value: 1,
              text: 'Eens'
            }
          ],
          answer: 1
        },
        {
          key: 'EL03',
          text: 'Vraag 3',
          answer_option_set: [
            {
              value: 0,
              text: 'Oneens'
            },
            {
              value: 1,
              text: 'Eens'
            }
          ]
        }
      ]
    }.with_indifferent_access)
  end
end
