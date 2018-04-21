$(function() {
  var chkbox = $("#user_terms_of_service");
  //__________________submit button disabled unless Conditions Checked Signup
  sign_up_button = $("#sign_up_btn_js_slider");
  sign_up_button.attr("disabled","disabled");
  chkbox.change(function(){
      if(this.checked){
        if($('#pack').val()) {
          sign_up_button.removeAttr("disabled");
        }
      }else{
        sign_up_button.attr("disabled","disabled");
      }
  });
  //__________________submit button disabled unless Conditions Checked Onboarding
  onboarding_button = $("#onboarding");
  onboarding_button.attr("disabled","disabled");
  chkbox.change(function(){
      if(this.checked){
        onboarding_button.removeAttr("disabled");
      }else{
        onboarding_button.attr("disabled","disabled");
      }
  });

  $('[data-pack-selector]').on('click', function() {
    var selector = $(this);
    $('[data-pack-selector].hover').removeClass('hover').text('SELECT');
    selector.addClass('hover').text('SELECTED');
    $('#pack').val(selector.attr('data-pack-selector'));
    if(chkbox.prop('checked')) sign_up_button.removeAttr("disabled");
  });
});
