    $('select').change(function(e){

       document.getElementById("buy-subscription").action ="manager?action=buy-subscription&saction=plan";
       document.getElementById("saction").value="plan"; 
      //var length = $('option:selected', this).length;
      //alert('ok');
        //$('#profile').submit();
       // document.getElementById('method').value='GET';
        //document.getElementById("buy-subscription").method ="GET";
         $("#submit").trigger("click"); 
        // document.getElementById('method').value='GET';
        // document.getElementById("buy-subscription").method ="GET";
        // alert('ok');

    });


    function chgAction(type,period)
        {
            if(type=='true'){

                  document.getElementById("buy-subscription").action ="https://www.sandbox.paypal.com/cgi-bin/webscr";

                  var number_of_users=document.getElementById("number_of_users").value; 

                    document.getElementById("pp_item_name").value ="Subscription : "+number_of_users+" - Teamguru.ca";
                    document.getElementById("pp_amount").value =document.getElementById("pp_monthly_price").value;
                  

            }else{
                 document.getElementById("buy-subscription").action ="manager?action=buy-subscription&saction=plan";
            }
              
             // document.getElementById("buy-subscription").submit();

        }    


