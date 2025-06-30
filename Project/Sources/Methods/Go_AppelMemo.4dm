//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_Appelmemo  
//{
//{          Mardi 20 mars 2001 à 12:15:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
SET MENU BAR:C67(1)
READ ONLY:C145(*)

QUERY:C277([MemO:30]; [MemO:30]MO_UserID:1=<>vl_UserRéfU)
MultiSoc_Filter(->[MemO:30])
C_BOOLEAN:C305(vb_Nouveau)
vb_Nouveau:=False:C215
If (Records in selection:C76([MemO:30])=0)
	READ WRITE:C146([MemO:30])
	CREATE RECORD:C68([MemO:30])
	MultiSoc_Init_Structure(->[MemO:30])
	[MemO:30]MO_UserID:1:=<>vl_UserRéfU
	[MemO:30]MO_Date:2:=Current date:C33
	[MemO:30]MO_Heure:3:=Current time:C178
	[MemO:30]MO_Nuit:4:=False:C215
	[MemO:30]MO_Note:5:=""
	SAVE RECORD:C53([MemO:30])
	UNLOAD RECORD:C212([MemO:30])
	READ ONLY:C145([MemO:30])
	vb_Nouveau:=True:C214
End if 
If (vb_Nouveau)
	QUERY:C277([MemO:30]; [MemO:30]MO_UserID:1=<>vl_UserRéfU)
	MultiSoc_Filter(->[MemO:30])
End if 
//Quit_MEMO 

If (Records in selection:C76([MemO:30])=1)
	READ WRITE:C146([MemO:30])
	If (i_NonVerrou(->[MemO:30]))
		FORM SET INPUT:C55([MemO:30]; "MO_EcranSaisie")
		$vl_Fenetre:=i_FenêtreNo(475; 457; 4; "Memo"; 4; "Quit_MEMO")  //"Quit_Confirmation")
		MODIFY RECORD:C57([MemO:30]; *)
		UNLOAD RECORD:C212([MemO:30])
		CLOSE WINDOW:C154($vl_Fenetre)
	End if 
	READ ONLY:C145([MemO:30])
	UNLOAD RECORD:C212([MemO:30])
Else 
	StrAlerte(4; "")
End if 

<>PR_AppelMem:=0

