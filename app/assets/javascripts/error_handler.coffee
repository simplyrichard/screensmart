email = 'support@roqua.nl'
message = "Onbekende fout. Mail naar <a href='#{email}'>#{email}</a> voor hulp"

applicationInitialized = ->
  Screensmart? && typeof Screensmart.store?.dispatch == 'function'

showUnknownError = ->
  # Show error in a primitive way if something went wrong during initialization
  if applicationInitialized()
    Screensmart.store.dispatch Screensmart.Actions.addMessage message
  else
    document.body.innerHTML = message

window.onerror = (_message, _filename, _lineno, _colno, error) ->
  showUnknownError()
  appsignal.sendError(error) if error && window.environment != 'development'

# Global jQuery AJAX error handler
$(document).ajaxError (event, xhr, settings, error ) ->
  { method, url } = settings
  { status } = xhr
  throw new Error "#{method} #{url} failed: #{status} #{error}. settings: #{JSON.stringify(settings, null, '\t')}"
