




  window.fbAsyncInit = function() {
    FB.init({
      appId      : '119617478537516',
      xfbml      : true,
      version    : 'v2.8'
    });
    FB.AppEvents.logPageView();
  };

  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "//connect.facebook.net/en_US/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));




function LoginFB(){

  FB.login(function(response) {

      console.log(response);
      
      var ibaccessToken=response.authResponse.accessToken;

      if (response.authResponse) {
        console.log('Welcome!  Fetching your information.... ');

        var url = '/me?fields=name,email,first_name,last_name,gender';

        FB.api(url, function(response) {

           console.log('Good to see you, ' + response.name + '.');
           console.log('ID  ' + response.id + '.');
           console.log('Email ' + response.email + '.');
           console.log('gender ' + response.gender + '.');
           console.log('first_name ' + response.first_name + '.');
           console.log('last_name ' + response.last_name + '.');
           //console.log('languages ' + response.languages + '.');

           console.log('AccessToken ' + ibaccessToken + '.');

           document.getElementById('fbmail').value=response.email;
           document.getElementById('fbid').value=response.id;
           document.getElementById('fbtoken').value=ibaccessToken;

           document.getElementById('fb_first_name').value=response.first_name;
           document.getElementById('fb_last_name').value=response.last_name;
           document.getElementById('fb_gender').value=response.gender;

          // document.getElementById('fbmail').value=response.email;

           document.getElementById("login").submit();
           

/*var xhReq = new XMLHttpRequest();
xhReq.open("GET", "http://localhost/login&type=fblogin&fbmail="+response.email+"&id="+response.id+"&token="+ibaccessToken);
xhReq.send(null);
var serverResponse = xhReq.responseText;*/
 //alert(serverResponse); // Shows "15"

          });
      } else {
        console.log('User cancelled login or did not fully authorize.');
      }
    }, {scope:'email,user_birthday'}
    );

}











/*(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/fr_FR/sdk.js#xfbml=1&version=v2.8&appId=119617478537516";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

function LoginFB(){

FB.login(function(response) {
      console.log(response);
      if (response.authResponse) {
        console.log('Welcome!  Fetching your information.... ');
        FB.api('/me', function(response) {
          });
      } else {
        console.log('User cancelled login or did not fully authorize.');
      }
    }, {scope:'user_about_me,user_birthday,manage_pages,pages_show_list,publish_actions,manage_pages,publish_pages'}
    );

}*/