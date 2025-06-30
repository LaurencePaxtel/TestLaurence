//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 06/04/20, 11:04:12
// ----------------------------------------------------
// Method: Web_Events_Get_List_TS
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($filtre_type; $filtre_presence; $filtre_titre)
C_DATE:C307($filtre_date_du; $filtre_date_au)
C_BOOLEAN:C305($is_event_a_venir)
C_OBJECT:C1216($O_Data; $object)
C_LONGINT:C283($filtre_proprietaire)


C_TEXT:C284($headers)
ARRAY OBJECT:C1221($tb_headers; 1)

ARRAY TEXT:C222($tb_headers_th; 0)
ARRAY POINTER:C280($tb_headers_values; 0)

APPEND TO ARRAY:C911($tb_headers_th; "Usager")
APPEND TO ARRAY:C911($tb_headers_th; "Type")
APPEND TO ARRAY:C911($tb_headers_th; "Présence")
APPEND TO ARRAY:C911($tb_headers_th; "Titre")
APPEND TO ARRAY:C911($tb_headers_th; "Date du")
APPEND TO ARRAY:C911($tb_headers_th; "Date au")
APPEND TO ARRAY:C911($tb_headers_th; "Heure du")
APPEND TO ARRAY:C911($tb_headers_th; "Heure au")
APPEND TO ARRAY:C911($tb_headers_th; "Rappel")
APPEND TO ARRAY:C911($tb_headers_th; "Récurrence")
APPEND TO ARRAY:C911($tb_headers_th; "Propriétaire")

APPEND TO ARRAY:C911($tb_headers_values; ->[Events:103]EVE_HB_NomPrenom:15)
APPEND TO ARRAY:C911($tb_headers_values; ->[Events:103]EVE_Type:10)
APPEND TO ARRAY:C911($tb_headers_values; ->[Events:103]EVE_Presence:11)
APPEND TO ARRAY:C911($tb_headers_values; ->[Events:103]EVE_Titre:3)
APPEND TO ARRAY:C911($tb_headers_values; ->[Events:103]EVE_Date_Du:5)
APPEND TO ARRAY:C911($tb_headers_values; ->[Events:103]EVE_Date_Au:6)
APPEND TO ARRAY:C911($tb_headers_values; ->[Events:103]EVE_Heure_Du:7)
APPEND TO ARRAY:C911($tb_headers_values; ->[Events:103]EVE_Heure_Au:8)
APPEND TO ARRAY:C911($tb_headers_values; ->[Events:103]EVE_Rappel:12)
APPEND TO ARRAY:C911($tb_headers_values; ->[Events:103]EVE_Recurrence:13)
APPEND TO ARRAY:C911($tb_headers_values; ->[Events:103]EVE_User_NomPrenom:16)

$O_Data:=Web_AGL_Get_Post_Json_Data(True:C214)


READ ONLY:C145([Events:103])
READ ONLY:C145([HeBerge:4])
READ ONLY:C145([INtervenants:10])

ALL RECORDS:C47([Events:103])

//QUERY([Events];[Events]EVE_Type=$filtre_type)

MultiSoc_Filter(->[Events:103])

ORDER BY:C49([Events:103]; [Events:103]EVE_Date_Du:5; >)



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
$filtre_heberge:=OB Get:C1224($O_Data; "fcol[0]"; Est un texte:K8:3)
$filtre_type:=OB Get:C1224($O_Data; "fcol[1]"; Est un texte:K8:3)
$filtre_presence:=OB Get:C1224($O_Data; "fcol[2]"; Est un texte:K8:3)
$filtre_titre:=OB Get:C1224($O_Data; "fcol[3]"; Est un texte:K8:3)
$filtre_date_du:=Date:C102(OB Get:C1224($O_Data; "fcol[4]"; Est un texte:K8:3))
$filtre_date_au:=Date:C102(OB Get:C1224($O_Data; "fcol[5]"; Est un texte:K8:3))
$filtre_proprietaire:=Num:C11(OB Get:C1224($O_Data; "fcol[10]"; Est un texte:K8:3))

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
ALL RECORDS:C47([Events:103])
MultiSoc_Filter(->[Events:103])

//ARRAY TEXT($tb_name_hb;0)
//UTL_Cut_Text (->$filtre_heberge;->$tb_name_hb;" ")

//If ($filtre_heberge#"")
//If (Size of array($tb_name_hb)>0)
//QUERY([HeBerge];[HeBerge]HB_Nom=$tb_name_hb{1}+"@")
//End if 
//If (Size of array($tb_name_hb)>1)
//QUERY SELECTION([HeBerge];[HeBerge]HB_Prénom=$tb_name_hb{2}+"@")
//End if 

