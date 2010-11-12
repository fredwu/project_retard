/*
  Author: Fred Wu (http://fredwu.me/)
*/

$(document).ready(function() {

  /* --------------------
    Fancybox
  -------------------- */

  $("a.fancybox").fancybox({
    speedOut: 0
  });

  /* --------------------
    Styling - they're here to 'automagically' fix the stock Adminus theme
  -------------------- */

  if ($("label").length > 0) {
    $("label").before(" ");
  }
  $("label.collection_radio").css("font-weight", "normal");
  $("input.string, input.password, input.numeric").addClass("text small");
  $("form p > label").after("<br />");
  $("#error_explanation").addClass("message errormsg");
  $("p.field_with_errors > span.error").addClass("note");
  $(".nohide").children(".close").hide();
  $("input.file").parent("div").css("background-image", "url(/adminus/original/images/upload.gif)");
  $(".pagination").addClass("paggination right");
  $(".pagination em").wrap("<a class='active'>").css("font-style", "normal");
  $(".pagination span.disabled").hide();
  $(".pagination a.previous_page").text("«");
  $(".pagination a.next_page").text("»");
  $("input:disabled").css({color: "#999"});

  /* --------------------
    Product publish toggle
  -------------------- */

  $("input#product_is_activated").change(function() {
    show_publish_block($(this));
  });

  if ($("input#product_is_activated").length >= 0) {
    show_publish_block($("input#product_is_activated"));
  }

  function show_publish_block(scope) {
    if ($(scope).attr("checked")) {
      $("#start_at p.datetime, #end_at p.datetime").fadeIn();
      $("#start_at p.datetime select, #end_at p.datetime select").attr("disabled", false);
    } else {
      $("#start_at p.datetime, #end_at p.datetime").hide();
      $("#start_at p.datetime select, #end_at p.datetime select").attr("disabled", true);
    }
  }

});