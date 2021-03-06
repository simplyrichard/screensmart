describe ResponseSerializer do
  let(:invitation_accepted) { Fabricate :invitation_accepted }

  subject do
    response = Response.find(invitation_accepted.response_uuid)
    Events::AnswerSet.create! response_uuid: response.uuid,
                              question_id: 'EL02',
                              answer_value: 2

    JSON.parse(ResponseSerializer.new(response).to_json)['response']
  end

  def pretty(json)
    JSON.pretty_generate(json)
  end

  it 'includes estimate, variance and questions' do
    expect(pretty(subject)).to eq(pretty({
      uuid: invitation_accepted.response_uuid,
      created_at: invitation_accepted.created_at.iso8601,
      estimate: 0.7,
      variance: 0.6,
      done: false,
      questions: [{
        id: 'EL02',
        text: 'Vraag 1',
        intro: 'Geef a.u.b. antwoord voor de afgelopen 7 dagen.',
        answer_value: 2,
        answer_option_set: {
          id: 2,
          answer_options: [
            {
              id: 1,
              text: 'Oneens'
            },
            {
              id: 2,
              text: 'Eens'
            }
          ]
        }
      }, {
        id: 'EL03',
        text: 'Vraag 2',
        intro: '',
        answer_value: nil,
        answer_option_set: {
          id: 2,
          answer_options: [
            {
              id: 1,
              text: 'Oneens'
            },
            {
              id: 2,
              text: 'Eens'
            }
          ]
        }
      }
      ]
    }.with_indifferent_access))
  end
end
