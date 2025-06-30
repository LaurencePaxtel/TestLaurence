//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 02/06/2020, 09:02:40
// ----------------------------------------------------
// Method: Web_GL_Get_Stkm_TS
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($O_Data; $object)
C_LONGINT:C283($i; $page; $limit; $id)
C_TEXT:C284($JSON)

C_TEXT:C284($search_filtre_0; $search_filtre_1)

C_TEXT:C284($headers)
ARRAY OBJECT:C1221($tb_headers; 1)

ARRAY TEXT:C222($tb_headers_th; 0)
ARRAY POINTER:C280($tb_headers_values; 0)

C_POINTER:C301($ptr_ID)
$ptr_ID:=->[Stock_Mouvements:114]ID:1

APPEND TO ARRAY:C911($tb_headers_th; "Date")
APPEND TO ARRAY:C911($tb_headers_th; "Heure")
APPEND TO ARRAY:C911($tb_headers_th; "Nature")
APPEND TO ARRAY:C911($tb_headers_th; "Quantité")
APPEND TO ARRAY:C911($tb_headers_th; "Motif")
APPEND TO ARRAY:C911($tb_headers_th; "Emplacement")

APPEND TO ARRAY:C911($tb_headers_values; ->[Stock_Mouvements:114]STKM_Date:7)
APPEND TO ARRAY:C911($tb_headers_values; ->[Stock_Mouvements:114]STKM_Heure:8)
APPEND TO ARRAY:C911($tb_headers_values; ->[Stock_Mouvements:114]STKM_Nature:9)
APPEND TO ARRAY:C911($tb_headers_values; ->[Stock_Mouvements:114]STKM_Quantite:6)
APPEND TO ARRAY:C911($tb_headers_values; ->[Stock_Mouvements:114]STKM_Motif:11)
APPEND TO ARRAY:C911($tb_headers_values; ->[Stock_Mouvements:114]STKM_Emplacement:13)

READ ONLY:C145([Stock_Mouvements:114])

$O_Data:=Web_AGL_Get_Post_Json_Data(True:C214)

$page:=Num:C11(OB Get:C1224($O_Data; "page"; Est un texte:K8:3))
$limit:=Num:C11(OB Get:C1224($O_Data; "size"; Est un texte:K8:3))

$sortList:=""
$scol_no:=0
$fcol:=""
$fcol_no:=0

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
$search_filtre_0:=OB Get:C1224($O_Data; "fcol[0]"; Est un texte:K8:3)
$search_filtre_1:=OB Get:C1224($O_Data; "fcol[1]"; Est un texte:K8:3)
//$search_bien_id:=Num(OB Get($O_Data;"fcol[2]";Is text))

$id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))

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
QUERY:C277([Stock_Mouvements:114]; [Stock_Mouvements:114]STKM_EQU_ID:3=$id)
MultiSoc_Filter(->[Stock_Mouvements:114])

//----------------------------//
// Filters
//----------------------------//

//If ($search_filtre_0#"")
//QUERY SELECTION([Stock_Mouvements];[Equipement]EQU_Type="@"+$search_filtre_0+"@")
//End if 

//If ($search_filtre_1#"")
//QUERY SELECTION([Equipement];[Equipement]EQU_Nom="@"+$search_filtre_1+"@")
//End if 

$total_rows:=Records in selection:C76([Stock_Mouvements:114])

//=====================================//
// Sorting
//======================================//
If ($sortList#"")
	If ($sortList="0")
		ORDER BY:C49([Stock_Mouvements:114]; $tb_headers_values{$scol_no}->; <)
	Else 
		ORDER BY:C49([Stock_Mouvements:114]; $tb_headers_values{$scol_no}->; >)
	End if 
End if 

$JSON:="{\"total_rows\":"+String:C10($total_rows)+",\"headers\":["
$JSON:=$JSON+$headers_formatted
$JSON:=$JSON+"],\"rows\":["

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

ARRAY OBJECT:C1221($tb_result; $total_rows)

//Pagination
$records_counter:=Records in selection:C76([Stock_Mouvements:114])
ARRAY LONGINT:C221($tb_numEnr; $records_counter)
For ($i; 1; $records_counter)
	$tb_numEnr{$i}:=$i
End for 

$page_start:=($page*$limit)+1

$i:=1

For ($k; $page_start; $records_counter)
	
	GOTO SELECTED RECORD:C245([Stock_Mouvements:114]; $tb_numEnr{$k})
	
	If ($i>1)
		$JSON:=$JSON+","
	End if 
	
	$JSON:=$JSON+"{"
	For ($j; 1; Size of array:C274($tb_headers_th))
		
		UTL_JSON_CLEAN($tb_headers_values{$j})
		
		QUERY:C277([Stock:113]; [Stock:113]STK_EQU_ID:3=[Equipement:107]ID:1)
		MultiSoc_Filter(->[Stock:113])
		
		Case of 
				//: ($tb_headers_values{$j}=$ptr_ID)
				
				//$value_spec:=""
				//$chx_disabled:=""
				
				//$value_spec:="<input type='checkbox' id='chx_"+String([Equipement]ID)+"' name='chx_"+String([Equipement]ID)+"' "+$chx_disabled+" class='iw_select' style='text-align:left;margin:0px 5px 0px 0px;'>"
				//$value_spec:=$value_spec+"<input type='hidden' id='id"+String([Equipement]ID)+"' name='id"+String([Equipement]ID)+"' value='"+String([Equipement]ID)+"'>"
				
				//$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div class='iw_text_center' id="+String([Factures]ID)+">"+$value_spec+"</div>\""
				
			Else 
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id='"+String:C10([Stock_Mouvements:114]ID:1)+"'>"+String:C10($tb_headers_values{$j}->)+"</div>\""
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
	
End for 

$JSON:=$JSON+"]"

$JSON:=$JSON+"}"

WEB_UTL_send_json($JSON)


