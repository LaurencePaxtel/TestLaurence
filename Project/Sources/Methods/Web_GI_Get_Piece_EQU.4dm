//%attributes = {}
// ======================================================================
// Methode projet : Web_GI_Get_Piece_EQU
// 
// ----------------------------------------------------------------------

If (False:C215)  // Historique
	// 02/08/22 remy@connect-io.fr - Clean code
End if 

If (True:C214)  // Déclarations
	C_OBJECT:C1216($data_o; $table_o; $enregistrement_o; $retour_o)
End if 

$data_o:=Web_AGL_Get_Post_Json_Data
$data_o:=OB Get:C1224($data_o; "data"; Est un objet:K8:27)

//=============================================//
// Sélection des données
//=============================================//
If (OB Get:C1224($data_o; "request_type"; Est un texte:K8:3)="get_records")
	$table_o:=ds:C1482.EquipementBien.query("bienID = :1"; Num:C11(OB Get:C1224($data_o; "id_bien"; Est un texte:K8:3)))
Else 
	$table_o:=ds:C1482.EquipementBien.query("UUID = :1"; OB Get:C1224($data_o; "id"; Est un texte:K8:3))
End if 

//=====================================//
// Filters
//=====================================//

//=====================================//
// Sorting
//=====================================//

//=====================================//
// Envoi des données
//=====================================//
$retour_o:=New object:C1471

$retour_o.total_rows:=String:C10($table_o.length)
$retour_o.rows:=New collection:C1472

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

For each ($enregistrement_o; $table_o)
	
	// On boucle sur le nombre de colonne
	$retour_o.rows.push(New object:C1471(\
		"uid"; $enregistrement_o.getKey(dk key as string:K85:16); \
		"equipementType"; $enregistrement_o.OneEquipement.EQU_Type; \
		"equipementNom"; $enregistrement_o.OneEquipement.EQU_Nom; \
		"dateInstallation"; String:C10($enregistrement_o.dateInstallation); \
		"quantite"; String:C10($enregistrement_o.quantite)))
	
End for each 

WEB_UTL_send_json(JSON Stringify:C1217($retour_o))