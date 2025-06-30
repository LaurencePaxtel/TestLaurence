
function FDPcheckboxManage($this) {

    //alert($($this).val());
	 var id=$($this).attr('id');
   //alert("ID:"+id);  
   
   //alert("checked "+$($this).is(':checked'));
   
   //document.getElementById("auc_services[]").value =document.getElementById("auc_services[]").value+';'+ id;
   
   document.getElementById("checked_values[]").value ="";
   
   var output=document.getElementById("fdp-hidden");
    
	
				var checkboxes = document.getElementsByTagName('input');
			
					for (var i=0, n=checkboxes.length;i<n;i++) {
						  if (checkboxes[i].checked) 
						  {
							
							var str = checkboxes[i].id;
							document.getElementById("checked_values[]").value =document.getElementById("checked_values[]").value+str+' ';
							//document.getElementById("auc_services[]").value =document.getElementById("auc_services[]").value+checkboxes[i].checked+';'+str;
						 }
					}
	/*Remove(id);
	
	var i = document.createElement("input");
	i.setAttribute('id','H_'+id);
	i.setAttribute('name','H_'+id);
	i.setAttribute('type',"text");
	i.value = id;
	i.setAttribute("data-val", id);
	output.appendChild(i);*/
		
		
	//$($this).val($($this).val());
	
	/*if (document.getElementById("services[]").checked) {
		document.getElementById("auc_services").value = 25;
	}
	else {
		document.getElementById("binder_discount").value = '';
	}*/
}


function Remove(EId)
{
	var element =  document.getElementById(EId);
	
   if (typeof(element) != 'undefined' && element != null) {
		return(EObj=document.getElementById(EId))?EObj.parentNode.removeChild(EObj):false;
	 }
}