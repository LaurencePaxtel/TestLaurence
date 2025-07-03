		 
 $(document).ready(function(){  

   //============================================//
   // DASHBOARD
   //============================================//
	$("#btn_dashboard_factures").click(function(ev){ 
	    $(location).attr('href', '/GL?action=factures');        
	});  
	$("#btn_dashboard_reglements").click(function(ev){ 
	    $(location).attr('href', '/GL?action=reglements');        
	}); 
	$("#btn_dashboard_locataires").click(function(ev){ 
	    $(location).attr('href', '/GL?home');        
	}); 
	$("#btn_dashboard_proprietaires").click(function(ev){ 
	    $(location).attr('href', '/GL?action=proprietaires');        
	}); 
	$("#btn_dashboard_biens").click(function(ev){ 
	    $(location).attr('href', '/GL?action=biens');        
	}); 
	$("#btn_dashboard_relances").click(function(ev){ 
	    $(location).attr('href', '/GL?action=relances');        
	}); 
	$("#btn_dashboard_irl").click(function(ev){ 
	    $(location).attr('href', '/GL?action=irl');        
	}); 

 });  
