class @Appsignal
  constructor: ->
    @action = null
    @tags   = {}

  set_action: (action) ->
    @action = action

  tag_request: (tags) ->
    for key in tags
      @tags[key] = tags[key]

  sendError: (error) ->
    data = {
      action:    @action
      message:   error.message
      name:      error.name
      backtrace: error.stack.split("\n")
      path:      window.location.pathname
      tags:      @tags
      environment: {
        agent:         navigator.userAgent
        platform:      navigator.platform
        vendor:        navigator.vendor
        screen_width:  screen.width
        screen_height: screen.height
      }
    }

    xhr = new XMLHttpRequest()
    xhr.open('POST', '/appsignal_error_catcher', true)
    xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
    xhr.send(JSON.stringify(data))

appsignal        = new Appsignal
window.appsignal = appsignal

email = 'support@roqua.nl'
message = "Onbekende fout. Mail naar <a href='#{email}'>#{email}</a> voor hulp"

applicationInitialized = ->
  Screensmart && typeof Screensmart.store?.dispatch == 'function'

showUnknownError = ->
  # Show error in a primitive way if something went wrong during initialization
  if applicationInitialized()
    Screensmart.store.dispatch Screensmart.Actions.addMessage message
  else
    document.body.innerHTML = message

window.onerror = (_message, _filename, _lineno, _colno, error) ->
  showUnknownError()
  appsignal.sendError(error) if error
