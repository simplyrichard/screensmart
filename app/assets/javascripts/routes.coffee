{ createFactory } = React
{ Route } = ReactRouter

createResponse = (invitationUUID) ->
  if invitationUUID
    Screensmart.store.dispatch Screensmart.Actions.createResponse invitationUUID
  else
    throw new Error 'No invitationUUID provided in query'

Screensmart.routes =
  [
    createFactory(Route)
      path: '/fillOut'
      component: createFactory(FeedContainer)
      onEnter: (nextState) ->
        invitationUUID = nextState.location.query.invitationUUID
        createResponse(invitationUUID)
    createFactory(Route)
      path: '/'
      component: createFactory(InvitationFormContainer)
  ]
