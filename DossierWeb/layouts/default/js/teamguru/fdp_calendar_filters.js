$(document).ready(function() {

    var uidt=$('#f_eve_uid_team option:selected').val();

    $('#f_eve_uid_team').change(function(){

        $("#calendar").fullCalendar('removeEvents');

        var uidt=$('#f_eve_uid_team option:selected').val();

        $.ajax({
            type:"GET",
            url:'/EVE?action=getsjoncal&uidt='+uidt, 
            success: function(events){

              $('#calendar').fullCalendar('addEventSource', '/EVE?action=getsjoncal&uidt='+uidt);
              $('#calendar').fullCalendar('render');

            }
        });

    });


});