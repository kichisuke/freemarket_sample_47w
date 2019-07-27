$(document).on('turbolinks:load', function() {
  var form = $("#card-form");

  Payjp.setPublicKey('pk_test_2cf03f0c1b9560e918e7ce5d');
  $("#card-form").on("click", "#submit-button", function(e) {
    e.preventDefault();
    form.find("input[type=submit]").prop("disabled", true);
    var card = {
        number: $("#card-number").val(),
        cvc: $("#cvc").val(),
        exp_month: $("#card_expire_mm").val(),
        exp_year: $("#card_expire_yy").val()
    };
    Payjp.createToken(card, function(status, response) {
      if (status == 200) {
        $(".number").removeAttr("name");
        $(".cvc").removeAttr("name");
        $(".exp_month").removeAttr("name");
        $(".exp_year").removeAttr("name");

        var token = response.id;
        form.append($('<input type="hidden" name="payjp-token" class="payjp-token" />').val(token));
        form.get(0).submit();
      }
      else {
        alert("error")
        $('#submit-button').prop('disabled', false);
      }
    });
  });
});
