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
    // 下記は1回目のクリックした情報を入れることはできる
    // 動的に変えることはまだできず、修正の余地あり
    // modal画面を閉じたときに中身の値をリセットできるようにする（以前同様の内容を実装したことがあるような）
    // そうすることで、一度入った本の情報もリセットされるので、動的に中身の値を変更することができる
    $('.modal-book-title').attr("value", title);
    $('.modal-book-authors').attr("value", authors);
    $('.modal-book-img').attr("value", image);
    $('.modal-book-uid').attr("value", uid);
  });
});

// ----- impressive_phraseフォーム ------
$(function(){
  // impressive_phraseフォームの追加・削除
  function buildImpressivePhraseField(index) {
    const html =
                  `<div class="js-phrase-form-group" data-index="${index}">
                    <div class="phrase input-group mb-2">
                      <input class="impressive-phrase-field" type="text" name="review[impressive_phrases_attributes][${index}][phrase]" id="phrase-input">
                    </div>
                    <div class="phrase-form-minus-btn input-group-append">
                      <input type="button" value="－" class="del pluralBtn">
                    </div>
                  </div>`
    return html
  }

  let fileIndex = [1, 2, 3, 4]
  var lastIndex = $(".js-phrase-form-group:last").data("index");
  fileIndex.splice(0, lastIndex);
  let fileCount = 5- fileIndex.length; // データが存在するフォームの数を取得する
  let displayCount = $(".js-phrase-form-group:last").length

  if (fileIndex.length == 0) $(".phrase-from-plus-btn").css("display", "none");

  $(".phrase-form-plus-btn").on("click", function(){
    $(".phrase-form-area").append(buildImpressivePhraseField(fileIndex[0]));
    fileIndex.shift();
    if (fileIndex.length == 0) $(".phrase-form-plus-btn").css("display", "none");
      displayCount += 1;
  })

  // フォーム削除処理
  $(".phrase-form-area").on("click", ".phrase-form-minus-btn", function(){
    $(".phrase-form-plus-btn").css("display", "block");
    const targetIndex = $(this).parent().data("index");
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    var lastIndex = $("js-phrase-form-group:last").data("index");
    displayCount -= 1;

    if (targetIndex < fileCount) {
      $(this).parent().css("display", "none")
      hiddenCheck.prop("checked", true);
    } else {
      $(this).parent().remove();
    }

    if (fileIndex.length >= 1) {
      fileIndex.push(fileIndex[fileIndex.length -1] + 1);
    } else {
      fileIndex.push(lastIndex + 1);
    }

    if (fileIndex.length == 5) $(".phrase-form-area").append(buildImpressivePhraseField(fileindex[0]));
    }
  )
})

// ----- action_plansフォーム ------
$(function(){
  // action_plansフォームの追加・削除
  function buildActionPlanField(index) {
    const html =
                  `<div class="js-plan-form-group" data-index="${index}">
                    <div class="plan input-group mb-2">
                      <input class="action-plan-field" type="text" name="review[action_plans_attributes][${index}][plan]" id="plan-input">
                    </div>
                    <div class="plan-form-minus-btn input-group-append">
                      <input type="button" value="－" class="del pluralBtn">
                    </div>
                  </div>`
    return html
  }

  let fileIndex = [1, 2, 3, 4]
  var lastIndex = $(".js-plan-form-group:last").data("index");
  fileIndex.splice(0, lastIndex);
  let fileCount = 5- fileIndex.length;
  let displayCount = $(".js-plan-form-group:last").length

  if (fileIndex.length == 0) $(".plan-from-plus-btn").css("display", "none");

  $(".plan-form-plus-btn").on("click", function(){
    $(".plan-form-area").append(buildActionPlanField(fileIndex[0]));
    fileIndex.shift();
    if (fileIndex.length == 0) $(".plan-form-plus-btn").css("display", "none");
      displayCount += 1;
  })

  $(".plan-form-area").on("click", ".plan-form-minus-btn", function(){
    $(".plan-form-plus-btn").css("display", "block");
    const targetIndex = $(this).parent().data("index");
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    var lastIndex = $("js-plan-form-group:last").data("index");
    displayCount -= 1;

    if (targetIndex < fileCount) {
      $(this).parent().css("display", "none")
      hiddenCheck.prop("checked", true);
    } else {
      $(this).parent().remove();
    }

    if (fileIndex.length >= 1) {
      fileIndex.push(fileIndex[fileIndex.length -1] + 1);
    } else {
      fileIndex.push(lastIndex + 1);
    }

    if (fileIndex.length == 5) $(".plan-form-area").append(buildActionPlanField(fileindex[0]));
    }
  )
})
