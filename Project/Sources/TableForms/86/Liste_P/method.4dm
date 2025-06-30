
Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		C_LONGINT:C283(selected_form_no; fac_hb_id)
		C_BOOLEAN:C305(Chk_tout_selectionner; Chk_facture; Chk_tous; Chk_non_facture)
		C_DATE:C307(txt_filtre_date1; txt_filtre_date2)
		
		ARRAY TEXT:C222(ta_PlageEnCours; 7)
		
		txt_titre_fenetre_p:="Liste des participations"
		
		selected_form_no:=1
		
		Chk_facture:=False:C215
		Chk_non_facture:=False:C215
		Chk_tous:=True:C214
		
		FAC_P_Get_Records
		
		ta_PlageEnCours{1}:="Aujourd'hui"
		ta_PlageEnCours{2}:="Semaine en cours"
		ta_PlageEnCours{3}:="Quinzaine en cours"
		ta_PlageEnCours{4}:="Mois en cours"
		ta_PlageEnCours{5}:="Trimestre en cours"
		ta_PlageEnCours{6}:="Semestre en cours"
		ta_PlageEnCours{7}:="Année en cours"
		ta_PlageEnCours:=1
		
		ta_PlageEnCours{0}:=ta_PlageEnCours{ta_PlageEnCours}
End case 