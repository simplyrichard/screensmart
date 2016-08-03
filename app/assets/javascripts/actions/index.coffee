{ routerActions } = ReactRouterRedux

Screensmart.Actions =
  fetchDomains: ->
    (dispatch) =>
      $.getJSON('/domains').then (data) =>
        dispatch @receiveDomains(data)

  receiveDomains: (data) ->
    type: 'RECEIVE_DOMAINS'
    domains: data.domains

  sendInvitation: (enteredValues) ->
    (dispatch) =>
      $.postJSON('/invitations', enteredValues).then =>
        dispatch @finishInvitationSend()

  finishInvitationSend: ->
    type: 'INVITATION_SENT'

  addMessage: (message) ->
    type: 'ADD_MESSAGE'
    message: message

  setAnswer: (id, value) ->
    (dispatch) =>
      dispatch @_setAnswer(id, value)
      dispatch @postAnswer(id, value)

  _setAnswer: (id, value) ->
    type: 'SET_ANSWER'
    id: id
    value: value

  createResponse: (invitationUUID) ->
    (dispatch) =>
      dispatch @startResponseUpdate()
      $.postJSON("/responses", {invitationUUID}).then (data) =>
        dispatch @receiveResponseUpdate(data)

  postAnswer: (questionId, answerValue) ->
    (dispatch, getState) =>
      response = getState().response
      dispatch @startResponseUpdate()
      $.postJSON '/answers',
        responseUUID: response.uuid
        questionId: questionId,
        answerValue: answerValue
      .then (data) =>
        dispatch @receiveResponseUpdate(data)

  setResponseUUID: (responseUUID) ->
    type: 'SET_RESPONSE_UUID'
    uuid: responseUUID

  resetQuestions: ->
    type: 'RESET_QUESTIONS'

  startResponseUpdate: ->
    type: 'START_RESPONSE_UPDATE'

  receiveResponseUpdate: (data) ->
    type: 'RECEIVE_RESPONSE_UPDATE'
    response: data.response

  finishResponse: (responseUUID) ->
    (dispatch) =>
      dispatch @startFinishResponse()
      $.putJSON("/responses/#{responseUUID}").then (data) =>
        dispatch @receiveFinishResponse(data)
        dispatch routerActions.push('/') #  Return to home page

  startFinishResponse: ->
    type: 'START_FINISH_RESPONSE'

  receiveFinishResponse: (data) ->
    type: 'RECEIVE_FINISH_RESPONSE'
    response: data
