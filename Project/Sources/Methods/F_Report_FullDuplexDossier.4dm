//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_Report_FullDuplexDossier
//{
//{          Vendrdi 24 octobre 2008 à 16:11
//{          Modifiée : 31 octobre 2008 à 10:18
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_BOOLEAN:C305($vb_OK)
C_TEXT:C284($vt_Texte)
//• *$1
// 0 Créer le répertoire s'il n'existe pas avec le chemin conu
// 1 Tester si  le répertoire existe avec le chemin conu
// 11 Tester si  le répertoire existe tout est envoyé d'un coup : 
//                   chemin et repertioire et separateur
//• *$2 : Nom du répertoire

$vb_OK:=False:C215

If ($2>"")
	Case of 
		: ($1=0)
			$vt_Texte:=<>vt_T_CheminRép+$2+Séparateur dossier:K24:12
			$vb_OK:=(Test path name:C476($vt_Texte)=Est un dossier:K24:2)
			If ($vb_OK)
				$vb_OK:=True:C214
			Else 
				CREATE FOLDER:C475($vt_Texte)
				If (OK=1)
					$vb_OK:=True:C214
				End if 
			End if 
			
		: ($1=1)
			$vt_Texte:=<>vt_T_CheminRép+$2+Séparateur dossier:K24:12
			$vb_OK:=(Test path name:C476($vt_Texte)=Est un dossier:K24:2)
			If ($vb_OK)
				$vb_OK:=True:C214
			End if 
			
		: ($1=3)
			$vt_Texte:=<>vt_T_CheminRépServeur+$2+Séparateur dossier:K24:12
			$vb_OK:=(Test path name:C476($vt_Texte)=Est un dossier:K24:2)
			If ($vb_OK)
				$vb_OK:=True:C214
			Else 
				CREATE FOLDER:C475($vt_Texte)
				If (OK=1)
					$vb_OK:=True:C214
				End if 
			End if 
			
			
		: ($1=11)
			$vt_Texte:=$2
			$vb_OK:=(Test path name:C476($vt_Texte)=Est un dossier:K24:2)
			If ($vb_OK)
				$vb_OK:=True:C214
			End if 
			
		: ($1=12)
			$vt_Texte:=$2
			$vb_OK:=(Test path name:C476($vt_Texte)=Est un dossier:K24:2)
			If ($vb_OK)
				$vb_OK:=True:C214
			Else 
				CREATE FOLDER:C475($vt_Texte)
				If (OK=1)
					$vb_OK:=True:C214
				End if 
			End if 
	End case 
End if 

$0:=$vb_OK