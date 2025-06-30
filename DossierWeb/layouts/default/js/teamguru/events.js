     $('.event_type').change(function(e){

       document.getElementById("schedule").action ="/EVE?action=schedule&type="+$(this).val();
       document.getElementById("type").value =$(this).val();
       $("form").submit()

    });

