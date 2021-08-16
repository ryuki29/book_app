$(document).on("turbolinks:load", function(){
  function removeBook(element) {
    let deleteBookId = "#" + element;
    let target = $(".user-show_tabs").find(deleteBookId)
    let ulBookBtn = target.parent()
    let bookMenu = ulBookBtn.parent()
    let addBookCover = bookMenu.parent()
    let textCenter = addBookCover.parent()
    let bookContent = textCenter.parent()
    bookContent.remove()
  }

  $(".destroy-book").on("click", function() {
    if (!confirm("本当に削除しますか？")) {
      return false;
    } else {
      let element = $(this).attr("id");
      let id = $(this).attr("data-id");

      $.ajax({
        url: "/books/" + id,
        type: "delete",
      })
        .done(function() {
          removeBook(element);
        })
        .fail(function() {
          alert("エラーが発生しました")
      });
    }
  });
})