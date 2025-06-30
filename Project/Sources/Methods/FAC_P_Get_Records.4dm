//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 29/06/2020, 08:53:29
// ----------------------------------------------------
// Method: FAC_P_Get_Records
// Description
// Mode de facturation : Participations
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($hd_ids)
C_LONGINT:C283($i)
C_BOOLEAN:C305($display_b)

C_TEXT:C284(txt_filtre_nom; txt_filtre_usager; txt_filtre_designation)
C_DATE:C307(txt_filtre_date1; txt_filtre_date2)
C_BOOLEAN:C305(var_bool_facture; var_bool_regle; Chk_facture)

ARRAY LONGINT:C221($tb_hb_ids; 0)

ARRAY TEXT:C222(tb_liste_cle; 0)
ARRAY TEXT:C222(tb_liste_hg_ids; 0)
ARRAY TEXT:C222(tb_liste_mois_annee; 0)
ARRAY TEXT:C222(tb_liste_facture_num; 0)

ARRAY LONGINT:C221(tb_liste_id; 0)
ARRAY LONGINT:C221(tb_liste_mois; 0)
ARRAY LONGINT:C221(tb_liste_hb_ref_id; 0)
ARRAY LONGINT:C221(tb_liste_nbre_fiches; 0)

ARRAY BOOLEAN:C223(tb_liste_choix; 0)
ARRAY BOOLEAN:C223(tb_liste_facture_bool; 0)

READ ONLY:C145([HeberGement:5])
READ ONLY:C145([Factures:86])
READ ONLY:C145([Factures_Lignes:87])
READ ONLY:C145([LesCentres:9])
READ ONLY:C145([HeBerge:4])

$progress_id:=Progress New

Progress SET TITLE($progress_id; "Recherche..."; -1; "en cours d'exécution...")
Progress SET BUTTON ENABLED($progress_id; True:C214)

