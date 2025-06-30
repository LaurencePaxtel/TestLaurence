
$("#submit_tmbasicinfo").click(function(){
    $("#team_settings_content").clone().appendTo("#team_basicinfo");
    $("#team_settings_content").addClass("fdp-hide");
    $("#team_rooster_content").clone().appendTo("#team_basicinfo");
    $("#team_rooster_content").addClass("fdp-hide");
});

$("#submit_tmsettings").click(function(){
    $('#submit_tmbasicinfo').trigger('click');
});

$("#submit_tmrooster").click(function(){
    $("#sform").val("form-player");
    $('#submit_tmbasicinfo').trigger('click');
});

$("#submit_tmrooster_save_close").click(function(){
	$("#saction").val("add-player");	
	$("#staction").val("save_and_new");
    $('#submit_tmrooster').trigger('click');
});


$("#submit_schedule_save_close").click(function(){
	$("#saction").val("add-event");	
	$("#staction").val("save_and_new");
    $('#submit_schedule_save').trigger('click');
});




