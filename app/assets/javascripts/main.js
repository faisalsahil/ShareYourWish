
$(document).ready(function() {

	// Another variation of placeholder text
	// This adds 'placeholder' to the items listed in the jQuery .support object. 
	jQuery(function() {
	   jQuery.support.placeholder = false;
	   test = document.createElement('input');
	   if('placeholder' in test) jQuery.support.placeholder = true;
	});
	// This adds placeholder support to browsers that wouldn't otherwise support it. 
	$(function() {
	   if(!$.support.placeholder) { 
	      var active = document.activeElement;
	      $(':text').focus(function () {
	         if ($(this).attr('placeholder') != '' && $(this).val() == $(this).attr('placeholder')) {
	            $(this).val('').removeClass('hasPlaceholder');
	         }
	      }).blur(function () {
	         if ($(this).attr('placeholder') != '' && ($(this).val() == '' || $(this).val() == $(this).attr('placeholder'))) {
	            $(this).val($(this).attr('placeholder')).addClass('hasPlaceholder');
	         }
	      });
	      $(':text').blur();
	      $(active).focus();
	      $('form:eq(0)').submit(function () {
	         $(':text.hasPlaceholder').val('');
	      });
	   }
	});

	// modal dialog
	$( "#signup-form" ).dialog({
				autoOpen: false,
				height: 500,
				width: 350,
				modal: true,
				title: "Sign Up to Stay In Touch",
				buttons: {
								Close: function() {
									$( this ).dialog( "close" );
								}
							},
				close: function() {
					$( "#full_name" ).val( "" ).removeClass( "ui-state-error" );
					$( "#email" ).val( "" ).removeClass( "ui-state-error" );
					$( "#comment" ).val( "" ).removeClass( "ui-state-error" );
				}
			});
	$( "#signup-button" ).button().click(function() 
			{
				$( "#signup-form" ).dialog( "open" );
			});

			$( "#signup-cancel" ).button().click(function() 
			{
				$( "#signup-form" ).dialog( "close" );
			});
       
	$( "#signup-form-popup" ).dialog({
				autoOpen: false,
				height: 550,
				width: 500,
				modal: true,
				title: "Sign Up to Stay In Touch",
				buttons: {
								Close: function() {
									$( this ).dialog( "close" );
								}
							},
				close: function() {
					$( "#full_name2" ).val( "" ).removeClass( "ui-state-error" );
					$( "#email2" ).val( "" ).removeClass( "ui-state-error" );   
				}
			});                        
	// If an event gets to the body
	$("body").click(function(){
	  $("#signup-form-popup").dialog( "close" );
	});

	// Prevent events from getting past popup window
	$("#signup-form-popup").click(function(e){
	  e.stopPropagation();
	});                       


	// enable IE Alert plugin
	$("body").iealert({ support: "ie7" });

	// fix IE9 select boxes that don't size correctly
	if(jQuery.browser.msie)
		$("select").css("font-size","1em");
		
// close Document.Ready 
})

String.prototype.nl2br = function()
{
	return this.replace(/\n/g, "<br />");
}

String.prototype.strip_tags = function()
{
	return this.replace(/<(?:.|\n)*?>/gm, '');
}

