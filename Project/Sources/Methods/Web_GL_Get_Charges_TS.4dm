//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 14/07/2020, 12:00:32
// ----------------------------------------------------
// Method: Web_GL_Get_Charges_TS
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($JSON; $header_value; $css_class; $lig_value; $search_filtre_0; $search_filtre_1; $search_filtre_2; $search_filtre_3; $search_filtre_4; $search_filtre_5; $headers; \
$headers_formatted; $hd_emplacement_txt; $hd_immeuble_txt; $sortList; $fcol)
C_LONGINT:C283($i; $page; $limit; $scol_no; $fcol_no; $records_counter; $total_rows)
C_POINTER:C301($ptr_ID; $hd_emplacement; $hd_immeuble)
C_OBJECT:C1216($O_Data; $object)

ARRAY OBJECT:C1221($tb_headers; 1)
ARRAY TEXT:C222($tb_headers_th; 0)

ARRAY POINTER:C280($tb_headers_values; 0)


$ptr_ID:=->[Charges:92]ID:1

$hd_emplacement_txt:="Logement"
$hd_immeuble_txt:="Immeuble"

$hd_emplacement:=->$hd_emplacement_txt
$hd_immeuble:=->$hd_immeuble_txt

APPEND TO ARRAY:C911($tb_headers_th; "Immeuble")
APPEND TO ARRAY:C911($tb_headers_th; "Logement")
APPEND TO ARRAY:C911($tb_headers_th; "Type de la charge")
APPEND TO ARRAY:C911($tb_headers_th; "Montant")
APPEND TO ARRAY:C911($tb_headers_th; "Période")

APPEND TO ARRAY:C911($tb_headers_values; $hd_immeuble)
APPEND TO ARRAY:C911($tb_headers_values; $hd_emplacement)
APPEND TO ARRAY:C911($tb_headers_values; ->[Charges:92]CHA_Libelle:3)
APPEND TO ARRAY:C911($tb_headers_values; ->[Charges:92]CHA_Montant:5)
APPEND TO ARRAY:C911($tb_headers_values; ->[Charges:92]CHA_Periode:11)

READ ONLY:C145([Charges:92])
READ ONLY:C145([Immeuble:105])
READ ONLY:C145([LesCentres:9])

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
$search_filtre_0:=OB Get:C1224($O_Data; "fcol[0]"; Est un texte:K8:3)
$search_filtre_1:=OB Get:C1224($O_Data; "fcol[1]"; Est un texte:K8:3)
$search_filtre_2:=OB Get:C1224($O_Data; "fcol[2]"; Est un texte:K8:3)
$search_filtre_3:=OB Get:C1224($O_Data; "fcol[3]"; Est un texte:K8:3)
$search_filtre_4:=OB Get:C1224($O_Data; "fcol[4]"; Est un texte:K8:3)
$search_filtre_5:=OB Get:C1224($O_Data; "fcol[5]"; Est un texte:K8:3)

// JSON
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
ALL RECORDS:C47([Charges:92])
MultiSoc_Filter(->[Charges:92])

//----------------------------//
// Filters
//----------------------------//

