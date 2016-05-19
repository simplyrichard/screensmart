describe 'Error reporting' do
  unknown_error = 'Onbekende fout. Mail naar support@roqua.nl voor hulp'
  context 'Internal server error' do
    def cause_internal_server_error
      allow_any_instance_of(ResponsesController).to receive(:create) do
        raise 'internal server error'
      end
      visit '/'
      page.execute_script("$.post('/responses')")
    end

    # it 'reports the error to Appsignal' do
    #   pending 'figure out how to assert Appsignal was called'
    # end

    it 'shows the error to the user' do
      expect { cause_internal_server_error }.to raise_error Capybara::Poltergeist::JavascriptError
      expect(page).to have_content unknown_error
    end
  end

  context 'javascript error' do
    it 'shows the error to the user' do
      def cause_javascript_error
        visit '/'
        page.execute_script "$.ajax('/responses', { data: { answer_values: { 'invalid key': 1 } },
                                                    method: 'POST',
                                                    async: false
                                                  })"
      end

      expect { cause_javascript_error }.to raise_error Capybara::Poltergeist::JavascriptError
      expect(page).to have_content unknown_error
    end
  end
end
