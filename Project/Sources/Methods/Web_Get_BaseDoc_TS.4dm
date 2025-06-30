//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 07/06/2020, 04:15:08
// ----------------------------------------------------
// Method: Web_Get_BaseDoc_TS
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($JSON; $header_value; $css_class; $module; $search_filtre_0; \
$search_filtre_1; $search_filtre_2; $search_filtre_3; $search_filtre_4; $search_filtre_5; $headers; $sortList; $fcol; \
$headers_formatted)
C_LONGINT:C283($i; $page; $limit; $field_number; $record_id; $table_num; $scol_no; $fcol_no)
C_POINTER:C301($ptr_table; $ptr_ID; $hd_imm_nom; $hd_bien_nom; $hd_intervention)
C_OBJECT:C1216($O_Data; $object)

ARRAY TEXT:C222($tb_headers_th; 0)
ARRAY LONGINT:C221($tb_ids; 0)
ARRAY POINTER:C280($tb_headers_values; 0)
ARRAY OBJECT:C1221($tb_headers; 1)

$ptr_table:=->[Base_documentaire:90]
$ptr_ID:=->[Base_documentaire:90]ID:1

$O_Data:=Web_AGL_Get_Post_Json_Data(True:C214)

$page:=Num:C11(OB Get:C1224($O_Data; "page"; Est un texte:K8:3))
$limit:=Num:C11(OB Get:C1224($O_Data; "size"; Est un texte:K8:3))

$module:=OB Get:C1224($O_Data; "module"; Est un texte:K8:3)
$record_id:=Num:C11(OB Get:C1224($O_Data; "record_id"; Est un texte:K8:3))
$table_num:=Num:C11(OB Get:C1224($O_Data; "table_num"; Est un texte:K8:3))

//=========================//
// Custom headers
//=========================//
$hd_imm_nom:=->[Immeuble:105]IMM_Nom:3
$hd_bien_nom:=->[LesCentres:9]LC_GL_Nom_Suite:63
$hd_intervention:=->[Intervention:108]INT_Numero:13

APPEND TO ARRAY:C911($tb_headers_th; " ")
APPEND TO ARRAY:C911($tb_headers_th; "Titre du document")
APPEND TO ARRAY:C911($tb_headers_th; "Type")
APPEND TO ARRAY:C911($tb_headers_th; "Créé Le")
APPEND TO ARRAY:C911($tb_headers_th; "Format")

