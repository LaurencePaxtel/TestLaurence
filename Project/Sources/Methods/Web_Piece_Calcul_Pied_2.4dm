//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26-12-18, 12:27:37
// ----------------------------------------------------
// Method: Web_Piece_Calcul_Pied_2
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_TEXT:C284($4)

C_POINTER:C301($table; $table_lignes; $champ_piece_id)
C_TEXT:C284($libelle)
C_OBJECT:C1216($O_Output)
C_BOOLEAN:C305($continu)
C_LONGINT:C283($id)

$table:=$1
$table_lignes:=$2
$champ_piece_id:=$3
$libelle:=$4

$O_Output:=New object:C1471
$continu:=True:C214

$id:=[Factures:86]ID:1

READ WRITE:C146($table->)
GES_Definition_Champs($libelle; False:C215)

//Calcul des totaux
corp_Total_HT->:=Round:C94(Sum:C1(lig_montant_ht->); 2)

If (corp_exonere_TVA=True:C214)
	corp_Total_TTC->:=Round:C94(corp_Total_HT->; 2)
	corp_Total_TVA->:=0
Else 
	corp_Total_TTC->:=Round:C94(Sum:C1(lig_montant_ttc->); 2)
	corp_Total_TVA->:=Round:C94(Sum:C1(lig_montant_tva->); 2)
End if 

corp_Total_remise->:=Round:C94(Sum:C1(lig_montant_remise->); 2)
corp_taux_remise->:=Round:C94(corp_Total_remise->/(corp_Total_HT->+corp_Total_remise->)*100; 2)

corp_montant_acompte->:=Round:C94(Sum:C1(lig_montant_acompte->); 2)

Case of 
	: ($libelle="facture")
		
		If (([Factures:86]FAC_Type_Piece:40="location") | ([Factures:86]FAC_Type_Piece:40="mixte")) & ([Factures:86]FAC_Type:21#"Avoir")
			[Factures:86]FAC_Loyer_Residuel:56:=[Factures:86]FAC_Montant_TTC:8+[Factures:86]FAC_Total_APL:54
		End if 
		
		// Modifié par : Scanu Rémy (19/04/2023) et Re-modifié par Scanu Rémy (26/09/2023) et Re-modifié par Scanu Rémy (29/08/2024)
		// Génération du solde antérieur (solde due de la facture précédente)
		Case of 
			: ([Factures:86]FAC_Type:21="Avoir")
			: ([Factures:86]FAC_Type_Piece:40="location")
				outilsManageFacture(1; [Factures:86]FAC_Locataire_ID:29)
			Else 
				outilsManageFacture(10; [Participations:116]PAR_HB_ID:2)
		End case 
		
		var $factures_e : cs:C1710.FacturesEntity
		$factures_e:=ds:C1482.Factures.get([Factures:86]ID:1)
		[Factures:86]FAC_Net_A_Payer:61:=$factures_e.FAC_Net_A_Payer_cal
		
End case 