//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_HébergementActionNotes  
//{
//{          Mardi 19 octobre 2010 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_TEXT:C284($2)
SET MENU BAR:C67(1)
C_LONGINT:C283($vl_Fenetre; $ii; vl_CentreSIAO_ID)
C_BOOLEAN:C305($vb_OK)
$vb_OK:=False:C215
va_IDT_TypTrans:=""
C_TEXT:C284(va_CritèreAlpha)
va_CritèreAlpha:=""
C_DATE:C307(vd_DateRéelle)
C_TIME:C306(vd_HeureRéelle)

If (User in group:C338(Current user:C182; <>Groupe_SIAO) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	READ WRITE:C146([Dossier_SIAO:49])
	
	QUERY:C277([Dossier_SIAO:49]; [Dossier_SIAO:49]SI_HB_ID:2=$1)
	MultiSoc_Filter(->[Dossier_SIAO:49])
	$ii:=Records in selection:C76([Dossier_SIAO:49])
	
	Case of 
		: ($ii=0)
			If (i_Confirmer("La fiche SIAO n'existe pas"+<>va_CR+<>va_CR+"Voulez-vous créer la fiche SIAO ?"))
				$vb_OK:=True:C214
				CREATE RECORD:C68([Dossier_SIAO:49])
				MultiSoc_Init_Structure(->[Dossier_SIAO:49])
				[Dossier_SIAO:49]SI_RéférenceID:1:=0
				[Dossier_SIAO:49]SI_HB_ID:2:=$1
				[Dossier_SIAO:49]SI_Date:3:=Current date:C33
				[Dossier_SIAO:49]SI_Heure:4:=Current time:C178
				[Dossier_SIAO:49]SI_Modifiéle:5:=[Dossier_SIAO:49]SI_Date:3
				[Dossier_SIAO:49]SI_EtatCivil:7:=""
				[Dossier_SIAO:49]SI_Nom:8:=""
				[Dossier_SIAO:49]SI_NomDeJeuneFille:9:=""
				[Dossier_SIAO:49]SI_Prénom:10:=""
				[Dossier_SIAO:49]SI_Date_Néle:11:=!00-00-00!
				[Dossier_SIAO:49]SI_Age:12:=0
				[Dossier_SIAO:49]SI_Genre:13:=False:C215
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$1)
				MultiSoc_Filter(->[HeBerge:4])
				If (Records in selection:C76([HeBerge:4])=1)
					[Dossier_SIAO:49]SI_Nom:8:=[HeBerge:4]HB_Nom:3
					[Dossier_SIAO:49]SI_Prénom:10:=[HeBerge:4]HB_Prénom:4
					[Dossier_SIAO:49]SI_Date_Néle:11:=[HeBerge:4]HB_DateNéLe:5
					[Dossier_SIAO:49]SI_Age:12:=Uut_HébergéAgePlus(->[Dossier_SIAO:49]SI_Date_Néle:11; ->[Dossier_SIAO:49]SI_Date:3)
					
					
					[Dossier_SIAO:49]SI_Genre:13:=[HeBerge:4]HG_Genre:39
				End if 
				SAVE RECORD:C53([Dossier_SIAO:49])
				UNLOAD RECORD:C212([Dossier_SIAO:49])
				QUERY:C277([Dossier_SIAO:49]; [Dossier_SIAO:49]SI_HB_ID:2=$1)
				MultiSoc_Filter(->[Dossier_SIAO:49])
				
			End if 
		: ($ii=1)
			$vb_OK:=True:C214
		: ($ii>1)
			ALERT:C41("ANOMALIES : "+String:C10($ii)+" fiches SIAO"+<>va_CR+"Veuillez contacter le service informatique.")
	End case 
	
	If ($vb_OK)
		If (i_NonVerrou(->[Dossier_SIAO:49]))
			FORM SET INPUT:C55([Dossier_SIAO:49]; "SI_aEcranSaisie")
			$vl_Fenetre:=i_FenêtreNo(876; 608; 4; "Fiche SIAO crée le "+String:C10([Dossier_SIAO:49]SI_Date:3; Interne date court:K1:7); 1; "Quit_SIAO")
			MODIFY RECORD:C57([Dossier_SIAO:49]; *)
			UNLOAD RECORD:C212([Dossier_SIAO:49])
			CLOSE WINDOW:C154($vl_Fenetre)
		End if 
	End if 
	
	UNLOAD RECORD:C212([Dossier_SIAO:49])
	READ ONLY:C145([Dossier_SIAO:49])
Else 
	StrAlerte(6; "SIAO")
End if 

<>PR_SIAO:=0