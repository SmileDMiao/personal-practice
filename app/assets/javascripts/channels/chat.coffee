App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
# Called when the subscription is ready for use on the server

  disconnected: ->
# Called when the subscription has been terminated by the server

  received: (data) ->
    $('#chats').append data['message']
# Called when there's incoming data on the websocket for this channel

  speak: (message) ->
    @perform 'speak', message: message

$(document).on 'keypress', '[data-behavior~=chat_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    App.chat.speak {'message':event.target.value, 'send_user_id': App.current_user_id, 'receive_user_id': App.receive_user_id}
    event.target.value = ""
    event.preventDefault()