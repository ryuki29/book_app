$(document).on("turbolinks:load", function() {
  function createReview() {
    $.ajax({
      url: "/books",
      method: "post",
      data: {
        book: {
          title: $("#read-book").attr("data-title"),
          authors: $("#read-book").attr("data-authors"),
          image_url: $("#read-book").attr("data-image"),
          uid: $("#read-book").attr("data-uid")
        },
        user_book: {
          status: 0
        },
        review: {
          date: $("#date-input").val(),
          text: $`("#review-text").val(),
          rating: $("#book-rating").val(),
          tweet: $("#tweet-review").val()
        }
      },
      dataType: "json"
    })
      .done(function(data) {
        let url = "/users/" + data.user_id;
        window.location.replace(url);
      })
      .fail(function() {
        alert("エラーが発生しました");
      });
  }

  $("#review-submit").on("click", function() {
    $(this).prop("disabled", true);

    if ($("#review-submit").text() === "更新する") {
      updateReview();
    } else {
      createReview();
    }
  });

});
