$(document).on("turbolinks:load", function(){
  $(".read-book").on("click", function() {
    let title = $(this).attr("data-title");
    let authors = $(this).attr("data-authors");
    let image = $(this).attr("data-image");
    let uid = $(this).attr("data-uid");

    $('#date').val("");
    $('#review-text').val("");
    $('#phrase-input').val("");
    $('#plan-input').val("");
    $('#modal-review-img').attr("data-image", image);

    $(".read-book")
      .attr("data-title", title)
      .attr("data-authors", authors)
      .attr("data-uid", uid);

    $('#modal-review-img').attr("src", image);
    $('.modal-book-title').attr("value", title);
    $('.modal-book-authors').attr("value", authors);
    $('.modal-book-img').attr("value", image);
    $('.modal-book-uid').attr("value", uid);

    $("#review-text_count").text($("#review-text").val().length);
    $("#review-tegline_count").text($("#review-tegline").val().length);
  });

  function textCount(maxCount, nowCount, target) {
    if(nowCount > maxCount) {
      $(target).css("color", "red");
    } else {
      $(target).css("color", "gray");
    }
  }

  $('#review-text').on("keyup", function() {
    let textLength = $(this).val().length;
    $("#review-text_count").text(textLength);
    target = $("#review-text_count");
    textCount(400, textLength, target);
  });

  $('#review-tegline').on("keyup", function() {
    let textLength = $(this).val().length;
    $("#review-tegline_count").text(textLength);
    target = $("#review-tegline_count");
    textCount(25, textLength, target);
  });

  $(".read-book").on("click", function() {
    $("#date-input").val(moment().format("YYYY/MM/DD"));
    $("#date-input").attr("disabled", false).removeClass("form-disabled");
  });

  $("#edit-review").on("click", function() {
    let image = $("#book-img").data("image");
    $("#modal-review-img").attr("src", image);

    let rateIndex = $(".star-rate").data("index");
    let rate = $(`#star-rate-${rateIndex} input`).val();
    $("#edit-star input").val(rate);

    let tegline = $(".review-show_tegline").text();
    $("#review-tegline_count").text($.trim(tegline).length);

    let text = $(".review-show_text").text();
    $("#review-text_count").text($.trim(text).length);
  })

});
