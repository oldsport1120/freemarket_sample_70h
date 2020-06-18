$(document).on('turbolinks:load', function() {
  var form = $("#charge-form");
  Payjp.setPublicKey('pk_test_f71965297cf6ca7ff18390fc'); //(自身の公開鍵)

  $("#charge-form").on("click", "#submit-button", function(e) {
    e.preventDefault();
    form.find("input[type=submit]").prop("disabled", true);
    var card = {
        number: parseInt($("#payment_card_no").val()),
        cvc: parseInt($("#cvc_code").val()),
        exp_month: parseInt($("#card_expire_mm").val()),
        exp_year: parseInt($("#card_expire_yy").val())
    };
    Payjp.createToken(card, function(status, response) {
      if (stauts == 200) {
        $(".number").removeAttr("name");
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