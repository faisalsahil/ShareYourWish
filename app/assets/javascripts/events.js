// Tabs & Steps
jQuery.fn.reset = function() {
  $(this).each(function() {
    this.reset();
  });
};

jQuery(function() {
  // history work
  jQuery("#steps-menu li a").click(function() {
    var is_new = isEventNew();
    if (jQuery(this).hasClass('state-open') || jQuery(this).hasClass('state-complete') || (jQuery(this).hasClass('state-complete-and-locked') && is_new))
      window.location.hash = jQuery(this).attr('href');
  });

  initEventTabs();

  // Validation
  init_event_wizard_validations();

  // init charity lightbox?
  jQuery('#gallery a').lightBox({
    fixedNavigation: true
  });

  // this should not be mixed with event#new
  jQuery('.event_page_faq_btn').click(function() {
    jQuery('#popup_container').html(jQuery('.event_faq_popup').html());
    jQuery('.mixed_popup').togglePopup();
    return false;
  });

  init_event_page_preview();

  dashboard_activity_log_callback();

  jQuery('#dashboard_guests #select_all_button').click(function() {
    jQuery('#dashboard_guests_list #select_guest').attr('checked', 'checked');
    return false;
  });
  jQuery('#dashboard_guests #select_none_button').click(function() {
    jQuery('#dashboard_guests_list #select_guest').removeAttr('checked');
    return false;
  });
  jQuery('#dashboard_contributions #release_gift_fund_button').click(function() {
    var _this = this;
    jQuery.post(jQuery(this).attr('data-href'), function() {
      jQuery(_this).attr('disabled', 'disabled');
    });
    return false;
  });
  jQuery('#dashboard_contributions #release_donation_fund_button').click(function() {
    var _this = this;
    jQuery.post(jQuery(this).attr('data-href'), function() {
      jQuery(_this).attr('disabled', 'disabled');
    });
    return false;
  });
  jQuery('#dashboard_guests_actions #guests_print_button').click(function() {
    window.print();
    return false;
  });
  jQuery('#dashboard_guests_actions #guests_bucket_button.full').live('click', function() {
    jQuery('#guests-hidden-container').toggleClass('hidden');
    return false;
  });

  // this is for?
  jQuery('.close_button').live('click', function() {
    jQuery(this).parent('div').toggleClass('hidden');
    return false;
  });

  // Show event page
  jQuery('a#contribution_participate_button').click(function() {
    jQuery('#contribution_form_wrapper').removeClass('hidden_important');
    jQuery("#my_contribution_response").text(jQuery(this).text());
    return false;
  });
  jQuery('a#no_contribution_participate_button').click(function() {
    jQuery('#contribution_form_wrapper').addClass('hidden_important');
    jQuery("#my_contribution_response_wrapper").removeClass('hidden');
    jQuery("#my_contribution_response").text('No, Thanks');
    return false;
  });
  jQuery('#contribution_anonymous').change(function() {
    jQuery('#guest_fields').toggleClass('hidden');
  });
  // Clear cookie on cancel_event_button, publish button click
  jQuery('input.cancel_event_button, #publish_button').click(function() {
    jQuery.cookie("tab_cookie", null);
  });
  // Buttons
  jQuery('#contribution_participate_button, #no_contribution_participate_button').button();

  disable_not_ready_tabs();
  event_forms_worker();
  $("#steps-menu li").removeClass('ui-corner-top');
});

function initEventTabs() {
  var tabs = $("#tabs").tabs();
  $(window).on("hashchange", function() {
    tabs.tabs("select", window.location.hash);
  });
}

function isEventNew() {
  return $('#tabs #event_form_state').attr('data-form_state') == 'new';
}

function init_event_page_preview() {
  $('.event_page_preview').click(function(event) {
    event.preventDefault();
    event.stopPropagation();
    var form = $('form.edit_event:visible');
    var linkEl = $(this).parent();
    onPagePreviewClick(form, linkEl.attr("href"));
  });
}

