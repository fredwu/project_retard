/*
  Author: Fred Wu (http://fredwu.me/)
*/

$(document).ready(function() {

  /* --------------------
    jQuery Functions
  -------------------- */

  $.fn.hide_and_clean = function() {
    $(this).hide();
    $("input[type=text]", this).val("");
    $("select option:selected", this).attr("selected", false);
  };

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

  /* --------------------
    Product publish toggle
  -------------------- */

  $("input#to_publish").change(function() {
    if ($(this).attr("checked")) {
      $("select#product_published_on_1i").attr("disabled", false);
      $("select#product_published_on_2i").attr("disabled", false);
      $("select#product_published_on_3i").attr("disabled", false);
    } else {
      $("select#product_published_on_1i").attr("disabled", true);
      $("select#product_published_on_2i").attr("disabled", true);
      $("select#product_published_on_3i").attr("disabled", true);
    }
  });
});