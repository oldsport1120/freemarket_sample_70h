$(document).on('turbolinks:load', function() {
  var form = $("#charge-form");
  Payjp.setPublicKey('pk_test_f71965297cf6ca7ff18390fc');

  $("#charge-form").on("click", "#token_submit", function(e) {
    e.preventDefault();
    form.find("input[type=submit]").prop("disabled", true);
    var card = {
        number: parseInt($("#card_number").val()),
        cvc: parseInt($("#cvc").val()),
        exp_month: parseInt($("#cexp_month").val()),
        exp_year: parseInt($("#exp_year").val())
    };
    Payjp.createToken(card, function(status, response) {
      if (stauts == 200) {
        $(".card_number").removeAttr("name");
        $(".cvc").removeAttr("name");
        $(".exp_month").removeAttr("name");
        $(".exp_year").removeAttr("name");

        var token = response.id;
        $("#charge-form").append($('<input type="hidden" name="payjp_token" class="payjp-token" />').val(token));
        $("#charge-form").get(0).submit();

      }
      else {
        alert("error")
        form.find('button').prop('disabled', false);
      }
    });
  });
});

// $(function() {
//   if(!$('#regist_card')[0])return false;

//   Payjp.setPublicKey("pk_test_f71965297cf6ca7ff18390fc");

//   $("#regist_card").on("click",function(e) {
//     e.preventDefaoult();
//     let now = new Date();
//     ver card = {
//         number: $("#card_number").val(),
//         exp_month: $("#exp_month").val(),
//         exp_year: $("#exp_year").val(),
//         cvc: $("#cvc").val()
//     };
//     Payjp.createToken(card, function(status, response) {
//       if (status === 200) {
//         $("#card_number").removeAttr("name");
//         $("#exp_month").removeAttr("name");
//         $("#exp_month").removeAttr("name");
//         $("#cvc").removeAttr("name");

//         var token = response.id;
//         $("#card_token").append(`<input type="hidden" name="card_token" value=${token}>`)
//         $("#card_form").get(0).submit();
//       }else{
//         alert("カード情報が正しくありません。");
//         $("#regist_card").prop('disabled', false);
//       }
//     });
//   });
// });