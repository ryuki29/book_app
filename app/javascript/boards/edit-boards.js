$(document).on("turbolinks:load", function() {
  $("#edit-board").on("click", function() {
    $(".modal-header-title").text("スレッドを編集する");
    $(".board-submit").val("更新する");

    let board_title = $("#js-board-title").text();
    $("#js-edit-board-title").val(board_title);

    let board_type = $("#js-board_type").data("type").toLowerCase();
    $("#js-edit-board_type").val(board_type);

    let board_text = $("#js-board-text").text();
    $("#js-edit-board-text").val($.trim(board_text));

    let board_img = $("#js-board-img").data("image");
    $("#edit-board-img").attr("src", board_img);
    console.log(board_img)
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

});
