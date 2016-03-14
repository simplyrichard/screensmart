# Only module that should communicate with screensmart-r
module RPackage
  def self.questions
    call('get_itembank_rdata')
  end

  def self.data_for(raw_answers, estimate, variance)
    raw_data = call('call_shadowcat', responses: answers_for_r(raw_answers), estimate: estimate, variance: variance)

    {
      next_question_key: raw_data['key_new_item'],
      estimate: raw_data['estimate'][0],
      variance: raw_data['variance'][0]
    }
  end

  def self.answers_for_r(raw_answers)
    answers = {}
    raw_answers.each do |key, value|
      answers[key] = value.to_i
    end

    # TODO: find a way to call OpenCPU with responses: [{}]
    answers.present? ? [answers] : []
  end

  def self.call(function, parameters = {})
    Rails.logger.debug "Calling OpenCPU: #{function}(#{parameters})"
    OpenCPU.client.execute('screensmart', function, user: :system, data: parameters, convert_na_to_nil: true)
  end
end
