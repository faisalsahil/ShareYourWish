jQuery ->
  jQuery(".help_message_container a.help_message_show_link").on 'click', (e) ->
    jQuery(this).parents('.help_message_container').find('.help_message_text').toggleClass 'hidden'
    e.stopPropagation()
    
  jQuery(".help_message_container a.help_message_ajax_show_link").on 'click', (e) ->
    element = jQuery(this).parents('.help_message_container').find('.help_message_text')
    jQuery(element.find('.help_message_target')).load("/help_messages/code/#{jQuery(this).data('code')}")
    element.toggleClass 'hidden'
    e.stopPropagation()

jQuery(document).on 'click', ->
  jQuery('.help_message_text').not('.hidden').each ->
    jQuery(this).addClass 'hidden'
