$(document).on("turbolinks:load", function(){

  $(".add-book").on("click", function() {
    let image = $(this).attr("data-image");

    $("#modal-review-img").attr("src", image)
  });
});

  let minCount = 1;
  let maxCount = 5;

  // impressive_phrase form
  $(function(){
    $('#impressive_phrase-form-plus').on('click', function(){
      let inputCount = $('#form-area .phrase').length;
      if (inputCount < maxCount){
        let element = $('#form-area .phrase:last-child').clone(true);
        let inputList = element[0].querySelectorAll('input[type="text"]');
        for (let i = 0; i < inputList.length; i++) {
          inputList[i].value = "";
        }
        $('#form-area .phrase').parent().append(element);
      }
    });
    $('.impressive_phrase-form-minus').on('click', function(){
      let inputCount = $('#form-area .phrase').length;
      if (inputCount > minCount){
        $(this).parents('.phrase').remove();
      }
    });
  });

  // action_plan form
  $(function(){
    $('#action_plan-form-plus').on('click', function(){
      let inputCount = $('#form-area .plan').length;
      if (inputCount < maxCount){
        let element = $('#form-area .plan:last-child').clone(true);
        let inputList = element[0].querySelectorAll('input[type="text"]');
        for (let i = 0; i < inputList.length; i++) {
          inputList[i].value = "";
        }
        $('#form-area .plan').parent().append(element);
      }
    });

    $('.action_plan-form-minus').on('click', function(){
      let inputCount = $('#form-area .plan').length;
      if (inputCount > minCount){
        $(this).parents('.plan').remove();
      }
    });
  });
