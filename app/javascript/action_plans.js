$(document).on("turbolinks:load", function() {
  $(".plans-show-input").on("click", function() {

    let inputId = $(this).attr("id")
    let input = $(this)
    let target = $(`label[for=${inputId}]`)
    let id = $(this).attr("data-id")

    $.ajax({
      url: "/reviews/action_plans/" + id,
      type: "patch"
    })
      .done(function() {
        if (input.prop("checked")) {
          completedProgress(target, 1)
          target.removeClass("plans-show-not_started")
        } else {
          completedProgress(target, 0)
          target.removeClass("plans-show-completed")
        }
      })
      .fail(function() {
        alert("エラーが発生しました")
    });
  })

  function completedProgress(target, progress) {
    if(progress == 1) {
      $(target).css("background-color", "#0080FF");
    } else {
      $(target).css("background-color", "orangered");
    }
  }
})