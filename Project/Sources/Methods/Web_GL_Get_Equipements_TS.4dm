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
C_OBJECT:C1216($O_Data; $object)
C_LONGINT:C283($i; $page; $limit)
C_TEXT:C284($JSON; $header_value; $css_class)

C_TEXT:C284($search_filtre_0; $search_filtre_1; $search_filtre_2; $search_filtre_3)

C_TEXT:C284($headers)
ARRAY OBJECT:C1221($tb_headers; 1)

ARRAY TEXT:C222($tb_headers_th; 0)
ARRAY POINTER:C280($tb_headers_values; 0)

C_POINTER:C301($ptr_ID)
$ptr_ID:=->[Equipement:107]ID:1

APPEND TO ARRAY:C911($tb_headers_th; "Type")
APPEND TO ARRAY:C911($tb_headers_th; "Nom")
APPEND TO ARRAY:C911($tb_headers_th; "Référence fabricant")
APPEND TO ARRAY:C911($tb_headers_th; "Référence structure")
APPEND TO ARRAY:C911($tb_headers_th; "Garantie")
APPEND TO ARRAY:C911($tb_headers_th; "Date d’achat")
APPEND TO ARRAY:C911($tb_headers_th; "Prix d’achat")
APPEND TO ARRAY:C911($tb_headers_th; "Montant TTC")

APPEND TO ARRAY:C911($tb_headers_values; ->[Equipement:107]EQU_Type:5)
APPEND TO ARRAY:C911($tb_headers_values; ->[Equipement:107]EQU_Nom:4)
APPEND TO ARRAY:C911($tb_headers_values; ->[Equipement:107]EQU_Reference_Fabricant:6)
APPEND TO ARRAY:C911($tb_headers_values; ->[Equipement:107]EQU_Reference_Structure:7)
APPEND TO ARRAY:C911($tb_headers_values; ->[Equipement:107]EQU_Garantie:10)
APPEND TO ARRAY:C911($tb_headers_values; ->[Equipement:107]EQU_Date_Achat:8)
APPEND TO ARRAY:C911($tb_headers_values; ->[Equipement:107]EQU_Prix_Achat_HT:9)
APPEND TO ARRAY:C911($tb_headers_values; ->[Equipement:107]EQU_Prix_Achat_TTC:12)

READ ONLY:C145([Equipement:107])
READ ONLY:C145([Stock:113])

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

$total_rows:=Records in selection:C76([Equipement:107])

//=====================================//
// Sorting
//======================================//
If ($sortList#"")
	If ($sortList="0")
		ORDER BY:C49([Equipement:107]; $tb_headers_values{$scol_no}->; <)
	Else 
		ORDER BY:C49([Equipement:107]; $tb_headers_values{$scol_no}->; >)
	End if 
End if 

$JSON:="{\"total_rows\":"+String:C10($total_rows)+",\"headers\":["
$JSON:=$JSON+$headers_formatted
$JSON:=$JSON+"],\"rows\":["

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

ARRAY OBJECT:C1221($tb_result; $total_rows)

//Pagination
$records_counter:=Records in selection:C76([Equipement:107])
ARRAY LONGINT:C221($tb_numEnr; $records_counter)
For ($i; 1; $records_counter)
	$tb_numEnr{$i}:=$i
End for 

$page_start:=($page*$limit)+1

$i:=1

For ($k; $page_start; $records_counter)
	
	GOTO SELECTED RECORD:C245([Equipement:107]; $tb_numEnr{$k})
	
	If ($i>1)
		$JSON:=$JSON+","
	End if 
	
	$JSON:=$JSON+"{"
	For ($j; 1; Size of array:C274($tb_headers_th))
		
		UTL_JSON_CLEAN($tb_headers_values{$j})
		
		$css_class:=""
		
		QUERY:C277([Stock:113]; [Stock:113]STK_EQU_ID:3=[Equipement:107]ID:1)
		MultiSoc_Filter(->[Stock:113])
		
		If (Records in selection:C76([Stock:113])=1)
			If ([Stock:113]STK_Stock_Disponible:5<[Equipement:107]EQU_Stock_Min:13)
				$css_class:="iw_highlight_red"
			End if 
		End if 
		
		Case of 
			: ($tb_headers_values{$j}=$ptr_ID)
				
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id='"+String:C10([Equipement:107]ID:1)+"' class='"+$css_class+"' >"+String:C10($tb_headers_values{$j}->)+"</div>\""
				
				//: ($tb_headers_values{$j}=->[Proprietaires]PRO_Nom)
				
				//QUERY([Proprietaires];[Proprietaires]ID=[LesCentres]LC_GL_Proprietaire_ID)
				//MultiSoc_Filter (->[Proprietaires])
				
				//$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id='"+String([LesCentres]ID)+"'>"+[Proprietaires]PRO_Nom+" "+[Proprietaires]PRO_Prenom+"</div>\""
				
				//: ($tb_headers_values{$j}=->[Immeuble]IMM_Nom)
				
				//QUERY([Immeuble];[Immeuble]ID=[LesCentres]LC_Immeuble_ID)
				//MultiSoc_Filter (->[Immeuble])
				
				//$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id='"+String([LesCentres]ID)+"'>"+[Immeuble]IMM_Nom+"</div>\""
				
				
				//: ($tb_headers_values{$j}=->$hd_locations_encours)
				
				//$value_spec:=""
				
				//QUERY([Locations];[Locations]LOC_Date_Sortie>Current date(*);*)
				//QUERY([Locations]; & ;[Locations]LOC_Bien_ID=[LesCentres]ID)
				//MultiSoc_Filter (->[Locations])
				
				//If (Records in selection([Locations])>0)
				//$value_spec:="<i class='fa fa-check-square-o fdp-icon-green'></i>"
				//Else 
				//$value_spec:="<i class='fa fa-times fdp-icon-red'></i>"
				//End if 
				
				//$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div class='iw_text_center' id='"+String([LesCentres]ID)+"'>"+$value_spec+"</div>\""
				
				
			Else 
				
				Case of 
					: (Type:C295($tb_headers_values{$j}->)=Est un numérique:K8:4)
						$header_value:=String:C10($tb_headers_values{$j}->; "###,###,##0.00")
					Else 
						$header_value:=String:C10($tb_headers_values{$j}->)
				End case 
				
				$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id='"+String:C10([Equipement:107]ID:1)+"' class='"+$css_class+"' >"+$header_value+"</div>\""
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


