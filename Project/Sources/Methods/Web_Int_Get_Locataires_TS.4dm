//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 16/12/19, 15:06:08
// ----------------------------------------------------
// Method: Web_Int_Get_Locataires_TS
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_TEXT:C284($data_label; $type; $nom; $prenom; $lien_famille; $telephone; $usager_type; $display_type; $sortList; $fcol; $JSON; $headers; $css_class; $value_spec; $chx_disabled)
C_LONGINT:C283($count_fiches; $i; $page; $limit; $scol_no; $fcol_no; $records_counter)
C_BOOLEAN:C305($query)
C_DATE:C307($date_naissance)
C_OBJECT:C1216($O_Data; $object)
C_POINTER:C301($ptr_ID; $ptr_loc_encours)

ARRAY TEXT:C222($tb_headers_th; 0)
ARRAY OBJECT:C1221($tb_headers; 1)
ARRAY POINTER:C280($tb_headers_values; 0)

$data_label:=$1
$type:=$2

APPEND TO ARRAY:C911($tb_headers_th; " ")
APPEND TO ARRAY:C911($tb_headers_th; "Clé")
APPEND TO ARRAY:C911($tb_headers_th; "Nom")
APPEND TO ARRAY:C911($tb_headers_th; "Prénom")
APPEND TO ARRAY:C911($tb_headers_th; "Date de naissance")
APPEND TO ARRAY:C911($tb_headers_th; "Type locataire")
APPEND TO ARRAY:C911($tb_headers_th; "Lien de famille")
APPEND TO ARRAY:C911($tb_headers_th; "Tél")
APPEND TO ARRAY:C911($tb_headers_th; "Location en cours")

APPEND TO ARRAY:C911($tb_headers_values; ->[HeBerge:4]ID:65)
APPEND TO ARRAY:C911($tb_headers_values; ->[HeBerge:4]HB_Clé:2)
APPEND TO ARRAY:C911($tb_headers_values; ->[HeBerge:4]HB_Nom:3)
APPEND TO ARRAY:C911($tb_headers_values; ->[HeBerge:4]HB_Prénom:4)
APPEND TO ARRAY:C911($tb_headers_values; ->[HeBerge:4]HB_DateNéLe:5)
APPEND TO ARRAY:C911($tb_headers_values; ->[HeBerge:4]HB_Type_Locataire:70)
APPEND TO ARRAY:C911($tb_headers_values; ->[HeBerge:4]HB_Trans_CléFam:56)
APPEND TO ARRAY:C911($tb_headers_values; ->[HeBerge:4]HB_Telephone:66)
APPEND TO ARRAY:C911($tb_headers_values; ->[HeBerge:4]HB_Cas1:7)  //***

READ ONLY:C145([HeBerge:4])

$O_Data:=Web_AGL_Get_Post_Json_Data(True:C214)

$page:=Num:C11(OB Get:C1224($O_Data; "page"; Est un texte:K8:3))
$limit:=Num:C11(OB Get:C1224($O_Data; "size"; Est un texte:K8:3))

//=========================================//
// Generic Sorting & Filters
//=========================================//
For ($i; 0; Size of array:C274($tb_headers_th)-1)
	
	If ($sortList="")
		$sortList:=OB Get:C1224($O_Data; "col["+String:C10($i)+"]"; Est un texte:K8:3)
		
		$scol_no:=$i
	End if 
	
	If ($fcol="")
		$fcol:=OB Get:C1224($O_Data; "fcol["+String:C10($i)+"]"; Est un texte:K8:3)
		
		$fcol_no:=$i
	End if 
	
End for 

$scol_no:=$scol_no+1
$fcol_no:=$fcol_no+1

//=========================================//
// External Filters
//=========================================//
$search_date_du:=Date:C102(OB Get:C1224($O_Data; "fcol[1]"; Est un texte:K8:3))
$search_date_au:=Date:C102(OB Get:C1224($O_Data; "fcol[2]"; Est un texte:K8:3))

//**********************
$nom:=OB Get:C1224($O_Data; "fcol[2]"; Est un texte:K8:3)
$prenom:=OB Get:C1224($O_Data; "fcol[3]"; Est un texte:K8:3)

