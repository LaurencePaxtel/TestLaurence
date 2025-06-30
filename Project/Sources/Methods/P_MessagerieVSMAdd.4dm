//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          P_MessagerieVSMAdd
//{
//{          Mardi 30 novembre 2004 à 13:40
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If ([HeBerge:4]HB_ReferenceID:1>0)
	READ WRITE:C146([MessagerieVSM:39])
	
	CREATE RECORD:C68([MessagerieVSM:39])
	MultiSoc_Init_Structure(->[MessagerieVSM:39])
	
	[MessagerieVSM:39]MV_RéférenceID:1:=Uut_Numerote(->[MessagerieVSM:39])
	[MessagerieVSM:39]MV_Date:2:=Current date:C33(*)
	[MessagerieVSM:39]MV_Heure:3:=Current time:C178(*)
	[Messagerie:34]MS_User:4:=<>vl_UserRéfU
	[MessagerieVSM:39]MV_Clé:6:=[HeBerge:4]HB_Clé:2
	SAVE RECORD:C53([MessagerieVSM:39])
	
	UNLOAD RECORD:C212([MessagerieVSM:39])
	
	READ ONLY:C145([MessagerieVSM:39])
	POST OUTSIDE CALL:C329(<>PR_MessagerieVSM)
Else 
	StrAlerte(3; "")
End if 