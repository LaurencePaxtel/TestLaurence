//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 17-12-18, 08:37:36
// ----------------------------------------------------
// Method: Web_Form_Locations
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)

C_TEXT:C284(SCRIPT; $disabled; $value)
C_LONGINT:C283($o)
C_POINTER:C301($form_layout)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

$form_layout:=$1
$disabled:=""
RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:="GL?action=irl"
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="locations"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="locations"
$TB_FORM{0}{6}:=""

READ WRITE:C146([Locations:84])
QUERY:C277([Locations:84]; [Locations:84]LOC_Statut:17="temp"; *)
QUERY:C277([Locations:84];  & ; [Locations:84]LOC_Intervenant_ID:18=w_userUID)
DELETE SELECTION:C66([Locations:84])

If (Count parameters:C259=1)
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="search_date"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Date du bail"
	$TB_HTML{$o}{6}:="search_date"
	$TB_HTML{$o}{7}:="span7 search fdp_placeholder datepicker iw_data_column_0"
	
	// Modifié par : Scanu Rémy (25/08/2021) et Re-modifié par : Scanu Rémy (14/02/2024)
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="search_bien_location"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Bien en location"
	$TB_HTML{$o}{6}:="search_bien_location"
	$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_data_column_1"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="search_usager"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Usager"
	$TB_HTML{$o}{6}:="search_usager"
	$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_data_column_2"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="search_usager_id"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="search_usager_id"
	$TB_HTML{$o}{7}:=""
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="checkbox"
	$TB_HTML{$o}{3}:="search_location_statut"
	$TB_HTML{$o}{4}:="search_location_statut;Location en cours;Location en cours|search_location_statut;Toutes les locations;Toutes les locations"
	$TB_HTML{$o}{5}:="Statut"
	$TB_HTML{$o}{6}:="search_location_statut"
	$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_data_column_3"
	
	// Modifié par : Scanu Rémy (25/08/2021)
	$o:=$o+1
	$TB_HTML{$o}{1}:="select"
	$TB_HTML{$o}{2}:="multiple"
	$TB_HTML{$o}{3}:="search_locations"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Bien en location (multi-sélection)"
	$TB_HTML{$o}{6}:="search_locations"
	$TB_HTML{$o}{7}:="fdp_row_start span7 search iw_data_column_4"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="search_bien_id"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="search_bien_id"
	$TB_HTML{$o}{7}:=""
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="id_selected"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="id_selected"
	$TB_HTML{$o}{7}:=""
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="method"
	$TB_HTML{$o}{4}:="GET"
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="method"
	$TB_HTML{$o}{7}:=""
	
	ARRAY TEXT:C222($TB_HTML; $o; 15)
	
	$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)
Else 
	C_POINTER:C301($HTML_CONTENT; $2)
	
	$HTML_CONTENT:=$2
	$HTML_CONTENT->:=$HTML_CONTENT->+"<div id=\""+$TB_FORM{0}{5}+"_content\" class=\"row\">"
	
	$value:=""
	
	WebAGL_Create_Group_HTML($HTML_CONTENT; "input"; "text"; "search_date"; "Date du bail"; ->$value; " "; "fdp_span3 span7 datepicker ")
	WebAGL_Create_Group_HTML($HTML_CONTENT; "input"; "text"; "search_usager"; "Locataire"; ->$value; " "; "fdp_span3 span7 ")
	WebAGL_Create_Group_HTML($HTML_CONTENT; "input"; "hidden"; "search_usager_id"; "Locataire"; ->$value; " "; "")
	WebAGL_Create_Group_HTML($HTML_CONTENT; "input"; "hidden"; "search_bien_id"; "Locataire"; ->$value; " "; " ")
	WebAGL_Create_Group_HTML($HTML_CONTENT; "input"; "hidden"; "id_selected"; "Locataire"; ->$value; " "; "")
	
	$HTML_CONTENT->:=$HTML_CONTENT->+"</div>"
End if 