$lien_famille:=OB Get:C1224($O_Data; "fcol[6]"; Est un texte:K8:3)
$telephone:=OB Get:C1224($O_Data; "fcol[7]"; Est un texte:K8:3)
$date_naissance:=Date:C102(OB Get:C1224($O_Data; "fcol[4]"; Est un texte:K8:3))

$usager_type:=OB Get:C1224($O_Data; "fcol[5]"; Est un texte:K8:3)
$display_type:=OB Get:C1224($O_Data; "fcol[8]"; Est un texte:K8:3)

READ ONLY:C145([HeBerge:4])

$nom:=$nom+"@"
$prenom:=$prenom+"@"

If ($display_type#"default")
	
	If ($nom#"")
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Nom:3=$nom)
		$query:=True:C214
	End if 
	
	If ($prenom#"")
		
		If ($query)
			QUERY SELECTION:C341([HeBerge:4]; [HeBerge:4]HB_Prénom:4=$prenom)
		Else 
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Prénom:4=$prenom)
			
			$query:=True:C214
		End if 
		
	End if 
	
	If ($date_naissance#!00-00-00!)
		
		If ($query)
			QUERY SELECTION:C341([HeBerge:4]; [HeBerge:4]HB_DateNéLe:5=$date_naissance)
		Else 
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_DateNéLe:5=$date_naissance)
			
			$query:=True:C214
		End if 
		
	End if 
	
	If ($telephone#"")
		
		If ($query)
			QUERY SELECTION:C341([HeBerge:4]; [HeBerge:4]HB_Prénom:4=$telephone)
		Else 
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Prénom:4=$telephone)
		End if 
		
	End if 
	
Else 
	
	If ($usager_type="locataire")  //Locataires actifs par défaut
		READ ONLY:C145([Locations:84])
		
		QUERY:C277([Locations:84]; [Locations:84]LOC_Date_Sortie:10>Current date:C33(*))
		MultiSoc_Filter(->[Locations:84])
		
		ARRAY LONGINT:C221($tb_id_tmp; 0)
		SELECTION TO ARRAY:C260([Locations:84]LOC_HB_ID:3; $tb_id_tmp)
		
		QUERY WITH ARRAY:C644([HeBerge:4]ID:65; $tb_id_tmp)
		
		If (Records in selection:C76([HeBerge:4])=0)
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Locataire:71=True:C214)
		End if 
		
	Else 
		ALL RECORDS:C47([HeBerge:4])
		
		$query:=True:C214
	End if 
	
End if 

If ($usager_type="locataire")  //Locataires actifs par défaut
	QUERY SELECTION:C341([HeBerge:4]; [HeBerge:4]HB_Locataire:71=True:C214)
	ORDER BY:C49([HeBerge:4]; [HeBerge:4]ID:65; <)
	
	$query:=True:C214
End if 

If ($query)
	MultiSoc_Filter(->[HeBerge:4])
End if 

ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Nom:3; >)

//**********************
// JSON
$headers:=""
$headers_formatted:=""

For ($i; 1; Size of array:C274($tb_headers_th))
	Web_URL_Format_Header(->$tb_headers_th{$i})
	
	$headers:=$headers+$tb_headers_th{$i}
	$headers_formatted:=$headers_formatted+"\""+$tb_headers_th{$i}+"\""
	
	If ($i<Size of array:C274($tb_headers_th))
		$headers:=$headers+","
		$headers_formatted:=$headers_formatted+","
	End if 
	
End for 

OB SET:C1220($tb_headers{1}; "headers"; $headers)

OB SET ARRAY:C1227($object; "headers"; $tb_headers)
OB SET ARRAY:C1227($object; "rows"; $tb_result)

$JSON:=JSON Stringify:C1217($object)

//=============================================//
// Sélection des données
//=============================================//
$total_rows:=Records in selection:C76([HeBerge:4])