If ($module#"Usagers") & ($table_num#90)
	APPEND TO ARRAY:C911($tb_headers_th; "Immeuble")
	APPEND TO ARRAY:C911($tb_headers_th; "Logement")
	APPEND TO ARRAY:C911($tb_headers_th; "Intervention")
End if 

APPEND TO ARRAY:C911($tb_headers_values; ->[Base_documentaire:90]ID:1)
APPEND TO ARRAY:C911($tb_headers_values; ->[Base_documentaire:90]DOC_Titre:8)
APPEND TO ARRAY:C911($tb_headers_values; ->[Base_documentaire:90]DOC_Document_Type:3)
APPEND TO ARRAY:C911($tb_headers_values; ->[Base_documentaire:90]DOC_Date:7)
APPEND TO ARRAY:C911($tb_headers_values; ->[Base_documentaire:90]DOC_Extension:12)

If ($module#"Usagers") & ($table_num#90)
	APPEND TO ARRAY:C911($tb_headers_values; $hd_imm_nom)
	APPEND TO ARRAY:C911($tb_headers_values; ->[LesCentres:9]LC_GL_Nom_Suite:63)
	APPEND TO ARRAY:C911($tb_headers_values; ->[Intervention:108]INT_Numero:13)
End if 

READ ONLY:C145($ptr_table->)

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
ALL RECORDS:C47($ptr_table->)
MultiSoc_Filter($ptr_table)

If ($record_id#0)
	QUERY SELECTION:C341([Base_documentaire:90]; [Base_documentaire:90]DOC_Origine_ID:4=$record_id)
End if 

If ($table_num#0)
	
	If (Table:C252($table_num)#->[Base_documentaire:90])
		QUERY SELECTION:C341([Base_documentaire:90]; [Base_documentaire:90]DOC_Table_No:5=$table_num)
	End if 
	
End if 

//------------------------------------------------------------------------------//
// Filtres
//------------------------------------------------------------------------------//

If ($search_filtre_0#"")
	QUERY SELECTION:C341([Base_documentaire:90]; [Base_documentaire:90]DOC_Titre:8="@"+$search_filtre_0+"@")
End if 

If ($search_filtre_1#"")
	QUERY SELECTION:C341([Base_documentaire:90]; [Base_documentaire:90]DOC_Document_Type:3="@"+$search_filtre_1+"@")
End if 

If ($search_filtre_2#"")
	QUERY:C277([Immeuble:105]; [Immeuble:105]IMM_Nom:3="@"+$search_filtre_2+"@")
	MultiSoc_Filter(->[Intervention:108])
	
	SELECTION TO ARRAY:C260([Immeuble:105]ID:1; $tb_ids)
	QUERY SELECTION WITH ARRAY:C1050([Base_documentaire:90]DOC_Immeuble_ID:13; $tb_ids)
End if 

If ($search_filtre_3#"")
	QUERY:C277([LesCentres:9]; [LesCentres:9]LC_GL_Nom_Suite:63="@"+$search_filtre_3+"@")
	MultiSoc_Filter(->[LesCentres:9])
	
	SELECTION TO ARRAY:C260([LesCentres:9]ID:60; $tb_ids)
	QUERY SELECTION WITH ARRAY:C1050([Base_documentaire:90]DOC_Bien_ID:14; $tb_ids)
End if 

If ($search_filtre_4#"")
	QUERY:C277([Intervention:108]; [Intervention:108]INT_Numero:13="@"+$search_filtre_4+"@")
	MultiSoc_Filter(->[Intervention:108])
	
	SELECTION TO ARRAY:C260([Intervention:108]ID:1; $tb_ids)
	QUERY SELECTION WITH ARRAY:C1050([Base_documentaire:90]DOC_Origine_ID:4; $tb_ids)
End if 

//------------------------------------------------------------------------------//

$total_rows:=Records in selection:C76($ptr_table->)
$field_number:=Num:C11(Field:C253($tb_headers_values{$scol_no}))

//=====================================//
// Sorting
//======================================//
If (Is field number valid:C1000($ptr_table; $field_number))
	
	If ($sortList#"")
		
		If ($sortList="0")
			ORDER BY:C49($ptr_table->; $tb_headers_values{$scol_no}->; <)
		Else 
			ORDER BY:C49($ptr_table->; $tb_headers_values{$scol_no}->; >)
		End if 
		
	End if 
	
End if 

$JSON:="{\"total_rows\":"+String:C10($total_rows)+",\"headers\":["
$JSON:=$JSON+$headers_formatted
$JSON:=$JSON+"],\"rows\":["

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)
ARRAY OBJECT:C1221($tb_result; $total_rows)

//Pagination
$records_counter:=Records in selection:C76($ptr_table->)
ARRAY LONGINT:C221($tb_numEnr; $records_counter)

For ($i; 1; $records_counter)
	$tb_numEnr{$i}:=$i
End for 

$i:=1
$page_start:=($page*$limit)+1

For ($k; $page_start; $records_counter)
	GOTO SELECTED RECORD:C245($ptr_table->; $tb_numEnr{$k})
	
	If ($i>1)
		$JSON:=$JSON+","
	End if 
	
	$JSON:=$JSON+"{"
	
	For ($j; 1; Size of array:C274($tb_headers_th))
		UTL_JSON_CLEAN($tb_headers_values{$j})
		$css_class:=""
		
		Case of 
			: ($tb_headers_values{$j}=$ptr_ID)
				$value_spec:=""
				$chx_disabled:=""
				
				$value_spec:="<input type='checkbox' id='chx_"+String:C10([Base_documentaire:90]ID:1)+"' name='chx_"+String:C10([Base_documentaire:90]ID:1)+"' "+$chx_disabled+" class='iw_select' style='text-align:left;margin:0px 5px 0px 0px;'>"
				$value_spec:=$value_spec+"<input type='hidden' id='basedocid"+String:C10([Base_documentaire:90]ID:1)+"' name='id"+String:C10([Base_documentaire:90]ID:1)+"' value='"+String:C10([Base_documentaire:90]ID:1)+"'>"
				
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div class='iw_text_center' id="+String:C10([Factures:86]ID:1)+">"+$value_spec+"</div>\""
			: ($tb_headers_values{$j}=$hd_imm_nom)
				$header_value:=String:C10($tb_headers_values{$j}->)
				
				Case of 
					: ($table_num=108)
						QUERY:C277([Intervention:108]; [Intervention:108]ID:1=[Base_documentaire:90]DOC_Origine_ID:4)
						MultiSoc_Filter(->[Intervention:108])
						
						$header_value:=[Intervention:108]INT_Immeuble_Nom:19
				End case 
				
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id='"+String:C10($ptr_ID->)+"'  class='"+$css_class+"' >"+$header_value+"</div>\""
			: ($tb_headers_values{$j}=$hd_bien_nom)
				$header_value:=String:C10($tb_headers_values{$j}->)
				
				Case of 
					: ($table_num=108)
						QUERY:C277([Intervention:108]; [Intervention:108]ID:1=[Base_documentaire:90]DOC_Origine_ID:4)
						MultiSoc_Filter(->[Intervention:108])
						
						$header_value:=[Intervention:108]INT_LC_Nom:17
				End case 
				
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id='"+String:C10($ptr_ID->)+"'  class='"+$css_class+"' >"+$header_value+"</div>\""
			: ($tb_headers_values{$j}=$hd_intervention)
				$header_value:=String:C10($tb_headers_values{$j}->)
				
				Case of 
					: ($table_num=108)
						QUERY:C277([Intervention:108]; [Intervention:108]ID:1=[Base_documentaire:90]DOC_Origine_ID:4)
						MultiSoc_Filter(->[Intervention:108])
						
						$header_value:=[Intervention:108]INT_Numero:13
				End case 
				
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id='"+String:C10($ptr_ID->)+"'  class='"+$css_class+"' >"+$header_value+"</div>\""
			Else 
				$header_value:=String:C10($tb_headers_values{$j}->)
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id='"+String:C10($ptr_ID->)+"'  class='"+$css_class+"' >"+$header_value+"</div>\""
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