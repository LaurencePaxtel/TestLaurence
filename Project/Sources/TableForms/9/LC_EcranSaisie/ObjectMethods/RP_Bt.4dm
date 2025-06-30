C_TEXT:C284($vt_Texte)
C_BOOLEAN:C305($vb_OK)
$vb_OK:=False:C215
$vt_Texte:=""

$vb_OK:=(([LesCentres:9]LC_Répertoire:54>"") & (<>vt_T_CheminRép>""))
If ($vb_OK)
	$vb_OK:=False:C215
	$vt_Texte:=<>vt_T_CheminRép
	
	If (7=8)
		If (<>vb_CestUnMac)
			$vt_Texte:=Replace string:C233($vt_Texte; "/"; Séparateur dossier:K24:12)
		Else 
			$vt_Texte:=Replace string:C233($vt_Texte; ":"; Séparateur dossier:K24:12)
		End if 
	End if 
	
	$vb_OK:=(Test path name:C476($vt_Texte)=Est un dossier:K24:2)
	If ($vb_OK)
		$vb_OK:=False:C215
		$vt_Texte:=$vt_Texte+[LesCentres:9]LC_Répertoire:54+Séparateur dossier:K24:12
		$vb_OK:=(Test path name:C476($vt_Texte)=Est un dossier:K24:2)
		If ($vb_OK)
			ALERT:C41("Le dossier : "+[LesCentres:9]LC_Répertoire:54+" existe déjà !")
		Else 
			CONFIRM:C162("Le répertoire : "+[LesCentres:9]LC_Répertoire:54+" n'existe pas."+"Voulez-vous le créer ?")
			If (OK=1)
				CREATE FOLDER:C475($vt_Texte)
			End if 
		End if 
	End if 
Else 
	ALERT:C41("Veuillez vérifier le chemin d'accès au répertoire et le nom du répertoire !")
End if 