//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_HébergementSP
//{
//{          Lundi 28 Juillet 1997 à 17:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_TEXT:C284($2)
SET MENU BAR:C67(1)


ARRAY TEXT:C222(ta_Page; 2)
ta_Page{1}:="SP"
ta_Page{2}:="Pièce"

If (User in group:C338(Current user:C182; <>Groupe_SP) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$1)
	MultiSoc_Filter(->[HeBerge:4])
	If (Records in selection:C76([HeBerge:4])=1)
		
		READ WRITE:C146([HeBerge:4])
		LOAD RECORD:C52([HeBerge:4])
		If (Not:C34(Locked:C147([HeBerge:4])))
			FORM SET INPUT:C55([HeBerge:4]; "HB_NotesSPPLUS")
			
			C_LONGINT:C283($vl_Fenetre)  // #20170701-1
			//$vl_Fenetre:=i_FenêtreNo (448;486;4;"Notes SP";4;"Quit_HBNotes")
			$vl_Fenetre:=i_FenêtreNo(448; 561; 4; "Notes SP"; 4; "Quit_HBNotes")
			MODIFY RECORD:C57([HeBerge:4]; *)
			UNLOAD RECORD:C212([HeBerge:4])
			CLOSE WINDOW:C154($vl_Fenetre)
		Else 
			
			//LOCKED BY([HeBerge];$L_Process;$T_User;$L_Session;$T_Process)
			
			Case of 
				: ((<>PR_HBNotes#0) | (<>PR_HBNotesV#0) | (<>PR_HBNotesP#0))
					ALERT:C41("Veuillez au préalable fermer la fiche 'Notes'.")
				: ((<>PR_HBAction#0) | (<>PR_HBActionV#0))
					ALERT:C41("Veuillez au préalable fermer la fiche 'Actions'.")
				Else 
					ALERT:C41("La fiche 'SP' est momentanément inaccessible.")
			End case 
		End if 
		READ ONLY:C145([HeBerge:4])
		UNLOAD RECORD:C212([HeBerge:4])
	Else 
		StrAlerte(4; "")
		UNLOAD RECORD:C212([HeBerge:4])
	End if 
Else 
	StrAlerte(6; "'SP'")
End if 
Case of 
	: ($2="P")
		<>PR_HBSP:=0
	: ($2="N")
		<>PR_HBST:=0
	: ($2="V")
		<>PR_HBSTV:=0
End case 
