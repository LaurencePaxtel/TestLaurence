//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26-12-18, 08:09:13
// ----------------------------------------------------
// Method: GES_Init_Variables
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301(lig_quantite; lig_montant_ht; lig_prix_unitaire_net; lig_taux_tva; lig_prix_unitaire_ttc; lig_montant_ttc; lig_montant_tva; lig_montant_remise; lig_Prix_unitaire)

lig_quantite:=->[Factures_Lignes:87]FACL_Quantite:18
lig_montant_ht:=->[Factures_Lignes:87]FACL_Montant_HT:9
lig_prix_unitaire_net:=->[Factures_Lignes:87]FACL_Prix_Unit_Net:15
lig_taux_tva:=->[Factures_Lignes:87]FACL_Taux_TVA:10
lig_prix_unitaire_ttc:=->[Factures_Lignes:87]FACL_Prix_Unit_TTC:16
lig_montant_ttc:=->[Factures_Lignes:87]FACL_Montant_TTC:12
lig_montant_tva:=->[Factures_Lignes:87]FACL_Montant_TVA:11
lig_montant_remise:=->[Factures_Lignes:87]FACL_Remise_Montant:14
lig_Prix_unitaire:=->[Factures_Lignes:87]FACL_Prix_Unit_HT:8