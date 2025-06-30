//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 02/07/19, 14:03:59
// ----------------------------------------------------
// Method: GES_Imp_Maj_Variables
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_TEXT:C284($2)  //[optionnel]

C_TEXT:C284(txt_strc_nom; txt_strc_nom_suite; txt_ll_adresse; txt_strc_cp_ville; txt_destinataire_nom; txt_strc_email; txt_destinataire_adresse; txt_piece_titre; file_name_pdf; \
txt_periode; txt_reference; txt_qt_numero; impression_modele; txt_ht; txt_tva; txt_ttc; txt_solde_du; txt_strc_tel; txt_strc_fax; txt_lig_libelle; txt_lig_usager\
; txt_lig_sejour_du; txt_lig_sejour_au; txt_titre_ligne_1; txt_titre_ligne_2; txt_titre_ligne_3; txt_titre_ligne_4; txt_titre_ligne_5; txt_titre_ligne_6; \
txt_titre_ligne_7; txt_titre_ligne_8; txt_titre_ligne_9; txt_titre_ligne_10; txt_titre_ligne_11; txt_titre_ligne_12; txt_titre_ligne_13; txt_titre_ligne_14)
C_REAL:C285(num_total_ht; num_total_tva; num_total_ttc; num_total_solde; num_net_a_payer; num_solde_anterieur)
C_PICTURE:C286(strc_logo)

C_POINTER:C301($ptr_table)
C_OBJECT:C1216($avoir_o)
C_COLLECTION:C1488($avoir_c)


var $facture_e : cs:C1710.FacturesEntity
var $facture_es : cs:C1710.FacturesSelection
var $factureCurrent_e : cs:C1710.FacturesEntity

var $reglement_es; $reglementB_es : cs:C1710.ReglementsSelection

$factureCurrent_e:=ds:C1482.Factures.get([Factures:86]ID:1)

$ptr_table:=$1

If (Count parameters:C259>1)
	impression_modele:=$2
End if 

txt_strc_nom:=""
txt_strc_nom_suite:=""

txt_destinataire_nom:=""

txt_destinataire_adresse:=""

// Modifié par : Scnau Rémy (29/07/2021)
txt_strc_cp_ville:=""

txt_piece_titre:=""
txt_lig_libelle:=""

txt_lig_sejour_du:=""
txt_lig_sejour_au:=""

txt_lig_usager:=""
file_name_pdf:=""

txt_periode:=""
txt_reference:=""
txt_qt_numero:=""

txt_ht:="Total HT"
txt_tva:="Total TVA"

// Modifié par : Scanu Rémy - remy@connect-io.fr (22/06/2021)
// On affiche le taux de TVA
If ($ptr_table=->[Factures:86])
	txt_tva:=txt_tva+" "+String:C10($factureCurrent_e.FAC_Montant_TVA)+"%"
End if 

txt_ttc:="Total TTC"
txt_solde_du:="Solde dû"
txt_montant_regle:="Montant réglé"
txt_net_a_payer:="Net à payer"

txt_titre_ligne_1:=""
txt_titre_ligne_2:=""
txt_titre_ligne_3:=""
txt_titre_ligne_4:=""
txt_titre_ligne_5:=""
txt_titre_ligne_6:=""
txt_titre_ligne_7:=""
txt_titre_ligne_8:=""
txt_titre_ligne_9:=""
txt_titre_ligne_10:=""
txt_titre_ligne_11:=""
txt_titre_ligne_12:=""
txt_titre_ligne_13:=""

READ ONLY:C145([Structures:79])
READ ONLY:C145([LesCentres:9])
READ ONLY:C145([Factures_Lignes:87])
READ ONLY:C145([HeBerge:4])

var $Ref_Structure_t : Text
If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
	$Ref_Structure_t:=Session:C1714.storage.intervenant.Ref_Structure
Else 
	$Ref_Structure_t:=Storage:C1525.societeDetail.Ref_Structure
End if 

QUERY:C277([Structures:79]; [Structures:79]STRC_Initiales:2=$Ref_Structure_t)
QUERY:C277([SOciete:18]; [SOciete:18]ID:94=[Structures:79]STRC_Societe_ID:6)

