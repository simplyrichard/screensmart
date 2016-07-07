@ScrollToOnMountMixin =
  componentDidMount: ->
    $('body').animate scrollTop: @positionInPage() - @marginTop(), 700

  positionInPage: ->
    parseFloat @jQueryElement().offset().top

  marginTop: ->
    parseFloat @jQueryElement().css('margin-top').replace('px', '')

  jQueryElement: ->
    $(ReactDOM.findDOMNode(this))
