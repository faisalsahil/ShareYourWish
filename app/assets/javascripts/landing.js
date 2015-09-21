function scrollToAnchor(id) {
  jQuery("html, body").animate({scrollTop: $("#"+id).offset().top}, 800);
}

// slider

jQuery(document).ready(function() {
  var pager = jQuery('.gallery-pager'),
    pager_width,
    pagerFactory = function(idx, slide) {
      return '<li><a href="#">'+(idx+1)+'</a></li>';
    };

  jQuery('.gallery').cycle({
    fx: 'fade',
    sync: true,
    timeout: 2500,
    speed: 1000,
    pager: '.gallery-pager',
    pagerAnchorBuilder: pagerFactory
  });

  jQuery('.counter').cycle({
    height:'39px',
    fx: 'fade',
    sync: true,
    speed: 1500,
    timeout: 5000,
  });

  pager_width = pager.width();

  pager.css({
    width: pager_width,
    left: ( 350 - ( pager_width/2 ) )
  });

});