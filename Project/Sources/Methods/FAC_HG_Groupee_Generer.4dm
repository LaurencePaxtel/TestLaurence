//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 09/07/2020, 14:14:21
// ----------------------------------------------------
// Method: FAC_HG_Groupee_Generer
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($0)

C_TEXT:C284($msg; $cle_valeur; $cle_valeur_previous; $financeur_valeur; $financeur_valeur_previous; $financeur_nom; $hg_dates; $ids_hebergements; \
$mois_annee_libelle)
C_LONGINT:C283($i; $nb_fiches; $centre_id_valeur; $centre_id_valeur_previous; $pos; $size_initial; $compteur; $mois_numero)
C_BOOLEAN:C305($continu)
C_OBJECT:C1216($table_o)
C_COLLECTION:C1488($collection_c)

ARRAY TEXT:C222($tb_fac_mois_annee; 0)
ARRAY LONGINT:C221($tb_fac_mois; 0)

$collection_c:=New collection:C1472

corp_exonere_TVA:=False:C215
$continu:=True:C214

GES_Definition_Champs("facture")

SOC_Get_Config

START TRANSACTION:C239

READ WRITE:C146([Factures:86])

$size_initial:=Size of array:C274(tb_cle)
SORT ARRAY:C229(tb_liste_choix; tb_liste_financeur; tb_cle; tb_hb_reference_id; tb_centre_id; tb_date; tb_etat_civil; tb_designation; tb_facture_bool; tb_facture_num; tb_id; tb_hg_reference_id; <)

$pos:=Find in array:C230(tb_liste_choix; False:C215)

If ($pos>0)
	DELETE FROM ARRAY:C228(tb_liste_choix; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_liste_financeur; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_cle; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_centre_id; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_hb_reference_id; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_date; $pos; $size_initial)
	
	//Secondaires
	DELETE FROM ARRAY:C228(tb_etat_civil; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_designation; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_facture_bool; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_facture_num; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_id; $pos; $size_initial)
	DELETE FROM ARRAY:C228(tb_hg_reference_id; $pos; $size_initial)
End if 

MULTI SORT ARRAY:C718(tb_liste_financeur; >; tb_cle; >; tb_hb_reference_id; >; tb_centre_id; >; tb_date; >; tb_liste_choix; >; tb_etat_civil; >; tb_designation; >; tb_facture_bool; >; tb_facture_num; >; tb_id; >; tb_hg_reference_id; >)

$progress_id:=Progress New

Progress SET TITLE($progress_id; "Facturation..."; -1; "en cours d'exécution...")
Progress SET BUTTON ENABLED($progress_id; True:C214)

