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
    Resource removals
  -------------------- */

  $(".confirm-cancel, .confirm-delete").live("click", function(e) {
    e.preventDefault();
  });

  $("a.del-resource").inlineConfirmation({
    confirm: "<a href='#' class='confirm-delete'>Delete!</a>",
    cancel: "<a href='#' class='confirm-cancel'>Cancel</a>",
    reverse: true,
    expiresIn: 5,
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