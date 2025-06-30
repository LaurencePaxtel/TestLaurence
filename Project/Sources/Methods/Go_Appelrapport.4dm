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


C_TEXT:C284(vaRP_Perma)

C_TEXT:C284(vaRP_Titre0)
C_TEXT:C284(vaRP_Titre1)
C_TEXT:C284(vaRP_Titre2)
C_TEXT:C284(vaRP_Titre3)
C_TEXT:C284(vaRP_Titre4)
C_TEXT:C284(vaRP_TitreDate)
C_TEXT:C284(vaRP_Titre5)
C_TEXT:C284(vaRP_TitreHeure)
C_TEXT:C284(vaRP_TitreObjet)
C_TEXT:C284(vaRP_Titre6)
C_TEXT:C284(vaRP_Titre7)
C_TEXT:C284(vaRP_Titre8)
C_PICTURE:C286(viRP_Logo)
C_TEXT:C284(vaRP_Titre9)
C_TEXT:C284(vaRP_Titre10)

viRP_Logo:=<>vi_FondLogoLarge


QUERY:C277([Rapport:35]; [Rapport:35]RP_UserID:1=<>vl_UserRéfU)
MultiSoc_Filter(->[Rapport:35])
C_BOOLEAN:C305(vb_Nouveau)
vb_Nouveau:=False:C215
If (Records in selection:C76([Rapport:35])=0)
	READ WRITE:C146([Rapport:35])
	CREATE RECORD:C68([Rapport:35])
	MultiSoc_Init_Structure(->[Rapport:35])
	[Rapport:35]RP_UserID:1:=<>vl_UserRéfU
	[Rapport:35]RP_Date:2:=Current date:C33
	[Rapport:35]RP_Heure:3:=Current time:C178
	[Rapport:35]RP_Objet:4:=""
	[Rapport:35]RP_LesSurveillantsChefs:5:=""
	[Rapport:35]RP_SurveillantRédacteur:6:=""
	[Rapport:35]RP_DirectriceSécurité:7:=""
	[Rapport:35]RP_Note:9:=""
	SAVE RECORD:C53([Rapport:35])
	UNLOAD RECORD:C212([Rapport:35])
	READ ONLY:C145([Rapport:35])
	vb_Nouveau:=True:C214
End if 
If (vb_Nouveau)
	QUERY:C277([Rapport:35]; [Rapport:35]RP_UserID:1=<>vl_UserRéfU)
	MultiSoc_Filter(->[Rapport:35])
End if 
//Quit_Rapport

If (Records in selection:C76([Rapport:35])=1)
	READ WRITE:C146([Rapport:35])
	If (i_NonVerrou(->[Rapport:35]))
		FORM SET INPUT:C55([Rapport:35]; "RP_EcranSaisie")
		$vl_Fenetre:=i_FenêtreNo(575; 508; 4; "Rapport"; 1; "Quit_Rapport")  //"Quit_Confirmation")  `
		
		MODIFY RECORD:C57([Rapport:35]; *)
		UNLOAD RECORD:C212([Rapport:35])
		CLOSE WINDOW:C154($vl_Fenetre)
	End if 
	READ ONLY:C145([Rapport:35])
	UNLOAD RECORD:C212([Rapport:35])
Else 
	StrAlerte(4; "")
End if 

<>PR_AppelRapport:=0