strc_logo:=[Structures:79]STRC_Logo:5


txt_strc_nom:=[SOciete:18]SO_Libel01:3
txt_strc_nom_suite:=[SOciete:18]SO_Libel02:4

txt_strc_adresse:=[SOciete:18]SO_Libel03:5
txt_strc_cp_ville:=[SOciete:18]SO_Ville:76

txt_strc_tel:=""
txt_strc_email:=""
txt_strc_fax:=""

Case of 
	: ($ptr_table=->[Factures:86])
		txt_piece_titre:="Facture provisoire"
		
		If ([Factures:86]FAC_No_Piece:2#"")
			
			If ([Factures:86]FAC_Montant_TTC:8>0)
				txt_piece_titre:="Facture n° "+[Factures:86]FAC_No_Piece:2
			Else 
				txt_piece_titre:="Avoir n° "+[Factures:86]FAC_No_Piece:2
			End if 
			
		End if 
		
		txt_titre_ligne_1:="Date : "+String:C10([Factures:86]FAC_Date_Piece:3)
		txt_titre_ligne_2:="Echéance : "+String:C10([Factures:86]FAC_Date_Echeance:20)
		txt_titre_ligne_4:=""
		
		txt_destinataire_nom:=[Factures:86]FAC_Destinataire_Nom:13
		txt_destinataire_adresse:=[Factures:86]FAC_Adresse_Facturation:14
		
		num_total_ht:=[Factures:86]FAC_Montant_HT:6
		num_total_tva:=[Factures:86]FAC_Montant_TVA:7
		num_total_ttc:=[Factures:86]FAC_Montant_TTC:8
		
		num_total_solde:=var_total_solde_du
		
		If (Type:C295(tb_fac_id)#Est une variable indéfinie:K8:13) & (Type:C295(tb_fac_choix)#Est une variable indéfinie:K8:13)
			$pos_el:=Find in array:C230(tb_fac_id; [Factures:86]ID:1)
			
			If ($pos_el>0) & (Count in array:C907(tb_fac_choix; True:C214)>0)
				$facture_es:=ds:C1482.Factures.query("FAC_Destinataire_ID = :1 AND FAC_Annee <= :2 AND ID <= :3"; [Factures:86]FAC_Destinataire_ID:11; [Factures:86]FAC_Annee:34; [Factures:86]ID:1)
				
				// Modifié par : Scanu Rémy (05/07/2022)
				num_total_solde:=$facture_es.sum("FAC_Solde_Du_cal")
			End if 
			
		End if 
		
		
		// Modifié par : Scanu Rémy (27/07/2021)
		$facture_es:=ds:C1482.Factures.query("FAC_Destinataire_ID = :1 AND FAC_Annee <= :2 AND ID < :3"; [Factures:86]FAC_Destinataire_ID:11; [Factures:86]FAC_Annee:34; [Factures:86]ID:1)
		
		// Modifié par : Scanu Rémy (23/08/2023)
		// On prends la somme de tous les réglements de la table [Reglements] et pas [Factures]FAC_Solde_Regle
		//num_solde_anterieur:=num_total_solde-[Factures]FAC_Montant_TTC+[Factures]FAC_Solde_Regle
		//num_solde_anterieur:=$facture_es.sum("FAC_Montant_TTC")-$facture_es.sum("FAC_Solde_Regle")
		$reglement_es:=ds:C1482.Reglements.newSelection()
		
		For each ($facture_e; $facture_es)
			$reglementB_es:=ds:C1482.Reglements.query("REG_Origine_IDS = :1"; "@"+String:C10($facture_e.ID)+"@")
			
			If ($reglementB_es.length>0)
				$reglement_es:=$reglement_es.or($reglementB_es)
			End if 
			
		End for each 
		
		num_solde_anterieur:=$facture_es.sum("FAC_Montant_TTC")-$reglement_es.sum("REG_Montant")
		
		// Modifié par : Scanu Rémy (02/09/2022)
		$avoir_o:=ds:C1482.Factures.query("ID > :1 AND FAC_Destinataire_ID = :2 AND FAC_Montant_TTC < :3"; [Factures:86]ID:1; [Factures:86]FAC_Destinataire_ID:11; 0)
		$avoir_c:=$avoir_o.toCollection("FAC_Avoir_ID").extract("FAC_Avoir_ID")
		
		If ($avoir_c.indexOf([Factures:86]ID:1)#-1)
			num_solde_anterieur:=num_solde_anterieur+$avoir_o.sum("FAC_Montant_TTC")
		End if 
		
		num_montant_regle:=[Factures:86]FAC_Solde_Regle:26
		num_net_a_payer:=$factureCurrent_e.FAC_Net_A_Payer_cal
		
		txt_lig_libelle:=[Factures_Lignes:87]FACL_Titre:6
		
		If ([SOciete:18]SO_Activer_Impression_CN:100) & (impression_modele="Modèle par défaut")
			txt_lig_libelle:=txt_lig_libelle+" ("+[Factures_Lignes:87]FACL_Libelle:5+")"
		End if 
		
		If ([Factures:86]FAC_No_Piece:2#"")
			file_name_pdf:="Facture_"+Replace string:C233([Factures:86]FAC_No_Piece:2; "FAC/"; "")+".pdf"
		Else 
			file_name_pdf:="Facture_provisoire_"+String:C10([Factures:86]ID:1)+".pdf"
		End if 
		
		If ([Factures:86]FAC_Commentaires:47#"")
			txt_titre_ligne_11:=[Factures:86]FAC_Commentaires:47
		Else 
			txt_titre_ligne_11:=[Factures:86]FAC_Notes:17
		End if 
		
		If (([Factures:86]FAC_Periode_Du:51#!00-00-00!) & ([Factures:86]FAC_Periode_Au:52#!00-00-00!))
			txt_titre_ligne_13:="Période du "+String:C10([Factures:86]FAC_Periode_Du:51)+" au "+String:C10([Factures:86]FAC_Periode_Au:52)
		End if 
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (14/04/2021)
		//CHERCHER([Factures_Lignes];[Factures_Lignes]FACL_Piece_ID=[Factures]ID)
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (21/04/2021)
		If ([Factures_Lignes:87]FACL_HB_ID:33#0)
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Factures_Lignes:87]FACL_HB_ID:33)
		Else 
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Factures:86]FAC_Destinataire_ID:11)
		End if 
		
		MultiSoc_Filter(->[HeBerge:4])
		
		txt_lig_usager:=[HeBerge:4]HB_Clé:2
		
		// Coordonnées bancaires
		QUERY:C277([Banques:91]; [Banques:91]BQE_Origine_ID:17=[SOciete:18]ID:94; *)
		QUERY:C277([Banques:91];  & ; [Banques:91]BQE_Origine_No_Table:18=Table:C252(->[SOciete:18]))
		
		MultiSoc_Filter(->[Banques:91])
		
		If (Records in selection:C76([Banques:91])=1)
			txt_titre_ligne_5:=[Banques:91]BQE_Domiciliation:3+" - "+[Banques:91]BQE_Nom_Bancaire:4
			
			// Modifié par : Scanu Rémy - remy@connect-io.fr (05/05/2021)    
			txt_titre_ligne_6:=[Banques:91]BQE_IBAN:9
			txt_titre_ligne_7:=[Banques:91]BQE_BIC:19
		End if 
		
		txt_titre_ligne_8:=[SOciete:18]SO_Fac_Pied_Ligne1:106
		txt_titre_ligne_9:=[SOciete:18]SO_Fac_Pied_Ligne2:107
		txt_titre_ligne_10:=[SOciete:18]SO_Fac_Pied_Ligne3:108
		
		FAC_Modeles_Impression_Get("values"; impression_modele)
		
		// Mode de facturation
		If ([Factures:86]FAC_Type_Facturation:49="Participations")
			txt_piece_titre:=Replace string:C233(txt_piece_titre; "Facture"; "Participation")
			file_name_pdf:=Replace string:C233(file_name_pdf; "Facture"; "Participation")
		End if 
		
End case 