//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26-12-18, 12:41:31
// ----------------------------------------------------
// Method: GES_Definition_Champs
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)
C_BOOLEAN:C305($2)

C_TEXT:C284($type)
C_POINTER:C301(lig_montant_ht; lig_montant_tva; lig_montant_remise; lig_montant_acompte; lig_taux_remise)
C_POINTER:C301(corp_Total_HT; corp_Total_TTC; corp_Total_TVA; corp_Total_remise; corp_taux_remise; corp_montant_acompte)
C_BOOLEAN:C305(corp_exonere_TVA)

$type:=$1
corp_exonere_TVA:=True:C214

If (Count parameters:C259>1)
	corp_exonere_TVA:=$2
End if 

Case of 
	: ($type="facture")
		lig_montant_ht:=->[Factures_Lignes:87]FACL_Montant_HT:9
		lig_montant_tva:=->[Factures_Lignes:87]FACL_Montant_TVA:11
		lig_montant_remise:=->[Factures_Lignes:87]FACL_Remise_Montant:14
		lig_montant_acompte:=->[Factures_Lignes:87]FACL_Acompte:19
		lig_taux_remise:=->[Factures_Lignes:87]FACL_Remise_Taux:13
		lig_montant_ttc:=->[Factures_Lignes:87]FACL_Montant_TTC:12
		
		corp_Total_HT:=->[Factures:86]FAC_Montant_HT:6
		corp_Total_TTC:=->[Factures:86]FAC_Montant_TTC:8
		corp_Total_TVA:=->[Factures:86]FAC_Montant_TVA:7
		corp_Total_remise:=->[Factures:86]FAC_Montant_remise:5
		corp_taux_remise:=->[Factures:86]FAC_Taux_Remise:4
		corp_montant_acompte:=->[Factures:86]FAC_Acompte:18
	: ($type="intervention")
		C_POINTER:C301(corp_EQU_Total_TTC; corp_Prestation_Total_TTC)
		
		corp_exonere_TVA:=False:C215
		
		lig_montant_ht:=->[Intervention_Lignes:109]INTL_Montant_HT:7
		lig_montant_tva:=->[Intervention_Lignes:109]INTL_Montant_TVA:9
		lig_montant_ttc:=->[Intervention_Lignes:109]INTL_Montant_TTC:10
		
		corp_Total_HT:=->[Intervention:108]INT_Total_HT:7
		corp_Total_TTC:=->[Intervention:108]INT_Total_TTC:9
		corp_Total_TVA:=->[Intervention:108]INT_Total_TVA:8
		
		corp_EQU_Total_TTC:=->[Intervention:108]INT_EQU_Total_TTC:10
		corp_Prestation_Total_TTC:=->[Intervention:108]INT_Prestation_Total_TTC:14
End case 