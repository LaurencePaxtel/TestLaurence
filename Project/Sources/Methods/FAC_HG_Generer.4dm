//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 28/01/20, 17:33:17
// ----------------------------------------------------
// Method: FAC_HG_Generer
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $msg; $cle_valeur; $cle_valeur_previous; $hg_dates; $ids_hebergements; $mois_annee_libelle : Text
var $i; $nb_fiches; $centre_id_valeur; $centre_id_valeur_previous; $pos; $size_initial; $compteur; $mois_numero; $pos; $size_initial; $progress_id : Integer
var $continu; $generer_lignes : Boolean

var $centre_e : cs:C1710.LesCentresEntity

ARRAY TEXT:C222($tb_fac_mois_annee; 0)
ARRAY LONGINT:C221($tb_fac_mois; 0)

corp_exonere_TVA:=False:C215
$continu:=True:C214

GES_Definition_Champs("facture")
SOC_Get_Config

START TRANSACTION:C239
READ WRITE:C146([Factures:86])

$size_initial:=Size of array:C274(tb_cle)
SORT ARRAY:C229(tb_liste_choix; tb_cle; tb_hb_reference_id; tb_centre_id; tb_date; tb_etat_civil; tb_designation; tb_facture_bool; tb_facture_num; tb_id; tb_hg_reference_id; tb_liste_financeur; <)

$pos:=Find in array:C230(tb_liste_choix; False:C215)

If ($pos>0)
	DELETE FROM ARRAY:C228(tb_liste_choix; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_cle; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_centre_id; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_hb_reference_id; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_date; $pos; $size_initial)
	
	// Secondaires
	DELETE FROM ARRAY:C228(tb_etat_civil; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_designation; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_facture_bool; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_facture_num; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_id; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_hg_reference_id; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_liste_financeur; $pos; $size_initial)
End if 

MULTI SORT ARRAY:C718(tb_cle; >; tb_hb_reference_id; >; tb_centre_id; >; tb_date; >; tb_liste_choix; >; tb_etat_civil; >; tb_designation; >; tb_facture_bool; >; tb_facture_num; >; tb_id; >; tb_hg_reference_id; >; tb_liste_financeur; >)

$progress_id:=Progress New

Progress SET TITLE($progress_id; "Facturation..."; -1; "en cours d'exécution...")
Progress SET BUTTON ENABLED($progress_id; True:C214)

