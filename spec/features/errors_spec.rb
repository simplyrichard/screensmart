describe 'Error reporting' do
  context 'Internal server error' do
    def cause_internal_server_error
      allow_any_instance_of(ResponsesController).to receive(:create) do
        raise 'internal server error'
      end
      visit '/'
      page.execute_script("$.post('/responses')")
    end

    it 'reports the error to Appsignal' do
      pending 'figure out how to assert Appsignal was called'
    end

    it 'shows the error to the user' do
      expect { cause_internal_server_error }.to raise_error Capybara::Poltergeist::JavascriptError
      expect(page).to have_content 'Onbekende fout. Mail naar support@roqua.nl voor hulp'
    end
  end

  context 'javascript error' do
    it 'shows the error to the user' do
      visit '/'
      page.execute_script("$.post('/resposes', { answer_values: { 'invalid key': 1 } })")
      expect(page).to have_content 'Er ging wat mis bij het verwerken van uw antwoord'
    end
  end
end
