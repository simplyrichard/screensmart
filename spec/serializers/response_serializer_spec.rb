describe ResponseSerializer do
  subject do
    response = Response.new(answer_values: { 'EL02' => 1 })
    JSON.parse(ResponseSerializer.new(response).to_json)['response']
  end

  def pretty(json)
    JSON.pretty_generate(json)
  end

  it 'includes estimate, variance and questions' do
    expect(pretty(subject)).to eq(pretty({
      estimate: 0.7,
      variance: 0.6,
      done: false,
      questions: [{
        key: 'EL02',
        text: 'Vraag 1',
        answer_value: 1,
        answer_option_set: {
          id: 2,
          answer_options: [
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
      }, {
        key: 'EL03',
        text: 'Vraag 2',
        answer_value: nil,
        answer_option_set: {
          id: 2,
          answer_options: [
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
      }
      ]
    }.with_indifferent_access))
  end
end
