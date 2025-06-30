//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : Go_SIAODivers
//{          Mardi 29 mars 2011 à 15:23
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)
C_LONGINT:C283($vl_Fenetre)


READ ONLY:C145(*)
SET MENU BAR:C67(1)

READ WRITE:C146([SIAO_Divers:58])
QUERY:C277([SIAO_Divers:58]; [SIAO_Divers:58]Sd_Clé:2=$1)
If (Records in selection:C76([SIAO_Divers:58])=0)
	CREATE RECORD:C68([SIAO_Divers:58])
	MultiSoc_Init_Structure(->[SIAO_Divers:58])
	[SIAO_Divers:58]Sd_RéférenceID:1:=0
	[SIAO_Divers:58]Sd_Clé:2:=$1
	SAVE RECORD:C53([SIAO_Divers:58])
	UNLOAD RECORD:C212([SIAO_Divers:58])
	QUERY:C277([SIAO_Divers:58]; [SIAO_Divers:58]Sd_Clé:2=$1)
	MultiSoc_Filter(->[SIAO_Divers:58])
End if 
If (Records in selection:C76([SIAO_Divers:58])=1)
	If (i_NonVerrou(->[SIAO_Divers:58]))
		FORM SET INPUT:C55([SIAO_Divers:58]; "SD_Note")
		$vl_Fenetre:=i_FenêtreNo(590; 357; 4; "Note"; 11; "Quit_SIAODivers")
		MODIFY RECORD:C57([SIAO_Divers:58]; *)
		UNLOAD RECORD:C212([SIAO_Divers:58])
		CLOSE WINDOW:C154($vl_Fenetre)
	End if 
	
End if 

UNLOAD RECORD:C212([SIAO_Divers:58])
READ ONLY:C145([SIAO_Divers:58])
<>PR_SIAODiv:=0