//=====================================//
// Sorting
//======================================//
If ($sortList#"")
	
	If ($sortList="0")
		ORDER BY:C49([HeBerge:4]; $tb_headers_values{$scol_no}->; <)
	Else 
		ORDER BY:C49([HeBerge:4]; $tb_headers_values{$scol_no}->; >)
	End if 
	
End if 

$JSON:="{\"total_rows\":"+String:C10($total_rows)+",\"headers\":["
$JSON:=$JSON+$headers_formatted
$JSON:=$JSON+"],\"rows\":["

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

ARRAY OBJECT:C1221($tb_result; $total_rows)

//Pagination
$records_counter:=Records in selection:C76([HeBerge:4])
ARRAY LONGINT:C221($tb_numEnr; $records_counter)

For ($i; 1; $records_counter)
	$tb_numEnr{$i}:=$i
End for 

$page_start:=($page*$limit)+1
$i:=1

$ptr_ID:=->[HeBerge:4]ID:65
$ptr_loc_encours:=->[HeBerge:4]HB_Cas1:7

For ($k; $page_start; $records_counter)
	GOTO SELECTED RECORD:C245([HeBerge:4]; $tb_numEnr{$k})
	
	If ($i>1)
		$JSON:=$JSON+","
	End if 
	
	$JSON:=$JSON+"{"
	
	If ([HeBerge:4]HB_Type_Locataire:70="locataire")
		$css_class:="fdp_blue"
	End if 
	
	For ($j; 1; Size of array:C274($tb_headers_th))
		
		Case of 
			: ($tb_headers_values{$j}=$ptr_ID)
				
				If ([HeBerge:4]HB_Type_Locataire:70="locataire")
					SET QUERY DESTINATION:C396(Vers variable:K19:4; $count_fiches)
					
					QUERY:C277([Locations:84]; [Locations:84]LOC_HB_ID:3=[HeBerge:4]ID:65)
					MultiSoc_Filter(->[Locations:84])
					
					If ($count_fiches<=0)
						$value_spec:="<input type='checkbox' id='chx_"+String:C10([HeBerge:4]ID:65)+"' name='chx_"+String:C10([HeBerge:4]ID:65)+"' "+$chx_disabled+" class='iw_select' style='text-align:left;margin:0px 5px 0px 0px;'>"
					End if 
					
					SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
				End if 
				
				$value_spec:=$value_spec+"<input type='hidden' id='id"+String:C10([HeBerge:4]ID:65)+"' name='id"+String:C10([HeBerge:4]ID:65)+"' value='"+String:C10([HeBerge:4]ID:65)+"'>"
				$value_spec:=$value_spec+"<input type='hidden' id='refid"+String:C10([HeBerge:4]HB_ReferenceID:1)+"' id='refid"+String:C10([HeBerge:4]HB_ReferenceID:1)+"' value='"+String:C10([HeBerge:4]HB_ReferenceID:1)+"'>"
				$value_spec:=$value_spec+"<input type='hidden' id='clev"+String:C10([HeBerge:4]HB_ReferenceID:1)+"' id='clev"+String:C10([HeBerge:4]HB_ReferenceID:1)+"' value='"+String:C10([HeBerge:4]HB_ReferenceID:1)+"'>"
				
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div class='iw_text_center ' id="+String:C10([HeBerge:4]ID:65)+" >"+$value_spec+"</div>\""
			: ($tb_headers_values{$j}=$ptr_loc_encours)
				SET QUERY DESTINATION:C396(Vers variable:K19:4; $count_fiches)
				
				QUERY:C277([Locations:84]; [Locations:84]LOC_Date_Sortie:10>Current date:C33(*); *)
				QUERY:C277([Locations:84];  & ; [Locations:84]LOC_HB_ID:3=[HeBerge:4]ID:65)
				
				MultiSoc_Filter(->[Locations:84])
				
				$locations_encours:=False:C215
				
				If ($count_fiches>0)
					$locations_encours:=True:C214
					$value_spec:="<i class='fa fa-check-square-o fdp-icon-green'></i>"
				End if 
				
				SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
				
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div class='iw_text_center' id="+String:C10([HeBerge:4]ID:65)+">"+$value_spec+"</div>\""
			Else 
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id="+String:C10([HeBerge:4]HB_ReferenceID:1)+" class='"+$css_class+"'>"+String:C10($tb_headers_values{$j}->)+"</div>\""
		End case 
		
		If ($j<Size of array:C274($tb_headers_th))
			$JSON:=$JSON+","
		End if 
		
	End for 
	
	$JSON:=$JSON+"}"
	
	If ($i=$limit)
		$k:=$records_counter
	End if 
	
	$i:=$i+1
	
	CLEAR VARIABLE:C89($chx_disabled)
	CLEAR VARIABLE:C89($value_spec)
	CLEAR VARIABLE:C89($css_class)
End for 

$JSON:=$JSON+"]"
$JSON:=$JSON+"}"

WEB_UTL_send_json($JSON)