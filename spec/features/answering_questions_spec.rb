describe 'answering questions' do
  def answer_question(index, answer)
    within ".question:nth-child(#{index})" do
      find('.option', text: answer).click
    end
  end

  def expect_last_question_to_be(text, intro_text = nil)
    within '.question:last-child' do
      expect(page).to have_content text
      expect(page).to have_content intro_text if intro_text
    end
  end

  def fill_out_url
    "/fillOut?invitationUUID=#{invitation_sent.invitation_uuid}"
  end

  let(:invitation_sent) do
    SendInvitation.run! requester_email: 'some@doctor.dev',
                        respondent_email: 'some@patient.dev',
                        domain_ids: ['POS-PQ']
  end

  before { visit fill_out_url }

  scenario 'initial intro text and answer text' do
    expect_last_question_to_be 'Vraag 1', 'Geef a.u.b. antwoord voor de afgelopen 7 dagen.'
  end

  scenario 'answering a question' do
    answer_question 1, 'Eens'
    expect_last_question_to_be 'Vraag 2'
  end

  scenario 'changing a previously answered question' do
    answer_question 1, 'Eens'
    expect_last_question_to_be 'Vraag 2'

    answer_question 1, 'Oneens'
    expect_last_question_to_be 'Vraag 3'
  end

  scenario 'starting over' do
    answer_question 1, 'Eens'
    expect_last_question_to_be 'Vraag 2'

    visit fill_out_url

    expect_last_question_to_be 'Vraag 1'
  end
end
