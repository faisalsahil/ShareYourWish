jQuery ->
  jQuery(".popup_large a").click (event) ->
    w = window.open(jQuery(this).attr("data-picture-medium"), "popUp", "width=600,height=600,top=200,left=300")
    w.onload = () ->  
      jQuery('body',w.document).append('<center><input type="button" value="Close" onclick="javascript:self.close()"/></center>')
    w.focus()
    event.preventDefault()
