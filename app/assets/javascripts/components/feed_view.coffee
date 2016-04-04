{div} = React.DOM

@FeedView = React.createClass
  displayName: 'FeedView'

  render: ->
    CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)

    div
      className: 'feed-wrapper'
      div
        className: 'feed'
        CSSTransitionGroup
          transitionName: 'item'
          transitionEnterTimeout: 0
          transitionLeaveTimeout: 0.001
          @props.children.map (child) ->
            div
              key: child.key
              className: 'item'
              child
