    $('#uid_user').change(function(e){
      var length = $('option:selected', this).length;
      if ( length > 0 ) {
        //$('#profile').submit();
        document.getElementById('method').value='GET';
        document.getElementById("profile").method ="GET";
         $("#submit_hidden").trigger("click"); 
         document.getElementById('method').value='GET';
         document.getElementById("profile").method ="GET";
         //alert('ok');
      }
    });
