//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 30/06/2020, 17:10:09
// ----------------------------------------------------
// Method: FAC_PAR_Generer
// Description
// Mode de facturation : Participations
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($msg; $cle_valeur)
C_LONGINT:C283($i; $size_initial)
C_BOOLEAN:C305($continu)

ARRAY TEXT:C222($tb_données; 0)

var $centre_e : cs:C1710.LesCentresEntity
var $centre_es : cs:C1710.LesCentresSelection

$continu:=True:C214
corp_exonere_TVA:=False:C215

GES_Definition_Champs("facture")

SOC_Get_Config

START TRANSACTION:C239

READ WRITE:C146([Factures:86])
READ WRITE:C146([Participations:116])
READ WRITE:C146([HeberGement:5])

$size_initial:=Size of array:C274(tb_liste_cle)
//TRIER TABLEAU(tb_liste_choix; tb_liste_cle; tb_liste_hb_ref_id; tb_liste_mois; tb_liste_nbre_fiches; tb_liste_facture_bool; tb_liste_facture_num; tb_liste_id; tb_liste_hg_ids; <)

/*
$pos:=Chercher dans tableau(tb_liste_choix; Faux)

Si ($pos>0)
SUPPRIMER DANS TABLEAU(tb_liste_choix; $pos; $size_initial)
SUPPRIMER DANS TABLEAU(tb_liste_cle; $pos; $size_initial)
SUPPRIMER DANS TABLEAU(tb_liste_hb_ref_id; $pos; $size_initial)
SUPPRIMER DANS TABLEAU(tb_liste_mois; $pos; $size_initial)
SUPPRIMER DANS TABLEAU(tb_liste_nbre_fiches; $pos; $size_initial)
SUPPRIMER DANS TABLEAU(tb_liste_facture_bool; $pos; $size_initial)
SUPPRIMER DANS TABLEAU(tb_liste_facture_num; $pos; $size_initial)
SUPPRIMER DANS TABLEAU(tb_liste_id; $pos; $size_initial)
SUPPRIMER DANS TABLEAU(tb_liste_hg_ids; $pos; $size_initial)
Fin de si 
*/

//TABLEAU MULTI TRI(tb_liste_cle; >; tb_liste_hb_ref_id; >; tb_liste_mois; >; tb_liste_choix; >; tb_liste_nbre_fiches; >; tb_liste_facture_bool; >; tb_liste_facture_num; >; tb_liste_id; >; tb_liste_hg_ids; >)

$progress_id:=Progress New
Progress SET TITLE($progress_id; "Facturation..."; -1; "en cours d'exécution...")
Progress SET BUTTON ENABLED($progress_id; True:C214)


