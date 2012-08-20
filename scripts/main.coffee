---
---
$(document).ready =>
  ## messages ##
  messages = $('.message-bar h1')
  randomMessageIndex = Math.floor(Math.random() * messages.length)
  messages.each (index) ->
    if index isnt randomMessageIndex
      $(@).hide()
