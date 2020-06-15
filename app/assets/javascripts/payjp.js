$(document).on('turbolinks:load', function () {
  var form = $("#card_form");
    number = form.find(".number"),
    cvc = form.find(".cvc"),
    exp_month = form.find(".exp_month"),
    exp_year = form.find(".exp_year");

  $("#card_form").on("click", "#regist_card", function (e) {
    e.preventDefault();
    form.find("input[type=submit]").prop("disabled", true);
    var card = {
      number: number.val(),
      cvc: cvc.val(),
      exp_month: exp_month.val(),
      exp_year: exp_year.val()
    };

    Payjp.createToken(card, function (s, response) {

      if (response.error) {
        alert("error")
        form.find('button').prop('disabled', false);
      }
      else {
        $(".number").removeAttr("name");
        $(".cvc").removeAttr("name");
        $(".exp_month").removeAttr("name");
        $(".exp_year").removeAttr("name");

        var token = response.id;
        $("#card_form").append(`<input type="hidden" name="card_token" class="payjp-token" value=${token} />`)
        $("#card_form").get(0).submit();
      }
    });
  });
});