For ($i; 1; Size of array:C274(tb_liste_choix))
	$cle_valeur:=tb_cle{$i}
	$centre_id_valeur:=tb_centre_id{$i}
	
	Progress SET PROGRESS($progress_id; $i/Size of array:C274(tb_liste_choix); "Facturation..."+String:C10($i)+" / "+String:C10(Size of array:C274(tb_liste_choix)); False:C215)
	Progress SET MESSAGE($progress_id; "Encours... "+tb_designation{$i}; False:C215)
	
	READ WRITE:C146([HeberGement:5])
	
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=tb_hg_reference_id{$i}; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4=tb_date{$i}; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_HB_ID:19=tb_hb_reference_id{$i}; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Facture:172=False:C215)
	
	MultiSoc_Filter(->[HeberGement:5])
	
	If (Records in selection:C76([HeberGement:5])=0)
		$continu:=False:C215
		$msg:="La sélection contient des fiches qui sont déja facturées"
	End if 
	
	If ($continu)
		READ ONLY:C145([HeBerge:4])
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=tb_hb_reference_id{$i})
		MultiSoc_Filter(->[HeBerge:4])
		
		If (Records in selection:C76([HeBerge:4])#1)
			$continu:=False:C215
			$msg:="L'hébergé de la fiche hébergement avec la référence ID "+String:C10(tb_hb_reference_id{$i})+" n'a pas pu être trouvé dans la base de donnée."
		End if 
		
	End if 
	
	If ($continu)
		
		If ($cle_valeur#$cle_valeur_previous)
			QUERY:C277([Structures:79]; [Structures:79]STRC_Initiales:2=<>ref_soc_active)
			QUERY:C277([SOciete:18]; [SOciete:18]ID:94=[Structures:79]STRC_Societe_ID:6)
			
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=$cle_valeur)
			
			// Modifié par : Rémy Scanu - remy@connect-io.fr (21/04/2021)
			ARRAY DATE:C224(tb_hg_dates; 0)
			ARRAY DATE:C224(tb_hg_lig_dates; 0)
			
			CREATE RECORD:C68([Factures:86])
			MultiSoc_Init_Structure(->[Factures:86])
			
			[Factures:86]FAC_Intervenant_ID:27:=w_userUID
			[Factures:86]FAC_Date_Piece:3:=Current date:C33(*)
			[Factures:86]FAC_Date_Echeance:20:=Add to date:C393(Current date:C33(*); 0; 0; [SOciete:18]SO_Nb_Jours_Echeance:102)
			
			// Modifié par : Scanu Rémy (19/04/2023)
			// On sauvegarde le centre de la dernière fiche hébergement trouvée pour le mois facturé
			outilsOrdaSearchSimple(->[LesCentres:9]; ->[LesCentres:9]LC_RéférenceID:1; [HeberGement:5]HG_LC_ID:61; ->$centre_e; "first")
			
			If ($centre_e#Null:C1517)
				[Factures:86]FAC_Bien_ID:28:=$centre_e.ID
				[Factures:86]FAC_Bien_Nom:30:=$centre_e.LC_Nom
				
				[Factures:86]FAC_Libelle:42:=$centre_e.LC_Nom
			End if 
			
			[Factures:86]FAC_Origine_ID:37:=tb_hb_reference_id{$i}
			[Factures:86]FAC_Date_HB:43:=tb_date{$i}
			
			[Factures:86]FAC_Type_Piece:40:="HG"
			[Factures:86]FAC_Destinataire_ID:11:=[HeBerge:4]HB_ReferenceID:1
			[Factures:86]FAC_Destinataire_Nom:13:=[HeBerge:4]HB_Nom:3+" "+[HeBerge:4]HB_Prénom:4
			[Factures:86]FAC_Destinataire_Type:50:="Hébergé"
			[Factures:86]FAC_Type:21:="Provisoire"
			[Factures:86]FAC_Adresse_Facturation:14:=UTL_Get_Adresse(->[HeBerge:4]ID:65; ->[HeBerge:4])
			[Factures:86]FAC_ID_Adresse_Facturation:15:=[Adresses:53]ID:32
			[Factures:86]FAC_Mode_Reglement:22:="Espèce"
			
			[Factures:86]FAC_Regle_Status_Color:44:=0x00FC4444
			[Factures:86]FAC_Type_Facturation:49:="Prestations"
		End if 
		
		//===========================================//
		// DONNEES
		//===========================================//
		
		FIRST RECORD:C50([HeberGement:5])
		$nb_fiches:=$nb_fiches+Records in selection:C76([HeberGement:5])
		
		While (Not:C34(End selection:C36([HeberGement:5])))
			$compteur:=$compteur+1
			
			APPEND TO ARRAY:C911(tb_hg_dates; [HeberGement:5]HG_Date:4)
			APPEND TO ARRAY:C911(tb_hg_lig_dates; [HeberGement:5]HG_Date:4)
			
			If ($compteur=1)
				$hg_dates:=$hg_dates+String:C10([HeberGement:5]HG_Date:4)
				$ids_hebergements:=$ids_hebergements+String:C10([HeberGement:5]HG_ReferenceID:1)
			Else 
				$hg_dates:=$hg_dates+" - "+String:C10([HeberGement:5]HG_Date:4)
				$ids_hebergements:=$ids_hebergements+";"+String:C10([HeberGement:5]HG_ReferenceID:1)
			End if 
			
			If (Locked:C147([HeberGement:5]))
				$continu:=False:C215
				$msg:="La sélection contient des fiches hebergements verrouillées"
			End if 
			
			If ([HeberGement:5]HG_Facture:172)
				$continu:=False:C215
				$msg:="La sélection contient des fiches hebergements qui sont déja facturées"
			End if 
			
			//=======Mois de facturation==========//
			$mois_numero:=Month of:C24([HeberGement:5]HG_Date:4)
			$mois_annee_libelle:=String:C10($mois_numero; "0#")+"/"+String:C10(Year of:C25([HeberGement:5]HG_Date:4))
			
			If (Find in array:C230($tb_fac_mois_annee; $mois_annee_libelle)<0)
				APPEND TO ARRAY:C911($tb_fac_mois; $mois_numero)
				APPEND TO ARRAY:C911($tb_fac_mois_annee; $mois_annee_libelle)
			End if 
			//===============//
			
			If ($continu)
				[HeberGement:5]HG_Facture:172:=True:C214
				SAVE RECORD:C53([HeberGement:5])
			End if 
			
			NEXT RECORD:C51([HeberGement:5])
		End while 
		//===========================================//
		
		CLEAR VARIABLE:C89($generer_lignes)
		
		Case of 
			: ($i+1<=Size of array:C274(tb_centre_id))
				
				If ($centre_id_valeur#tb_centre_id{$i+1}) | ($cle_valeur#tb_cle{$i+1})
					$generer_lignes:=True:C214
				End if 
				
			: ($i=Size of array:C274(tb_centre_id))
				$generer_lignes:=True:C214
		End case 
		
		If ($generer_lignes)
			READ ONLY:C145([LesCentres:9])
			
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=tb_centre_id{$i})
			MultiSoc_Filter(->[LesCentres:9])
			
			Case of 
				: (Records in selection:C76([LesCentres:9])#1)
					$continu:=False:C215
					$msg:="Le centre d'hébergement avec l'id "+String:C10(tb_centre_id{$i})+" n'a pas pu être trouvé dans la base de donnée"
				: ([LesCentres:9]LC_Facturation_1_Active:81=False:C215) & ([LesCentres:9]LC_Facturation_2_Active:82=False:C215) & ([LesCentres:9]LC_Facturation_3_Active:83=False:C215)
					$continu:=False:C215
					$msg:="Aucune ligne n'est activée au niveau de la fiche d'hébergement."
			End case 
			
			// Modifié par : Rémy Scanu - remy@connect-io.fr (21/04/2021)
			SORT ARRAY:C229(tb_hg_lig_dates; >)
			
			//===========================================//
			// LIGNE 1
			//===========================================//
			If ([LesCentres:9]LC_Facturation_1_Active:81)
				CREATE RECORD:C68([Factures_Lignes:87])
				MultiSoc_Init_Structure(->[Factures_Lignes:87])
				
				[Factures_Lignes:87]FACL_Piece_ID:3:=[Factures:86]ID:1
				[Factures_Lignes:87]FACL_Origine_Table_No:20:=Table:C252(->[Factures:86])
				[Factures_Lignes:87]FACL_Service_ID:4:=tb_centre_id{$i}
				[Factures_Lignes:87]FACL_Service_Ids:30:=$ids_hebergements
				[Factures_Lignes:87]FACL_Libelle:5:=[LesCentres:9]LC_Nom:4  //****************************
				[Factures_Lignes:87]FACL_Titre:6:=[LesCentres:9]LC_Designation:70
				[Factures_Lignes:87]FACL_Libelle_2:29:=$hg_dates
				[Factures_Lignes:87]FACL_Date_Fiche_Produit:27:=$hg_dates
				[Factures_Lignes:87]FACL_Quantite:18:=$nb_fiches
				[Factures_Lignes:87]FACL_Prix_Unit_HT:8:=[LesCentres:9]LC_Tarif:69  //****************************
				[Factures_Lignes:87]FACL_Taux_TVA:10:=[LesCentres:9]LC_TVA:71  //****************************
				[Factures_Lignes:87]FACL_Prix_Unit_Net:15:=([Factures_Lignes:87]FACL_Prix_Unit_HT:8-([Factures_Lignes:87]FACL_Prix_Unit_HT:8*([Factures_Lignes:87]FACL_Remise_Taux:13/100)))
				[Factures_Lignes:87]FACL_Montant_HT:9:=[Factures_Lignes:87]FACL_Quantite:18*[Factures_Lignes:87]FACL_Prix_Unit_Net:15
				[Factures_Lignes:87]FACL_Prix_Unit_TTC:16:=([Factures_Lignes:87]FACL_Prix_Unit_Net:15*((100+[Factures_Lignes:87]FACL_Taux_TVA:10)/100))
				[Factures_Lignes:87]FACL_Montant_TTC:12:=([Factures_Lignes:87]FACL_Montant_HT:9+[Factures_Lignes:87]FACL_Montant_TVA:11)
				[Factures_Lignes:87]FACL_Type_Ligne:26:="hebergement"
				[Factures_Lignes:87]FACL_Compte_Comptable:28:=[LesCentres:9]LC_Compte_Comptable:72  //****************************
				[Factures_Lignes:87]FACL_No_Ordre:7:=1
				
				// Modifié par : Rémy Scanu - remy@connect-io.fr (21/04/2021)
				If (Size of array:C274(tb_hg_lig_dates)>0)
					[Factures_Lignes:87]FACL_Sejour_Debut:31:=tb_hg_lig_dates{1}
					[Factures_Lignes:87]FACL_Sejour_Fin:32:=tb_hg_lig_dates{Size of array:C274(tb_hg_lig_dates)}
				End if 
				
				GES_Calcul_Ligne
				
				SAVE RECORD:C53([Factures_Lignes:87])
			End if 
			
			//===========================================//
			// LIGNE 2
			//===========================================//
			If ([LesCentres:9]LC_Facturation_2_Active:82)
				CREATE RECORD:C68([Factures_Lignes:87])
				MultiSoc_Init_Structure(->[Factures_Lignes:87])
				
				[Factures_Lignes:87]FACL_Piece_ID:3:=[Factures:86]ID:1
				[Factures_Lignes:87]FACL_Origine_Table_No:20:=Table:C252(->[Factures:86])
				[Factures_Lignes:87]FACL_Service_ID:4:=tb_centre_id{$i}
				[Factures_Lignes:87]FACL_Service_Ids:30:=$ids_hebergements
				[Factures_Lignes:87]FACL_Libelle:5:=[LesCentres:9]LC_Nom:4  //****************************
				[Factures_Lignes:87]FACL_Titre:6:=[LesCentres:9]LC_Designation_2:73  //****************************
				[Factures_Lignes:87]FACL_Libelle_2:29:=$hg_dates
				[Factures_Lignes:87]FACL_Date_Fiche_Produit:27:=$hg_dates
				[Factures_Lignes:87]FACL_Quantite:18:=$nb_fiches
				[Factures_Lignes:87]FACL_Prix_Unit_HT:8:=[LesCentres:9]LC_Tarif_2:74  //****************************
				[Factures_Lignes:87]FACL_Taux_TVA:10:=[LesCentres:9]LC_TVA_2:75  //****************************
				[Factures_Lignes:87]FACL_Prix_Unit_Net:15:=([Factures_Lignes:87]FACL_Prix_Unit_HT:8-([Factures_Lignes:87]FACL_Prix_Unit_HT:8*([Factures_Lignes:87]FACL_Remise_Taux:13/100)))
				[Factures_Lignes:87]FACL_Montant_HT:9:=[Factures_Lignes:87]FACL_Quantite:18*[Factures_Lignes:87]FACL_Prix_Unit_Net:15
				[Factures_Lignes:87]FACL_Prix_Unit_TTC:16:=([Factures_Lignes:87]FACL_Prix_Unit_Net:15*((100+[Factures_Lignes:87]FACL_Taux_TVA:10)/100))
				[Factures_Lignes:87]FACL_Montant_TTC:12:=([Factures_Lignes:87]FACL_Montant_HT:9+[Factures_Lignes:87]FACL_Montant_TVA:11)
				[Factures_Lignes:87]FACL_Type_Ligne:26:="hebergement"
				[Factures_Lignes:87]FACL_Compte_Comptable:28:=[LesCentres:9]LC_Compte_Comptable_2:76  //****************************
				[Factures_Lignes:87]FACL_No_Ordre:7:=2
				
				// Modifié par : Rémy Scanu - remy@connect-io.fr (21/04/2021)
				If (Size of array:C274(tb_hg_lig_dates)>0)
					[Factures_Lignes:87]FACL_Sejour_Debut:31:=tb_hg_lig_dates{1}
					[Factures_Lignes:87]FACL_Sejour_Fin:32:=tb_hg_lig_dates{Size of array:C274(tb_hg_lig_dates)}
				End if 
				
				GES_Calcul_Ligne
				SAVE RECORD:C53([Factures_Lignes:87])
			End if 
			
			//===========================================//
			// LIGNE 3
			//===========================================//
			If ([LesCentres:9]LC_Facturation_3_Active:83)
				CREATE RECORD:C68([Factures_Lignes:87])
				MultiSoc_Init_Structure(->[Factures_Lignes:87])
				
				[Factures_Lignes:87]FACL_Piece_ID:3:=[Factures:86]ID:1
				[Factures_Lignes:87]FACL_Origine_Table_No:20:=Table:C252(->[Factures:86])
				[Factures_Lignes:87]FACL_Service_ID:4:=tb_centre_id{$i}
				[Factures_Lignes:87]FACL_Service_Ids:30:=$ids_hebergements
				[Factures_Lignes:87]FACL_Libelle:5:=[LesCentres:9]LC_Nom:4  //****************************
				[Factures_Lignes:87]FACL_Titre:6:=[LesCentres:9]LC_Designation_3:77  //****************************
				[Factures_Lignes:87]FACL_Libelle_2:29:=$hg_dates
				[Factures_Lignes:87]FACL_Date_Fiche_Produit:27:=$hg_dates
				[Factures_Lignes:87]FACL_Quantite:18:=$nb_fiches
				[Factures_Lignes:87]FACL_Prix_Unit_HT:8:=[LesCentres:9]LC_Tarif_3:78  //****************************
				[Factures_Lignes:87]FACL_Taux_TVA:10:=[LesCentres:9]LC_TVA_3:79  //****************************
				[Factures_Lignes:87]FACL_Prix_Unit_Net:15:=([Factures_Lignes:87]FACL_Prix_Unit_HT:8-([Factures_Lignes:87]FACL_Prix_Unit_HT:8*([Factures_Lignes:87]FACL_Remise_Taux:13/100)))
				[Factures_Lignes:87]FACL_Montant_HT:9:=[Factures_Lignes:87]FACL_Quantite:18*[Factures_Lignes:87]FACL_Prix_Unit_Net:15
				[Factures_Lignes:87]FACL_Prix_Unit_TTC:16:=([Factures_Lignes:87]FACL_Prix_Unit_Net:15*((100+[Factures_Lignes:87]FACL_Taux_TVA:10)/100))
				[Factures_Lignes:87]FACL_Montant_TTC:12:=([Factures_Lignes:87]FACL_Montant_HT:9+[Factures_Lignes:87]FACL_Montant_TVA:11)
				[Factures_Lignes:87]FACL_Type_Ligne:26:="hebergement"
				[Factures_Lignes:87]FACL_Compte_Comptable:28:=[LesCentres:9]LC_Compte_Comptable_3:80  //****************************
				[Factures_Lignes:87]FACL_No_Ordre:7:=3
				
				// Modifié par : Rémy Scanu - remy@connect-io.fr (21/04/2021)
				If (Size of array:C274(tb_hg_lig_dates)>0)
					[Factures_Lignes:87]FACL_Sejour_Debut:31:=tb_hg_lig_dates{1}
					[Factures_Lignes:87]FACL_Sejour_Fin:32:=tb_hg_lig_dates{Size of array:C274(tb_hg_lig_dates)}
				End if 
				
				GES_Calcul_Ligne
				SAVE RECORD:C53([Factures_Lignes:87])
			End if 
			
			// Modifié par : Rémy Scanu - remy@connect-io.fr (21/04/2021)
			outilsCleanVariable(->$nb_fiches; ->$hg_dates; ->$ids_hebergements; ->$compteur)
			
			//======== Mois de facturation =======//
			
			If (Size of array:C274($tb_fac_mois_annee)=1)
				[Factures:86]FAC_Mois_Annee:48:=$tb_fac_mois_annee{1}
				
				[Factures:86]FAC_Mois:33:=Num:C11(Substring:C12([Factures:86]FAC_Mois_Annee:48; 1; Position:C15("/"; [Factures:86]FAC_Mois_Annee:48)-1))
				[Factures:86]FAC_Annee:34:=Num:C11(Substring:C12([Factures:86]FAC_Mois_Annee:48; Position:C15("/"; [Factures:86]FAC_Mois_Annee:48)+1))
			End if 
			
			DELETE FROM ARRAY:C228($tb_fac_mois; 1; Size of array:C274($tb_fac_mois))
			DELETE FROM ARRAY:C228($tb_fac_mois_annee; 1; Size of array:C274($tb_fac_mois_annee))
		End if 
		
		UNLOAD RECORD:C212([Factures_Lignes:87])
		
		// Modifié par : Rémy Scanu - remy@connect-io.fr (21/04/2021)
		If ((txt_filtre_pe_du=!00-00-00!) | (txt_filtre_pe_au=!00-00-00!))
			
			If (Size of array:C274(tb_hg_dates)>0)
				SORT ARRAY:C229(tb_hg_dates; >)
				
				[Factures:86]FAC_Periode_Du:51:=tb_hg_dates{1}
				[Factures:86]FAC_Periode_Au:52:=tb_hg_dates{Size of array:C274(tb_hg_dates)}
			End if 
			
		End if 
		
		QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
		Web_Piece_Calcul_Pied_2(->[Factures:86]; ->[Factures_Lignes:87]; ->[Factures_Lignes:87]FACL_Piece_ID:3; "facture")
		
		SAVE RECORD:C53([Factures:86])
	End if 
	
	$cle_valeur_previous:=$cle_valeur
	$centre_id_valeur_previous:=$centre_id_valeur
	
	If (Not:C34($continu))
		$i:=Size of array:C274(tb_liste_choix)
	End if 
	
End for 

Progress QUIT($progress_id)

If (Size of array:C274(tb_liste_choix)=0)
	$continu:=False:C215
	
	$msg:="Aucune fiche à facturer"
End if 

UNLOAD RECORD:C212([Factures:86])
READ ONLY:C145([Factures:86])

If (Not:C34($continu))
	ALERT:C41($msg)
	CANCEL TRANSACTION:C241
Else 
	VALIDATE TRANSACTION:C240
End if 

$0:=$continu