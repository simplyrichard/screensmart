{ div, i, p, a, button, span } = React.DOM

@Outcome = React.createClass
  displayName: 'Outcome'

  mixins: [ScrollToOnMountMixin]

  propTypes: ->
    response: React.PropTypes.object.isRequired

  onFinishClick: ->
    { dispatch } = Screensmart.store
    dispatch Screensmart.Actions.finishResponse(@props.response.uuid)

  render: ->
    { estimate, variance, finished } = @props.response

    div
      className: 'outcome'
      if finished
        [
          p
            key: 'thanks'
            [
              i
                className: 'fa fa-2x fa-check'
                key: 'check'
              span
                key: 'thanks'
                'Bedankt voor het invullen. De uitslag van de test is verstuurd naar uw behandelaar.'
            ]
          p
            key: 'estimate-variance'
            "Estimate: #{estimate}, variance: #{variance}"
        ]
      else
        [
          p
            key: 'instructions'
            'U kunt de invulling afronden of uw antwoorden aanpassen'
          button
            type: 'submit'
            key: 'button'
            onClick: @onFinishClick
            'Afronden'
        ]
