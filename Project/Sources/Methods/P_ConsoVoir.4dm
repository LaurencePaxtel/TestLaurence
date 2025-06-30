//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_ConsoVoir
//{
//{          Mardi 18 novembre 2008 à 12:06:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_TIME:C306(vh_Réf)
C_BOOLEAN:C305($vb_OK)
C_TEXT:C284($vt_Temp)


//Condition
If (Substring:C12(<>ta_ConsoB_Document{$1}; Length:C16(<>ta_ConsoB_Document{$1})-3; 4)=".TXT")
	$vt_Temp:=Substring:C12(<>ta_ConsoB_Document{$1}; 1; Length:C16(<>ta_ConsoB_Document{$1})-4)
Else 
	$vt_Temp:=<>ta_ConsoB_Document{$1}
End if 

$vb_OK:=((Length:C16($vt_Temp)>=25) | (Length:C16($vt_Temp)<=32))
$vb_OK:=$vb_OK & ($vt_Temp[[12]]="h")  //Heure
$vb_OK:=$vb_OK & (($vt_Temp[[22]]="H") | ($vt_Temp[[22]]="F"))  //Homme ou femme


If ($vb_OK)
	vt_TitreDocument:=vt_FullDuplexDossier+<>ta_ConsoB_Document{$1}
	//vérifier si on ajoute .TXT si on est sur PC
	If (<>vb_CestUnMac)  //16/6/2010
	Else 
		vt_TitreDocument:=F_FichierSuffixe(vt_TitreDocument)
	End if 
	
	
	If (Test path name:C476(vt_TitreDocument)=Est un document:K24:1)
		vh_Réf:=Open document:C264(vt_TitreDocument)
		If (OK=1)
			<>vt_ConsoB_CheminDossier:=vt_FullDuplexDossier
			//L'idée est de créer un tableau en mémoire et de l'enregistrer ensuite
			//    RECEVOIR PAQUET(vh_Réf;◊vt_Buffer;"SSPFINEXPORTSSP")
			//      ◊vt_Buffer:=Remplacer chaine(◊vt_Buffer;◊va_LF;"")
			//   ECRIRE TEXTE DANS PRESSE PAPIERS(◊vt_Buffer)
			
			//Découpage du nom du document
			$vb_OK:=F_Report_FullDuplexTitreB(<>ta_ConsoB_Document{$1})
			
			//Découpage du contenu du document
			// $vb_OK:=F_Report_FullDuplexBufferB (vt_TitreDocument;◊vt_Buffer)
			
			USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // Filtre import. BS Migration v15
			$vb_OK:=F_Report_FullDuplexBufferC(vh_Réf)
			USE CHARACTER SET:C205(*; 1)  // reset Filtre import. BS Migration v15
			
			CLOSE DOCUMENT:C267(vh_Réf)
		End if 
	End if 
Else 
	P_VarParamConsoVoir(2)
	$vb_OK:=True:C214
	If ((Length:C16($vt_Temp)>=25) & (Length:C16($vt_Temp)<=32))
	Else 
		//ALERTE("Ce n'est pas un fichier de consolidation (mauvaise longueur) !")
		$vb_OK:=False:C215
	End if 
	If ($vb_OK)
		If ($vt_Temp[[12]]#"h")  //Heure
			ALERT:C41("Ce n'est pas un fichier de consolidation  (h) !")
			$vb_OK:=False:C215
		End if 
	End if 
	
	If ($vb_OK)
		If (($vt_Temp[[22]]#"H") | ($vt_Temp[[22]]#"F"))  //Homme ou femme
			ALERT:C41("Ce n'est pas un fichier de consolidation (H ou F) !")
			$vb_OK:=False:C215
		End if 
	End if 
	
	
	
End if 

