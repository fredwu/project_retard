/*
  Author: Fred Wu (http://fredwu.me/)
*/

$(document).ready(function() {

  /* --------------------
    AJAX loader
  -------------------- */

  $("#ajax_loader").ajaxStart(function() {
    $("#ajax_error").fadeOut();
    $(this).fadeIn();
  }).ajaxStop(function() {
    $(this).fadeOut();
  });

  $("#ajax_error").ajaxError(function() {
    $(this).fadeIn();
  });

  /* --------------------
    Styling - they're here to 'automagically' fix the stock Adminus theme
  -------------------- */

  if ($("label").length > 0) {
    $("label").before(" ");
  }
  $("label.collection_radio").css("font-weight", "normal");
  $("input.string, input.password, input.numeric").addClass("text small");
  $("form > p > label").after("<br />");
  $("#error_explanation").addClass("message errormsg");
  $("p.field_with_errors > span.error").addClass("note");
  $(".nohide").children(".close").hide();
  $("input.file").parent("div").css("background-image", "url(/adminus/original/images/upload.gif)");
  $(".pagination").addClass("paggination right");
  $(".pagination em").wrap("<a class='active'>").css("font-style", "normal");
  $(".pagination span.disabled").hide();
  $(".pagination a.previous_page").text("«");
  $(".pagination a.next_page").text("»");

  /* --------------------
    Resource removals
  -------------------- */

  $(".confirm-cancel, .confirm-delete").live("click", function(e) {
    e.preventDefault();
  });

  $("a.del-resource").inlineConfirmation({
    confirm: "<a href='#' class='confirm-delete'>Delete!</a>",
    cancel: "<a href='#' class='confirm-cancel'>Cancel</a>",
    reverse: true,
    expiresIn: 3,
    confirmCallback: function(action) {
      var id = action.attr("data-id");

      $.post(action.attr("href"), {
        _method: "delete",
        id: id
      }, function() {
        $("tr[data-id=" + id + "]").fadeOut();
      })
    }
  });
});