//If (Records in selection([HeBerge])=1)
//QUERY SELECTION([Events];[Events]EVE_HB_ID=[HeBerge]HB_ReferenceID)
//Else 
//ARRAY LONGINT($tb_ids_tmp;0)
//SELECTION TO ARRAY([HeBerge]HB_ReferenceID;$tb_ids_tmp)
//QUERY SELECTION WITH ARRAY([Events]EVE_HB_ID;$tb_ids_tmp)
//End if 
//End if 

If ($filtre_heberge#"")
	QUERY SELECTION:C341([Events:103]; [Events:103]EVE_HB_NomPrenom:15=$filtre_heberge+"@")
End if 

If ($filtre_type#"")
	QUERY SELECTION:C341([Events:103]; [Events:103]EVE_Type:10=$filtre_type)
End if 

If ($filtre_presence#"")
	QUERY SELECTION:C341([Events:103]; [Events:103]EVE_Presence:11=$filtre_presence)
End if 

If ($filtre_titre#"")
	QUERY SELECTION:C341([Events:103]; [Events:103]EVE_Titre:3="@"+$filtre_titre+"@")
End if 

If ($filtre_date_du#!00-00-00!)
	QUERY SELECTION:C341([Events:103]; [Events:103]EVE_Date_Du:5>=$filtre_date_du)
End if 

If ($filtre_date_au#!00-00-00!)
	QUERY SELECTION:C341([Events:103]; [Events:103]EVE_Date_Au:6<=$filtre_date_au)
End if 

If ($filtre_proprietaire>0)
	QUERY SELECTION:C341([Events:103]; [Events:103]EVE_User_ID:9=$filtre_proprietaire)
End if 
If ($filtre_proprietaire=0)
	QUERY SELECTION:C341([Events:103]; [Events:103]EVE_User_ID:9=w_userUID)
End if 

//ORDER BY([Events];[Events]EVE_Date_Du;<)



$total_rows:=Records in selection:C76([Events:103])

//=====================================//
// Sorting
//======================================//
If ($sortList#"")
	If ($sortList="0")
		ORDER BY:C49([Events:103]; $tb_headers_values{$scol_no}->; <)
	Else 
		ORDER BY:C49([Events:103]; $tb_headers_values{$scol_no}->; >)
	End if 
End if 

$JSON:="{\"total_rows\":"+String:C10($total_rows)+",\"headers\":["
$JSON:=$JSON+$headers_formatted
$JSON:=$JSON+"],\"rows\":["

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)


ARRAY OBJECT:C1221($tb_result; $total_rows)

FIRST RECORD:C50([Events:103])

//Pagination
$records_counter:=Records in selection:C76([Events:103])
ARRAY LONGINT:C221($tb_numEnr; $records_counter)
For ($i; 1; $records_counter)
	$tb_numEnr{$i}:=$i
End for 

$page_start:=($page*$limit)+1

$i:=1

For ($k; $page_start; $records_counter)
	
	GOTO SELECTED RECORD:C245([Events:103]; $tb_numEnr{$k})
	
	QUERY:C277([INtervenants:10]; [INtervenants:10]ID:16=[Events:103]EVE_User_ID:9)
	MultiSoc_Filter(->[INtervenants:10])
	
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Events:103]EVE_HB_ID:14)
	MultiSoc_Filter(->[HeBerge:4])
	
	$css_class:=""
	
	//-----------------------------------------------------------------//
	//Statut : événement à venir
	//-----------------------------------------------------------------//
	$is_event_a_venir:=False:C215
	If (Current date:C33(*)<[Events:103]EVE_Date_Du:5)
		$is_event_a_venir:=True:C214
	End if 
	If (Current date:C33(*)=[Events:103]EVE_Date_Du:5)
		If (Current time:C178(*)<=[Events:103]EVE_Heure_Du:7)
			$is_event_a_venir:=True:C214
		End if 
	End if 
	If ($is_event_a_venir)
		$css_class:="iw_style_bold"
	End if 
	//-----------------------------------------------------------------//
	
	If ($i>1)
		$JSON:=$JSON+","
	End if 
	
	$JSON:=$JSON+"{"
	For ($j; 1; Size of array:C274($tb_headers_th))
		
		//Case of 
		//: ($tb_headers_th{$j}="Hébergé")
		//$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id="+String([Events]ID)+">"+String($tb_headers_values{$j}->)+" "+String([HeBerge]HB_Prénom)+"</div>\""
		//: ($tb_headers_th{$j}="Propriétaire")
		//$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id="+String([Events]ID)+">"+String($tb_headers_values{$j}->)+" "+String([INtervenants]IN_NomPrénom)+"</div>\""
		//Else 
		//$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id="+String([Events]ID)+">"+String($tb_headers_values{$j}->)+"</div>\""
		//End case 
		
		$JSON:=$JSON+"\""+$tb_headers_th{$j}+"\":\"<div id="+String:C10([Events:103]ID:1)+" class="+$css_class+">"+String:C10($tb_headers_values{$j}->)+"</div>\""
		
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

