{ createFactory } = React
{ Route } = ReactRouter

setInvitationUUIDBasedOnQuery = (query) ->
  invitationUUID = query.invitationUUID
  if invitationUUID
    Screensmart.store.dispatch Screensmart.Actions.setInvitationUUID invitationUUID
  else
    throw new Error 'No invitationUUID provided in query'

Screensmart.routes =
  [
    createFactory(Route)
      path: '/fillOut'
      component: createFactory(FeedContainer)
      onEnter: (nextState) ->
        query = nextState.location.query
        setInvitationUUIDBasedOnQuery(query)
    createFactory(Route)
      path: '/'
      component: createFactory(InvitationFormContainer)
  ]
