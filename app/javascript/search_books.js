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
  });

  $(".read-book").on("click", function() {
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

});

// // ----- impressive_phraseフォーム ------
// $(function(){
//   // impressive_phraseフォームの追加・削除
//   function buildImpressivePhraseField(index) {
//     const html =
//                   `<div class="col-lg-3"></div>
//                   <div class="js-phrase-form-group col-lg-7 mb-1" data-index="${index}">
//                     <div class="phrase input-group">
//                       <input class="impressive-phrase-field form-control" type="text" name="review[impressive_phrases_attributes][${index}][phrase]" id="phrase-input">
//                       <div class="phrase-form-minus-btn input-group-append">
//                         <input type="button" value="－" class="del pluralBtn">
//                       </div>
//                     </div>
//                   </div>`
//     return html
//   }

//   let fileIndex = [1, 2, 3, 4]
//   var lastIndex = $(".js-phrase-form-group:last").data("index");
//   fileIndex.splice(0, lastIndex);
//   let fileCount = 5- fileIndex.length; // データが存在するフォームの数を取得する

//   if (fileIndex.length == 0) $(".phrase-from-plus-btn").css("display", "none");

//   $(".phrase-form-plus-btn").on("click", function(){
//     $(".phrase-form-area").append(buildImpressivePhraseField(fileIndex[0]));
//     fileIndex.shift();
//     if (fileIndex.length == 0) $(".phrase-form-plus-btn").css("display", "none");
//   })

//   // フォーム削除処理
//   $(".phrase-form-area").on("click", ".phrase-form-minus-btn", function(){
//     $(".phrase-form-plus-btn").css("display", "inline-block");
//     const targetIndex = $(this).parent().data("index");
//     const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
//     var lastIndex = $("js-phrase-form-group:last").data("index");

//     if (targetIndex < fileCount) {
//       $(this).parent().css("display", "none")
//       hiddenCheck.prop("checked", true);
//     } else {
//       $(this).parent().remove();
//     }

//     if (fileIndex.length >= 1) {
//       fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
//     } else {
//       fileIndex.push(lastIndex + 1);
//     }
//   })
// })

// // ----- action_plansフォーム ------
// $(function(){
//   // action_plansフォームの追加・削除
//   // function buildActionPlanField(index) {
//   //   const html =
//   //                 `<div class="col-lg-3"></div>
//   //                 <div class="js-plan-form-group col-lg-7 mb-1" data-index="${index}">
//   //                   <div class="plan input-group">
//   //                     <input type="text" id="plan-input" class="action-plan-field form-control" name="review[action_plans_attributes][${index}][plan]" placeholder="アクションプランを記入">
//   //                     <input type="text" class="date result form-control review-date" name="review[action_plans_attributes][${index}][deadline]" placeholder="期限">
//   //                     <div class="plan-form-minus-btn input-group-append">
//   //                       <input type="button" value="－" class="del pluralBtn">
//   //                     </div>
//   //                   </div>
//   //                 </div>
//   //                 <script>
//   //                   $(function () {
//   //                     $('.date').bootstrapMaterialDatePicker({
//   //                         time: false,
//   //                         lang:"ja",
//   //                     });
//   //                   });
//   //                 </script>`
//   //   return html
//   // }
  

//   let fileIndex = [1, 2, 3, 4]
//   var lastIndex = $(".js-plan-form-group:last").data("index");
//   fileIndex.splice(0, lastIndex);
//   let fileCount = 5- fileIndex.length;

//   if (fileIndex.length == 0) $(".plan-from-plus-btn").css("display", "none");

//   $(".plan-form-plus-btn").on("click", function(){
//     $(".plan-form-area").append(buildActionPlanField(fileIndex[0]));
//     fileIndex.shift();
//     if (fileIndex.length == 0) $(".plan-form-plus-btn").css("display", "none");
//   })

//   $(".plan-form-area").on("click", ".plan-form-minus-btn", function() {
//     $(".plan-form-plus-btn").css("display", "inline-block");
//     const targetIndex = $(this).parent().data("index");
//     const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
//     var lastIndex = $("js-plan-form-group:last").data("index");

//     if (targetIndex < fileCount) {
//       $(this).parent().css("display", "none")
//       hiddenCheck.prop("checked", true);
//     } else {
//       $(this).parent().remove();
//     }

//     if (fileIndex.length >= 1) {
//       fileIndex.push(fileIndex[fileIndex.length -1] + 1);
//     } else {
//       fileIndex.push(lastIndex + 1);
//     }
//   })

//   $(".read-book").on("click", function() {
//     if (fileIndex.length >= 4) {
//       $(".del").prop("disabled", "true");
//     }
//   })
// })