QUERY:C277([Participations:116]; [Participations:116]PAR_Mois:4>=Month of:C24(txt_filtre_date1); *)
QUERY:C277([Participations:116];  & ; [Participations:116]PAR_Mois:4<=Month of:C24(txt_filtre_date2); *)
QUERY:C277([Participations:116];  & ; [Participations:116]PAR_Annee:3>=Year of:C25(txt_filtre_date1); *)
QUERY:C277([Participations:116];  & ; [Participations:116]PAR_Annee:3<=Year of:C25(txt_filtre_date2); *)
If (Storage:C1525.societeDetail.participationWeb)
	QUERY:C277([Participations:116];  & ; [Participations:116]PAR_participationWebID:36#0)
Else 
	QUERY:C277([Participations:116];  & ; [Participations:116]PAR_participationWebID:36=0)
End if 


MultiSoc_Filter(->[Participations:116])

//CHERCHER([ParticipationsWebBudget]; [ParticipationsWebBudget]mois>=Mois de(txt_filtre_date1); *)
//CHERCHER([ParticipationsWebBudget];  & ; [ParticipationsWebBudget]mois<=Mois de(txt_filtre_date2); *)
//CHERCHER([ParticipationsWebBudget];  & ; [ParticipationsWebBudget]annee>=Année de(txt_filtre_date1); *)
//CHERCHER([ParticipationsWebBudget];  & ; [ParticipationsWebBudget]annee<=Année de(txt_filtre_date2))

//MultiSoc_Filter(->[ParticipationsWebBudget])

If (txt_filtre_nom#"")
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Nom:3="@"+txt_filtre_nom+"@")
	MultiSoc_Filter(->[HeBerge:4])
	
	SELECTION TO ARRAY:C260([HeBerge:4]HB_ReferenceID:1; $tb_hb_ids)
	
	If (Size of array:C274($tb_hb_ids)>0)
		QUERY SELECTION WITH ARRAY:C1050([Participations:116]PAR_HB_ID:2; $tb_hb_ids)
		//CHERCHER PAR TABLEAU DANS SÉLECTION([ParticipationsWebBudget]hebergeID; $tb_hb_ids)
	End if 
	
End if 

If (Not:C34(Chk_tous))
	QUERY SELECTION:C341([Participations:116]; [Participations:116]PAR_Facture:19=Chk_facture)
End if 

ORDER BY:C49([Participations:116]; [Participations:116]PAR_Annee:3; >; [Participations:116]PAR_Mois:4; >)
$total_records:=Records in selection:C76([Participations:116])

//TRIER([ParticipationsWebBudget]; [ParticipationsWebBudget]annee; >; [ParticipationsWebBudget]mois; >)
//$total_records:=Enregistrements trouvés([ParticipationsWebBudget])

While (Not:C34(End selection:C36([Participations:116])))
	$i:=$i+1
	
	Progress SET PROGRESS($progress_id; $i/$total_records; "Recherche..."+String:C10($i)+" / "+String:C10($total_records); True:C214)
	Progress SET MESSAGE($progress_id; "Encours... "+[HeberGement:5]HG_CentreNom:62; True:C214)
	
	$display_b:=True:C214
	
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Participations:116]PAR_HB_ID:2)
	MultiSoc_Filter(->[HeBerge:4])
	//CHERCHER([HeBerge]; [HeBerge]HB_ReferenceID=[ParticipationsWebBudget]hebergeID)
	//MultiSoc_Filter(->[HeBerge])
	
	If ([HeBerge:4]HB_FAC_Mode_Facturation:80="Participations")
		REDUCE SELECTION:C351([Factures:86]; 0)
		REDUCE SELECTION:C351([Factures_Lignes:87]; 0)
		
		//CHERCHER([Factures];[Factures]FAC_Origine_ID=[Participations]ID)
		// Modifié par : Scanu Rémy - remy@connect-io.fr (09/06/2021)
		QUERY:C277([Factures:86]; [Factures:86]FAC_Participation_ID:62=[Participations:116]ID:1)
		MultiSoc_Filter(->[Factures:86])
		
		$date_du:=Date:C102("01/"+String:C10([Participations:116]PAR_Mois:4; "0#")+"/"+String:C10([Participations:116]PAR_Annee:3))
		//$date_du:=Date("01/"+Chaîne([ParticipationsWebBudget]mois; "0#")+"/"+Chaîne([ParticipationsWebBudget]annee))
		$date_au:=UTL_Date_Day($date_du; True:C214)
		
		// Modifié par : Scanu Rémy (23/03/2021)
		// Je décommente ça pour avoir les hébergements pour la participation sur lequel je suis en train de boucler
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[Participations:116]PAR_HB_ID:2; *)
		//CHERCHER([HeberGement]; [HeberGement]HG_HB_ID=[ParticipationsWebBudget]hebergeID; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4>=$date_du; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=$date_au)
		//CHERCHER([HeberGement]; & ;[HeberGement]HG_Nuit=Faux;*)
		//CHERCHER([HeberGement]; & ;[HeberGement]HG_Cloturée=Vrai)
		MultiSoc_Filter(->[HeberGement:5])
		
		If (Records in selection:C76([HeberGement:5])>0)
			
			While (Not:C34(End selection:C36([HeberGement:5])))
				$hd_ids:=$hd_ids+";"+String:C10([HeberGement:5]HG_ReferenceID:1)
				NEXT RECORD:C51([HeberGement:5])
			End while 
			
		End if 
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (11/05/2021)
		// On affiche que les enregistrements qui ont des fiches d'hébergements pour le mois et l'année où a été généré la participation
		If (Records in selection:C76([HeberGement:5])>0)
			APPEND TO ARRAY:C911(tb_liste_choix; False:C215)
			APPEND TO ARRAY:C911(tb_liste_cle; [HeBerge:4]HB_Clé:2)
			APPEND TO ARRAY:C911(tb_liste_hb_ref_id; [HeBerge:4]HB_ReferenceID:1)
			APPEND TO ARRAY:C911(tb_liste_mois; [Participations:116]PAR_Mois:4)
			//AJOUTER À TABLEAU(tb_liste_mois; [ParticipationsWebBudget]mois)
			APPEND TO ARRAY:C911(tb_liste_mois_annee; String:C10([Participations:116]PAR_Mois:4; "0#")+"/"+String:C10([Participations:116]PAR_Annee:3))
			//AJOUTER À TABLEAU(tb_liste_mois_annee; Chaîne([ParticipationsWebBudget]mois; "0#")+"/"+Chaîne([ParticipationsWebBudget]annee))
			APPEND TO ARRAY:C911(tb_liste_nbre_fiches; 0)
			APPEND TO ARRAY:C911(tb_liste_facture_bool; [Participations:116]PAR_Facture:19)
			APPEND TO ARRAY:C911(tb_liste_facture_num; [Factures:86]FAC_No_Piece:2)
			APPEND TO ARRAY:C911(tb_liste_id; [Participations:116]ID:1)
			APPEND TO ARRAY:C911(tb_liste_hg_ids; $hd_ids)
			//AJOUTER À TABLEAU(tb_liste_hg_ids;"")
		End if 
		
	End if 
	
	If (Progress Stopped($progress_id))
		LAST RECORD:C200([Participations:116])
	End if 
	
	CLEAR VARIABLE:C89($hd_ids)
	
	NEXT RECORD:C51([Participations:116])
End while 

txt_titre_fenetre_p:="Liste des participations "

Progress QUIT($progress_id)