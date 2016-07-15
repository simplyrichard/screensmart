{div} = React.DOM

@FeedView = React.createClass
  displayName: 'FeedView'

  render: ->
    div
      className: "feed #{'done' if @props.done}"
      @props.children
