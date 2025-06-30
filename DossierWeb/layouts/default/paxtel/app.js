$(document).ready(function(){  

    function Get_Address($id){
        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

        $.LoadingOverlay("show");

		var data_address = { 
			"id": $id
		};

		var data = { 
			"zone":"cg", 
			"action":"get_address",
			"data": {
				"address": data_address
			}
		};

		var data_json = '&json='+JSON.stringify(data);

		$.getJSON("/CG?action=get_address",data_json, function(data){  

			$.each(data, function(key, value){ 
				$("#ad_adresse1").attr('value', value.ad_adresse1);
				$("#ad_adresse2").attr('value', value.ad_adresse2);
				$("#ad_adresse3").attr('value', value.ad_adresse3);
				$("#ad_code_postal").attr('value', value.ad_code_postal);
				$("#ad_ville").attr('value', value.ad_ville);
			});  
			
		}).done(function() {
		})
		.fail(function() {
		})
		.always(function() {
			$.LoadingOverlay("hide");
		});  

    }

});