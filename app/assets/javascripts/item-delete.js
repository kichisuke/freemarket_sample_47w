$(document).on('turbolinks:load', function(){
  if(document.getElementById("overlay-open") != null){
    let open = document.getElementById("overlay-open");
    open.onclick = function () {
      $('#overlay').fadeIn();
      document.getElementById('modal-close-btn').onclick = function () {
        $('#overlay').fadeOut();
      };
      document.getElementById("delete-comformation-btn").onclick = function () {
        document.getElementById("delete-item").click();
      };
    };
  };
});