//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26-12-18, 12:27:37
// ----------------------------------------------------
// Method: Web_Piece_Calcul_Pied
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $1 : Pointer
var $2 : Pointer
var $3 : Pointer
var $4 : Text

var $libelle; $Status : Text
var $id : Integer
var $continu : Boolean
var $table; $table_lignes; $champ_piece_id : Pointer
var $O_Output; $O_Data : Object

var champID_p : Pointer

$table:=$1
$table_lignes:=$2
$champ_piece_id:=$3
$libelle:=$4
$O_Output:=New object:C1471
$continu:=True:C214

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; $libelle; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "id_piece"; Est un texte:K8:3))

EXECUTE FORMULA:C63("champID_p:=->["+Table name:C256($table)+"]id")

READ ONLY:C145($table_lignes->)
READ WRITE:C146($table->)

GES_Definition_Champs($libelle)

If ($id#0)
	QUERY:C277($table->; champID_p->=$id)
	QUERY:C277($table_lignes->; $champ_piece_id->=$id)
	
	//Calcul des totaux
	corp_Total_HT->:=Round:C94(Sum:C1(lig_montant_ht->); 2)
	
	If (corp_exonere_TVA=True:C214)
		corp_Total_TTC->:=Round:C94(corp_Total_HT->; 2)
		corp_Total_TVA->:=0
	Else 
		corp_Total_TTC->:=Round:C94(Sum:C1(lig_montant_ttc->); 2)
		corp_Total_TVA->:=Round:C94(Sum:C1(lig_montant_tva->); 2)
	End if 
	
	If (corp_Total_remise#Null:C1517)
		corp_Total_remise->:=Round:C94(Sum:C1(lig_montant_remise->); 2)
		corp_taux_remise->:=Round:C94(corp_Total_remise->/(corp_Total_HT->+corp_Total_remise->)*100; 2)
		
		corp_montant_acompte->:=Round:C94(Sum:C1(lig_montant_acompte->); 2)
	End if 
	
	If ($libelle="intervention")
		QUERY:C277($table_lignes->; $champ_piece_id->=$id; *)
		QUERY:C277($table_lignes->;  & ; [Intervention_Lignes:109]INTL_EQU_ID:4#0)
		corp_EQU_Total_TTC->:=Round:C94(Sum:C1(lig_montant_ttc->); 2)
		
		QUERY:C277($table_lignes->; $champ_piece_id->=$id; *)
		QUERY:C277($table_lignes->;  & ; [Intervention_Lignes:109]INTL_EQU_ID:4=0)
		corp_Prestation_Total_TTC->:=Round:C94(Sum:C1(lig_montant_ttc->); 2)
	End if 
	
	If ($libelle="facture")
		var $factures_e : cs:C1710.FacturesEntity
		$factures_e:=ds:C1482.Factures.get([Factures:86]ID:1)
		[Factures:86]FAC_Net_A_Payer:61:=$factures_e.FAC_Net_A_Payer_cal
	End if 
	
Else 
	$continu:=False:C215
End if 

If ($continu)
	$T_JSON:=Selection to JSON:C1234($table->; SelectionJson_template($table))
Else 
	$status:="Failed"
	
	OB SET:C1220($O_Output; "Status"; $status)
	$T_Json:=JSON Stringify:C1217($O_Output)
End if 

WEB SEND TEXT:C677($T_Json)