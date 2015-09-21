# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  jQuery("form#create_or_update_guest .invited #delete_guest_children_link").live 'click', ->
    if confirm 'About to delete this child. This cannot be undone. Continue?'
      fields_for_child = ($ @).parents('.fields_for_child')
      jQuery.ajax(
        url: ($ @).data('url')+ '.json',
        type: 'DELETE'
        success: (response) ->
          fields_for_child.remove()
      )
    false
  jQuery("form#create_or_update_guest #add_new_guest_child_link").live 'click', ->
    form = ($ @).parents('form#create_or_update_guest')
    index = form.find('.fields_for_child').length
    new_child_template = jQuery('#new_child_template').html()
    ($ @).before(new_child_template)
    new_child_template = new_child_template.replace(new RegExp('attributes_'+(index-1)+'_','g'), 'attributes_'+index+'_')
    new_child_template = new_child_template.replace(new RegExp('attributes\\]\\['+(index-1)+'\\]','g'), 'attributes]['+index+']')
    jQuery('#new_child_template').html(new_child_template)
    false