For ($i; 1; Size of array:C274(tb_liste_choix))
	$cle_valeur:=tb_liste_cle{$i}
	
	Progress SET PROGRESS($progress_id; $i/Size of array:C274(tb_liste_choix); "Facturation..."+String:C10($i)+" / "+String:C10(Size of array:C274(tb_liste_choix)); False:C215)
	Progress SET MESSAGE($progress_id; "Encours... "+tb_liste_cle{$i}; False:C215)
	
	If (tb_liste_choix{$i}=True:C214)
		QUERY:C277([Participations:116]; [Participations:116]ID:1=tb_liste_id{$i})
		MultiSoc_Filter(->[Participations:116])
		
		QUERY SELECTION:C341([Participations:116]; [Participations:116]PAR_Facture:19=False:C215)
		
		If (Records in selection:C76([Participations:116])=0)
			$continu:=False:C215
			$msg:="La sélection contient des fiches qui sont déja facturées"
		End if 
		
		If ($continu)
			READ WRITE:C146([HeberGement:5])
			
			CLEAR VARIABLE:C89($tb_données)
			UTL_Cut_Text(->tb_liste_hg_ids{$i}; ->$tb_données; ";")
			
			ARRAY LONGINT:C221($tb_donnees_num; Size of array:C274($tb_données))
			
			For ($j; 1; Size of array:C274($tb_données))
				$tb_donnees_num{$j}:=Num:C11($tb_données{$j})
			End for 
			
			// Modifié par : Scanu Rémy (23/03/2021)
			// Je décommente cela... a ce stade on a toutes les fiches hébergements liées à la participation sur lequel on est en train de boucler
			QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; $tb_donnees_num)
			MultiSoc_Filter(->[HeberGement:5])
			
			// Modifié par : Scanu Rémy (16/05/2023)
			// Et je rajoute cela, on cherche dans les hébergements si on trouve au moins un hébergement pour le mois sélectionné
			QUERY SELECTION BY FORMULA:C207([HeberGement:5]; Month of:C24([HeberGement:5]HG_Date:4)=Month of:C24(Date:C102("01/"+tb_liste_mois_annee{$i})))
			
			If (Records in selection:C76([HeberGement:5])=0)
				$continu:=False:C215
				$msg:="Pas de fiches d'hébergements à facturer."
			Else 
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
			End if 
			
			If ($continu)
				READ ONLY:C145([HeBerge:4])
				
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=tb_liste_hb_ref_id{$i})
				MultiSoc_Filter(->[HeBerge:4])
				
				If (Records in selection:C76([HeBerge:4])#1)
					$continu:=False:C215
					$msg:="La fiche de l'hébergé est introuvable."
				End if 
				
				If ($continu)
					QUERY:C277([Structures:79]; [Structures:79]STRC_Initiales:2=<>ref_soc_active)
					QUERY:C277([SOciete:18]; [SOciete:18]ID:94=[Structures:79]STRC_Societe_ID:6)
					
					QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=$cle_valeur)
					
					CREATE RECORD:C68([Factures:86])
					MultiSoc_Init_Structure(->[Factures:86])
					
					[Factures:86]FAC_Intervenant_ID:27:=w_userUID
					[Factures:86]FAC_Date_Piece:3:=Current date:C33(*)
					[Factures:86]FAC_Date_Echeance:20:=Add to date:C393(Current date:C33(*); 0; 0; [SOciete:18]SO_Nb_Jours_Echeance:102)
					
					// Modifié par : Scanu Rémy (19/04/2023)
					// On sauvegarde le centre de la dernière fiche hébergement trouvée pour le mois facturé
					$centre_es:=ds:C1482.LesCentres.query("LC_RéférenceID = :1"; [HeberGement:5]HG_LC_ID:61)
					
					If ($centre_es.length=1)
						$centre_e:=$centre_es.first()
						
						[Factures:86]FAC_Bien_ID:28:=$centre_e.ID
						[Factures:86]FAC_Bien_Nom:30:=$centre_e.LC_Nom
					End if 
					
					// Modifié par : Scanu Rémy - remy@connect-io.fr (11/05/2021)
					// Ce n'est pas [Participations]ID qu'il faut mettre...
					[Factures:86]FAC_Origine_ID:37:=[Participations:116]PAR_HB_ID:2
					//[Factures]FAC_Origine_ID:=[ParticipationsWebBudget]hebergeID
					
					// Modifié par : Scanu Rémy - remy@connect-io.fr (09/06/2021)
					// Bricolage... je n'aime pas ça mais on s'y perd trop dans cette base...
					[Factures:86]FAC_Participation_ID:62:=[Participations:116]ID:1
					
					[Factures:86]FAC_Type_Piece:40:="P"
					[Factures:86]FAC_Destinataire_ID:11:=[HeBerge:4]HB_ReferenceID:1
					[Factures:86]FAC_Destinataire_Nom:13:=[HeBerge:4]HB_Nom:3+" "+[HeBerge:4]HB_Prénom:4
					[Factures:86]FAC_Type:21:="Provisoire"
					[Factures:86]FAC_Adresse_Facturation:14:=UTL_Get_Adresse(->[HeBerge:4]ID:65; ->[HeBerge:4])
					[Factures:86]FAC_ID_Adresse_Facturation:15:=[Adresses:53]ID:32
					[Factures:86]FAC_Mode_Reglement:22:="Espèce"
					
					[Factures:86]FAC_Regle_Status_Color:44:=0x00FC4444
					[Factures:86]FAC_Type_Facturation:49:="Participations"
					
					If (Locked:C147([Participations:116]))  // Participation
						$continu:=False:C215
						$msg:="La sélection contient des fiches verrouillées"
					Else 
						[Participations:116]PAR_Facture:19:=True:C214
						SAVE RECORD:C53([Participations:116])
					End if 
					
					//===========================================//
					// LIGNE 1
					//===========================================//
					If ([Participations:116]PAR_Montant_Participation:18>0)
						//Si ([ParticipationsWebBudget]totalParticipation>0)
						CREATE RECORD:C68([Factures_Lignes:87])
						MultiSoc_Init_Structure(->[Factures_Lignes:87])
						
						[Factures_Lignes:87]FACL_Piece_ID:3:=[Factures:86]ID:1
						[Factures_Lignes:87]FACL_Origine_Table_No:20:=Table:C252(->[Factures:86])
						[Factures_Lignes:87]FACL_Service_ID:4:=[Participations:116]ID:1
						[Factures_Lignes:87]FACL_Service_Ids:30:=""
						//[Factures_Lignes]FACL_Libelle:="Participation "+String([Participations]PAR_Taux)+"%"
						[Factures_Lignes:87]FACL_Titre:6:="Participation "+String:C10([Participations:116]PAR_Taux:15)+"%"
						[Factures_Lignes:87]FACL_Libelle_2:29:=""
						[Factures_Lignes:87]FACL_Date_Fiche_Produit:27:=""
						[Factures_Lignes:87]FACL_Quantite:18:=1
						[Factures_Lignes:87]FACL_Prix_Unit_HT:8:=[Participations:116]PAR_Montant_Participation:18
						//[Factures_Lignes]FACL_Prix_Unit_HT:=[ParticipationsWebBudget]totalParticipation
						[Factures_Lignes:87]FACL_Taux_TVA:10:=0
						[Factures_Lignes:87]FACL_Prix_Unit_Net:15:=([Factures_Lignes:87]FACL_Prix_Unit_HT:8-([Factures_Lignes:87]FACL_Prix_Unit_HT:8*([Factures_Lignes:87]FACL_Remise_Taux:13/100)))
						[Factures_Lignes:87]FACL_Montant_HT:9:=[Factures_Lignes:87]FACL_Quantite:18*[Factures_Lignes:87]FACL_Prix_Unit_Net:15
						[Factures_Lignes:87]FACL_Prix_Unit_TTC:16:=([Factures_Lignes:87]FACL_Prix_Unit_Net:15*((100+[Factures_Lignes:87]FACL_Taux_TVA:10)/100))
						[Factures_Lignes:87]FACL_Montant_TTC:12:=([Factures_Lignes:87]FACL_Montant_HT:9+[Factures_Lignes:87]FACL_Montant_TVA:11)
						[Factures_Lignes:87]FACL_Type_Ligne:26:="participation"
						//[Factures_Lignes]FACL_Compte_Comptable:=[LesCentres]LC_Compte_Comptable  //****************************
						[Factures_Lignes:87]FACL_No_Ordre:7:=1
						
						GES_Calcul_Ligne
						SAVE RECORD:C53([Factures_Lignes:87])
					End if 
					
					// Modifié par : Scanu Rémy (20/04/2023)
					// Ajout d'une ligne pour les extras
					//===========================================//
					// LIGNE 2
					//===========================================//
					
					If ([Participations:116]PAR_Extra:35#Null:C1517)
						CREATE RECORD:C68([Factures_Lignes:87])
						MultiSoc_Init_Structure(->[Factures_Lignes:87])
						
						[Factures_Lignes:87]FACL_Piece_ID:3:=[Factures:86]ID:1
						[Factures_Lignes:87]FACL_Origine_Table_No:20:=Table:C252(->[Factures:86])
						[Factures_Lignes:87]FACL_Service_ID:4:=[Participations:116]ID:1
						[Factures_Lignes:87]FACL_Service_Ids:30:=""
						[Factures_Lignes:87]FACL_Titre:6:="Extra"
						[Factures_Lignes:87]FACL_Libelle_2:29:=""
						[Factures_Lignes:87]FACL_Date_Fiche_Produit:27:=""
						[Factures_Lignes:87]FACL_Quantite:18:=1
						If ((Not:C34(OB Is empty:C1297([Participations:116]PAR_Extra:35))))
							[Factures_Lignes:87]FACL_Prix_Unit_HT:8:=[Participations:116]PAR_Extra:35.detail.sum("montant")
						End if 
						[Factures_Lignes:87]FACL_Taux_TVA:10:=0
						[Factures_Lignes:87]FACL_Prix_Unit_Net:15:=([Factures_Lignes:87]FACL_Prix_Unit_HT:8-([Factures_Lignes:87]FACL_Prix_Unit_HT:8*([Factures_Lignes:87]FACL_Remise_Taux:13/100)))
						[Factures_Lignes:87]FACL_Montant_HT:9:=[Factures_Lignes:87]FACL_Quantite:18*[Factures_Lignes:87]FACL_Prix_Unit_Net:15
						[Factures_Lignes:87]FACL_Prix_Unit_TTC:16:=([Factures_Lignes:87]FACL_Prix_Unit_Net:15*((100+[Factures_Lignes:87]FACL_Taux_TVA:10)/100))
						[Factures_Lignes:87]FACL_Montant_TTC:12:=([Factures_Lignes:87]FACL_Montant_HT:9+[Factures_Lignes:87]FACL_Montant_TVA:11)
						[Factures_Lignes:87]FACL_Type_Ligne:26:="participation extra"
						[Factures_Lignes:87]FACL_No_Ordre:7:=2
						
						GES_Calcul_Ligne
						SAVE RECORD:C53([Factures_Lignes:87])
					End if 
					
					//===========================================//
					// CALCUL PIED
					//===========================================//
					
					// Modifié par : Scanu Rémy (23/03/2021) et Re-modifié par Scanu Rémy (16/05/2023)
					//[Factures]FAC_Mois_Annee:=$mois_annee_libelle
					[Factures:86]FAC_Mois_Annee:48:=tb_liste_mois_annee{$i}
					
					// Modifié par : Scanu Rémy (19/04/2023)
					[Factures:86]FAC_Mois:33:=Num:C11(Substring:C12([Factures:86]FAC_Mois_Annee:48; 1; Position:C15("/"; [Factures:86]FAC_Mois_Annee:48)-1))
					[Factures:86]FAC_Annee:34:=Num:C11(Substring:C12([Factures:86]FAC_Mois_Annee:48; Position:C15("/"; [Factures:86]FAC_Mois_Annee:48)+1))
					
					QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
					Web_Piece_Calcul_Pied_2(->[Factures:86]; ->[Factures_Lignes:87]; ->[Factures_Lignes:87]FACL_Piece_ID:3; "facture")
					
					SAVE RECORD:C53([Factures:86])
				End if 
				
			End if 
			
		End if 
		
		If (Not:C34($continu))
			$i:=Size of array:C274(tb_liste_choix)
		End if 
		
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
	VALIDATE TRANSACTION:C240
End if 

$0:=$continu