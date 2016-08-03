{ div, i, p, a } = React.DOM

@Outcome = React.createClass
  displayName: 'Outcome'

  mixins: [ScrollToOnMountMixin]

  propTypes: ->
    response: React.PropTypes.object.isRequired

  onFinishClick: ->
    { dispatch } = Screensmart.store
    dispatch Screensmart.Actions.finishResponse(@props.response.uuid)

  render: ->
    {estimate, variance} = @props.response

    div
      className: 'outcome'
      p
        className: ''
        'Bedankt voor het invullen.'
      p
        clasName: ''
        "Estimate: #{estimate}, variance: #{variance}"
      a
        className: ''
        onClick: @onFinishClick
        'Klaar'
