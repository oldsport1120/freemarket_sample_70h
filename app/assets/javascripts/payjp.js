document.addEventListener(
  "DOMContentLoaded", e => {
    if (document.getElementById("token_submit") != null) { 
      Payjp.setPublicKey("pk_test_f71965297cf6ca7ff18390fc")
      let btn = document.getElementById("token_submit"); 
      btn.addEventListener("click", e => { 
        e.preventDefault(); 
        let card = {
          number: document.getElementById("card_number").value,
          cvc: document.getElementById("cvc").value,
          exp_month: document.getElementById("exp_month").value,
          exp_year: document.getElementById("exp_year").value
        }; 
        Payjp.createToken(card, (status, response) => {
          if (status === 200) { //成功した場合
            $("#card_number").removeAttr("name");
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name"); 
            $("#card_token").append(
              `<input type="hidden" name="payjp_token" value=${response.id}>`
            ); 
            alert("登録が完了しました");
            $('#card_submit')[0].submit();
          } else {
            alert("カード情報が正しくありません。"); 
          }
        });
      });
    }
  },
  false
);