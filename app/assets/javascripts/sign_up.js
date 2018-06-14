$(function() {
  var chkbox1 = $("#user_terms_of_service");
  var chkbox2 = $("#user_data_use");
  //__________________submit button disabled unless Conditions Checked Signup
  sign_up_button = $("#sign_up_btn_js_slider");
  sign_up_button.attr("disabled","disabled");
  chkbox1.change(function(){
      if(this.checked){
        if($('#pack').val() && chkbox2.prop('checked')) {
          sign_up_button.removeAttr("disabled");
        }
      }else{
        sign_up_button.attr("disabled","disabled");
      }
  });
  chkbox2.change(function(){
      if(this.checked){
        if($('#pack').val() && chkbox1.prop('checked')) {
          sign_up_button.removeAttr("disabled");
        }
      }else{
        sign_up_button.attr("disabled","disabled");
      }
  });
  //__________________submit button disabled unless Conditions Checked Onboarding
  onboarding_button = $("#onboarding");
  onboarding_button.attr("disabled","disabled");
  chkbox1.change(function(){
      if(this.checked){
        onboarding_button.removeAttr("disabled");
      }else{
        onboarding_button.attr("disabled","disabled");
      }
  });

  var form = $('.sign-up-body').first();

  $('[data-pack-selector]').on('click', function() {
    var selector = $(this);
    $('[data-pack-selector].hover').removeClass('hover').text('SELECT');
    selector.addClass('hover').text('SELECTED');
    $('#pack').val(selector.attr('data-pack-selector'));
    if(chkbox1.prop('checked') && chkbox2.prop('checked')) sign_up_button.removeAttr("disabled");
    if(form.length) {
      setTimeout(function() {
        $('body').animate({
          scrollTop: Math.min(form.offset().top - 100, document.body.offsetHeight - window.innerHeight)
        });

        $('#user_email').focus();
      }, 300);
    }
  });
});
