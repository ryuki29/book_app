$(document).on("turbolinks:load", function() {
  $("#edit-board").on("click", function() {
    $(".modal-header-title").text("スレッドを編集する");
    $(".board-submit").val("更新する");

    let board_title = $("#js-board-title").text();
    $("#js-board-title").val(board_title);
    $("#js-board-title_count").text(board_title.length);

    let board_type = $("#js-board_type").data("type").toLowerCase();
    $("#js-edit-board_type").val(board_type);

    let board_text = $("#js-board-text").text();
    $("#js-board-text").val($.trim(board_text));
    $("#js-board-text_count").text($.trim(board_text).length);

    let board_img = $("#js-board-img").data("image");
    $("#edit-board-img").attr("src", board_img);
  })

  $(".edit-board_img_input").on("change", function(e) {
    let file = e.target.files[0];
    let reader = new FileReader();

    if (file.type.indexOf("image") < 0) {
      alert("画像ファイルを選択してください");
      return false;
    }

    reader.onload = (function(file) {
      return function(e) {
        $(".edit-board_img").attr("src", e.target.result);
      };
    })(file);
    reader.readAsDataURL(file);
  });

  $(".boards-new_btn").on("click", function() {
    $("#js-board-title_count").text($("#js-board-title").val().length);
    $("#js-board-text_count").text($("#js-board-text").val().length);
  });

  function textCount(maxCount, nowCount, target) {
    if(nowCount > maxCount) {
      $(target).css("color", "red");
    } else {
      $(target).css("color", "gray");
    }
  }

  $('.js-board-title').on("keyup", function() {
    let textLength = $(this).val().length;
    $(".js-board-title_count").text(textLength);
    target = $(".js-board-title_count");
    textCount(25, textLength, target);
  });

  $('.js-board-text').on("keyup", function() {
    let textLength = $(this).val().length;
    $(".js-board-text_count").text(textLength);
    target = $(".js-board-text_count");
    textCount(200, textLength, target);
  });

  // -----new-board_comment-----
  $(".board_comment-img_input").on("change", function(e) {
    let file = e.target.files[0];
    let reader = new FileReader();

    if (file.type.indexOf("image") < 0) {
      alert("画像ファイルを選択してください");
      return false;
    }

    reader.onload = (function(file) {
      return function(e) {
        $(".board_comment-img").attr("src", e.target.result);
      };
    })(file);
    reader.readAsDataURL(file);
  });

  $(".board-comment_btn").on("click", function() {
    $("#js-board-comment_count").text($("#js-board-comment").val().length);
  })

  $('#js-board-comment').on("keyup", function() {
    let textLength = $(this).val().length;
    $("#js-board-comment_count").text(textLength);
    target = $("#js-board-comment_count");
    textCount(200, textLength, target);
  });

});
