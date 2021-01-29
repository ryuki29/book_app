$(document).on("turbolinks:load", function(){

  $(".add-book").on("click", function() {
    let image = $(this).attr("data-image");

    $("#modal-review-img").attr("src", image)
  });
});
