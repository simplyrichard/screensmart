class @Appsignal
  sendError: (error) ->
    data = {
      message:   error.message
      name:      error.name
      backtrace: error.stack.split("\n")
      path:      window.location.pathname
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