For ($i; 1; Size of array:C274(tb_liste_choix))
	$cle_valeur:=tb_cle{$i}
	
	$financeur_valeur:=tb_liste_financeur{$i}
	$centre_id_valeur:=tb_centre_id{$i}
	
	Progress SET PROGRESS($progress_id; $i/Size of array:C274(tb_liste_choix); "Facturation..."+String:C10($i)+" / "+String:C10(Size of array:C274(tb_liste_choix)); False:C215)
	Progress SET MESSAGE($progress_id; "Encours... "+tb_designation{$i}; False:C215)
	
	READ WRITE:C146([HeberGement:5])
	
	// toDo recherche par clé + prendre en compte tri sur colonne
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=tb_hg_reference_id{$i}; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4=tb_date{$i}; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_HB_ID:19=tb_hb_reference_id{$i}; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Facture:172=False:C215)
	
	MultiSoc_Filter(->[HeberGement:5])
	
	If (Records in selection:C76([HeberGement:5])=0)
		$continu:=False:C215
		
		$msg:="Aucun hébergement trouvé pour la fiche qui porte l'id "+String:C10(tb_hg_reference_id{$i})+" à la date du "+String:C10(tb_date{$i})
	End if 
	
	READ ONLY:C145([HeBerge:4])
	
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=tb_hb_reference_id{$i})
	MultiSoc_Filter(->[HeBerge:4])
	
	If (Records in selection:C76([HeBerge:4])#1)
		$continu:=False:C215
		
		$msg:="Impossible de retrouver l'héberger avec l'ID "+String:C10(tb_hb_reference_id{$i})
	End if 
	
	If ($continu)
		// Modifié par : Scanu Rémy - remy@connect-io.fr (07/05/2021)
		// On affiche dans la colonne tb_liste_financeur de la listbox le champ [HeberGement]HG_FamGroupe et non [Financeurs]FIN_Code ça n'a pas de sens \
												de faire donc cette recherche...
		READ ONLY:C145([Financeurs:117])
		
		QUERY:C277([Financeurs:117]; [Financeurs:117]FIN_Code:4=$financeur_valeur)
		MultiSoc_Filter(->[Financeurs:117])
		
		If (Records in selection:C76([Financeurs:117])#1)
			$continu:=False:C215
			
			$msg:="Impossible de retrouver le financeur avec le code "+$financeur_valeur
		End if 
		
		If ($continu)
			
			If ($financeur_valeur#$financeur_valeur_previous)
				QUERY:C277([Structures:79]; [Structures:79]STRC_Initiales:2=<>ref_soc_active)
				QUERY:C277([SOciete:18]; [SOciete:18]ID:94=[Structures:79]STRC_Societe_ID:6)
				
				If ([Financeurs:117]FIN_Nom:3="")
					$financeur_nom:=[Financeurs:117]FIN_Code:4
				Else 
					$financeur_nom:=[Financeurs:117]FIN_Nom:3
				End if 
				
				ARRAY DATE:C224(tb_hg_dates; 0)
				ARRAY DATE:C224(tb_hg_lig_dates; 0)
				
				CREATE RECORD:C68([Factures:86])
				MultiSoc_Init_Structure(->[Factures:86])
				
				[Factures:86]FAC_Intervenant_ID:27:=w_userUID
				[Factures:86]FAC_Date_Piece:3:=Current date:C33(*)
				[Factures:86]FAC_Date_Echeance:20:=Add to date:C393(Current date:C33(*); 0; 0; [SOciete:18]SO_Nb_Jours_Echeance:102)
				[Factures:86]FAC_Origine_ID:37:=tb_hb_reference_id{$i}
				[Factures:86]FAC_Date_HB:43:=tb_date{$i}
				[Factures:86]FAC_Type_Piece:40:="HG"
				[Factures:86]FAC_Destinataire_ID:11:=[Financeurs:117]ID:1
				[Factures:86]FAC_Destinataire_Nom:13:=$financeur_nom
				[Factures:86]FAC_Destinataire_Type:50:="Financeur"
				[Factures:86]FAC_Type:21:="Provisoire"
				[Factures:86]FAC_Adresse_Facturation:14:=UTL_Get_Adresse(->[Financeurs:117]ID:1; ->[Financeurs:117])
				
				//**********/
				If ([Financeurs:117]FIN_Siret:5#"")
					[Factures:86]FAC_Adresse_Facturation:14:=[Factures:86]FAC_Adresse_Facturation:14+Char:C90(Retour chariot:K15:38)+"Siret : "+[Financeurs:117]FIN_Siret:5
				End if 
				
				If ([Financeurs:117]FIN_Num_TVA:6#"")
					[Factures:86]FAC_Adresse_Facturation:14:=[Factures:86]FAC_Adresse_Facturation:14+Char:C90(Retour chariot:K15:38)+"TVA : "+[Financeurs:117]FIN_Num_TVA:6
				End if 
				
				[Factures:86]FAC_Periode_Du:51:=txt_filtre_pe_du
				[Factures:86]FAC_Periode_Au:52:=txt_filtre_pe_au
				//**********/
				
				[Factures:86]FAC_ID_Adresse_Facturation:15:=[Adresses:53]ID:32
				[Factures:86]FAC_Mode_Reglement:22:="Espèce"
				
				If (([Factures:86]FAC_Type:21="Définitive") & ([Factures:86]FAC_No_Piece:2=""))
					[Factures:86]FAC_No_Piece:2:=SO_Facture_Prefixe+"/"+UTL_Numerotation_Piece(->[Factures:86]FAC_Date_Piece:3)
					[Factures:86]FAC_Cloture:10:=True:C214
					[Factures:86]FAC_Statut:16:="Clôturée"
				Else 
					[Factures:86]FAC_Statut:16:=""
				End if 
				
				[Factures:86]FAC_Regle_Status_Color:44:=0x00FC4444
				[Factures:86]FAC_Type_Facturation:49:="Prestations"
				
				FIRST RECORD:C50([HeberGement:5])
				
				READ ONLY:C145([LesCentres:9])
				
				QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[HeberGement:5]HG_LC_ID:61)
				MultiSoc_Filter(->[LesCentres:9])
				
				[Factures:86]FAC_Libelle:42:=[LesCentres:9]LC_Nom:4
			End if 
			
			//===========================================//
			// DONNEES
			//===========================================//
			$nb_fiches:=$nb_fiches+Records in selection:C76([HeberGement:5])
			
			FIRST RECORD:C50([HeberGement:5])
			
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
					$msg:="La sélection contient des fiches verrouillées"
				End if 
				
				If ([HeberGement:5]HG_Facture:172)
					$continu:=False:C215
					
					$msg:="La sélection contient des fiches qui sont déja facturées"
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
			
			$generer_lignes:=False:C215
			
			If ($i+1<=Size of array:C274(tb_cle))
				
				If ($cle_valeur#tb_cle{$i+1})
					$generer_lignes:=True:C214
				End if 
				
			Else 
				$generer_lignes:=True:C214
			End if 
			
			If ($generer_lignes)
				READ ONLY:C145([LesCentres:9])
				
				QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=tb_centre_id{$i})
				MultiSoc_Filter(->[LesCentres:9])
				
				If (Records in selection:C76([LesCentres:9])#1)
					$continu:=False:C215
					
					If ($msg#"@Les centres@")
						$msg:=$msg+"Les centres "
					End if 
					
				Else 
					
					If ([LesCentres:9]LC_Facturation_1_Active:81=False:C215) & ([LesCentres:9]LC_Facturation_2_Active:82=False:C215) & ([LesCentres:9]LC_Facturation_3_Active:83=False:C215)
						$continu:=False:C215
						
						$msg:="Aucune ligne n'est activé au niveau de la fiche d'hébergement."
					End if 
					
				End if 
				
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
					[Factures_Lignes:87]FACL_Libelle:5:=[LesCentres:9]LC_Nom:4+" - "+[HeBerge:4]HB_Nom:3+" "+[HeBerge:4]HB_Prénom:4  //****************************
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
					[Factures_Lignes:87]FACL_HB_ID:33:=[HeBerge:4]HB_ReferenceID:1
					[Factures_Lignes:87]FACL_No_Ordre:7:=1
					
					If (Size of array:C274(tb_hg_lig_dates)>0)
						[Factures_Lignes:87]FACL_Sejour_Debut:31:=tb_hg_lig_dates{1}
						[Factures_Lignes:87]FACL_Sejour_Fin:32:=tb_hg_lig_dates{Size of array:C274(tb_hg_lig_dates)}
					End if 
					
					GES_Calcul_Ligne
					
					SAVE RECORD:C53([Factures_Lignes:87])
				End if 
				
				outilsCleanVariable(->$nb_fiches; ->$hg_dates; ->$ids_hebergements; ->$compteur)
				
				//======== Mois de facturation =======//
				If (Size of array:C274($tb_fac_mois_annee)=1)
					[Factures:86]FAC_Mois:33:=$tb_fac_mois{1}
					[Factures:86]FAC_Mois_Annee:48:=$tb_fac_mois_annee{1}
				End if 
				
				DELETE FROM ARRAY:C228($tb_fac_mois; 1; Size of array:C274($tb_fac_mois))
				DELETE FROM ARRAY:C228($tb_fac_mois_annee; 1; Size of array:C274($tb_fac_mois_annee))
			End if 
			
			UNLOAD RECORD:C212([Factures_Lignes:87])
			
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
			
			$collection_c.push([Factures:86]ID:1)
		End if 
		
	End if 
	
	$financeur_valeur_previous:=$financeur_valeur
	
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
	CANCEL TRANSACTION:C241
	
	ALERT:C41($msg)
Else 
	$collection_c:=$collection_c.distinct()
	
	$table_o:=ds:C1482.Factures.query("ID in :1"; $collection_c)
	
	USE ENTITY SELECTION:C1513($table_o)
	LOAD RECORD:C52([Factures:86])
	
	VALIDATE TRANSACTION:C240
End if 

$0:=$continu