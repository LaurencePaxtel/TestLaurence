//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Fonction : F_SIAO_TransmettreOld
//{          Mardi 22 février 2011 à 11:50
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
$0:=False:C215
ARRAY TEXT:C222(<>tt_Block; 0)

C_LONGINT:C283($1)  //ID de la fiche SIAO à transmettre (0 = deja en mémoire)
C_BOOLEAN:C305($2)  //Exporter au format windows

C_TIME:C306($h_RefDoc)
C_BOOLEAN:C305($vb_OK; $vb_OkMessage)
C_TEXT:C284($vt_Texte)
C_TEXT:C284($vt_Block)
C_LONGINT:C283($ii; $vl_Personnes; $vl_Tableau)
$vb_OK:=False:C215
$vb_OkMessage:=True:C214
$vt_Texte:=String:C10(Current date:C33; Interne date court:K1:7)
$vt_Block:=""

If ($1>0)
	QUERY:C277([SIAO:50]; [SIAO:50]Si_RéférenceID:1=$1)
	MultiSoc_Filter(->[SIAO:50])
	If (Records in selection:C76=1)
		$vb_OK:=True:C214
	Else 
		ALERT:C41("Acune fiche trouvée !")
	End if 
Else 
	$vb_OK:=True:C214
End if 

If ($vb_OK)
	//•(1) Le répertoir de transfert existe-t-il  
	$vb_OK:=(Test path name:C476(<>vt_T_CheminRép)=Est un dossier:K24:2)
	If ($vb_OK=False:C215)
		i_MessagerieFiche(False:C215; "Export SIAO"; "NO"; "SIAO export "+$vt_Texte+" : absence de repertoire ou de chemin"; "Fiche SIAO exportée : 0")
	End if 
	
	//•(2) Le répertoire des prestations  existe t il
	If ($vb_OK)
		vt_FullDuplexDossier:=<>vt_T_CheminRép+<>va_Rép_TransSIAO+Séparateur dossier:K24:12
		$vb_OK:=(Test path name:C476(vt_FullDuplexDossier)=Est un dossier:K24:2)
		If ($vb_OK=False:C215)
			CREATE FOLDER:C475(vt_FullDuplexDossier)
			If (OK=1)
				$vb_OK:=True:C214
			End if 
		End if 
	End if 
	
	//•(3) On lance te transfert 
	If ($vb_OK)
		If ($vb_OkMessage)
			i_Message("SIAO : tranfert en cours…")
		End if 
		
		//•(3-1) Entête
		$vt_Block:=$vt_Block+"SIAO Infos : "+<>va_Tab+<>va_T_Site+", Le "+$vt_Texte+" à "+String:C10(Current time:C178; h mn s:K7:1)+<>va_Tab+"0"+<>va_Tab+"0"+<>va_Tab+"0"+<>va_CR
		
		If ($vb_OkMessage)
			i_MessageSeul("SIAO : tranfert en cours : Entête")
		End if 
		//•(3-2) SIAO
		$vt_Block:=$vt_Block+"SIAO SIAO : "+<>va_Tab+""+<>va_Tab+String:C10(Table:C252(->[SIAO:50]))+<>va_Tab+String:C10(Get last field number:C255(->[SIAO:50]))+<>va_Tab+"0"+<>va_CR
		For ($ii; 1; Get last field number:C255(->[SIAO:50]))
			$vt_Block:=$vt_Block+Substring:C12(Field name:C257(Table:C252(->[SIAO:50]); $ii); 4)+<>va_Tab+F_ChampEnChaine(Table:C252(->[SIAO:50]); $ii)+<>va_Tab+String:C10(Table:C252(->[SIAO:50]))+<>va_Tab+String:C10($ii)+<>va_Tab+"0"+<>va_CR
		End for 
		
		If ($vb_OkMessage)
			i_MessageSeul("SIAO : tranfert en cours : Référent")
		End if 
		//•(3-3) SIAO Référent
		$vt_Block:=$vt_Block+"SIAO REFERENT : "+<>va_Tab+""+<>va_Tab+String:C10(Table:C252(->[SIAO_SiteAccueil:55]))+<>va_Tab+String:C10(Get last field number:C255(->[SIAO_SiteAccueil:55]))+<>va_Tab+"0"+<>va_CR
		QUERY:C277([SIAO_SiteAccueil:55]; [SIAO_SiteAccueil:55]Sr_RéférenceID:1=[SIAO:50]Si_OrigineSiteAccueil_ID:19)
		MultiSoc_Filter(->[SIAO_SiteAccueil:55])
		If (Records in selection:C76([SIAO_SiteAccueil:55])=1)
			For ($ii; 1; Get last field number:C255(->[SIAO_SiteAccueil:55]))
				$vt_Block:=$vt_Block+Substring:C12(Field name:C257(Table:C252(->[SIAO_SiteAccueil:55]); $ii); 4)+<>va_Tab+F_ChampEnChaine(Table:C252(->[SIAO_SiteAccueil:55]); $ii)+<>va_Tab+String:C10(Table:C252(->[SIAO_SiteAccueil:55]))+<>va_Tab+String:C10($ii)+<>va_Tab+"0"+<>va_CR
			End for 
		Else 
			For ($ii; 1; Get last field number:C255(->[SIAO_SiteAccueil:55]))
				$vt_Block:=$vt_Block+Substring:C12(Field name:C257(Table:C252(->[SIAO_SiteAccueil:55]); $ii); 4)+<>va_Tab+""+<>va_Tab+String:C10(Table:C252(->[SIAO_SiteAccueil:55]))+<>va_Tab+String:C10($ii)+<>va_Tab+"0"+<>va_CR
			End for 
		End if 
		
		If ($vb_OkMessage)
			i_MessageSeul("SIAO : tranfert en cours : Accueil")
		End if 
		//•(3-4) SIAO Accueil
		$vt_Block:=$vt_Block+"SIAO ACCUEIL : "+<>va_Tab+""+<>va_Tab+String:C10(Table:C252(->[SIAO_SiteReference:54]))+<>va_Tab+String:C10(Get last field number:C255(->[SIAO_SiteReference:54]))+<>va_Tab+"0"+<>va_CR
		QUERY:C277([SIAO_SiteReference:54]; [SIAO_SiteReference:54]Sa_RéférenceID:1=[SIAO:50]Si_Origine_SiteReference_ID:15)
		MultiSoc_Filter(->[SIAO_SiteReference:54])
		If (Records in selection:C76([SIAO_SiteReference:54])=1)
			For ($ii; 1; Get last field number:C255(->[SIAO_SiteReference:54]))
				$vt_Block:=$vt_Block+Substring:C12(Field name:C257(Table:C252(->[SIAO:50]); $ii); 4)+<>va_Tab+F_ChampEnChaine(Table:C252(->[SIAO_SiteReference:54]); $ii)+<>va_Tab+String:C10(Table:C252(->[SIAO_SiteReference:54]))+<>va_Tab+String:C10($ii)+<>va_Tab+"0"+<>va_CR
			End for 
		Else 
			For ($ii; 1; Get last field number:C255(->[SIAO_SiteReference:54]))
				$vt_Block:=$vt_Block+Substring:C12(Field name:C257(Table:C252(->[SIAO_SiteReference:54]); $ii); 4)+<>va_Tab+""+<>va_Tab+String:C10(Table:C252(->[SIAO_SiteReference:54]))+<>va_Tab+String:C10($ii)+<>va_Tab+"0"+<>va_CR
			End for 
		End if 
		
		If ($vb_OkMessage)
			i_MessageSeul("SIAO : tranfert en cours : Personnes")
		End if 
		
		
		
		
		//•(3-5) SIAO personnes
		QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1)
		MultiSoc_Filter(->[SIAO_Personnes:51])
		$vl_Personnes:=Records in selection:C76([SIAO_Personnes:51])
		$vt_Block:=$vt_Block+"SIAO PERSONNE : "+<>va_Tab+""+<>va_Tab+String:C10(Table:C252(->[SIAO_Personnes:51]))+<>va_Tab+String:C10(Get last field number:C255(->[SIAO_Personnes:51]))+<>va_Tab+String:C10($vl_Personnes)+<>va_CR
		If ($vl_Personnes>0)
			ORDER BY:C49([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Rang:7; >)
			Repeat 
				If ($vb_OkMessage)
					i_MessageSeul("SIAO : Transmission : "+String:C10($vl_Personnes)+"/"+String:C10([SIAO_Personnes:51]Sp_Rang:7)+" - "+[SIAO_Personnes:51]Sp_Nom:11+" "+[SIAO_Personnes:51]Sp_Prenom:13)
				End if 
				
				$vl_Tableau:=Size of array:C274(<>tt_Block)+1
				INSERT IN ARRAY:C227(<>tt_Block; $vl_Tableau; 1)
				<>tt_Block{$vl_Tableau}:=""
				
				<>tt_Block{$vl_Tableau}:=<>tt_Block{$vl_Tableau}+"SIAO PERSONNE : "+String:C10([SIAO_Personnes:51]Sp_Rang:7)+<>va_Tab+""+<>va_Tab+String:C10([SIAO_Personnes:51]Sp_RéférenceID:1)+<>va_Tab+String:C10([SIAO_Personnes:51]Sp_SIAO_ID:2)+<>va_Tab+String:C10([SIAO_Personnes:51]Sp_Personne_ID:3)+<>va_CR
				For ($ii; 1; Get last field number:C255(->[SIAO_Personnes:51]))
					<>tt_Block{$vl_Tableau}:=<>tt_Block{$vl_Tableau}+Substring:C12(Field name:C257(Table:C252(->[SIAO_Personnes:51]); $ii); 4)+<>va_Tab+F_ChampEnChaine(Table:C252(->[SIAO_Personnes:51]); $ii)+<>va_Tab+String:C10(Table:C252(->[SIAO_Personnes:51]))+<>va_Tab+String:C10($ii)+<>va_Tab+"0"+<>va_CR
				End for 
				
				//•(3-5-1) SIAO adresse HEB
				<>tt_Block{$vl_Tableau}:=<>tt_Block{$vl_Tableau}+"SIAO ADR HEB : "+<>va_Tab+"1"+<>va_Tab+String:C10(Table:C252(->[Adresses:53]))+<>va_Tab+String:C10(Get last field number:C255(->[Adresses:53]))+<>va_Tab+"0"+<>va_CR
				$vb_OK:=F_SIAO_Var_AD(12; [SIAO_Personnes:51]Sp_SIAO_ID:2; [SIAO_Personnes:51]Sp_RéférenceID:1; ->vt_TransTexte; 1)  //ADRESSE
				<>tt_Block{$vl_Tableau}:=<>tt_Block{$vl_Tableau}+vt_TransTexte
				//•(3-5-2) SIAO adresse DOM
				<>tt_Block{$vl_Tableau}:=<>tt_Block{$vl_Tableau}+"SIAO ADR DOM : "+<>va_Tab+"2"+<>va_Tab+String:C10(Table:C252(->[Adresses:53]))+<>va_Tab+String:C10(Get last field number:C255(->[Adresses:53]))+<>va_Tab+"0"+<>va_CR
				$vb_OK:=F_SIAO_Var_AD(12; [SIAO_Personnes:51]Sp_SIAO_ID:2; [SIAO_Personnes:51]Sp_RéférenceID:1; ->vt_TransTexte; 2)  //ADRESSE
				<>tt_Block{$vl_Tableau}:=<>tt_Block{$vl_Tableau}+vt_TransTexte
				
				//•(3-5-3) SITUATION 
				$vb_OK:=F_SIAO_Var_SsCS(12; [SIAO_Personnes:51]Sp_SIAO_ID:2; [SIAO_Personnes:51]Sp_RéférenceID:1; ->vt_TransTexte; 0)  //RENSEIGNEMENTS ADMINISTRATIFS
				<>tt_Block{$vl_Tableau}:=<>tt_Block{$vl_Tableau}+vt_TransTexte
				$vb_OK:=F_SIAO_Var_SsSP(12; [SIAO_Personnes:51]Sp_SIAO_ID:2; [SIAO_Personnes:51]Sp_RéférenceID:1; ->vt_TransTexte; 0)  //SITUATION PROFESSIONNELLE
				<>tt_Block{$vl_Tableau}:=<>tt_Block{$vl_Tableau}+vt_TransTexte
				$vb_OK:=F_SIAO_Var_SsRS(12; [SIAO_Personnes:51]Sp_SIAO_ID:2; [SIAO_Personnes:51]Sp_RéférenceID:1; ->vt_TransTexte; 0)  //RESSOURCES
				<>tt_Block{$vl_Tableau}:=<>tt_Block{$vl_Tableau}+vt_TransTexte
				$vb_OK:=F_SIAO_Var_SsDT(12; [SIAO_Personnes:51]Sp_SIAO_ID:2; [SIAO_Personnes:51]Sp_RéférenceID:1; ->vt_TransTexte; 0)  //ENDETTEMENT
				<>tt_Block{$vl_Tableau}:=<>tt_Block{$vl_Tableau}+vt_TransTexte
				$vb_OK:=F_SIAO_Var_SsLG(12; [SIAO_Personnes:51]Sp_SIAO_ID:2; [SIAO_Personnes:51]Sp_RéférenceID:1; ->vt_TransTexte; 0)  //SITUATION EN REGARD DU LOGEMENT
				<>tt_Block{$vl_Tableau}:=<>tt_Block{$vl_Tableau}+vt_TransTexte
				$vb_OK:=F_SIAO_Var_SsDL(12; [SIAO_Personnes:51]Sp_SIAO_ID:2; [SIAO_Personnes:51]Sp_RéférenceID:1; ->vt_TransTexte; 0)  //SITUATION EN REGARD DE LA DEMANDE DE LOGEMENT
				<>tt_Block{$vl_Tableau}:=<>tt_Block{$vl_Tableau}+vt_TransTexte
				
				$vb_OK:=F_SIAO_Var_SsBS(12; [SIAO_Personnes:51]Sp_SIAO_ID:2; [SIAO_Personnes:51]Sp_RéférenceID:1; ->vt_TransTexte; 0)  //EVALUATION REALISEE PAR LE PROFESSIONNEL
				<>tt_Block{$vl_Tableau}:=<>tt_Block{$vl_Tableau}+vt_TransTexte
				$vb_OK:=F_SIAO_Var_SsPR(12; [SIAO_Personnes:51]Sp_SIAO_ID:2; [SIAO_Personnes:51]Sp_RéférenceID:1; ->vt_TransTexte; 0)  //PRECONISATION DU PROFESSIONNEL et suite
				<>tt_Block{$vl_Tableau}:=<>tt_Block{$vl_Tableau}+vt_TransTexte
				$vb_OK:=F_SIAO_Var_SsPP(12; [SIAO_Personnes:51]Sp_SIAO_ID:2; [SIAO_Personnes:51]Sp_RéférenceID:1; ->vt_TransTexte; 0)  //PROPOSITIONS
				<>tt_Block{$vl_Tableau}:=<>tt_Block{$vl_Tableau}+vt_TransTexte
				
				NEXT RECORD:C51([SIAO_Personnes:51])
			Until (End selection:C36([SIAO_Personnes:51]))
		End if 
		
		//•(3-6) Pied
		//   $vt_Block:=$vt_Block+"SSPFINEXPORTSSP"+◊va_CR
		$vt_Texte:="SSPFINEXPORTSSP"+<>va_CR
		
		//•(3-7) •••• Construire le nom du fichier sur disque
		$vb_Ok:=F_SIAOFicheSurDisqueFichier(->vt_TitreDocument; Current date:C33; Current time:C178; [SIAO:50]Si_Demande_Numero:3; -1)
		If ($vb_OK)
			vt_TitreDocument:=F_FichierSuffixe(vt_TitreDocument)
		End if 
		
		
		//•(3-8) •••• Export des données
		If ($vb_OK)
			
			$h_RefDoc:=Create document:C266(vt_FullDuplexDossier+vt_TitreDocument)
			If (OK=1)
				USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
				
				$0:=True:C214
				If ($2)
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Block))
					For ($ii; 1; $vl_Tableau)
						SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(<>tt_Block{$ii}))
					End for 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				Else 
					SEND PACKET:C103($h_RefDoc; $vt_Block)
					For ($ii; 1; $vl_Tableau)
						SEND PACKET:C103($h_RefDoc; <>tt_Block{$ii})
					End for 
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				End if 
				
				USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
				CLOSE DOCUMENT:C267($h_RefDoc)
			End if 
		End if 
		
		
	End if 
	If ($vb_OkMessage)
		CLOSE WINDOW:C154
	End if 
End if 