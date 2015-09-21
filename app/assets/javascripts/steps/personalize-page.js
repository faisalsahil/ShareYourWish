function apply_example_text(target_id, source_text_id) {
  var target = '#' + target_id;
  var source = '#' + source_text_id;
  jQuery(target).val(jQuery(source).html().replace(/<br>/g, "\n"));
  jQuery('form#personalize_new_event').attr('changed', true);
}

jQuery(function() {

  jQuery("#personalize_page_button").click(function() {
    jQuery('form#personalize_new_event').valid()
  });

  // Confusing... This is for the "suggested text" popup, but confusing with other general use of .tooltip, such as for errors
  jQuery("a.show_tooltip").click(function() {
    jQuery(this).next(".tooltip").find("#tooltip_default").click();
    jQuery(this).next(".tooltip").toggle();
  });
  jQuery(".tooltip a.use_this_button").click(function() {
    jQuery(".tooltip").hide();
  });
  jQuery(".tooltip a.example-text-close").click(function() {
    jQuery(".tooltip").hide();
  });
  jQuery(".tooltip a.tooltip_sample_link").click(function() {
    jQuery(this).parents('.tooltip').find('.sample_text_preview').html(jQuery(this).next('.sample_text').html())
  });

  jQuery(".theme_button .select_theme_button").click(function() {
    jQuery(".theme_container").removeClass('selected');
    jQuery(this).parents(".theme_container").addClass('selected');
  });

  new ShareYourWish.Views.PictureUploaderView($(".picture-uploader"));
});
