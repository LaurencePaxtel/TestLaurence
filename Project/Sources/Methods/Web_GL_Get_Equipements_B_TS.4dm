//%attributes = {}
// ----------------------------------------------------
// User name (OS): KEVIN HASSAL
// Date and time: 20/05/30, 19:57:25
// ----------------------------------------------------
// Method: Web_GL_Get_Equipements_TS
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($sortList; $fcol; $JSON; $header_value; $css_class; $lig_value; $search_filtre_0; $search_filtre_1; $search_filtre_2; $search_filtre_3; $headers; $headers_formatted; \
$hd_emplacement_txt; $hd_piece_txt; $hd_immeuble_txt)
C_LONGINT:C283($i; $page; $limit; $scol_no; $fcol_no)
C_OBJECT:C1216($O_Data; $object)
C_POINTER:C301($ptr_ID; $hd_emplacement; $hd_piece; $hd_immeuble)

ARRAY TEXT:C222($tb_headers_th; 0)

ARRAY LONGINT:C221($tb_equ_ids; 0)
ARRAY LONGINT:C221($tb_biens_ids; 0)

ARRAY POINTER:C280($tb_headers_values; 0)
ARRAY OBJECT:C1221($tb_headers; 1)

$ptr_ID:=->[EquipementBien:125]UUID:2

$hd_emplacement_txt:="emplacement"
$hd_piece_txt:="piece"
$hd_immeuble_txt:="Immeuble"

$hd_emplacement:=->$hd_emplacement_txt
$hd_piece:=->$hd_piece_txt
$hd_immeuble:=->$hd_immeuble_txt

APPEND TO ARRAY:C911($tb_headers_th; " ")
APPEND TO ARRAY:C911($tb_headers_th; "Type")
APPEND TO ARRAY:C911($tb_headers_th; "Nom")
APPEND TO ARRAY:C911($tb_headers_th; "Immeuble")
APPEND TO ARRAY:C911($tb_headers_th; "Emplacement")
APPEND TO ARRAY:C911($tb_headers_th; "Pièce")
APPEND TO ARRAY:C911($tb_headers_th; "Date d’installation")
APPEND TO ARRAY:C911($tb_headers_th; "Garantie")
APPEND TO ARRAY:C911($tb_headers_th; "Date d’achat")
APPEND TO ARRAY:C911($tb_headers_th; "Prix d’achat")
APPEND TO ARRAY:C911($tb_headers_th; "Montant TTC")

APPEND TO ARRAY:C911($tb_headers_values; $ptr_ID)
APPEND TO ARRAY:C911($tb_headers_values; ->[Equipement:107]EQU_Type:5)
APPEND TO ARRAY:C911($tb_headers_values; ->[Equipement:107]EQU_Nom:4)
APPEND TO ARRAY:C911($tb_headers_values; $hd_immeuble)
APPEND TO ARRAY:C911($tb_headers_values; $hd_emplacement)
APPEND TO ARRAY:C911($tb_headers_values; $hd_piece)
APPEND TO ARRAY:C911($tb_headers_values; ->[Piece_LK_Equipement:115]PLE_Date_Installation:6)
APPEND TO ARRAY:C911($tb_headers_values; ->[Equipement:107]EQU_Garantie:10)
APPEND TO ARRAY:C911($tb_headers_values; ->[Equipement:107]EQU_Date_Achat:8)
APPEND TO ARRAY:C911($tb_headers_values; ->[Equipement:107]EQU_Prix_Achat_HT:9)
APPEND TO ARRAY:C911($tb_headers_values; ->[Equipement:107]EQU_Prix_Achat_TTC:12)

READ ONLY:C145([Piece_LK_Equipement:115])
READ ONLY:C145([Equipement:107])
READ ONLY:C145([Stock:113])

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
ALL RECORDS:C47([Equipement:107])
MultiSoc_Filter(->[Equipement:107])

