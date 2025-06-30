//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : i_Environnement  
//{
//{          Vendredi 5 Jamarsnvier 1999 à 14:56:23
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($PlateForme; $Systeme; $Machine)
C_REAL:C285($WinMajVers; $WinMinVers)
C_LONGINT:C283($vl_PlateForme; $vl_Systeme; $vl_Machine)

C_TEXT:C284(<>va_NomMachine)  //Nom de la machine
C_TEXT:C284(<>va_NomPpossesseur)  //Nom du possesseur
C_TEXT:C284(<>va_Utilisateur)  //Utilisateur courant
C_TEXT:C284(<>va_PlateForme)  //Plate-forme

C_TEXT:C284(<>vt_ApplStructure)  //Fichier structure
C_TEXT:C284(<>vt_ApplDonnees)  //Fichier donnees
C_TEXT:C284(<>vt_ApplApplication)  //Fichier application

C_TEXT:C284(<>vt_DossierStructure)  //Fichier structure
C_TEXT:C284(<>vt_DossierDonnees)  //Fichier donnees
C_TEXT:C284(<>vt_DossierApplication)  //Fichier application
C_TEXT:C284(<>vt_DossierACI)  //Dossier ACI

C_TEXT:C284(<>va_FichierStructure)  //Fichier structure
C_TEXT:C284(<>va_FichierDonnees)  //Fichier donnees
C_TEXT:C284(<>va_FichierApplication)  //Fichier application

C_TEXT:C284(<>va_VersionApplication)  //Version application
C_LONGINT:C283(<>vl_TypeApplication)  //Type application
C_LONGINT:C283(<>vl_TypeVersion)  //Version application

C_BOOLEAN:C305(<>vb_ApplCompilé)  //Application compilee

C_LONGINT:C283(<>vl_LargeurEcran)  //Largeur ecran
C_LONGINT:C283(<>vl_HauteurEcran)  //Hauteur ecran
C_TEXT:C284(<>va_TailleEcran)
C_LONGINT:C283(<>vl_ProfondeurEcran)  //PROFONDEUR ECRAN
C_TEXT:C284(<>va_ProfondeurEcran)  //PROFONDEUR ECRAN
C_LONGINT:C283(<>vl_CouleurEcran)  //Couleur Ecran
C_TEXT:C284(<>va_CouleurEcran)  //Couleur Ecran

C_BOOLEAN:C305(<>vb_CestUnMac)  //Quel OS
C_LONGINT:C283(<>vl_QuelOS)

C_LONGINT:C283(<>ve_NbUserConnecté)  //Nb d'utilisateurs connectés
C_TEXT:C284(<>va_NbUserConnecté)


<>va_NomMachine:=Current machine:C483
<>va_NomPpossesseur:=Current system user:C484
<>va_Utilisateur:=Current user:C182

<>vb_ApplCompilé:=Is compiled mode:C492
<>va_VersionApplication:=Application version:C493
<>va_VersionApplication:=String:C10(Num:C11(Substring:C12(<>va_VersionApplication; 1; 2)))+"."+Substring:C12(<>va_VersionApplication; 3; 1)+"."+Substring:C12(<>va_VersionApplication; 4; 1)
<>vl_TypeApplication:=Application type:C494
<>vl_TypeVersion:=Version type:C495

<>ve_NbUserConnecté:=Count users:C342
<>va_NbUserConnecté:=String:C10(<>ve_NbUserConnecté)+" utilisateur"+("s"*Num:C11(<>ve_NbUserConnecté>1))+" connecté"+("s"*Num:C11(<>ve_NbUserConnecté>1))

_O_PLATFORM PROPERTIES:C365($PlateForme; $Systeme; $Machine)  //Recupere la plateforme
<>vl_QuelOS:=$PlateForme

If ($PlateForme<3)  //si Mac OS
	
	<>vb_CestUnMac:=True:C214
	<>va_EOF:=Char:C90(13)  //fin d'enregistrement
Else   //sinon, c'est un PC Windows
	
	<>vb_CestUnMac:=False:C215
	<>va_EOF:=Char:C90(13)+Char:C90(10)  //fin d'enregistrement
End if 

_O_PLATFORM PROPERTIES:C365($vl_PlateForme; $vl_Systeme; $vl_Machine)

If ($PlateForme<1) & (3<$PlateForme)
	<>va_PlateForme:=""
Else 
	
	If ($PlateForme=3)
		<>va_PlateForme:=""
		
		If ($Systeme<0)
			$WinMajVers:=((2^31)+$Systeme)%256
			$WinMinVers:=(((2^31)+$Systeme)\256)%256
			
			If ($WinMinVers>=4)
				<>va_PlateForme:="Windows™ 95"
			Else 
				<>va_PlateForme:="Windows™ (with Win32s)"
			End if 
			
		Else 
			$WinMajVers:=$Systeme%256
			$WinMinVers:=($Systeme\256)%256
			
			<>va_PlateForme:="Windows™ NT"
		End if 
		
		<>va_PlateForme:=<>va_PlateForme+" version "+String:C10($WinMajVers)+"."+String:C10($WinMinVers)
	Else 
		<>va_PlateForme:="MacOS™ version "+String:C10($Systeme\256)+"."+String:C10(($Systeme\16)%16)+(("."+String:C10($Systeme%16))*Num:C11(($Systeme%16)#0))
	End if 
	
End if 

<>vl_LargeurEcran:=Screen width:C187
<>vl_HauteurEcran:=Screen height:C188
<>va_TailleEcran:=String:C10(<>vl_LargeurEcran)+"/"+String:C10(<>vl_HauteurEcran)

i_EcranCouleur(-><>vl_ProfondeurEcran; -><>va_ProfondeurEcran; -><>vl_CouleurEcran; -><>va_CouleurEcran)

<>vt_ApplStructure:=Structure file:C489
<>vt_ApplDonnees:=Data file:C490
<>vt_ApplApplication:=Application file:C491
<>vt_DossierACI:=Get 4D folder:C485

<>va_FichierStructure:=i_NomFichier(<>vt_ApplStructure)  //Fichier structure
<>va_FichierDonnees:=i_NomFichier(<>vt_ApplDonnees)  //Fichier donnees
<>va_FichierApplication:=i_NomFichier(<>vt_ApplApplication)  //Fichier application

<>vt_DossierStructure:=i_NomChemin(<>vt_ApplStructure)  //Chemin structure
<>vt_DossierDonnees:=i_NomChemin(<>vt_ApplDonnees)  //Chemin donnees
<>vt_DossierApplication:=i_NomChemin(<>vt_ApplApplication)  //Chemin application