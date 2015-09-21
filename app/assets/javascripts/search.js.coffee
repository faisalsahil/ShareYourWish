# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  jQuery("form#search_form").submit ->
    query = jQuery.trim(jQuery('#q').val()).strip_tags().replace(/(['"])/g,'')
    jQuery('#q').val(query)
    true

# search by magic phrase
  jQuery("form#magic_phrase_search_form").submit ->
    if jQuery(this).valid()
      true
    else
      false
      
  jQuery("form#magic_phrase_search_form").bind 'ajaxError', (event, request, settings) ->
    alert 'Search Error with Magic Phrase request.'
  jQuery("form#magic_phrase_search_form").bind 'ajaxSuccess', (event, request, settings) ->
    response =  jQuery.parseJSON(request.responseText);
    if response.url
      window.location.href = response.url
    else
      jQuery(".nav-magic_phrase-container_popup").removeClass('hidden')
      
  jQuery(".nav-magic_phrase-container_popup .close_magic_phrase_button").on 'click', (e) ->
    jQuery(".nav-magic_phrase-container_popup").addClass('hidden')
    e.stopPropagation()

  jQuery(document).on 'click', ->
    if jQuery(".nav-magic_phrase-container_popup").not('.hidden').length
      jQuery(".nav-magic_phrase-container_popup").addClass('hidden')