//----------------------------//
// Filters
//----------------------------//
If ($search_filtre_0#"")
	QUERY SELECTION:C341([Equipement:107]; [Equipement:107]EQU_Type:5="@"+$search_filtre_0+"@")
End if 

If ($search_filtre_1#"")
	QUERY SELECTION:C341([Equipement:107]; [Equipement:107]EQU_Nom:4="@"+$search_filtre_1+"@")
End if 

If ($search_filtre_2#"")
	QUERY SELECTION:C341([Equipement:107]; [Equipement:107]EQU_Reference_Fabricant:6="@"+$search_filtre_2+"@")
End if 

If ($search_filtre_3#"")
	QUERY SELECTION:C341([Equipement:107]; [Equipement:107]EQU_Reference_Structure:7="@"+$search_filtre_3+"@")
End if 

SELECTION TO ARRAY:C260([Equipement:107]ID:1; $tb_equ_ids)
QUERY WITH ARRAY:C644([EquipementBien:125]equipementID:1; $tb_equ_ids)

If ($search_filtre_5#"")
	QUERY:C277([LesCentres:9]; [LesCentres:9]LC_GL_Nom_Suite:63="@"+$search_filtre_5+"@")
	MultiSoc_Filter(->[LesCentres:9])
	
	If (Records in selection:C76([LesCentres:9])=1)
		QUERY SELECTION:C341([EquipementBien:125]; [EquipementBien:125]bienID:3=[LesCentres:9]ID:60)
	End if 
	
Else 
	
	If ($search_filtre_4#"")
		QUERY:C277([Immeuble:105]; [Immeuble:105]IMM_Nom:3="@"+$search_filtre_4+"@")
		MultiSoc_Filter(->[Immeuble:105])
		
		ARRAY LONGINT:C221($tb_imm_ids; 0)
		SELECTION TO ARRAY:C260([Immeuble:105]ID:1; $tb_imm_ids)
		
		QUERY WITH ARRAY:C644([LesCentres:9]LC_Immeuble_ID:84; $tb_imm_ids)
		MultiSoc_Filter(->[LesCentres:9])
		
		If (Records in selection:C76([LesCentres:9])>0)
			SELECTION TO ARRAY:C260([LesCentres:9]ID:60; $tb_biens_ids)
			QUERY SELECTION WITH ARRAY:C1050([EquipementBien:125]bienID:3; $tb_biens_ids)
		End if 
		
	End if 
	
End if 

$total_rows:=Records in selection:C76([EquipementBien:125])

//=====================================//
// Sorting
//======================================//
If ($sortList#"")
	
	If ($sortList="0")
		ORDER BY:C49([EquipementBien:125]; $tb_headers_values{$scol_no}->; <)
	Else 
		ORDER BY:C49([EquipementBien:125]; $tb_headers_values{$scol_no}->; >)
	End if 
	
End if 

$JSON:="{\"total_rows\":"+String:C10($total_rows)+",\"headers\":["
$JSON:=$JSON+$headers_formatted
$JSON:=$JSON+"],\"rows\":["

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

ARRAY OBJECT:C1221($tb_result; $total_rows)

//Pagination
$records_counter:=Records in selection:C76([EquipementBien:125])
ARRAY LONGINT:C221($tb_numEnr; $records_counter)

For ($i; 1; $records_counter)
	$tb_numEnr{$i}:=$i
End for 

$page_start:=($page*$limit)+1

$i:=1

For ($k; $page_start; $records_counter)
	GOTO SELECTED RECORD:C245([EquipementBien:125]; $tb_numEnr{$k})
	
	QUERY:C277([Equipement:107]; [Equipement:107]ID:1=[EquipementBien:125]equipementID:1)
	MultiSoc_Filter(->[Equipement:107])
	
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
				$value_spec:=""
				$chx_disabled:=""
				
				$value_spec:="<input type='checkbox' id='chx_"+String:C10($ptr_ID->)+"' name='chx_"+String:C10($ptr_ID->)+"' "+$chx_disabled+" class='iw_select' style='text-align:left;margin:0px 5px 0px 0px;'>"
				
				$value_spec:=$value_spec+"<input type='hidden' id='id_record_"+String:C10($ptr_ID->)+"' name='id_record_"+String:C10($ptr_ID->)+"' value='"+String:C10($ptr_ID->)+"'>"
				$value_spec:=$value_spec+"<input type='hidden' id='table_"+String:C10($ptr_ID->)+"' name='table_"+String:C10($ptr_ID->)+"' value='"+String:C10(Table:C252(->[EquipementBien:125]))+"'>"
				
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div class='iw_text_center' id="+String:C10($ptr_ID->)+">"+$value_spec+"</div>\""
			: ($tb_headers_values{$j}=$hd_immeuble)
				QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[EquipementBien:125]bienID:3)
				MultiSoc_Filter(->[LesCentres:9])
				
				If (Records in selection:C76([LesCentres:9])=1)
					QUERY:C277([Immeuble:105]; [Immeuble:105]ID:1=[LesCentres:9]LC_Immeuble_ID:84)
					MultiSoc_Filter(->[Immeuble:105])
					
					If (Records in selection:C76([Immeuble:105])=1)
						$lig_value:=[Immeuble:105]IMM_Nom:3
					End if 
					
				End if 
				
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id='"+String:C10([EquipementBien:125]UUID:2)+"'>"+$lig_value+"</div>\""
			: ($tb_headers_values{$j}=$hd_emplacement)
				QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[EquipementBien:125]bienID:3)
				MultiSoc_Filter(->[LesCentres:9])
				
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id='"+String:C10([EquipementBien:125]UUID:2)+"'>"+[LesCentres:9]LC_GL_Nom_Suite:63+"</div>\""
			: ($tb_headers_values{$j}=$hd_piece)
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id='"+String:C10([EquipementBien:125]UUID:2)+"'>"+[Pieces:106]PIE_Nom:4+"</div>\""
			Else 
				
				Case of 
					: (Type:C295($tb_headers_values{$j}->)=Est un numérique:K8:4)
						$header_value:=String:C10($tb_headers_values{$j}->; "###,###,##0.00")
					Else 
						$header_value:=String:C10($tb_headers_values{$j}->)
				End case 
				
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id='"+String:C10([EquipementBien:125]UUID:2)+"' class='"+$css_class+"' >"+$header_value+"</div>\""
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