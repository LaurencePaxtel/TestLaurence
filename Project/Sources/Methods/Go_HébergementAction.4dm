//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_HébergementAction
//{
//{          Lundi 28 Juillet 1997 à 17:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_TEXT:C284(vt_TempActi; vt_TempDistri)

SET MENU BAR:C67(1)
vt_TempDistri:=$3

If (User in group:C338(Current user:C182; <>Groupe_Actions) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$1)
	MultiSoc_Filter(->[HeBerge:4])
	
	If (Records in selection:C76([HeBerge:4])=1)
		READ WRITE:C146([HeBerge:4])
		LOAD RECORD:C52([HeBerge:4])
		
		If (Not:C34(Locked:C147([HeBerge:4])))
			FORM SET INPUT:C55([HeBerge:4]; "HB_NotesAction")
			
			$vl_Fenetre:=i_FenêtreNo(485; 517; 4; "Notes reçu"; 11; "Quit_HBAction")
			MODIFY RECORD:C57([HeBerge:4]; *)
			
			UNLOAD RECORD:C212([HeBerge:4])
			CLOSE WINDOW:C154($vl_Fenetre)
		Else 
			
			Case of 
				: ((<>PR_HBNotes#0) | (<>PR_HBNotesV#0) | (<>PR_HBNotesP#0))
					ALERT:C41("Veuillez au préalable fermer la fiche 'Notes'.")
				: ((<>PR_HBST#0) | (<>PR_HBSTV#0) | (<>PR_HBSP#0))
					ALERT:C41("Veuillez au préalable fermer la fiche SP.")
				Else 
					ALERT:C41("La fiche 'Actions' est momentanément inaccessible.")
			End case 
			
		End if 
		
		READ ONLY:C145([HeBerge:4])
		UNLOAD RECORD:C212([HeBerge:4])
	Else 
		StrAlerte(4; "")
		UNLOAD RECORD:C212([HeBerge:4])
	End if 
	
Else 
	StrAlerte(6; "'Actions'")
End if 

Case of 
	: ($2="N")
		<>PR_HBAction:=0
	: ($2="V")
		<>PR_HBActionV:=0
End case 