# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  guests.initialize()

guests =
  initialize: ->
    @guest_attendance()
    @uninvited_children_form_handle()
  
  guests_save_button: ->
    ($ '.uninvited form#create_or_update_guest #guests_save_button')
  guests_cancel_button: ->
    ($ '.uninvited form#create_or_update_guest #guests_cancel_button')
  delete_guest_children_link: ->
    ($ '.uninvited form#create_or_update_guest #delete_guest_children_link')
  close_button: ->
    ($ '.uninvited .close_button')
  uninvited_children_form: ->
    ($ '.uninvited form#create_or_update_guest')
  uninvited_children_form_elements: -> 
    ($ 'form#create_or_update_guest input, form#create_or_update_guest select')
  
  close: -> 
    @close_button().click()
  confirm_reminder: ->
    jQuery.post(@uninvited_children_form().attr('action') + '/confirm_reminder.json')
  uninvited_children_form_handle: ->
    @guests_save_button().live "click", ->
      jQuery('.guests_error,.guests_notice').html('').addClass('hidden')
      form = jQuery(@).parents('form#create_or_update_guest')
      if form.valid()
        jQuery.ajax(
          url: jQuery(form).attr('action') + '.json',
          data: jQuery(form).serialize()
          dataType: "json"
          type: 'PUT'
          success: (response) ->
            if response.result
              _this.close()
              _this.confirm_reminder()
              jQuery('.guests_notice').text('Thanks! You\'ll receive an email reminder several weeks before the next birthday.').removeClass('hidden')
              jQuery.get jQuery(form).attr('action') + '/uninvited', (data) ->
                  jQuery('.guest_children.uninvited').replaceWith(data)
            else
              jQuery.map(response.errors, (error, property) ->
                jQuery('.guests_error').append(response.errors[property] + ' <br />').addClass('error')
              )
              jQuery('.guests_error').removeClass('hidden')
        )

    @uninvited_children_form_elements().live "change", =>
      jQuery('.guests_error,.guests_notice').html('').addClass('hidden')
      unless @guests_save_button().hasClass('dirty')
        @guests_save_button().addClass('dirty')

    @delete_guest_children_link().live "click", ->
      jQuery('.guests_error,.guests_notice').html('').addClass('hidden')
      fields_for_child = ($ @).parents('.fields_for_child')
      jQuery.ajax(
        url: ($ @).data('url') + '.json'
        type: 'DELETE'
        success: (data) ->
          fields_for_child.remove()
      )

    @guests_cancel_button().live "click", =>
      jQuery('.guests_error,.guests_notice').html('').addClass('hidden')
      @close()

  guest_attendance: ->
    jQuery("#radio").buttonset()
    jQuery("form.edit_guest .guest_attendance_button").click ->
      form = jQuery(this).parents("form.edit_guest")
      my_response = form.find('#my_response')
      message = form.find("#guest_message")
      form.find('#' + jQuery(this).attr('for')).attr('checked','checked')
      my_response.text(jQuery(this).text())  
      if message.val().length && guests.do_post_to_the_message_board(form)
        guests.post_to_the_message_board(message.val())
      form.submit()
      message.val('')
      alert('Thanks! Your RSVP has been sent to the Host and if you left a message it has been sent or posted. (You can change your RSVP at any time.)')
  # post_to_the_message_board?      
  do_post_to_the_message_board: (form) -> 
    form.find('input[name=message_type]:checked').val() == 'board'
  post_to_the_message_board: (message) -> 
    comment_content = guests.comment_form().find("#comment_content")
    button = guests.comment_form().find("#add_guest_comment")
    comment_content.val(message)
    button.click() 
  comment_form: ->
    ($ "form#new_comment")  
    
