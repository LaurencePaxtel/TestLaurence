//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_Report_FullDuplexDonnées
//{
//{          Vendrdi 31 octobre 2008 à 11:36
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
C_TIME:C306($1)  //RéfDoc
C_DATE:C307($2)
C_TIME:C306($3)
C_LONGINT:C283($4)  //Trans STR : Par défaut on s'appuie sur la STR de ASILE
C_BOOLEAN:C305($5)  //Vrai=Windows

C_LONGINT:C283($vl_TransSTR)
C_TEXT:C284($va_Temp)
$vl_TransSTR:=$4
If ($vl_TransSTR#8)
	$vl_TransSTR:=8
End if 
$va_Temp:=""

If ($5)
	
	
	SEND PACKET:C103($1; _O_Mac to Win:C463("Infos : "+<>va_Tab+<>va_T_Site+", Le "+String:C10($2; Interne date court:K1:7)+" à "+String:C10($3; h mn s:K7:1)+<>va_Tab+"0"+<>va_Tab+"0")+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Etat civil : "+<>va_Tab+[HeberGement:5]HG_EtatCivil:20+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_EtatCivil:20)))+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Date"+<>va_Tab+String:C10([HeberGement:5]HG_Date:4; Interne date court:K1:7)+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Date:4)))+<>va_CR)
	
	vt_Full_HB_Notes:=""
	va_FullHB_Clé:=""
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
	MultiSoc_Filter(->[HeBerge:4])
	vt_Full_HB_Notes:=[HeBerge:4]HB_NotesTrans:53
	va_FullHB_Clé:=[HeBerge:4]HB_Clé:2
	vt_Full_HB_Notes:=Replace string:C233(vt_Full_HB_Notes; "≤"; "-")
	vt_Full_HB_Notes:=Replace string:C233(vt_Full_HB_Notes; Char:C90(13); "≤")
	
	SEND PACKET:C103($1; _O_Mac to Win:C463("Fiche n°"+<>va_Tab+[HeberGement:5]HG_FicheNuméro:3+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_FicheNuméro:3))))
	SEND PACKET:C103($1; <>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Clé"+<>va_Tab+va_FullHB_Clé+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_HB_ID:19))))
	SEND PACKET:C103($1; <>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Nom"+<>va_Tab+[HeBerge:4]HB_Nom:3+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Nom:21))))
	SEND PACKET:C103($1; <>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Prénom"+<>va_Tab+[HeBerge:4]HB_Prénom:4+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Prénom:22))))
	SEND PACKET:C103($1; <>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Né(e) le"+<>va_Tab+String:C10([HeBerge:4]HB_DateNéLe:5; Interne date court:K1:7)+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_DateNéLe:24))))
	SEND PACKET:C103($1; <>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Age"+<>va_Tab+String:C10([HeberGement:5]HG_Age:23; "000")+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Age:23))))
	SEND PACKET:C103($1; <>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Nuit en cours"+<>va_Tab+String:C10([HeberGement:5]HG_NuitenCours:92)+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_NuitenCours:92))))
	SEND PACKET:C103($1; <>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Nuits totales"+<>va_Tab+String:C10([HeberGement:5]HG_NuitTOTAL:93)+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_NuitTOTAL:93))))
	SEND PACKET:C103($1; <>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Notes de transfert"+<>va_Tab+vt_Full_HB_Notes+<>va_Tab+String:C10(Table:C252(->[HeBerge:4]))+<>va_Tab+String:C10(Field:C253(->[HeBerge:4]HB_NotesTrans:53))))
	SEND PACKET:C103($1; <>va_CR)
	
	SEND PACKET:C103($1; _O_Mac to Win:C463("Référence Hébergement"+<>va_Tab+String:C10([HeberGement:5]HG_ReferenceID:1)+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_ReferenceID:1)))+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Référence Hébergé"+<>va_Tab+String:C10([HeberGement:5]HG_HB_ID:19)+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_HB_ID:19)))+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Référence Centre"+<>va_Tab+String:C10([HeberGement:5]HG_LC_ID:61)+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_LC_ID:61)))+<>va_CR)
	
	
	va_LC_Nom:=Replace string:C233(va_LC_Nom; Char:C90(10); "")
	va_LC_Nom:=Replace string:C233(va_LC_Nom; Char:C90(13); "")
	SEND PACKET:C103($1; _O_Mac to Win:C463("Trans Centre Nom"+<>va_Tab+va_LC_Nom+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Nom:4)))+<>va_CR)
	va_LC_Ad1:=Replace string:C233(va_LC_Ad1; Char:C90(10); "")
	va_LC_Ad1:=Replace string:C233(va_LC_Ad1; Char:C90(13); "")
	SEND PACKET:C103($1; _O_Mac to Win:C463("Trans Centre Adr1"+<>va_Tab+va_LC_Ad1+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Adr1:24)))+<>va_CR)
	va_LC_Ad2:=Replace string:C233(va_LC_Ad2; Char:C90(10); "")
	va_LC_Ad2:=Replace string:C233(va_LC_Ad2; Char:C90(13); "")
	SEND PACKET:C103($1; _O_Mac to Win:C463("Trans Centre Adr2"+<>va_Tab+va_LC_Ad2+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Adr2:25)))+<>va_CR)
	va_LC_CP:=Replace string:C233(va_LC_CP; Char:C90(10); "")
	va_LC_CP:=Replace string:C233(va_LC_CP; Char:C90(13); "")
	SEND PACKET:C103($1; _O_Mac to Win:C463("Trans Centre CP"+<>va_Tab+va_LC_CP+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_CP:27)))+<>va_CR)
	va_LC_Ville:=Replace string:C233(va_LC_Ville; Char:C90(10); "")
	va_LC_Ville:=Replace string:C233(va_LC_Ville; Char:C90(13); "")
	SEND PACKET:C103($1; _O_Mac to Win:C463("Trans Centre Ville"+<>va_Tab+va_LC_Ville+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Ville:28)))+<>va_CR)
	va_LC_Tel:=Replace string:C233(va_LC_Tel; Char:C90(10); "")
	va_LC_Tel:=Replace string:C233(va_LC_Tel; Char:C90(13); "")
	SEND PACKET:C103($1; _O_Mac to Win:C463("Trans Centre Tel"+<>va_Tab+va_LC_Tel+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Télécopie1:30)))+<>va_CR)
	va_LC_Fax:=Replace string:C233(va_LC_Fax; Char:C90(10); "")
	va_LC_Fax:=Replace string:C233(va_LC_Fax; Char:C90(13); "")
	SEND PACKET:C103($1; _O_Mac to Win:C463("Trans Centre Fax"+<>va_Tab+va_LC_Fax+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Télécopie2:31)))+<>va_CR)
	va_LC_Pers:=Replace string:C233(va_LC_Pers; Char:C90(10); "")
	va_LC_Pers:=Replace string:C233(va_LC_Pers; Char:C90(13); "")
	SEND PACKET:C103($1; _O_Mac to Win:C463("Trans Centre Responsable"+<>va_Tab+va_LC_Pers+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Responsable:32)))+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Trans Centre Plateforme"+<>va_Tab+va_LC_Plateforme+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Plateforme:56)))+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Trans Centre Niveau"+<>va_Tab+String:C10(vl_LC_Niveau)+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Niveau:52)))+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Trans Centre Capacite"+<>va_Tab+String:C10(vl_LC_Capacité)+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Capacité:38)))+<>va_CR)
	va_LC_Dossier:=Replace string:C233(va_LC_Dossier; Char:C90(10); "")
	va_LC_Dossier:=Replace string:C233(va_LC_Dossier; Char:C90(13); "")
	SEND PACKET:C103($1; _O_Mac to Win:C463("Trans Centre Repertoire"+<>va_Tab+va_LC_Dossier+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Répertoire:54)))+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Trans Centre Trans"+<>va_Tab+String:C10(vl_LC_RéfTrans)+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Trans_RéférenceID:57)))+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Trans Fiche créée le"+<>va_Tab+String:C10([HeberGement:5]HG_DateCreationFiche:149; Interne date court:K1:7)+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_DateCreationFiche:149)))+<>va_CR)
	
	
	SEND PACKET:C103($1; _O_Mac to Win:C463("Trans DASS"+<>va_Tab+("O"*Num:C11([HeberGement:5]HG_Trans_DDASS:141))+("N"*Num:C11([HeberGement:5]HG_Trans_DDASS:141=False:C215))+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Trans_DDASS:141)))+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Trans Fiche n°"+<>va_Tab+[HeberGement:5]HG_Trans_FicheNuméro:143+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Trans_FicheNuméro:143)))+<>va_CR)
	[HeberGement:5]HG_Trans_CentreNom:146:=Replace string:C233([HeberGement:5]HG_Trans_CentreNom:146; Char:C90(10); "")
	[HeberGement:5]HG_Trans_CentreNom:146:=Replace string:C233([HeberGement:5]HG_Trans_CentreNom:146; Char:C90(13); "")
	SEND PACKET:C103($1; _O_Mac to Win:C463("Trans Centre Nom"+<>va_Tab+[HeberGement:5]HG_Trans_CentreNom:146+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Trans_CentreNom:146)))+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Trans FamClé"+<>va_Tab+[HeberGement:5]HG_Trans_FamClé:147+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Trans_FamClé:147)))+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Trans Plateforme"+<>va_Tab+[HeberGement:5]HG_Trans_Plateforme:148+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Trans_Plateforme:148)))+<>va_CR)
	
	
	SEND PACKET:C103($1; _O_Mac to Win:C463("Champ Signalement"+<>va_Tab+[HeberGement:5]HG_Signalement:12+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Signalement:12)))+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Champ Orientation 1"+[HeberGement:5]HG_Orientation1:58+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Orientation1:58)))+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Champ Orientation 2"+[HeberGement:5]HG_Orientation2:60+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Orientation2:60)))+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Champ Autre solution"+[HeberGement:5]HG_AutreSolutio:88+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_AutreSolutio:88)))+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Champ Plateforme"+[HeberGement:5]HG_Plateforme:139+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Plateforme:139)))+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Famille Groupe"+[HeberGement:5]HG_FamGroupe:102+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_FamGroupe:102)))+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Famille Chef"+<>va_Tab+("O"*Num:C11([HeberGement:5]HG_FamChef:103))+("N"*Num:C11([HeberGement:5]HG_FamChef:103=False:C215))+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_FamChef:103)))+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Famille Clé de lien"+[HeberGement:5]HG_FamClé:104+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_FamClé:104)))+<>va_CR)
	SEND PACKET:C103($1; _O_Mac to Win:C463("Famille Composition"+[HeberGement:5]HG_FamCompoVar:117+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_FamCompoVar:117)))+<>va_CR)
	
	$ii:=0
	$vl_TransChamp:=Size of array:C274(<>te_RdsRub{$vl_TransSTR})
	Repeat 
		$ii:=$ii+1
		If (<>te_RdsRub{$vl_TransSTR}{$ii}>0)
			If (<>tb_RdsTrans{$vl_TransSTR}{$ii})
				GET FIELD PROPERTIES:C258(Field:C253(<>te_RdsFic{$vl_TransSTR}{$ii}; <>te_RdsRub{$vl_TransSTR}{$ii}); ve_Type; vl_Long; vb_Index)
				$va_Temp:=""
				Case of 
					: (ve_Type=Est un champ alpha:K8:1)
						$va_Temp:=Field:C253(<>te_RdsFic{$vl_TransSTR}{$ii}; <>te_RdsRub{$vl_TransSTR}{$ii})->
						$va_Temp:=Replace string:C233($va_Temp; Char:C90(10); "")
						$va_Temp:=Replace string:C233($va_Temp; Char:C90(13); "")
					: (ve_Type=Est un texte:K8:3)
						$va_Temp:=""
					: (ve_Type=Est un numérique:K8:4)
						$va_Temp:=String:C10(Field:C253(<>te_RdsFic{$vl_TransSTR}{$ii}; <>te_RdsRub{$vl_TransSTR}{$ii})->)
					: (ve_Type=Est un entier:K8:5)
						$va_Temp:=String:C10(Field:C253(<>te_RdsFic{$vl_TransSTR}{$ii}; <>te_RdsRub{$vl_TransSTR}{$ii})->)
					: (ve_Type=Est un entier long:K8:6)
						$va_Temp:=String:C10(Field:C253(<>te_RdsFic{$vl_TransSTR}{$ii}; <>te_RdsRub{$vl_TransSTR}{$ii})->)
					: (ve_Type=Est une date:K8:7)
						$va_Temp:=String:C10(Field:C253(<>te_RdsFic{$vl_TransSTR}{$ii}; <>te_RdsRub{$vl_TransSTR}{$ii})->; Interne date court:K1:7)
					: (ve_Type=Est une heure:K8:8)
						$va_Temp:=String:C10(Field:C253(<>te_RdsFic{$vl_TransSTR}{$ii}; <>te_RdsRub{$vl_TransSTR}{$ii})->; h mn s:K7:1)
					: (ve_Type=Est un booléen:K8:9)
						$va_Temp:=("O"*Num:C11(Field:C253(<>te_RdsFic{$vl_TransSTR}{$ii}; <>te_RdsRub{$vl_TransSTR}{$ii})->))
						$va_Temp:=$va_Temp+("N"*Num:C11(Field:C253(<>te_RdsFic{$vl_TransSTR}{$ii}; <>te_RdsRub{$vl_TransSTR}{$ii})->=False:C215))
					: (ve_Type=Est une image:K8:10)
						$va_Temp:=""
					: (ve_Type=Est une sous table:K8:11)
						$va_Temp:=""
					: (ve_Type=Est un BLOB:K8:12)
						$va_Temp:=""
				End case 
				SEND PACKET:C103($1; _O_Mac to Win:C463(<>ta_RdsNomNew{$vl_TransSTR}{$ii}+<>va_Tab+$va_Temp+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(<>te_RdsRub{$vl_TransSTR}{$ii}))+<>va_CR)
				
				
			End if 
		End if 
	Until ($vl_TransChamp=$ii)
	
