
jQuery(function() {

	jQuery("#invite_option_one").click(function() {
		jQuery("#event_invite_option_syw-email").click()
		jQuery("#invite_option_one").addClass('checked')
		jQuery("#invite_option_two").removeClass('checked')
		jQuery("#invite_option_three").removeClass('checked')
	});
	jQuery("#invite_option_two").click(function() {
		jQuery("#event_invite_option_other-email").click()
		jQuery("#invite_option_one").removeClass('checked')
		jQuery("#invite_option_two").addClass('checked')
		jQuery("#invite_option_three").removeClass('checked')
	});	
	jQuery("#invite_option_three").click(function() {
		jQuery("#event_invite_option_print").click()
		jQuery("#invite_option_one").removeClass('checked')
		jQuery("#invite_option_two").removeClass('checked')
		jQuery("#invite_option_three").addClass('checked')
	});

	jQuery("#form#create_or_update_guest").validate({
		onkeyup : false,
		onkeydown : false,
		onclick : true
	});

});
