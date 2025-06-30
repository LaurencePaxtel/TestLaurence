//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 11-04-19, 13:19:45
// ----------------------------------------------------
// Method: Web_GB_Get_Documents
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($O_Data; $object)
C_LONGINT:C283($i; $page; $limit)
C_DATE:C307($search_date_du; $search_date_au)
C_TEXT:C284($JSON)

C_TEXT:C284($headers)
ARRAY OBJECT:C1221($tb_headers; 1)

ARRAY TEXT:C222($tb_headers_th; 0)
ARRAY POINTER:C280($tb_headers_values; 0)

APPEND TO ARRAY:C911($tb_headers_th; "ID")
APPEND TO ARRAY:C911($tb_headers_th; "Date")
APPEND TO ARRAY:C911($tb_headers_th; "Nom")
APPEND TO ARRAY:C911($tb_headers_th; "Titre")
APPEND TO ARRAY:C911($tb_headers_th; "Type")
APPEND TO ARRAY:C911($tb_headers_th; "Version")

APPEND TO ARRAY:C911($tb_headers_values; ->[Base_documentaire:90]ID:1)
APPEND TO ARRAY:C911($tb_headers_values; ->[Base_documentaire:90]DOC_Date:7)
APPEND TO ARRAY:C911($tb_headers_values; ->[Base_documentaire:90]DOC_Document_Nom:6)
APPEND TO ARRAY:C911($tb_headers_values; ->[Base_documentaire:90]DOC_Titre:8)
APPEND TO ARRAY:C911($tb_headers_values; ->[Base_documentaire:90]DOC_Document_Type:3)
APPEND TO ARRAY:C911($tb_headers_values; ->[Base_documentaire:90]DOC_Version:10)


//LECTURE SEULEMENT([Base_documentaire])

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
$search_date_du:=Date:C102(OB Get:C1224($O_Data; "fcol[1]"; Est un texte:K8:3))
$search_date_au:=Date:C102(OB Get:C1224($O_Data; "fcol[2]"; Est un texte:K8:3))

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
ALL RECORDS:C47([Base_documentaire:90])
MultiSoc_Filter(->[Base_documentaire:90])

ORDER BY:C49([Base_documentaire:90]; [Base_documentaire:90]DOC_Date:7; <)

//Filters

If (($search_date_du#!00-00-00!) & ($search_date_au#!00-00-00!))
	QUERY SELECTION:C341([Base_documentaire:90]; [Base_documentaire:90]DOC_Date:7>=$search_date_du; *)
	QUERY SELECTION:C341([Base_documentaire:90];  & ; [Base_documentaire:90]DOC_Date:7<=$search_date_au)
End if 

$total_rows:=Records in selection:C76([Base_documentaire:90])

//=====================================//
// Sorting
//======================================//
If ($sortList#"")
	If ($sortList="0")
		ORDER BY:C49([Base_documentaire:90]; $tb_headers_values{$scol_no}->; <)
	Else 
		ORDER BY:C49([Base_documentaire:90]; $tb_headers_values{$scol_no}->; >)
	End if 
End if 

$JSON:="{\"total_rows\":"+String:C10($total_rows)+",\"headers\":["
$JSON:=$JSON+$headers_formatted
$JSON:=$JSON+"],\"rows\":["

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)


ARRAY OBJECT:C1221($tb_result; $total_rows)

//Pagination
$records_counter:=Records in selection:C76([Base_documentaire:90])
ARRAY LONGINT:C221($tb_numEnr; $records_counter)
For ($i; 1; $records_counter)
	$tb_numEnr{$i}:=$i
End for 

$page_start:=($page*$limit)+1

$i:=1

For ($k; $page_start; $records_counter)
	
	GOTO SELECTED RECORD:C245([Base_documentaire:90]; $tb_numEnr{$k})
	
	If ($i>1)
		$JSON:=$JSON+","
	End if 
	
	$JSON:=$JSON+"{"
	For ($j; 1; Size of array:C274($tb_headers_th))
		
		
		$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id="+String:C10([Base_documentaire:90]ID:1)+">"+String:C10($tb_headers_values{$j}->)+"</div>\""
		
		
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


