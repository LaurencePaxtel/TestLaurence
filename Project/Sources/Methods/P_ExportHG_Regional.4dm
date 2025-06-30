//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_ExportHG_regional
//{          Mardi 6 décembre 2011 à 12:30:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_TEXT:C284($vt_Dossier; vt_TitreDocument)
C_LONGINT:C283($ii)

F_Report_FullDuplexTableau
SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_Trans_Réf_HG)
$vt_Dossier:=Select folder:C670
If (OK=1)
	i_Message("     Export régional en cours…")
	vt_FullDuplexDossier:=$vt_Dossier
	
	READ WRITE:C146([HeberGement:5])
	For ($ii; 1; Size of array:C274(tl_Trans_Réf_HG))
		i_MessageSeul("     Export régional en cours : "+String:C10(Size of array:C274(tl_Trans_Réf_HG))+"/"+String:C10($ii))
		$vb_OK:=F_Regional_TransfertLoop($ii; tl_Trans_Réf_HG{$ii}; False:C215; False:C215)
	End for 
	UNLOAD RECORD:C212([HeberGement:5])
	READ ONLY:C145([HeberGement:5])
	CLOSE WINDOW:C154
	QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_Trans_Réf_HG)
	P_HébergementVeilleSort(2)
	BEEP:C151
	BEEP:C151
	
End if 
F_Report_FullDuplexTableau