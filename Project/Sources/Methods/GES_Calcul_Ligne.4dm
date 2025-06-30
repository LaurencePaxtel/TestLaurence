//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26-12-18, 07:57:08
// ----------------------------------------------------
// Method: GES_Calcul_Ligne
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283(nbr_arrondi)


nbr_arrondi:=2

GES_Init_Variables

lig_prix_unitaire_net->:=Round:C94(lig_Prix_unitaire->-(lig_Prix_unitaire->*(lig_taux_remise->/100)); nbr_arrondi)

lig_montant_ht->:=Round:C94(lig_quantite->*lig_prix_unitaire_net->; nbr_arrondi)
lig_montant_tva->:=Round:C94(lig_montant_ht->*lig_taux_tva->/100; nbr_arrondi)

lig_prix_unitaire_ttc->:=Round:C94(lig_prix_unitaire_net->*((100+lig_taux_tva->)/100); nbr_arrondi)
lig_montant_ttc->:=lig_montant_ht->+lig_montant_tva->

lig_montant_remise->:=Round:C94((lig_Prix_unitaire->-lig_prix_unitaire_net->)*lig_quantite->; nbr_arrondi)