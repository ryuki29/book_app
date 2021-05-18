$(document).on("turbolinks:load", function(){
  function createBook(status, element) {
    $.ajax({
      url: "/books",
      method: "post",
      data: {
        book: {
          title: $("#" + element).attr("data-title"),
          authors: $("#" + element).attr("data-authors"),
          image_url: $("#" + element).attr("data-image"),
          uid: $("#" + element).attr("data-uid")
        },
        user_book: {
          status: status
        }
      },
      dataType: "json"
    })
    .done(function(data) {
      location.href = "/users/" + data.user_id;
    })
    .fail(function() {
      alert("エラーが発生しました");
    });
  }

  $(".reading-book-btn").on("click", function() {
    let element = $(this).attr('id');
    createBook(1, element);
  });

  $(".will-read-book-btn").on("click", function() {
    let element = $(this).attr('id');
    createBook(2, element);
  });
})