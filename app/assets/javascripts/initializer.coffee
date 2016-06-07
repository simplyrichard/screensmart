window.Screensmart = {}

# Global jQuery configuration
$.ajaxSetup
  headers:
    'X-CSRF-Token': window.csrfToken
  contentType: 'application/json'
  dataType: 'json'
