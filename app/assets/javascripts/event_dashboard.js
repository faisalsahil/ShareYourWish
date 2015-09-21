
jQuery(function() {

	jQuery("#form#create_or_update_guest").validate({
		onkeyup : false,
		onkeydown : false,
		onclick : true
	});

	// Guests
	jQuery('#add_guest_field').click(function() {
		jQuery('#shown_guests').prepend(jQuery('#guests_inputs_template #create_or_update_guest').clone(true));
	});

	var create_update_guest = function(element, target) {
		var form = jQuery(element).parents('form#create_or_update_guest')
		if (jQuery(form).valid()) {
			jQuery.ajax({
				url : jQuery(form).attr('action'),
				type : 'PUT',
				data : jQuery(form).serialize(),
				success : function(data) {
					if (target && data.guest.id) {
						jQuery(target).load('/guests/' + data.guest.id + '?dashboard=1', function() { enable_qtip() });
					}
				},
				error : function(response) {
					var r = jQuery.parseJSON(response.responseText);
					jQuery('.guests_error').html('');
					for (var i in r) {
						if (form.find('#guest_' + i).length)
							form.find('#guest_' + i).after('<label for="guest_' + i + '" generated="true" class="error">' + r[i] + '</label>');
						else {
							jQuery('.guests_error').append(r[i] + ' <br />').addClass('error')
							jQuery('html, body').animate({
								scrollTop : $(".guests_error").offset().top
							}, 1000);
						}
					}
				}
			});
		}
	}

	jQuery('#dashboard_guests_actions #remove_from_list_button').click(function() {
		jQuery('#dashboard_guests_list #select_guest:checked').each(function() {
			create_update_guest(this);
			var form = jQuery(this).parents('form#create_or_update_guest');
			jQuery(this).removeAttr('checked')
			jQuery(form).find('#guest_restore, #guest_hide').removeAttr('checked')
			jQuery('#hidden_guests').append(form)
			jQuery(form).find('.guest-table').toggleClass('hidden');
		})
		jQuery('#dashboard_guests_actions #guests_bucket_button').addClass('full')
		return false;
	})

	jQuery('form#create_or_update_guest a#guests_save_button').live('click', function() {
		var form = jQuery(this).parents('form#create_or_update_guest');
		create_update_guest(this, form);
	});
	
	jQuery('form#create_or_update_guest input, form#create_or_update_guest select').live('change', function() {
		var form = jQuery(this).parents('form#create_or_update_guest');
		var guests_save_button = form.find('#guests_save_button');
		if(!guests_save_button.hasClass('dirty'))
			guests_save_button.addClass('dirty')
	});

	jQuery('form#create_or_update_guest a#guests_close_button').live('click', function() {
		// pretty sure this has been, or at least it should be, totally replaced by library functions format_name etc
		var names = [], names_string = '', form = jQuery(this).parents('form#create_or_update_guest');
		form.find('.child_name').each(function() {
			if (jQuery(this).val().length) {
				names.push(jQuery(this).val())
			}
		})
		switch (names.length) {
			case 0:
				names_string = ''
				break
			case 1:
				names_string = names.pop()
				break
			default:
				last = names.pop();
				names_string = names.join(', ') + " and " + last
		}
		form.find('.guests-children-names').html(names_string)
	});

	jQuery('form#create_or_update_guest a#guests_cancel_button').live('click', function() {
		var form = jQuery(this).parents('form#create_or_update_guest');
		var guest_id = jQuery(form).find('#select_guest').val();
		if (guest_id == undefined)
			jQuery(form).remove();
		else
			jQuery(form).load('/guests/' + guest_id + '?dashboard=1', function() { enable_qtip() });
	});

	jQuery('form#create_or_update_guest a#enable_guest_edit').live('click', function() {
		var form = jQuery(this).parents('form#create_or_update_guest');
		var guest_id = jQuery(form).find('#select_guest').val();
		jQuery.ajax({
			url : '/guests/' + guest_id + '/edit',
			success : function(data) {
				jQuery(form).replaceWith(data);
				enable_qtip();
			},
			cache : false,
			dataType : 'html'
		});
	});

	jQuery('form#create_or_update_guest #guest_restore').live('change', function() {
		var form = jQuery(this).parents('form#create_or_update_guest');
		jQuery(form).find('#guest_restore, #guest_hide').removeAttr('checked')
		jQuery('#shown_guests').append(form)
		jQuery(form).find('.guest-table').toggleClass('hidden');
		create_update_guest(this);
		if (is_guests_bucket_empty()) {
			jQuery('#guests-hidden-container').addClass('hidden');
			jQuery('#dashboard_guests_actions #guests_bucket_button').removeClass('full')
		}
	});

	var is_guests_bucket_empty = function() {
		return jQuery('#guests-hidden-container #hidden_guests form.edit_guest').length == 0
	}

	jQuery('form#create_or_update_guest #guest_delete').live('click', function() {
		var form = jQuery(this).parents('form#create_or_update_guest');
		jQuery.ajax({
			url : jQuery(form).attr('action') + '.json',
			type : 'DELETE',
			data : jQuery(form).serialize(),
			success : function(data) {
				form.detach();
				if (is_guests_bucket_empty()) {
					jQuery('#guests-hidden-container').addClass('hidden');
					jQuery('#dashboard_guests_actions #guests_bucket_button').removeClass('full')
				}
			},
			error : function(request, status, error) {
				var r = jQuery.parseJSON(request.responseText);
				if (r.contribution) {
					form.find('#guest_delete').replaceWith('<label for="guest_delete" generated="true" class="error">' + r.contribution + '</label><br/>');
				}
			},
			dataType : 'json'
		});

	});

	jQuery('#guests_button_clicker').click(function() {
		jQuery('#guests_button').click();
		jQuery('html, body').animate({
			scrollTop : jQuery('#syw-logo').offset().top
		}, 500);
	});
	
	jQuery('#invitation_types input:radio').click(function() {
		var invitation_type = jQuery('input:radio[name=invitation_type]:checked').val();
		if(invitation_type == 'custom')
			jQuery('#show_invitations_popup_button').text('Create Email')
		else
			jQuery('#show_invitations_popup_button').text('Preview Email(s)')
	})

	jQuery('#send_invitations_button').click(function() {
		var valid = true;
		var invitation_type = jQuery('input:radio[name=invitation_type]:checked').val();
		var guests_count = jQuery('#dashboard_guests_list #select_guest:checked').length;
		if (invitation_type == 'custom')
			valid = jQuery('form#guest_mailer_custom_form').valid()
		if (valid)
			jQuery('.mixed_popup').togglePopup();
		if (guests_count && valid) {
			jQuery('#dashboard_guests_list #select_guest:checked').each(function() {
				var form = jQuery(this).parents('form#create_or_update_guest');
				jQuery(this).removeAttr('checked')
				var guests_status = jQuery(form).find('.guests-status-smaller');
				guests_status.find('.response').text('Sending invitations...').show()
				var data = {};
				if (invitation_type == 'custom') {
					data = {
						id : jQuery(this).val(),
						subject : jQuery('form#guest_mailer_custom_form #subject').val().strip_tags(),
						title : jQuery('form#guest_mailer_custom_form #title').val().strip_tags(),
						body : jQuery('form#guest_mailer_custom_form #body').val().strip_tags()
					}
				}
				jQuery.post('/guests/' + jQuery(this).val() + '/' + invitation_type + '.json', data).success(function() {
					guests_status.find('.response').text('Success!')
				}).error(function() {
					guests_status.find('.response').text('An error occurred')
				})
			})
			reset_email_preview();
		} else {
			jQuery('#guest_mailer_back_button').click();
		}
	})
	var reset_email_preview = function() {
		jQuery('form#guest_mailer_custom_form').reset();
		jQuery('#guest_mailer_form_container').css('margin-left', '0');
		jQuery('#guest_mailer_back_button').hide();
		jQuery('#guest_mailer_preview_button').show();
	}

	jQuery('#cancel_send_email_button').click(function() {
		jQuery('.mixed_popup').togglePopup();
		reset_email_preview();
	});

	jQuery('#show_invitations_popup_button').click(function() {
		jQuery('#guest_mailer_form_container').hide();
		var guests_count = jQuery('#dashboard_guests_list #select_guest:checked').length;
		if (guests_count) {
			jQuery('#frame #guests_quantity_for_send').html(guests_count)
			var guest_id = jQuery('#dashboard_guests_list #select_guest:checked').eq(0).val()
			var invitation_type = jQuery('input:radio[name=invitation_type]:checked').val();
			jQuery('#popup_container').load('/guest_mailer/' + invitation_type + '/' + guest_id)
			if (invitation_type == 'custom')
				jQuery('#guest_mailer_form_container').show();
			jQuery('.mixed_popup').togglePopup()
		} else {
			alert('Please select one or more Guests first');
		}
	})

	jQuery('#guest_mailer_preview_button').click(function() {
		jQuery('#guest_mailer_form_container').animate({ 
			'margin-left' : '-=570',
		}, 500);
		jQuery('#guest_mailer_back_button').show();
	})

	jQuery('#guest_mailer_back_button').click(function() {
		jQuery('#guest_mailer_form_container').animate({
			'margin-left' : '+=570',
		}, 500);
		jQuery(this).hide();
	})

	jQuery('form#guest_mailer_custom_form #title, form#guest_mailer_custom_form #body').change(function() {
		jQuery('#popup_container #custom_message_' + jQuery(this).attr('id')).html(jQuery(this).val().strip_tags().nl2br());
	})
	// children
	jQuery('.add_remove_kids_link').live('click', function() {
		var form = jQuery(this).parents('form#create_or_update_guest');
		jQuery(form).find('.guest_children').toggleClass('hidden');
	})
	// messages
	enable_qtip();
});

var enable_qtip = function(){
	jQuery('.message-tip').qtip("destroy");
	jQuery('.message-tip').qtip({
		style : { classes : 'ui-tooltip-rounded ui-tooltip-shadow'}
	})
}