If ($search_filtre_0#"")
	
	QUERY:C277([Immeuble:105]; [Immeuble:105]IMM_Nom:3="@"+$search_filtre_0+"@")
	MultiSoc_Filter(->[Immeuble:105])
	
	ARRAY LONGINT:C221($tb_imm_ids; 0)
	SELECTION TO ARRAY:C260([Immeuble:105]ID:1; $tb_imm_ids)
	
	QUERY WITH ARRAY:C644([LesCentres:9]LC_Immeuble_ID:84; $tb_imm_ids)
	MultiSoc_Filter(->[LesCentres:9])
	
	ARRAY LONGINT:C221($tb_lc_ids; 0)
	SELECTION TO ARRAY:C260([LesCentres:9]ID:60; $tb_lc_ids)
	
	QUERY SELECTION WITH ARRAY:C1050([Charges:92]CHA_Origine_ID:6; $tb_lc_ids)
	
End if 

If ($search_filtre_1#"")
	
	QUERY:C277([LesCentres:9]; [LesCentres:9]LC_GL_Nom_Suite:63="@"+$search_filtre_1+"@")
	MultiSoc_Filter(->[LesCentres:9])
	
	ARRAY LONGINT:C221($tb_lc_ids; 0)
	SELECTION TO ARRAY:C260([LesCentres:9]ID:60; $tb_lc_ids)
	
	QUERY SELECTION WITH ARRAY:C1050([Charges:92]CHA_Origine_ID:6; $tb_lc_ids)
End if 

$total_rows:=Records in selection:C76([Charges:92])

//=====================================//
// Sorting
//======================================//
If ($sortList#"")
	
	If ($sortList="0")
		ORDER BY:C49([Charges:92]; $tb_headers_values{$scol_no}->; <)
	Else 
		ORDER BY:C49([Charges:92]; $tb_headers_values{$scol_no}->; >)
	End if 
	
End if 

$JSON:="{\"total_rows\":"+String:C10($total_rows)+",\"headers\":["
$JSON:=$JSON+$headers_formatted
$JSON:=$JSON+"],\"rows\":["

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)
ARRAY OBJECT:C1221($tb_result; $total_rows)

//Pagination
$records_counter:=Records in selection:C76([Charges:92])
ARRAY LONGINT:C221($tb_numEnr; $records_counter)

For ($i; 1; $records_counter)
	$tb_numEnr{$i}:=$i
End for 

$page_start:=($page*$limit)+1
$i:=1

For ($k; $page_start; $records_counter)
	GOTO SELECTED RECORD:C245([Charges:92]; $tb_numEnr{$k})
	
	If ($i>1)
		$JSON:=$JSON+","
	End if 
	
	$JSON:=$JSON+"{"
	For ($j; 1; Size of array:C274($tb_headers_th))
		
		UTL_JSON_CLEAN($tb_headers_values{$j})
		
		$css_class:=""
		$lig_value:=""
		
		Case of 
			: ($tb_headers_values{$j}=$ptr_ID)
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id='"+String:C10([Charges:92]ID:1)+"' class='"+$css_class+"' >"+String:C10($tb_headers_values{$j}->)+"</div>\""
			: ($tb_headers_values{$j}=$hd_immeuble)
				QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Charges:92]CHA_Origine_ID:6)
				MultiSoc_Filter(->[LesCentres:9])
				
				If (Records in selection:C76([LesCentres:9])=1)
					QUERY:C277([Immeuble:105]; [Immeuble:105]ID:1=[LesCentres:9]LC_Immeuble_ID:84)
					MultiSoc_Filter(->[Immeuble:105])
					
					If (Records in selection:C76([Immeuble:105])=1)
						$lig_value:=[Immeuble:105]IMM_Nom:3
					End if 
					
				End if 
				
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id='"+String:C10([Charges:92]ID:1)+"'>"+$lig_value+"</div>\""
			: ($tb_headers_values{$j}=$hd_emplacement)
				QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Charges:92]CHA_Origine_ID:6)
				MultiSoc_Filter(->[LesCentres:9])
				
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id='"+String:C10([Charges:92]ID:1)+"'>"+[LesCentres:9]LC_GL_Nom_Suite:63+"</div>\""
			Else 
				
				Case of 
					: (Type:C295($tb_headers_values{$j}->)=Est un numérique:K8:4)
						$header_value:=String:C10($tb_headers_values{$j}->; "###,###,##0.00")
					Else 
						$header_value:=String:C10($tb_headers_values{$j}->)
				End case 
				
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id='"+String:C10([Charges:92]ID:1)+"' class='"+$css_class+"' >"+$header_value+"</div>\""
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