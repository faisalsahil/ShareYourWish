jQuery(document).ready(function() {

  jQuery('#add_guest_comment').click(function(){
    var form = jQuery(this).parent("form");
    if(form.valid()){
        jQuery.post(form.attr('action'), form.serialize(), function(data) {
            jQuery('#guest_comments_target').load(form.attr('action'), function(){ guest_comments_callback() });
            form.reset()
        });
    }
    return false;
  })

  var guest_comments_callback = function(){
    jQuery('#guest_comments_target a').unbind('click');
    jQuery('#guest_comments_target a').click(function(){
        jQuery('#guest_comments_target').load(jQuery(this).attr('href'), function() { guest_comments_callback() });
        return false;
    })
    jQuery('.delete_comment_button').unbind('click');
    jQuery('.delete_comment_button').click(function() {
      if(confirm('About to delete this comment. This cannot be undone. Continue?')){
        var _this = this  
        jQuery.post(jQuery(_this).attr('data-url'),{ _method: "DELETE"}, function(data) {
          jQuery(_this).parents('.comment').hide();
        });
      }
    });
  }
  guest_comments_callback();

});
