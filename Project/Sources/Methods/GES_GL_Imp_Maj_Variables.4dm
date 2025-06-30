//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 02/07/19, 14:03:59
// ----------------------------------------------------
// Method: GES_GL_Imp_Maj_Variables
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284(txt_strc_nom; txt_strc_telephone; txt_strc_email; txt_ll_adresse; txt_locataire_civilite; txt_locataire_nom; txt_locataire_adresse; txt_ll_date; txt_facture_notestxt_ll_nom)
C_TEXT:C284(txt_periode; txt_reference; txt_qt_numero)
C_TEXT:C284(txt_lig_loyer; txt_lig_charges; txt_paye; txt_echeance_paye; txt_lig_echeance_sa_lib; txt_lig_echeance_sa_mnt)
C_TEXT:C284(txt_pj_locataire_nom; txt_pj_reference; txt_pj_ll; txt_pj_periode; txt_pj_montant)
C_TEXT:C284(txt_lig_apl; txt_lig_apl_montant)
C_TEXT:C284(txt_locataire_adresse_1; txt_locataire_adresse_2; txt_locataire_adresse_3; txt_locataire_adresse_4)
C_PICTURE:C286(strc_logo)

C_REAL:C285($charges_montant_total; $apl_montant_total)
var $factures_e : cs:C1710.FacturesEntity
$factures_e:=ds:C1482.Factures.get([Factures:86]ID:1)

txt_strc_nom:=""
txt_strc_telephone:=""
txt_strc_email:=""

txt_ll_adresse:=""
txt_locataire_civilite:=""
txt_locataire_nom:=""
txt_locataire_adresse:=""
txt_locataire_adresse_1:=""
txt_locataire_adresse_2:=""
txt_locataire_adresse_3:=""
txt_locataire_adresse_4:=""
txt_ll_date:=""
txt_ll_nom:=""

txt_periode:=""
txt_reference:=""
txt_qt_numero:=""

txt_lig_loyer:=""
txt_lig_charges:=""
txt_lig_loyer_montant:=""
txt_lig_charges_montant:=""
txt_lig_apl:=""
txt_lig_apl_montant:=""

txt_lig_echeance_sa_lib:=""
txt_lig_echeance_sa_mnt:=""

txt_paye:=""
txt_echeance_paye:=""

txt_pj_locataire_nom:=""
txt_pj_reference:=""
txt_pj_ll:=""
txt_pj_periode:=""
txt_pj_montant:=""

txt_facture_notes:=""

READ ONLY:C145([Structures:79])
READ ONLY:C145([LesCentres:9])
READ ONLY:C145([Factures_Lignes:87])
READ ONLY:C145([HeBerge:4])

SOC_Get_Config

txt_titre_ligne_8:=[SOciete:18]SO_Fac_Pied_Ligne1:106
txt_titre_ligne_9:=[SOciete:18]SO_Fac_Pied_Ligne2:107
txt_titre_ligne_10:=[SOciete:18]SO_Fac_Pied_Ligne3:108

QUERY:C277([Structures:79]; [Structures:79]STRC_Initiales:2=ref_soc_active)
QUERY:C277([SOciete:18]; [SOciete:18]ID:94=[Structures:79]STRC_Societe_ID:6)

strc_logo:=[Structures:79]STRC_Logo:5
txt_strc_nom:=[Structures:79]STRC_Nom:4

txt_strc_telephone:=[SOciete:18]SO_Telephone:115
txt_strc_email:=[SOciete:18]SO_Email:116
txt_strc_adresse:=[SOciete:18]SO_Libel03:5
txt_lig_charges:=[SOciete:18]SO_FAC_Intitule_Quittance:118

txt_facture_notes:=$factures_e.FAC_Notes

txt_ll_nom:=$factures_e.FAC_Bien_Nom

//OBJECT SET RGB COLORS(*;"rectangle_ll";0x00FFFFFF;0x001F56AD)

//==========================================================//
// LOCATION
//==========================================================//
QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1; *)
QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Type_Ligne:26="location")
MultiSoc_Filter(->[Factures_Lignes:87])

