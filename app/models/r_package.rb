# Only module that should communicate with screensmart-r
module RPackage
  def self.questions
    call('get_itembank_rdata')
  end

  def self.data_for(raw_answers, estimate, variance)
    # TODO: find a way to call OpenCPU with responses: [{}]
    answers = {}
    raw_answers.each do |key, value|
      answers[key] = value.to_i
    end

    Rails.logger.debug "call_shadowcat(responses=#{answers}, estimate=#{estimate}, variance=#{variance}"
    raw_data = if answers.any?
                 call('call_shadowcat', responses: [answers], estimate: estimate, variance: variance)
               else
                 call('call_shadowcat', responses: [], estimate: estimate, variance: variance)
               end

    {
      next_question_key: raw_data['key_new_item'],
      estimate: raw_data['estimate'][0],
      variance: raw_data['variance'][0]
    }
  end

  def self.call(function, parameters = {})
    OpenCPU.client.execute('screensmart', function, user: :system, data: parameters, convert_na_to_nil: true)
  end
end
