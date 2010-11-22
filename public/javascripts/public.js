/*
  Author: Fred Wu (http://fredwu.me/)
*/

$(document).ready(function() {

  /* --------------------
    jQuery Functions
  -------------------- */

  $.fn.highlightIt = function() {
    $(this).parent().siblings().children("a").css({
      color: "#111",
      background: "#fff"
    });
    $(this).css({
      color: "#fff",
      background: "#111"
    });
    $(".info_div").hide();
    $("#" + $(this).attr("data-id")).show();
  };

  /* --------------------
    Product
  -------------------- */

  $("#deal .product_images").slideshow({
    width: 616,
    height: 240,
    pauseSeconds: 5,
    caption: false
  });

  $("#info ul li:first a").highlightIt();
  $("#info ul li a").click(function(e) {
    $(this).highlightIt();
    e.preventDefault();
  });

});