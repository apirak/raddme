# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
sendDataToServer = ($form) ->
  i = 0
  dataString = ''
  while i <= localStorage.length - 1
    dataString = localStorage.key(i)
    if dataString
      $.post $form.attr('action'), localStorage.getItem(dataString)
      localStorage.removeItem dataString
    else
      i++

saveDataLocally = (serializedData) ->
  if typeof (localStorage) is "undefined"
    alert "Your browser does not support offline mode"
  else
    newDate = new Date()
    itemId = newDate.getTime()
    try
        localStorage.setItem itemId, serializedData
      catch e
        alert "We can't store more data"  if e is QUOTA_EXCEEDED_ERR
  
$(document).ready ->
  $(window).bind "offline", ->
    $("#offline").show()
    $(".exchange > form").submit (e)->
      e.preventDefault()
      saveDataLocally($(this).serialize())

  $(window).bind "online", ->
    $("#offline").hide()
    $form = $(".exchange > form")
    $form.unbind()
    if localStorage.length > 0
      sendDataToServer($form)
  
  $("a.close").click ->
    $(this).parent().fadeOut()