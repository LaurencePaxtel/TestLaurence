//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 25-12-18, 15:58:56
// ----------------------------------------------------
// Method: Web_Autocomplete_Locations
// Description
// 
//
// Parameters
// ----------------------------------------------------
var ${1} : Pointer

var $request_term_1; $request_term_2 : Text
var $size; $i; $id_origin; $id_origin_2; $days_count : Integer
var $continu : Boolean
var $date_du; $date_au : Date
var $table; $field_id; $field_value; $field_value_second; $field_id_origin; $field_id_origin_2 : Pointer
var $O_Output; $O_Data : Object

var champRef_p : Pointer

ARRAY TEXT:C222($tb_value; 0)
ARRAY TEXT:C222($tb_value_second; 0)

ARRAY LONGINT:C221($tb_id; 0)

ARRAY REAL:C219($tb_quantite; 0)
ARRAY REAL:C219($tb_prix_unitaire; 0)
ARRAY REAL:C219($tb_montant_garantie; 0)

ARRAY BOOLEAN:C223($tb_garantie_encaisse; 0)

ARRAY DATE:C224($tb_date_du; 0)
ARRAY DATE:C224($tb_date_au; 0)

$table:=$1
$field_id:=$2
$field_value:=$3

$field_value_second:=Null:C1517
$field_id_origin:=Null:C1517

If (Count parameters:C259>3)
	$field_value_second:=$4
End if 

If (Count parameters:C259>4)
	$field_id_origin:=$5
End if 

If (Count parameters:C259>5)
	$field_id_origin_2:=$6
End if 

EXECUTE FORMULA:C63("champRef_p:=->["+Table name:C256($table)+"]Ref_Structure")

$O_Output:=New object:C1471
$continu:=True:C214

$O_Data:=Web_AGL_Get_Post_Json_Data

$request_term_1:=OB Get:C1224($O_Data; "data_first"; Est un texte:K8:3)
$request_term_2:=OB Get:C1224($O_Data; "data_second"; Est un texte:K8:3)

$id_origin:=Num:C11(OB Get:C1224($O_Data; "id_bien"; Est un texte:K8:3))
$id_origin_2:=Num:C11(OB Get:C1224($O_Data; "id_locataire"; Est un texte:K8:3))

READ ONLY:C145($table->)

If ($request_term_1#"")
	QUERY:C277($table->; $field_value->="@"+$request_term_1+"@"; *)
	
	If ($field_value_second#Null:C1517)
		QUERY:C277($table->;  & ; $field_value_second->="@"+$request_term_2+"@"; *)
	End if 
	
	QUERY:C277($table->;  & ; champRef_p->=Session:C1714.storage.intervenant.Ref_Structure)
Else 
	QUERY:C277($table->; $field_value->#""; *)
	QUERY:C277($table->;  & ; champRef_p->=Session:C1714.storage.intervenant.Ref_Structure)
End if 

If ($field_id_origin#Null:C1517)
	QUERY SELECTION:C341($table->; $field_id_origin->=$id_origin)
End if 

If ($field_id_origin_2#Null:C1517)
	QUERY SELECTION:C341($table->; $field_id_origin_2->=$id_origin_2)
End if 

// On affiche uniquement les locations non facturées
QUERY SELECTION:C341([Locations:84]; [Locations:84]LOC_Facture:13=False:C215)

MultiSoc_Filter($table)

ORDER BY:C49([Locations:84]; [Locations:84]LOC_Date:2; <)
$size:=Records in selection:C76($table->)

ARRAY OBJECT:C1221($tb_result; $size)

If ($field_value_second=Null:C1517)
	SELECTION TO ARRAY:C260($field_id->; $tb_id; $field_value->; $tb_value; [Locations:84]LOC_Nombre_Jours:15; $tb_quantite; [Locations:84]LOC_Montant_Revise:7; $tb_prix_unitaire; [Locations:84]LOC_Garantie_Encaisse:4; $tb_garantie_encaisse; [Locations:84]LOC_Garantie_Montant:11; $tb_montant_garantie; [Locations:84]LOC_Date_Entree:9; $tb_date_du; [Locations:84]LOC_Date_Sortie:10; $tb_date_au)
	
	For ($i; 1; $size)
		QUERY:C277([Locations:84]; [Locations:84]ID:1=$tb_id{$i})
		
		Case of 
			: ((Month of:C24(Current date:C33(*))=Month of:C24($tb_date_du{$i}))) & (Year of:C25(Current date:C33(*))=Year of:C25($tb_date_du{$i}))
				$date_du:=$tb_date_du{$i}
			: ((Month of:C24(Current date:C33(*))>Month of:C24($tb_date_du{$i})) & (Year of:C25(Current date:C33(*))=Year of:C25($tb_date_du{$i}))) & ((Month of:C24(Current date:C33(*))<Month of:C24($tb_date_au{$i})) & (Year of:C25(Current date:C33(*))=Year of:C25($tb_date_au{$i})))
				$date_du:=UTL_Date_Day(Current date:C33(*); False:C215)
			: ((Month of:C24(Current date:C33(*))=Month of:C24($tb_date_au{$i}))) & (Year of:C25(Current date:C33(*))=Year of:C25($tb_date_du{$i}))
				$date_du:=UTL_Date_Day($tb_date_au{$i}; False:C215)
			Else 
				$date_du:=UTL_Date_Day(Current date:C33(*); False:C215)
		End case 
		
		$date_au:=UTL_Date_Day($date_du; True:C214)
		
		If ((Month of:C24(Current date:C33(*))=Month of:C24($tb_date_au{$i}))) & (Year of:C25(Current date:C33(*))=Year of:C25($tb_date_au{$i}))
			$date_au:=$tb_date_au{$i}
		End if 
		
		$days_count:=$date_au-$date_du+1
		OB SET:C1220($tb_result{$i}; "id"; $tb_id{$i}; "value"; $tb_value{$i}; "quantite"; String:C10($days_count); "prix_unitaire"; String:C10($tb_prix_unitaire{$i}); "garantie_encaisse"; String:C10($tb_garantie_encaisse{$i}); "garantie_montant"; String:C10($tb_montant_garantie{$i}); "loc_date_du"; String:C10($date_du); "loc_date_au"; String:C10($date_au))
		
		If ($i=10)
			$i:=$size
		End if 
		
	End for 
	
Else 
	SELECTION TO ARRAY:C260($field_id->; $tb_id; $field_value->; $tb_value; $field_value_second->; $tb_value_second; [Locations:84]LOC_Nombre_Jours:15; $tb_quantite; [Locations:84]LOC_Montant_Revise:7; $tb_prix_unitaire; [Locations:84]LOC_Garantie_Encaisse:4; $tb_garantie_encaisse; [Locations:84]LOC_Garantie_Montant:11; $tb_montant_garantie)
	
	For ($i; 1; $size)
		OB SET:C1220($tb_result{$i}; "id"; $tb_id{$i}; "value"; $tb_value{$i}+" "+$tb_value_second{$i}; "quantite"; String:C10($tb_quantite{$i}); "prix_unitaire"; String:C10($tb_prix_unitaire{$i}); "garantie_encaisse"; String:C10($tb_garantie_encaisse{$i}); "garantie_montant"; String:C10($tb_montant_garantie{$i}))
		
		If ($i=10)
			$i:=$size
		End if 
		
	End for 
	
End if 

$JSON:=JSON Stringify array:C1228($tb_result)
WEB SEND TEXT:C677($JSON)