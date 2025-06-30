//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Fonction : F_SIAO_Transmettre
//{          Mardi 22 février 2011 à 11:50
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215

C_LONGINT:C283($1)  //ID de la fiche SIAO à transmettre (0 = deja en mémoire)
C_BOOLEAN:C305($2)  //Exporter au format windows

C_TIME:C306($h_RefDoc)
C_BOOLEAN:C305($vb_OK; $vb_OkMessage)
C_TEXT:C284($vt_Texte)
C_TEXT:C284($vt_Block)
C_LONGINT:C283($ii; $vl_Personnes; $vl_Situations)
C_TEXT:C284($va_Theme)
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
	//•(2) Le répertoire des SIAO  existe t il
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
End if 


If ($vb_OK)
	//•(3) •••• Construire le nom du fichier sur disque
	
	$vb_Ok:=F_SIAOFicheSurDisqueFichier(->vt_TitreDocument; Current date:C33; Current time:C178; [SIAO:50]Si_Demande_Numero:3; Num:C11([SIAO:50]Si_Trans_Type:34))
	If ($vb_OK)
		vt_TitreDocument:=F_FichierSuffixe(vt_TitreDocument)
	End if 
	//•(3-1) •••• Créer le nom du fichier sur disque
	If ($vb_OK)
		$vb_OK:=False:C215
		$h_RefDoc:=Create document:C266(vt_FullDuplexDossier+vt_TitreDocument)
		If (OK=1)
			$vb_OK:=True:C214
		End if 
	End if 
End if 

USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15

