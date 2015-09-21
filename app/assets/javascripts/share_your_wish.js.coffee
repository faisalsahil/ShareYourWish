window.ShareYourWish =
  Models:
    {}
  Views:
    {}
  init: ->

$(document).ready(->
  ShareYourWish.init()
  initPopupLinks()
)

initUnderscoreString = () ->
  _.mixin(_.string.exports())
  _.mixin(
    includeString: _.str.include
    reverseString: _.str.reverse
  )
initUnderscoreString(_)


initPopupLinks = ->
  $("*[data-open-in-popup]").on("click", (event) ->
    event.preventDefault()
    el = $(this)
    openInPopup(el.attr("data-open-in-popup"), el.attr("href"))
  )

window.openInPopup = (dialogContId, url) ->
  dialogCont = $(dialogContId)
  iframe = dialogCont.find("iframe")
  iframe.attr("src", url) unless iframe.attr("src") == url
  dialogCont.dialog(
    modal: true
    width: 1080
    height: $(window).height() - 100
  )