function onPagePreviewClick(form, url) {
  var eventFormView = new ShareYourWish.Views.EventFormView(form);
  eventFormView.on("success", function(form, response) {
    openInPopup("#preview-dialog", url);
  });
  eventFormView.on("error", function(form, response) {
    alert("Error while trying to display Event preview");
  });
  eventFormView.submit();
}

function init_event_wizard_validations() {
  jQuery.validator.addMethod("time", function(value) {
    return value.match(/^\d\d:\d\d:\d\d$/);
  }, "Please enter a time in the format hh:mm:ss");

  jQuery.validator.addMethod("date", function(value) {
    return value.match(/^(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\d\d$/);
  }, "Please use the format mm/dd/yyyy");

  jQuery.validator.addMethod("in", function(value, element, params) {
    var arr = params.split(',');
    return jQuery.inArray(value, arr) != -1;
  }, jQuery.format("Please enter the correct value"));

  jQuery.validator.addMethod("two_digits", function(value) {
    return value.match(/^\d\d$/);
  }, "Please enter two digits");

  jQuery.validator.addMethod("postalcode", function(postalcode, element) {
    return this.optional(element) || postalcode.match(/(^\d{5}(-\d{4})?$)|(^[ABCEGHJKLMNPRSTVXYabceghjklmnpstvxy]{1}\d{1}[A-Za-z]{1} ?\d{1}[A-Za-z]{1}\d{1})$/);
  }, "Please specify a valid postal/zip code");

  // this validator is for imageupload via URL (only)...the regular client-side test works only for local files (selected or drag/drop)
  jQuery.validator.addMethod("file_types", function(value, element, params) {
    var result = false;
    var arr = params.split(',');
    if (value.toLowerCase().match(/\.(\w{3,4})$/)) {
      var extension = value.toLowerCase().match(/\.(\w{3,4})$/)[1];
      result = jQuery.inArray(extension, arr) != -1;
    }
    return result;
  }, jQuery.format("Sorry that is not a supported image type."));

  jQuery('#new_event input, #new_event select').change(function() {
    jQuery('#new_event').attr('changed', true);
  });

  jQuery('#personalize_new_event input, #personalize_new_event textarea').change(function() {
    jQuery('#personalize_new_event').attr('changed', true);
  });

  jQuery('#guests_new_event input').change(function() {
    jQuery('#guests_new_event').attr('changed', true);
  });

  jQuery('#tabs').tabs({
    cookie: { name: 'tab_cookie', expires: 1 },
    select: function(event, ui) {
      jQuery('#final_step_error').html('').removeClass('error');
      jQuery('label.error, .edit_event_response, .error.tooltip-field').remove();
      var form = jQuery('form.edit_event:visible');
      var step_must_complete = form.parents('.tab_container').data('step-must-complete');
      if (jQuery(form).length) {
        if (form.attr('changed') == 'true') {
          if (step_must_complete) {
            form.find('.event_form_submit_button').click();
            return form.valid();
          }
          else {
            var result = true;
            jQuery.ajax({
              url: form.attr('action'),
              type: 'PUT',
              data: form.serialize(),
              async: false,
              success: function() {
                form.removeAttr('changed')
              },
              error: function(response) {
                handle_form_errors(response, form);
                result = false;
              }
            });
            return result;
          }
        }
      }
    }
  });
}

function dashboard_activity_log_callback() {
  jQuery('#dashboard_activity_log_target a').unbind('click');
  jQuery('#dashboard_activity_log_target a').click(function() {
    jQuery('#dashboard_activity_log_target').load(jQuery(this).attr('href'), function() {
      dashboard_activity_log_callback();
    });
    return false;
  });
}

var handle_form_errors = function(response, form) {
  var response = jQuery.parseJSON(response.responseText);
  form.children('#step_error').html('');
  form.find('span.error.tooltip-field').hide();
  for (var fieldName in response) {
    // place error msg (1) in pre-positioned ui element, (2) next to a form element of same name, (3) page's error text area
    var errorMessages = response[fieldName].join(", ");
    if (form.children('#event_' + fieldName + '_status_ui').length)
      form.children('#event_' + fieldName + '_status_ui').html(errorMessages).addClass('error').addClass('tooltip-field').show();
    else if (jQuery('#event_' + fieldName).length)
      jQuery('#event_' + fieldName).after('<span for="event_' + fieldName + '" generated="true" class="error tooltip-field">' + errorMessages + '</span>');
    else
      form.children('#step_error').append(errorMessages + ' (' + fieldName + ') <br />').addClass('error');
  }
  // scroll to top-most error message, which might have been the page's error text area
  if (form.children("#step_error").html().length > 0)
    jQuery('html, body').animate({scrollTop: form.children("#step_error").offset().top - 60}, 500);
  else if (form.children(".error:visible").length)
    jQuery('html, body').animate({scrollTop: form.children(".error:visible:first").offset().top - 60}, 500);
  else
    jQuery('html, body').animate({scrollTop: jQuery("#syw-logo").offset().top}, 500);
};

var event_forms_worker = function() {
  var is_new = isEventNew();

  jQuery('.event_form_submit_button').unbind('mousedown');
  jQuery('.event_form_submit_button').mousedown(function() {
    var form = jQuery(this).parent("form");
    form.removeAttr('changed');
  });

  jQuery('.previous_event_button').unbind('click');
  jQuery('.previous_event_button').click(function() {
    var form_id = "#" + jQuery(this).parent("form").attr('id');
    var form = jQuery(this).parent("form");
    if (jQuery(form_id).length) {
      if (jQuery('#previous_tab').length) {
        var tab_id = "#tabs-" + form.children('#previous_tab').val();
        jQuery('#tabs a[href="' + tab_id + '"]').click();
        jQuery('html, body').animate({scrollTop: jQuery('#syw-logo').offset().top}, 500);
      }
    }
  });

  var submitButtons = $('.event_form_submit_button');
  submitButtons.unbind('click');
  submitButtons.click(function() {
    var form = $(this).parent("form");
    if (!form.attr("id"))
      alert('Error: Could not find parent form element: look for bad object hierarchy in form ');
    $('#final_step_error, #step_error').html('').removeClass('error');
    $('.edit_event_response').remove();

    if (form.length && form.valid())
      submitEventForm(form);

    // form failed validation by jQuery Validation plugin; without this scroll_to it does not scroll to first error (why not?)
    if (jQuery(".error:visible").length) {
      jQuery('html, body').animate({
        scrollTop: jQuery(".error:visible:first").offset().top - 60
      }, 500);
    }
    return false;
  });

  jQuery("#event_title:visible, .featured_button:visible, #picture_image:visible, #event_magic_phrase:visible").focus();

};

function submitEventForm(form) {
  var eventFormView = new ShareYourWish.Views.EventFormView(form);
  eventFormView.on("success", function(form, response) {
    if (isEventNew()) {
      var tab_id = "#tabs-" + form.find('#event_step_id').val();
      $('#tabs').tabs('enable', tab_id);
      window.location.hash = tab_id;
      tabs_refresh();
    } else
      $('.event_description:visible').after('<div class="edit_event_response hilighted">Event saved!</div>');
    $('html, body').animate({scrollTop: $('#syw-logo').offset().top}, 500);
  });
  eventFormView.on("error", function(form, response) {
    handle_form_errors(response, form);
  });
  eventFormView.submit();
}

// refresh tabs
var tabs_refresh = function() {
  var url = jQuery('#steps_states_path').text();
  jQuery.get(url, function(response) {
    jQuery(response.states).each(function() {
      jQuery('#tabs a[href="#tabs-' + this.id + '"]').attr('class', this.state).attr('title', this.message);
      disable_not_ready_tabs();
    });
  }, "json");
};

var disable_not_ready_tabs = function() {
  var is_edit = (jQuery('#tabs #event_form_state').attr('data-form_state') == 'edit');
  var ids_for_disable = '#tabs a.state-not-ready';
  if (is_edit)
    ids_for_disable += ', #tabs a.state-complete-and-locked';
  jQuery(ids_for_disable).each(function() {
    jQuery('#tabs').tabs('disable', jQuery(this).attr('href'));
  });
  jQuery('#tabs a.state-open').each(function() {
    jQuery('#tabs').tabs('enable', jQuery(this).attr('href'));
  })
};