If ($vb_OK)
	If ($vb_OkMessage)
		i_Message("SIAO : tranfert en cours…")
	End if 
	
	//•(4-1) •••• Export des données : 1ère ligne du document : Entête 
	//•(4-2) •••• Export des données : 4Block SIAO
	//•(4-3) •••• Export des données : 2Block Référent
	//•(4-4) •••• Export des données : 3Block Acueil
	
	//•(4-5) •••• Export des données : Titre Personnes
	//•(4-5-1) •••• Export des données : Block Personnes
	//•(4-5-2) •••• Export des données : Block Personnes Adresse
	//•(4-5-3) •••• Export des données : Block Personnes Pages
	
	
	//•(4-1) Entête
	If ($vb_OkMessage)
		i_MessageSeul("SIAO : tranfert en cours : Entête")
	End if 
	$vt_Block:="SIAO SIAO Infos : "+<>va_Tab+"-1"+<>va_Tab+"0"+<>va_Tab+<>va_T_Site+(" "*(3-Length:C16(<>va_T_Site)))+", Le "+$vt_Texte+" à "+String:C10(Current time:C178; h mn s:K7:1)+<>va_Tab+<>va_T_01+<>va_Tab+[SIAO:50]Si_Demandeur:20+<>va_CR
	If ($2)
		SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Block))
	Else 
		SEND PACKET:C103($h_RefDoc; $vt_Block)
	End if 
	
	
	//•(4-2) •••• Export des données : Block Acueil
	If ($vb_OkMessage)
		i_MessageSeul("SIAO : tranfert en cours : Accueil")
	End if 
	QUERY:C277([SIAO_SiteReference:54]; [SIAO_SiteReference:54]Sa_RéférenceID:1=[SIAO:50]Si_Origine_SiteReference_ID:15)
	MultiSoc_Filter(->[SIAO_SiteReference:54])
	If (Records in selection:C76([SIAO_SiteReference:54])=1)
		If (7=8)
			$vt_Block:="SIAO SIAO ACCUEIL : "+<>va_Tab+String:C10(Table:C252(->[SIAO_SiteReference:54]))+<>va_Tab+"-1"+<>va_Tab+String:C10(Get last field number:C255(->[SIAO_SiteReference:54]))+<>va_Tab+"1"+<>va_Tab+[SIAO_SiteReference:54]Sa_ReferenceNom:6+<>va_CR
		End if 
		$vt_Block:="SIAO SIAO ACCUEIL : "+<>va_Tab+String:C10(Table:C252(->[SIAO_SiteReference:54]))+<>va_Tab+"-1"+<>va_Tab+String:C10(Get last field number:C255(->[SIAO_SiteReference:54]))+<>va_Tab+"1"+<>va_CR
		For ($ii; 1; Get last field number:C255(->[SIAO_SiteReference:54]))
			$vt_Block:=$vt_Block+Substring:C12(Field name:C257(Table:C252(->[SIAO_SiteReference:54]); $ii); 4)+<>va_Tab+String:C10(Table:C252(->[SIAO_SiteReference:54]))+<>va_Tab+String:C10($ii)+<>va_Tab+F_ChampEnChaine(Table:C252(->[SIAO_SiteReference:54]); $ii)+<>va_Tab+"0"+<>va_CR
		End for 
		$vt_Block:=$vt_Block+"SIAO SIAO ACCUEIL : "+<>va_Tab+String:C10(Table:C252(->[SIAO_SiteReference:54]))+<>va_Tab+"0"+<>va_Tab+"0"+<>va_Tab+"0"+<>va_CR
	Else 
		$vt_Block:="SIAO SIAO ACCUEIL : "+<>va_Tab+String:C10(Table:C252(->[SIAO_SiteReference:54]))+<>va_Tab+"-1"+<>va_Tab+String:C10(Get last field number:C255(->[SIAO_SiteReference:54]))+<>va_Tab+"0"+<>va_CR
	End if 
	If ($2)
		SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Block))
	Else 
		SEND PACKET:C103($h_RefDoc; $vt_Block)
	End if 
	
	
	//•(4-3) •••• Export des données :  Référent
	If ($vb_OkMessage)
		i_MessageSeul("SIAO : tranfert en cours : Référent")
	End if 
	QUERY:C277([SIAO_SiteAccueil:55]; [SIAO_SiteAccueil:55]Sr_RéférenceID:1=[SIAO:50]Si_OrigineSiteAccueil_ID:19)
	MultiSoc_Filter(->[SIAO_SiteAccueil:55])
	If (Records in selection:C76([SIAO_SiteAccueil:55])=1)
		If (7=8)
			$vt_Block:="SIAO SIAO REFERENT : "+<>va_Tab+String:C10(Table:C252(->[SIAO_SiteAccueil:55]))+<>va_Tab+"-1"+<>va_Tab+String:C10(Get last field number:C255(->[SIAO_SiteAccueil:55]))+<>va_Tab+"1"+<>va_Tab+[SIAO_SiteAccueil:55]Sr_Nom:5+"/"+[SIAO_SiteAccueil:55]Sr_Prénom:6+"/"+[SIAO_SiteAccueil:55]Sr_Téléphone:9+<>va_CR
		End if 
		$vt_Block:="SIAO SIAO REFERENT : "+<>va_Tab+String:C10(Table:C252(->[SIAO_SiteAccueil:55]))+<>va_Tab+"-1"+<>va_Tab+String:C10(Get last field number:C255(->[SIAO_SiteAccueil:55]))+<>va_Tab+"1"+<>va_CR
		For ($ii; 1; Get last field number:C255(->[SIAO_SiteAccueil:55]))
			$vt_Block:=$vt_Block+Substring:C12(Field name:C257(Table:C252(->[SIAO_SiteAccueil:55]); $ii); 4)+<>va_Tab+String:C10(Table:C252(->[SIAO_SiteAccueil:55]))+<>va_Tab+String:C10($ii)+<>va_Tab+F_ChampEnChaine(Table:C252(->[SIAO_SiteAccueil:55]); $ii)+<>va_Tab+"0"+<>va_CR
		End for 
		$vt_Block:=$vt_Block+"SIAO SIAO REFERENT : "+<>va_Tab+String:C10(Table:C252(->[SIAO_SiteAccueil:55]))+<>va_Tab+"0"+<>va_Tab+"0"+<>va_Tab+"0"+<>va_CR
	Else 
		$vt_Block:="SIAO SIAO REFERENT : "+<>va_Tab+String:C10(Table:C252(->[SIAO_SiteAccueil:55]))+<>va_Tab+"-1"+<>va_Tab+String:C10(Get last field number:C255(->[SIAO_SiteAccueil:55]))+<>va_Tab+"0"+<>va_CR
	End if 
	If ($2)
		SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Block))
	Else 
		SEND PACKET:C103($h_RefDoc; $vt_Block)
	End if 
	
	
	//•(4-4) •••• Export des données : SIAO
	If ($vb_OkMessage)
		i_MessageSeul("SIAO : tranfert en cours : SIAO")
	End if 
	$vt_Block:="SIAO SIAO SIAO : "+<>va_Tab+String:C10(Table:C252(->[SIAO:50]))+<>va_Tab+"-1"+<>va_Tab+String:C10(Get last field number:C255(->[SIAO:50]))+<>va_Tab+"1"+<>va_CR
	For ($ii; 1; Get last field number:C255(->[SIAO:50]))
		$vt_Block:=$vt_Block+Substring:C12(Field name:C257(Table:C252(->[SIAO:50]); $ii); 4)+<>va_Tab+String:C10(Table:C252(->[SIAO:50]))+<>va_Tab+String:C10($ii)+<>va_Tab+F_ChampEnChaine(Table:C252(->[SIAO:50]); $ii)+<>va_Tab+"0"+<>va_CR
	End for 
	$vt_Block:=$vt_Block+"SIAO SIAO SIAO : "+<>va_Tab+String:C10(Table:C252(->[SIAO:50]))+<>va_Tab+"0"+<>va_Tab+"0"+<>va_Tab+"0"+<>va_CR
	If ($2)
		SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Block))
	Else 
		SEND PACKET:C103($h_RefDoc; $vt_Block)
	End if 
	
	
	//•(4-5) •••• Export des données : Titre Personnes
	If ($vb_OkMessage)
		i_MessageSeul("SIAO : tranfert en cours : Personnes")
	End if 
	QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1)
	MultiSoc_Filter(->[SIAO_Personnes:51])
	$vl_Personnes:=Records in selection:C76([SIAO_Personnes:51])
	If ($vl_Personnes>0)
		QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1)
		MultiSoc_Filter(->[SIAO_Situations:52])
		$vl_Situations:=Records in selection:C76([SIAO_Situations:52])
		$vt_Block:="SIAO SIAO PERSONNE : "+<>va_Tab+String:C10(Table:C252(->[SIAO_Personnes:51]))+<>va_Tab+"-1"+<>va_Tab+String:C10(Get last field number:C255(->[SIAO_Personnes:51]))+<>va_Tab+String:C10($vl_Personnes)+<>va_CR
	Else 
		$vt_Block:="SIAO SIAO PERSONNE : "+<>va_Tab+String:C10(Table:C252(->[SIAO_Personnes:51]))+<>va_Tab+"-1"+<>va_Tab+String:C10(Get last field number:C255(->[SIAO_Personnes:51]))+<>va_Tab+"0"+<>va_CR
	End if 
	If ($2)
		SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Block))
	Else 
		SEND PACKET:C103($h_RefDoc; $vt_Block)
	End if 
	
	If ($vl_Personnes>0)
		ORDER BY:C49([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Rang:7; >)
		SELECTION TO ARRAY:C260([SIAO_Personnes:51]Sp_RéférenceID:1; tl_RefPers)
		
		If ($vb_OkMessage)
			i_MessageSeul("SIAO : tranfert en cours : Personnes 12/1")
		End if 
		For ($ii; 1; Get last field number:C255(->[SIAO_Personnes:51]))
			$vt_Block:=Substring:C12(Field name:C257(Table:C252(->[SIAO_Personnes:51]); $ii); 4)+<>va_Tab+String:C10(Table:C252(->[SIAO_Personnes:51]))+<>va_Tab+String:C10($ii)
			For ($jj; 1; Size of array:C274(tl_RefPers))
				QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_RéférenceID:1=tl_RefPers{$jj})
				$vt_Block:=$vt_Block+<>va_Tab+F_ChampEnChaine(Table:C252(->[SIAO_Personnes:51]); $ii)
			End for 
			$vt_Block:=$vt_Block+<>va_CR
			If ($2)
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Block))
			Else 
				SEND PACKET:C103($h_RefDoc; $vt_Block)
			End if 
		End for 
		
		$vt_Block:="SIAO SIAO PERSONNE : "+<>va_Tab+String:C10(Table:C252(->[SIAO_Personnes:51]))+<>va_Tab+"0"+<>va_Tab+"0"+<>va_Tab+"0"+<>va_CR
		If ($2)
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Block))
		Else 
			SEND PACKET:C103($h_RefDoc; $vt_Block)
		End if 
		
		//•• Adresse HEB
		If ($vb_OkMessage)
			i_MessageSeul("SIAO : tranfert en cours : Personnes 12/2")
		End if 
		$vt_Block:="SIAO SIAO ADRHEB : "+<>va_Tab+String:C10(Table:C252(->[Adresses:53]))+<>va_Tab+"-1"+<>va_Tab+String:C10(Get last field number:C255(->[Adresses:53]))+<>va_Tab+"1"+<>va_CR
		If ($2)
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Block))
		Else 
			SEND PACKET:C103($h_RefDoc; $vt_Block)
		End if 
		For ($ii; 1; Get last field number:C255(->[Adresses:53]))
			$vt_Block:=Substring:C12(Field name:C257(Table:C252(->[Adresses:53]); $ii); 4)+<>va_Tab+String:C10(Table:C252(->[Adresses:53]))+<>va_Tab+String:C10($ii)
			For ($jj; 1; Size of array:C274(tl_RefPers))
				QUERY:C277([Adresses:53]; [Adresses:53]AD_SIAO_Personne_ID:4=tl_RefPers{$jj}; *)
				QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_Categorie:5="HEB")
				MultiSoc_Filter(->[Adresses:53])
				$vt_Block:=$vt_Block+<>va_Tab+F_ChampEnChaine(Table:C252(->[Adresses:53]); $ii)
				
			End for 
			$vt_Block:=$vt_Block+<>va_CR
			If ($2)
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Block))
			Else 
				SEND PACKET:C103($h_RefDoc; $vt_Block)
			End if 
		End for 
		
		$vt_Block:="SIAO SIAO ADRHEB : "+<>va_Tab+String:C10(Table:C252(->[Adresses:53]))+<>va_Tab+"0"+<>va_Tab+"0"+<>va_Tab+"0"+<>va_CR
		If ($2)
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Block))
		Else 
			SEND PACKET:C103($h_RefDoc; $vt_Block)
		End if 
		
		//•• Adresse DOM
		If ($vb_OkMessage)
			i_MessageSeul("SIAO : tranfert en cours : Personnes 12/3")
		End if 
		$vt_Block:="SIAO SIAO ADRDOM : "+<>va_Tab+String:C10(Table:C252(->[Adresses:53]))+<>va_Tab+"-1"+<>va_Tab+String:C10(Get last field number:C255(->[Adresses:53]))+<>va_Tab+"1"+<>va_CR
		If ($2)
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Block))
		Else 
			SEND PACKET:C103($h_RefDoc; $vt_Block)
		End if 
		
		For ($ii; 1; Get last field number:C255(->[Adresses:53]))
			$vt_Block:=Substring:C12(Field name:C257(Table:C252(->[Adresses:53]); $ii); 4)+<>va_Tab+String:C10(Table:C252(->[Adresses:53]))+<>va_Tab+String:C10($ii)
			For ($jj; 1; Size of array:C274(tl_RefPers))
				QUERY:C277([Adresses:53]; [Adresses:53]AD_SIAO_Personne_ID:4=tl_RefPers{$jj}; *)
				QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_Categorie:5="DOM")
				MultiSoc_Filter(->[Adresses:53])
				$vt_Block:=$vt_Block+<>va_Tab+F_ChampEnChaine(Table:C252(->[Adresses:53]); $ii)
			End for 
			$vt_Block:=$vt_Block+<>va_CR
			If ($2)
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Block))
			Else 
				SEND PACKET:C103($h_RefDoc; $vt_Block)
			End if 
		End for 
		$vt_Block:="SIAO SIAO ADRDOM : "+<>va_Tab+String:C10(Table:C252(->[Adresses:53]))+<>va_Tab+"0"+<>va_Tab+"0"+<>va_Tab+"0"+<>va_CR
		If ($2)
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Block))
		Else 
			SEND PACKET:C103($h_RefDoc; $vt_Block)
		End if 
		
		
		If ($vl_Personnes>0)
			$vl_Situations:=$vl_Situations\$vl_Personnes
		End if 
		
		$vt_Block:="SIAO SIAO SITUATIONS : "+<>va_Tab+String:C10(Table:C252(->[SIAO_Situations:52]))+<>va_Tab+"-1"+<>va_Tab+String:C10(Get last field number:C255(->[SIAO_Situations:52]))+<>va_Tab+String:C10($vl_Situations)+<>va_CR
		If ($2)
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Block))
		Else 
			SEND PACKET:C103($h_RefDoc; $vt_Block)
		End if 
		
		$va_Theme:=ta_SIAO_PageTitre{3}  //"RENSEIGNEMENTS ADMINISTRATIFS"    F_SIAO_Var_SsCS
		If ($vb_OkMessage)
			i_MessageSeul("SIAO : tranfert en cours : Personnes 12/4")
		End if 
		P_SIAO_TransSituation($h_RefDoc; $2; 3; ta_SIAO_PageTitre{3}; "A")
		P_SIAO_TransSituation($h_RefDoc; $2; 1; ta_SIAO_PageTitre{3}; "N")
		$va_Theme:=ta_SIAO_PageTitre{4}  //"SITUATION PROFESSIONNELLE" F_SIAO_Var_SsSP
		If ($vb_OkMessage)
			i_MessageSeul("SIAO : tranfert en cours : Personnes 12/5")
		End if 
		P_SIAO_TransSituation($h_RefDoc; $2; 2; ta_SIAO_PageTitre{4}; "A")
		P_SIAO_TransSituation($h_RefDoc; $2; 1; ta_SIAO_PageTitre{4}; "B")
		P_SIAO_TransSituation($h_RefDoc; $2; 1; ta_SIAO_PageTitre{4}; "C")
		$va_Theme:=ta_SIAO_PageTitre{5}  //"RESSOURCES" F_SIAO_Var_SsRS
		If ($vb_OkMessage)
			i_MessageSeul("SIAO : tranfert en cours : Personnes 12/6")
		End if 
		P_SIAO_TransSituation($h_RefDoc; $2; 5; ta_SIAO_PageTitre{5}; "A")
		P_SIAO_TransSituation($h_RefDoc; $2; 1; ta_SIAO_PageTitre{5}; "N")
		$va_Theme:=ta_SIAO_PageTitre{6}  //"ENDETTEMENT" F_SIAO_Var_SsDT
		If ($vb_OkMessage)
			i_MessageSeul("SIAO : tranfert en cours : Personnes 12/7")
		End if 
		P_SIAO_TransSituation($h_RefDoc; $2; 5; ta_SIAO_PageTitre{6}; "A")
		P_SIAO_TransSituation($h_RefDoc; $2; 2; ta_SIAO_PageTitre{6}; "B")
		P_SIAO_TransSituation($h_RefDoc; $2; 1; ta_SIAO_PageTitre{6}; "N")
		$va_Theme:=ta_SIAO_PageTitre{7}  //"SITUATION EN REGARD DU LOGEMENT" F_SIAO_Var_SsLG
		If ($vb_OkMessage)
			i_MessageSeul("SIAO : tranfert en cours : Personnes 12/8")
		End if 
		P_SIAO_TransSituation($h_RefDoc; $2; 2; ta_SIAO_PageTitre{7}; "A")
		P_SIAO_TransSituation($h_RefDoc; $2; 2; ta_SIAO_PageTitre{7}; "B")
		P_SIAO_TransSituation($h_RefDoc; $2; 1; ta_SIAO_PageTitre{7}; "N")
		$va_Theme:=ta_SIAO_PageTitre{8}  //"SITUATION EN REGARD DE LA DEMANDE DE LOGEMENT" F_SIAO_Var_SsDL
		If ($vb_OkMessage)
			i_MessageSeul("SIAO : tranfert en cours : Personnes 12/9")
		End if 
		P_SIAO_TransSituation($h_RefDoc; $2; 2; ta_SIAO_PageTitre{8}; "A")
		P_SIAO_TransSituation($h_RefDoc; $2; 7; ta_SIAO_PageTitre{8}; "B")
		P_SIAO_TransSituation($h_RefDoc; $2; 2; ta_SIAO_PageTitre{8}; "C")
		P_SIAO_TransSituation($h_RefDoc; $2; 1; ta_SIAO_PageTitre{8}; "N")
		$va_Theme:=ta_SIAO_PageTitre{9}  //"EVALUATION REALISEE PAR LE PROFESSIONNEL" F_SIAO_Var_SsBS
		If ($vb_OkMessage)
			i_MessageSeul("SIAO : tranfert en cours : Personnes 12/10")
		End if 
		P_SIAO_TransSituation($h_RefDoc; $2; 4; ta_SIAO_PageTitre{9}; "A")
		P_SIAO_TransSituation($h_RefDoc; $2; 1; ta_SIAO_PageTitre{9}; "B")
		P_SIAO_TransSituation($h_RefDoc; $2; 1; ta_SIAO_PageTitre{9}; "C")
		P_SIAO_TransSituation($h_RefDoc; $2; 1; ta_SIAO_PageTitre{9}; "N")
		$va_Theme:=ta_SIAO_PageTitre{10}  //"PRECONISATION DU PROFESSIONNEL" F_SIAO_Var_SsPR
		If ($vb_OkMessage)
			i_MessageSeul("SIAO : tranfert en cours : Personnes 12/11")
		End if 
		P_SIAO_TransSituation($h_RefDoc; $2; 4; ta_SIAO_PageTitre{10}; "A")
		P_SIAO_TransSituation($h_RefDoc; $2; 2; ta_SIAO_PageTitre{10}; "B")
		P_SIAO_TransSituation($h_RefDoc; $2; 3; ta_SIAO_PageTitre{10}; "C")
		P_SIAO_TransSituation($h_RefDoc; $2; 2; ta_SIAO_PageTitre{10}; "N")
		//$va_Theme:=ta_SIAO_PageTitre{11}  `"PRECONISATION DU PROFESSIONNELSUITE"
		$va_Theme:=ta_SIAO_PageTitre{12}  //"PROPOSITIONS" F_SIAO_Var_SsPP
		If ($vb_OkMessage)
			i_MessageSeul("SIAO : tranfert en cours : Personnes 12/12")
		End if 
		P_SIAO_TransSituation($h_RefDoc; $2; 1; ta_SIAO_PageTitre{12}; "A")
		P_SIAO_TransSituation($h_RefDoc; $2; 3; ta_SIAO_PageTitre{12}; "B")
		P_SIAO_TransSituation($h_RefDoc; $2; 3; ta_SIAO_PageTitre{12}; "C")
	End if 
	
	If ($vb_OkMessage)
		CLOSE WINDOW:C154
	End if 
End if 

If ($vb_OK)
	//•(5) •••• fermeture du fichier sur disque  
	$vt_Block:="SSPFINEXPORTSSPSIAO"+<>va_CR
	If ($2)
		SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Block))
	Else 
		SEND PACKET:C103($h_RefDoc; $vt_Block)
	End if 
	
	
	$0:=True:C214
	
	CLOSE DOCUMENT:C267($h_RefDoc)
End if 
USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
