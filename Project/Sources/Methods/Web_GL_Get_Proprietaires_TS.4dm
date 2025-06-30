//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 24/10/2020, 08:40:33
// ----------------------------------------------------
// Method: Web_GL_Get_Proprietaires_TS
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($O_Data; $object)
C_LONGINT:C283($i; $page; $limit; $pos)
C_TEXT:C284($JSON; $headers; $search_filtre_0; $search_filtre_1; $search_filtre_2; $search_filtre_3)
ARRAY OBJECT:C1221($tb_headers; 1)
C_POINTER:C301($table_ptr; $ptr_ID)

$table_ptr:=->[Proprietaires:83]
$ptr_ID:=->[Proprietaires:83]ID:1

READ ONLY:C145($table_ptr->)

ARRAY TEXT:C222($tb_headers_th; 0)
ARRAY POINTER:C280($tb_headers_values; 0)

APPEND TO ARRAY:C911($tb_headers_th; "Nom")
APPEND TO ARRAY:C911($tb_headers_th; "Prénom")
APPEND TO ARRAY:C911($tb_headers_th; "Téléphone")
APPEND TO ARRAY:C911($tb_headers_th; "E-mail")

APPEND TO ARRAY:C911($tb_headers_values; ->[Proprietaires:83]PRO_Nom:2)
APPEND TO ARRAY:C911($tb_headers_values; ->[Proprietaires:83]PRO_Prenom:3)
APPEND TO ARRAY:C911($tb_headers_values; ->[Proprietaires:83]PRO_Telephone:4)
APPEND TO ARRAY:C911($tb_headers_values; ->[Proprietaires:83]PRO_Email:5)

ARRAY POINTER:C280($tb_except_sort; 0)

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
$search_filtre_2:=OB Get:C1224($O_Data; "fcol[2]"; Est un texte:K8:3)
$search_filtre_3:=OB Get:C1224($O_Data; "fcol[3]"; Est un texte:K8:3)

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
READ ONLY:C145($table_ptr->)
ALL RECORDS:C47($table_ptr->)
MultiSoc_Filter($table_ptr)

//----------------------------//
// Filters
//----------------------------//

If ($search_filtre_0#"")
	QUERY SELECTION:C341([Proprietaires:83]; [Proprietaires:83]PRO_Nom:2="@"+$search_filtre_0+"@")
End if 

If ($search_filtre_1#"")
	QUERY SELECTION:C341([Proprietaires:83]; [Proprietaires:83]PRO_Prenom:3="@"+$search_filtre_1+"@")
End if 

If ($search_filtre_2#"")
	QUERY SELECTION:C341([Proprietaires:83]; [Proprietaires:83]PRO_Telephone:4="@"+$search_filtre_2+"@")
End if 

If ($search_filtre_3#"")
	QUERY SELECTION:C341([Proprietaires:83]; [Proprietaires:83]PRO_Email:5="@"+$search_filtre_3+"@")
End if 

$total_rows:=Records in selection:C76([Proprietaires:83])

//=====================================//
// Sorting
//======================================//
If ($sortList#"")
	$pos:=Find in array:C230($tb_except_sort; $tb_headers_values{$scol_no})
	If ($pos<0)
		If ($sortList="0")
			ORDER BY:C49($table_ptr->; $tb_headers_values{$scol_no}->; <)
		Else 
			ORDER BY:C49($table_ptr->; $tb_headers_values{$scol_no}->; >)
		End if 
	End if 
End if 

$JSON:="{\"total_rows\":"+String:C10($total_rows)+",\"headers\":["
$JSON:=$JSON+$headers_formatted
$JSON:=$JSON+"],\"rows\":["

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)


ARRAY OBJECT:C1221($tb_result; $total_rows)

//Pagination
$records_counter:=Records in selection:C76($table_ptr->)
ARRAY LONGINT:C221($tb_numEnr; $records_counter)
For ($i; 1; $records_counter)
	$tb_numEnr{$i}:=$i
End for 

$page_start:=($page*$limit)+1

$i:=1

For ($k; $page_start; $records_counter)
	
	GOTO SELECTED RECORD:C245($table_ptr->; $tb_numEnr{$k})
	
	If ($i>1)
		$JSON:=$JSON+","
	End if 
	
	$JSON:=$JSON+"{"
	For ($j; 1; Size of array:C274($tb_headers_th))
		
		UTL_JSON_CLEAN($tb_headers_values{$j})
		
		Case of 
			: ($tb_headers_values{$j}=$ptr_ID)
				
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id='"+String:C10($ptr_ID->)+"'>"+String:C10($tb_headers_values{$j}->)+"</div>\""
				
			Else 
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id='"+String:C10($ptr_ID->)+"'>"+String:C10($tb_headers_values{$j}->)+"</div>\""
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