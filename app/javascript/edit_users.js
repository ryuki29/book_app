$(document).on("turbolinks:load", function() {
  $("#edit-profile").on("click", function() {
    $("#edit-user_name_count").text($("#edit-user_name").val().length);
    $("#edit-user_text_count").text($("#edit-user_text").val().length);
  });

  $(".edit-user_img_input").on("change", function(e) {
    let file = e.target.files[0];
    let reader = new FileReader();

    if (file.type.indexOf("image") < 0) {
      alert("画像ファイルを選択してください");
      return false;
    }

    reader.onload = (function(file) {
      return function(e) {
        $(".edit-user_img").attr("src", e.target.result);
      };
    })(file);
    reader.readAsDataURL(file);
  });

  $('#edit-user_name').on("keyup", function() {
    let nameLength = $(this).val().length;
    $("#edit-user_name_count").text(nameLength);
  });

  $('#edit-user_text').on("keyup", function() {
    let textLength = $(this).val().length;
    $("#edit-user_text_count").text(textLength);
  });
})

