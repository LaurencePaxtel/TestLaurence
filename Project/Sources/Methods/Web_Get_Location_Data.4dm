//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 19-12-18, 08:30:55
// ----------------------------------------------------
// Method: Web_Get_Location_Data
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $1 : Pointer
var $2 : Text

var $data_label; $T_JSON : Text
var $id : Integer
var $continu : Boolean
var $table : Pointer
var $O_Output; $O_Data : Object

var champRef_p : Pointer

ARRAY OBJECT:C1221($tb_result; 1)

$table:=$1
$data_label:=$2

$O_Output:=New object:C1471
$continu:=True:C214

EXECUTE FORMULA:C63("champRef_p:=->["+Table name:C256($table)+"]id")

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; $data_label; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))

READ ONLY:C145($table->)

If ($id#0)
	QUERY:C277($table->; champRef_p->=$id)
	
	If (Records in selection:C76($table->)=1)
		SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=[Locations:84]LOC_HB_ID:3)
		QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Locations:84]LOC_Bien_ID:5)
		
		// Modifié par : Scanu Rémy (05/05/2021)
		// Ajout du champ LOC_Qualification
		OB SET:C1220($tb_result{1}; "id"; String:C10([Locations:84]ID:1); "loc_date"; String:C10([Locations:84]LOC_Date:2); "loc_hb_id"; String:C10([Locations:84]LOC_HB_ID:3); \
			"loc_usager_name"; [HeBerge:4]HB_Nom:3+" "+[HeBerge:4]HB_Prénom:4; "loc_bien_id"; String:C10([Locations:84]LOC_Bien_ID:5); "loc_bien_name"; [LesCentres:9]LC_Nom:4; \
			"loc_montant_initial"; String:C10([Locations:84]LOC_Montant_Initial:6); "loc_montant_revise"; String:C10([Locations:84]LOC_Montant_Revise:7); "loc_date_entree"; \
			String:C10([Locations:84]LOC_Date_Entree:9); "loc_date_sortie"; String:C10([Locations:84]LOC_Date_Sortie:10); "loc_garantie_montant"; String:C10([Locations:84]LOC_Garantie_Montant:11); \
			"loc_garantie_encaisse"; String:C10([Locations:84]LOC_Garantie_Encaisse:4); "loc_duree_mois"; String:C10([Locations:84]LOC_Duree_Mois:19); "loc_statut"; \
			String:C10([Locations:84]LOC_Qualification:21); "loc_referent"; String:C10([Locations:84]LOC_Referent:28); "loc_coordinateur"; String:C10([Locations:84]LOC_Coordinateur:29))
		
		$T_Json:=JSON Stringify array:C1228($tb_result)
		
	Else 
		$continu:=False:C215
	End if 
	
Else 
	$continu:=False:C215
End if 


WEB SEND TEXT:C677($T_Json)