Else 
	SEND PACKET:C103($1; "Infos : "+<>va_Tab+<>va_T_Site+", Le "+String:C10($2; Interne date court:K1:7)+" à "+String:C10($3; h mn s:K7:1)+<>va_Tab+"0"+<>va_Tab+"0"+<>va_CR)
	SEND PACKET:C103($1; "Etat civil : "+<>va_Tab+[HeberGement:5]HG_EtatCivil:20+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_EtatCivil:20))+<>va_CR)
	SEND PACKET:C103($1; "Date"+<>va_Tab+String:C10([HeberGement:5]HG_Date:4; Interne date court:K1:7)+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Date:4))+<>va_CR)
	
	vt_Full_HB_Notes:=""
	va_FullHB_Clé:=""
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
	MultiSoc_Filter(->[HeBerge:4])
	vt_Full_HB_Notes:=[HeBerge:4]HB_NotesTrans:53
	va_FullHB_Clé:=[HeBerge:4]HB_Clé:2
	vt_Full_HB_Notes:=Replace string:C233(vt_Full_HB_Notes; "≤"; "-")
	vt_Full_HB_Notes:=Replace string:C233(vt_Full_HB_Notes; Char:C90(13); "≤")
	
	SEND PACKET:C103($1; "Fiche n°"+<>va_Tab+[HeberGement:5]HG_FicheNuméro:3+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_FicheNuméro:3)))
	SEND PACKET:C103($1; <>va_CR)
	SEND PACKET:C103($1; "Clé"+<>va_Tab+va_FullHB_Clé+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_HB_ID:19)))
	SEND PACKET:C103($1; <>va_CR)
	SEND PACKET:C103($1; "Nom"+<>va_Tab+[HeBerge:4]HB_Nom:3+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Nom:21)))
	SEND PACKET:C103($1; <>va_CR)
	SEND PACKET:C103($1; "Prénom"+<>va_Tab+[HeBerge:4]HB_Prénom:4+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Prénom:22)))
	SEND PACKET:C103($1; <>va_CR)
	SEND PACKET:C103($1; "Né(e) le"+<>va_Tab+String:C10([HeBerge:4]HB_DateNéLe:5; Interne date court:K1:7)+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_DateNéLe:24)))
	SEND PACKET:C103($1; <>va_CR)
	SEND PACKET:C103($1; "Age"+<>va_Tab+String:C10([HeberGement:5]HG_Age:23; "000")+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Age:23)))
	SEND PACKET:C103($1; <>va_CR)
	SEND PACKET:C103($1; "Nuit en cours"+<>va_Tab+String:C10([HeberGement:5]HG_NuitenCours:92)+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_NuitenCours:92)))
	SEND PACKET:C103($1; <>va_CR)
	SEND PACKET:C103($1; "Nuits totales"+<>va_Tab+String:C10([HeberGement:5]HG_NuitTOTAL:93)+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_NuitTOTAL:93)))
	SEND PACKET:C103($1; <>va_CR)
	SEND PACKET:C103($1; "Notes de transfert"+<>va_Tab+vt_Full_HB_Notes+<>va_Tab+String:C10(Table:C252(->[HeBerge:4]))+<>va_Tab+String:C10(Field:C253(->[HeBerge:4]HB_NotesTrans:53)))
	SEND PACKET:C103($1; <>va_CR)
	
	SEND PACKET:C103($1; "Référence Hébergement"+<>va_Tab+String:C10([HeberGement:5]HG_ReferenceID:1)+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_ReferenceID:1))+<>va_CR)
	SEND PACKET:C103($1; "Référence Hébergé"+<>va_Tab+String:C10([HeberGement:5]HG_HB_ID:19)+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_HB_ID:19))+<>va_CR)
	SEND PACKET:C103($1; "Référence Centre"+<>va_Tab+String:C10([HeberGement:5]HG_LC_ID:61)+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_LC_ID:61))+<>va_CR)
	
	
	va_LC_Nom:=Replace string:C233(va_LC_Nom; Char:C90(10); "")
	va_LC_Nom:=Replace string:C233(va_LC_Nom; Char:C90(13); "")
	SEND PACKET:C103($1; "Trans Centre Nom"+<>va_Tab+va_LC_Nom+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Nom:4))+<>va_CR)
	va_LC_Ad1:=Replace string:C233(va_LC_Ad1; Char:C90(10); "")
	va_LC_Ad1:=Replace string:C233(va_LC_Ad1; Char:C90(13); "")
	SEND PACKET:C103($1; "Trans Centre Adr1"+<>va_Tab+va_LC_Ad1+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Adr1:24))+<>va_CR)
	va_LC_Ad2:=Replace string:C233(va_LC_Ad2; Char:C90(10); "")
	va_LC_Ad2:=Replace string:C233(va_LC_Ad2; Char:C90(13); "")
	SEND PACKET:C103($1; "Trans Centre Adr2"+<>va_Tab+va_LC_Ad2+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Adr2:25))+<>va_CR)
	va_LC_CP:=Replace string:C233(va_LC_CP; Char:C90(10); "")
	va_LC_CP:=Replace string:C233(va_LC_CP; Char:C90(13); "")
	SEND PACKET:C103($1; "Trans Centre CP"+<>va_Tab+va_LC_CP+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_CP:27))+<>va_CR)
	va_LC_Ville:=Replace string:C233(va_LC_Ville; Char:C90(10); "")
	va_LC_Ville:=Replace string:C233(va_LC_Ville; Char:C90(13); "")
	SEND PACKET:C103($1; "Trans Centre Ville"+<>va_Tab+va_LC_Ville+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Ville:28))+<>va_CR)
	va_LC_Tel:=Replace string:C233(va_LC_Tel; Char:C90(10); "")
	va_LC_Tel:=Replace string:C233(va_LC_Tel; Char:C90(13); "")
	SEND PACKET:C103($1; "Trans Centre Tel"+<>va_Tab+va_LC_Tel+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Télécopie1:30))+<>va_CR)
	va_LC_Fax:=Replace string:C233(va_LC_Fax; Char:C90(10); "")
	va_LC_Fax:=Replace string:C233(va_LC_Fax; Char:C90(13); "")
	SEND PACKET:C103($1; "Trans Centre Fax"+<>va_Tab+va_LC_Fax+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Télécopie2:31))+<>va_CR)
	va_LC_Pers:=Replace string:C233(va_LC_Pers; Char:C90(10); "")
	va_LC_Pers:=Replace string:C233(va_LC_Pers; Char:C90(13); "")
	SEND PACKET:C103($1; "Trans Centre Responsable"+<>va_Tab+va_LC_Pers+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Responsable:32))+<>va_CR)
	SEND PACKET:C103($1; "Trans Centre Plateforme"+<>va_Tab+va_LC_Plateforme+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Plateforme:56))+<>va_CR)
	SEND PACKET:C103($1; "Trans Centre Niveau"+<>va_Tab+String:C10(vl_LC_Niveau)+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Niveau:52))+<>va_CR)
	SEND PACKET:C103($1; "Trans Centre Capacite"+<>va_Tab+String:C10(vl_LC_Capacité)+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Capacité:38))+<>va_CR)
	va_LC_Dossier:=Replace string:C233(va_LC_Dossier; Char:C90(10); "")
	va_LC_Dossier:=Replace string:C233(va_LC_Dossier; Char:C90(13); "")
	SEND PACKET:C103($1; "Trans Centre Repertoire"+<>va_Tab+va_LC_Dossier+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Répertoire:54))+<>va_CR)
	SEND PACKET:C103($1; "Trans Centre Trans"+<>va_Tab+String:C10(vl_LC_RéfTrans)+<>va_Tab+String:C10(Table:C252(->[LesCentres:9]))+<>va_Tab+String:C10(Field:C253(->[LesCentres:9]LC_Trans_RéférenceID:57))+<>va_CR)
	SEND PACKET:C103($1; "Trans Fiche créée le"+<>va_Tab+String:C10([HeberGement:5]HG_DateCreationFiche:149; Interne date court:K1:7)+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_DateCreationFiche:149))+<>va_CR)
	
	
	SEND PACKET:C103($1; "Trans DASS"+<>va_Tab+("O"*Num:C11([HeberGement:5]HG_Trans_DDASS:141))+("N"*Num:C11([HeberGement:5]HG_Trans_DDASS:141=False:C215))+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Trans_DDASS:141))+<>va_CR)
	SEND PACKET:C103($1; "Trans Fiche n°"+<>va_Tab+[HeberGement:5]HG_Trans_FicheNuméro:143+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Trans_FicheNuméro:143))+<>va_CR)
	[HeberGement:5]HG_Trans_CentreNom:146:=Replace string:C233([HeberGement:5]HG_Trans_CentreNom:146; Char:C90(10); "")
	[HeberGement:5]HG_Trans_CentreNom:146:=Replace string:C233([HeberGement:5]HG_Trans_CentreNom:146; Char:C90(13); "")
	SEND PACKET:C103($1; "Trans Centre Nom"+<>va_Tab+[HeberGement:5]HG_Trans_CentreNom:146+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Trans_CentreNom:146))+<>va_CR)
	SEND PACKET:C103($1; "Trans FamClé"+<>va_Tab+[HeberGement:5]HG_Trans_FamClé:147+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Trans_FamClé:147))+<>va_CR)
	SEND PACKET:C103($1; "Trans Plateforme"+<>va_Tab+[HeberGement:5]HG_Trans_Plateforme:148+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Trans_Plateforme:148))+<>va_CR)
	
	
	SEND PACKET:C103($1; "Champ Signalement"+<>va_Tab+[HeberGement:5]HG_Signalement:12+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Signalement:12))+<>va_CR)
	SEND PACKET:C103($1; "Champ Orientation 1"+[HeberGement:5]HG_Orientation1:58+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Orientation1:58))+<>va_CR)
	SEND PACKET:C103($1; "Champ Orientation 2"+[HeberGement:5]HG_Orientation2:60+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Orientation2:60))+<>va_CR)
	SEND PACKET:C103($1; "Champ Autre solution"+[HeberGement:5]HG_AutreSolutio:88+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_AutreSolutio:88))+<>va_CR)
	SEND PACKET:C103($1; "Champ Plateforme"+[HeberGement:5]HG_Plateforme:139+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_Plateforme:139))+<>va_CR)
	SEND PACKET:C103($1; "Famille Groupe"+[HeberGement:5]HG_FamGroupe:102+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_FamGroupe:102))+<>va_CR)
	SEND PACKET:C103($1; "Famille Chef"+<>va_Tab+("O"*Num:C11([HeberGement:5]HG_FamChef:103))+("N"*Num:C11([HeberGement:5]HG_FamChef:103=False:C215))+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_FamChef:103))+<>va_CR)
	SEND PACKET:C103($1; "Famille Clé de lien"+[HeberGement:5]HG_FamClé:104+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_FamClé:104))+<>va_CR)
	SEND PACKET:C103($1; "Famille Composition"+[HeberGement:5]HG_FamCompoVar:117+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(Field:C253(->[HeberGement:5]HG_FamCompoVar:117))+<>va_CR)
	
	$ii:=0
	$vl_TransChamp:=Size of array:C274(<>te_RdsRub{$vl_TransSTR})
	Repeat 
		$ii:=$ii+1
		If (<>te_RdsRub{$vl_TransSTR}{$ii}>0)
			If (<>tb_RdsTrans{$vl_TransSTR}{$ii})
				GET FIELD PROPERTIES:C258(Field:C253(<>te_RdsFic{$vl_TransSTR}{$ii}; <>te_RdsRub{$vl_TransSTR}{$ii}); ve_Type; vl_Long; vb_Index)
				$va_Temp:=""
				Case of 
					: (ve_Type=Est un champ alpha:K8:1)
						$va_Temp:=Field:C253(<>te_RdsFic{$vl_TransSTR}{$ii}; <>te_RdsRub{$vl_TransSTR}{$ii})->
						$va_Temp:=Replace string:C233($va_Temp; Char:C90(10); "")
						$va_Temp:=Replace string:C233($va_Temp; Char:C90(13); "")
					: (ve_Type=Est un texte:K8:3)
						$va_Temp:=""
					: (ve_Type=Est un numérique:K8:4)
						$va_Temp:=String:C10(Field:C253(<>te_RdsFic{$vl_TransSTR}{$ii}; <>te_RdsRub{$vl_TransSTR}{$ii})->)
					: (ve_Type=Est un entier:K8:5)
						$va_Temp:=String:C10(Field:C253(<>te_RdsFic{$vl_TransSTR}{$ii}; <>te_RdsRub{$vl_TransSTR}{$ii})->)
					: (ve_Type=Est un entier long:K8:6)
						$va_Temp:=String:C10(Field:C253(<>te_RdsFic{$vl_TransSTR}{$ii}; <>te_RdsRub{$vl_TransSTR}{$ii})->)
					: (ve_Type=Est une date:K8:7)
						$va_Temp:=String:C10(Field:C253(<>te_RdsFic{$vl_TransSTR}{$ii}; <>te_RdsRub{$vl_TransSTR}{$ii})->; Interne date court:K1:7)
					: (ve_Type=Est une heure:K8:8)
						$va_Temp:=String:C10(Field:C253(<>te_RdsFic{$vl_TransSTR}{$ii}; <>te_RdsRub{$vl_TransSTR}{$ii})->; h mn s:K7:1)
					: (ve_Type=Est un booléen:K8:9)
						$va_Temp:=("O"*Num:C11(Field:C253(<>te_RdsFic{$vl_TransSTR}{$ii}; <>te_RdsRub{$vl_TransSTR}{$ii})->))
						$va_Temp:=$va_Temp+("N"*Num:C11(Field:C253(<>te_RdsFic{$vl_TransSTR}{$ii}; <>te_RdsRub{$vl_TransSTR}{$ii})->=False:C215))
					: (ve_Type=Est une image:K8:10)
						$va_Temp:=""
					: (ve_Type=Est une sous table:K8:11)
						$va_Temp:=""
					: (ve_Type=Est un BLOB:K8:12)
						$va_Temp:=""
				End case 
				SEND PACKET:C103($1; <>ta_RdsNomNew{$vl_TransSTR}{$ii}+<>va_Tab+$va_Temp+<>va_Tab+String:C10(Table:C252(->[HeberGement:5]))+<>va_Tab+String:C10(<>te_RdsRub{$vl_TransSTR}{$ii})+<>va_CR)
				
				
			End if 
		End if 
	Until ($vl_TransChamp=$ii)
	
End if 
SEND PACKET:C103($1; "SSPFINEXPORTSSP"+<>va_CR)

$0:=True:C214