If (Records in selection:C76([Factures_Lignes:87])=1)
	QUERY:C277([Locations:84]; [Locations:84]ID:1=[Factures_Lignes:87]FACL_Service_ID:4)
	MultiSoc_Filter(->[Locations:84])
	
	QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Locations:84]LOC_Bien_ID:5)
	MultiSoc_Filter(->[LesCentres:9])
	
	QUERY:C277([Adresses:53]; [Adresses:53]AD_ID_Origine:34=[LesCentres:9]ID:60; *)
	QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_ID_Table_Origine:35=Table:C252(->[LesCentres:9]))
	MultiSoc_Filter(->[Adresses:53])
	
	txt_ll_adresse:=$factures_e.FAC_Adresse_Proprietaire
	txt_ll_date:=SO_Ville+", Le "+String:C10($factures_e.FAC_Date_Piece)
	
	QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=[Locations:84]LOC_HB_ID:3)
	MultiSoc_Filter(->[HeBerge:4])
	
	txt_locataire_nom:=$factures_e.FAC_Locataire_Nom
	txt_locataire_adresse:=$factures_e.FAC_Adresse_Locataire
	
	QUERY:C277([Adresses:53]; [Adresses:53]AD_ID_Origine:34=[HeBerge:4]ID:65; *)
	QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_ID_Table_Origine:35=Table:C252(->[HeBerge:4]))
	MultiSoc_Filter(->[Adresses:53])
	
	txt_locataire_adresse_1:=[Adresses:53]AD_Adresse1:16
	txt_locataire_adresse_2:=[Adresses:53]AD_Adresse2:17
	txt_locataire_adresse_3:=[Adresses:53]AD_Adresse3:18
	txt_locataire_adresse_4:=[Adresses:53]AD_Code_postal:19+" "+[Adresses:53]AD_Ville:20
	
	txt_periode:="PERIODE DU "+String:C10([Factures_Lignes:87]FACL_Date_Du:21)+" AU "+String:C10([Factures_Lignes:87]FACL_Date_Au:22)
	txt_reference:="Réf. : "+String:C10([Locations:84]ID:1)
	txt_qt_numero:="Quittance n° "+$factures_e.FAC_No_Piece
	txt_echeance_num:="Avis n° "+String:C10($factures_e.ID+1)
	
	txt_lig_loyer:="LOYER"
	txt_lig_loyer_montant:=String:C10([Factures_Lignes:87]FACL_Montant_TTC:12)
	
	txt_lig_echeance_sa_lib:="SOLDE ANTÉRIEUR AU "+String:C10(Add to date:C393([Factures_Lignes:87]FACL_Date_Du:21; 0; 0; -1))
	txt_lig_echeance_sa_mnt:=String:C10($factures_e.FAC_Solde_Du_cal)
	
	txt_pj_locataire_nom:=txt_locataire_nom
	txt_pj_reference:=String:C10([Locations:84]ID:1)
	txt_pj_ll:=$factures_e.FAC_Bien_Nom
	txt_pj_ll_adresse:=txt_ll_adresse
	txt_pj_periode:="Du "+String:C10([Factures_Lignes:87]FACL_Date_Du:21)+" Au "+String:C10([Factures_Lignes:87]FACL_Date_Au:22)
	txt_pj_montant:=txt_lig_loyer_montant+" €"
End if 

//==========================================================//
// CHARGES
//==========================================================//
QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=$factures_e.ID; *)
QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Type_Ligne:26="charge")

While (Not:C34(End selection:C36([Factures_Lignes:87])))
	$charges_montant_total:=$charges_montant_total+[Factures_Lignes:87]FACL_Montant_TTC:12
	
	If (txt_lig_charges="")
		txt_lig_charges:="PROVISIONS SUR CHARGES"
	End if 
	
	txt_lig_charges_montant:=String:C10($charges_montant_total)
	
	If ([Factures_Lignes:87]FACL_Type_Ligne:26="apl")
		txt_lig_apl:="APL"
		txt_lig_apl_montant:=String:C10([Factures_Lignes:87]FACL_Montant_TTC:12)
	End if 
	
	NEXT RECORD:C51([Factures_Lignes:87])
End while 

txt_locataire_nom:=$factures_e.FAC_Locataire_Nom

//==========================================================//
// APL
//==========================================================//
QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=$factures_e.ID; *)
QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Type_Ligne:26="apl")

While (Not:C34(End selection:C36([Factures_Lignes:87])))
	$apl_montant_total:=$apl_montant_total+[Factures_Lignes:87]FACL_Montant_TTC:12
	
	If (txt_lig_apl="")
		txt_lig_apl:="APL"
	End if 
	
	txt_lig_apl_montant:=String:C10($apl_montant_total)
	
	NEXT RECORD:C51([Factures_Lignes:87])
End while 

txt_paye:="PAYÉ : "+String:C10($factures_e.FAC_Montant_TTC)+" €"
txt_echeance_paye:="NET A PAYER : "+String:C10($factures_e.FAC_Net_A_Payer_cal)+" €"
txt_pj_montant:=String:C10($factures_e.FAC_Net_A_Payer_cal)+" €"