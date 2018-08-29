App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    alert 'connected'

  disconnected: ->
    alert 'disconnected'

  received: (data) ->
    # do you screen update stuff here