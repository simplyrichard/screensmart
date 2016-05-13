describe 'answering questions' do
  def answer_question(index, answer)
    within(".item:nth-child(#{index}) .question") { find('.option', text: answer).click }
  end

  scenario 'answering a question' do
    visit '/'
    answer_question 1, 'Eens'
    expect(page).to have_content 'Vraag 2'
  end

  scenario 'changing a previously answered question' do
    visit '/'
    answer_question 1, 'Eens'
    expect(page).to have_content 'Vraag 2'

    byebug
    answer_question 1, 'Oneens'
    expect(page).to have_content 'Vraag 3'
  end
end
