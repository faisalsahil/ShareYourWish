# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  jQuery("form#visitor_entrance").submit ->
    if jQuery(this).valid()
      jQuery("#guest_submit_button").attr('disabled','disabled')
      jQuery(this).addClass('loading')
      true 
    else
      false
