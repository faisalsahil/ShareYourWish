jQuery(function() {
	
	// Change this if possible... the last step has its own form submit handler, unlike the others which use a shared hander in events.js
	var save_publish_event_form = function(){
		var event_id = jQuery('#event_id').val();
		var data = jQuery('#publish_event').serialize();
		var cart_empty = parseInt(jQuery("form#new_order #order_subtotal").val()) == 0;
		if(cart_empty)
			data += '&event[status]=published'
		jQuery.ajax({
			url : jQuery('#publish_event').attr('action'),
			type : 'PUT',
			data : data,
			async : false,
			success : function(response) {
				if(cart_empty){
					jQuery.cookie("tab_cookie", null)
					window.location.href = '/events/' + event_id + '/dashboard'
				}
				else
				{
					jQuery('#order_form_container, input.checkout').show()
					jQuery('input.publish').hide()
				}
			},
			error : function(response) { handle_errors(response) }
		});
	}

	// This step does not use the event_submit_button or handle_form_errors from events.js 
	// TO-DO: We want to (a) validate all forms on all steps (b) indicate errors in-line on those pages (c) change step status to an error icon
	// We can do (a) but we are not able to do (b) because navigating between steps removes error alerts/styles. And we don't have logic for (c) yet
	// For now, just show all errors in this page's error box
	var handle_errors = function(response){
		jQuery("#final_step_error").html('')
		var r = jQuery.parseJSON(response.responseText);
		for (var i in r) {
				jQuery("#final_step_error").append(r[i].join(', ') + ' ('+i+') <br />').addClass('error')
		}
		scrollToTopError();
	};
	
	var scrollToTopError = function(){
		if(jQuery("#final_step_error").html().length>0){
			jQuery('html, body').animate({
				scrollTop : jQuery("#final_step_error").offset().top-40
			}, 250);
		}
	};

	
	jQuery('#publish_button').click(function() {
		if (jQuery("#publish_event").valid() && jQuery("form#event_user_address_form").valid()) {
			// FIX THIS: This is a workaround. We only want to submit Mailing Address form for users w/o Orders
			// This whole sequence of buttons and showing/hiding of elements needs improvement
			var cart_empty = parseInt(jQuery("form#new_order #order_subtotal").val()) == 0;
			if(cart_empty) {
				// save address at first
				jQuery.ajax({
					url : jQuery('form#event_user_address_form').attr('action') + '.json',
					type : 'PUT',
					async : false,
					data : jQuery('form#event_user_address_form').serialize(),
					success : function(response) { save_publish_event_form() },
					error : function(response) { handle_errors(response) }
				});
			} else {
				save_publish_event_form();
			}
		} else {
			scrollToTopError();
		}
		return false;
	});
	
	jQuery('.form input.checkout_confirm').click(function() {
		jQuery('#event_checkout_button').click();
		jQuery("#checkout_confirm_container").addClass('loading')
	});
	
	jQuery('.form input.edit_order').click(function() {
		jQuery('.form input.checkout_confirm, .form input.edit_order, .form #checkout_confirm_container').hide();
		jQuery('.form #order_form_container, .form input.cancel_event_button, .form input.checkout').show();
	});

	jQuery('.form input.checkout').click(function() {
		if(jQuery("form#new_order").valid()){
			jQuery('.form input.checkout_confirm, .form input.edit_order, .form #checkout_confirm_container').show();
			jQuery(this).hide();
			jQuery('.form #order_form_container, .form input.cancel_event_button').hide();
		}
		scrollToTopError()
	});
	

	jQuery("#steps-menu li a").click(function() {
		// not happy with this logic for showing/hiding checkout forms
		if(jQuery("#order_form_container:visible").length){
			var cart_empty = parseInt(jQuery("form#new_order #order_subtotal").val()) == 0;
			if(cart_empty){
				orders.hide_order_form()
				orders.hide_checkout_confirm_container()
				orders.show_free_package_message()
			}
			else
			{
				orders.hide_order_form()
				orders.hide_free_package_message()
				orders.show_checkout_confirm_container()
			}
		}
	});

	
}); 
