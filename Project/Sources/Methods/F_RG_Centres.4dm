//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_RG_Centres
//{
//{          Jeudi 13 mai 2010 à 16:20
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_TEXT:C284($va_Table)
C_LONGINT:C283($vlSTR_Std)

Case of 
	: ($1=1)
		
		$va_Table:=String:C10(Table:C252(->[LesCentres:9]))
		
		<>vt_TexteRegional_LC:=Table name:C256(->[LesCentres:9])+<>va_TAB+"Centre"+$va_Table+<>va_Tab+"-1"
		<>vt_TexteRegional_LC:=<>vt_TexteRegional_LC+<>va_CR+Substring:C12(Field name:C257(->[LesCentres:9]LC_RéférenceID:1); 4)+<>va_TAB+String:C10([LesCentres:9]LC_RéférenceID:1)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[LesCentres:9]LC_RéférenceID:1))
		<>vt_TexteRegional_LC:=<>vt_TexteRegional_LC+<>va_CR+Substring:C12(Field name:C257(->[LesCentres:9]LC_Type:2); 4)+<>va_TAB+[LesCentres:9]LC_Type:2+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[LesCentres:9]LC_Type:2))
		<>vt_TexteRegional_LC:=<>vt_TexteRegional_LC+<>va_CR+Substring:C12(Field name:C257(->[LesCentres:9]LC_Code:3); 4)+<>va_TAB+[LesCentres:9]LC_Code:3+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[LesCentres:9]LC_Code:3))
		<>vt_TexteRegional_LC:=<>vt_TexteRegional_LC+<>va_CR+Substring:C12(Field name:C257(->[LesCentres:9]LC_Nom:4); 4)+<>va_TAB+[LesCentres:9]LC_Nom:4+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[LesCentres:9]LC_Nom:4))
		<>vt_TexteRegional_LC:=<>vt_TexteRegional_LC+<>va_CR+Substring:C12(Field name:C257(->[LesCentres:9]LC_Lieu:5); 4)+<>va_TAB+[LesCentres:9]LC_Lieu:5+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[LesCentres:9]LC_Lieu:5))
		
		<>vt_TexteRegional_LC:=<>vt_TexteRegional_LC+<>va_CR+Substring:C12(Field name:C257(->[LesCentres:9]LC_Adr1:24); 4)+<>va_TAB+[LesCentres:9]LC_Adr1:24+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[LesCentres:9]LC_Adr1:24))
		<>vt_TexteRegional_LC:=<>vt_TexteRegional_LC+<>va_CR+Substring:C12(Field name:C257(->[LesCentres:9]LC_Adr2:25); 4)+<>va_TAB+[LesCentres:9]LC_Adr2:25+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[LesCentres:9]LC_Adr2:25))
		<>vt_TexteRegional_LC:=<>vt_TexteRegional_LC+<>va_CR+Substring:C12(Field name:C257(->[LesCentres:9]LC_Adr3:26); 4)+<>va_TAB+[LesCentres:9]LC_Adr3:26+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[LesCentres:9]LC_Adr3:26))
		<>vt_TexteRegional_LC:=<>vt_TexteRegional_LC+<>va_CR+Substring:C12(Field name:C257(->[LesCentres:9]LC_CP:27); 4)+<>va_TAB+[LesCentres:9]LC_CP:27+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[LesCentres:9]LC_CP:27))
		<>vt_TexteRegional_LC:=<>vt_TexteRegional_LC+<>va_CR+Substring:C12(Field name:C257(->[LesCentres:9]LC_Ville:28); 4)+<>va_TAB+[LesCentres:9]LC_Ville:28+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[LesCentres:9]LC_Ville:28))
		<>vt_TexteRegional_LC:=<>vt_TexteRegional_LC+<>va_CR+Substring:C12(Field name:C257(->[LesCentres:9]LC_Téléphone:29); 4)+<>va_TAB+[LesCentres:9]LC_Téléphone:29+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[LesCentres:9]LC_Téléphone:29))
		<>vt_TexteRegional_LC:=<>vt_TexteRegional_LC+<>va_CR+Substring:C12(Field name:C257(->[LesCentres:9]LC_Télécopie1:30); 4)+<>va_TAB+[LesCentres:9]LC_Télécopie1:30+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[LesCentres:9]LC_Télécopie1:30))
		<>vt_TexteRegional_LC:=<>vt_TexteRegional_LC+<>va_CR+Substring:C12(Field name:C257(->[LesCentres:9]LC_Télécopie2:31); 4)+<>va_TAB+[LesCentres:9]LC_Télécopie2:31+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[LesCentres:9]LC_Télécopie2:31))
		
		<>vt_TexteRegional_LC:=<>vt_TexteRegional_LC+<>va_CR+Substring:C12(Field name:C257(->va_LC_Repertoire); 4)+<>va_TAB+va_LC_Repertoire+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->va_LC_Repertoire))
		<>vt_TexteRegional_LC:=<>vt_TexteRegional_LC+<>va_CR+Substring:C12(Field name:C257(->[LesCentres:9]LC_Plateforme:56); 4)+<>va_TAB+[LesCentres:9]LC_Plateforme:56+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[LesCentres:9]LC_Plateforme:56))
		<>vt_TexteRegional_LC:=<>vt_TexteRegional_LC+<>va_CR+Substring:C12(Field name:C257(->[LesCentres:9]LC_Niveau:52); 4)+<>va_TAB+String:C10([LesCentres:9]LC_Niveau:52)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[LesCentres:9]LC_Niveau:52))
		<>vt_TexteRegional_LC:=<>vt_TexteRegional_LC+<>va_CR+Substring:C12(Field name:C257(->[LesCentres:9]LC_DispoJour:48); 4)+<>va_TAB+String:C10([LesCentres:9]LC_DispoJour:48)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[LesCentres:9]LC_DispoJour:48))
		
		va_LC_Specialites:=String:C10(Num:C11([LesCentres:9]LC_H:6))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_F:7))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_M:8))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_E:9))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_FA:10))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_16à24:11))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_18à25:12))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_18à40:13))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_28etPlus:14))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_18à55:15))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_Toxico:16))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_Prostitué:17))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_Violent:18))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_Prison:19))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_TraitPsy:20))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_Irrégulier:21))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_Alcool:45))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_HIV:46))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_LitMédicalis:47))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_Mod_Fax_Tel:42))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_Excuse:49))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_Fermé:53))
		va_LC_Specialites:=va_LC_Specialites+String:C10(Num:C11([LesCentres:9]LC_Prestation:55))
		
		<>vt_TexteRegional_LC:=<>vt_TexteRegional_LC+<>va_CR+"Specialites"+<>va_TAB+va_LC_Specialites+<>va_TAB+$va_Table+<>va_TAB+"0"
		
		
	: ($1=2)
		$va_Table:=String:C10(Table:C252(->[HeBerge:4]))
		<>vt_TexteRegional_HB:=Table name:C256(->[HeBerge:4])+<>va_TAB+"Personne"+$va_Table+<>va_Tab+"-1"
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_ReferenceID:1); 4)+<>va_TAB+String:C10([HeBerge:4]HB_ReferenceID:1)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_Clé:2))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_Clé:2); 4)+<>va_TAB+[HeBerge:4]HB_Clé:2+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_Clé:2))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_Nom:3); 4)+<>va_TAB+[HeBerge:4]HB_Nom:3+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_Nom:3))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_Prénom:4); 4)+<>va_TAB+[HeBerge:4]HB_Prénom:4+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_Prénom:4))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_DateNéLe:5); 4)+<>va_TAB+String:C10([HeBerge:4]HB_DateNéLe:5; Interne date court:K1:7)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_DateNéLe:5))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HG_Genre:39); 4)+<>va_TAB+String:C10(Num:C11([HeBerge:4]HG_Genre:39))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HG_Genre:39))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_CléFam:47); 4)+<>va_TAB+[HeBerge:4]HB_CléFam:47+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_CléFam:47))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_Status:18); 4)+<>va_TAB+String:C10(Num:C11([HeBerge:4]HB_Status:18))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_Status:18))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_PièceNéOu:57); 4)+<>va_TAB+[HeBerge:4]HB_PièceNéOu:57+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_PièceNéOu:57))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_PièceNationalité:58); 4)+<>va_TAB+[HeBerge:4]HB_PièceNationalité:58+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_PièceNationalité:58))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_PièceCNI:59); 4)+<>va_TAB+[HeBerge:4]HB_PièceCNI:59+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_PièceCNI:59))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_PiècePasseport:60); 4)+<>va_TAB+[HeBerge:4]HB_PiècePasseport:60+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeBerge:4]HB_PiècePasseport:60))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+""+<>va_TAB+""+<>va_TAB+$va_Table+<>va_TAB+"0"
		
		
	: ($1=3)
		$va_Table:=String:C10(Table:C252(->[HeberGement:5]))
		<>vt_TexteRegional_HB:=Table name:C256(->[HeberGement:5])+<>va_TAB+"Suivi"+$va_Table+<>va_Tab+"-1"
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeBerge:4]HB_ReferenceID:1); 4)+<>va_TAB+String:C10([HeberGement:5]HG_ReferenceID:1)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ReferenceID:1))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_Nuit:2); 4)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_Nuit:2))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Nuit:2))
		// <>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+"Fiche n°"+<>va_TAB+HéberGement]HG_FicheNuméro+<>va_TAB+$va_Table+<>va_TAB+String(Field(->[HeberGement]HG_FicheNuméro))  // #20180530-2
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_Date:4); 4)+<>va_TAB+String:C10([HeberGement:5]HG_Date:4; Interne date court:K1:7)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Date:4))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+Substring:C12(Field name:C257(->[HeberGement:5]HG_HeureAppel:5); 4)+<>va_TAB+String:C10([HeberGement:5]HG_HeureAppel:5; h mn s:K7:1)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_HeureAppel:5))
		//Identité
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_EtatCivil:20+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_EtatCivil:20))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+"HB"+<>va_TAB+String:C10([HeberGement:5]HG_HB_ID:19)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_HB_ID:19))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_Genre:96))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Genre:96))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Nom:21+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Nom:21))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Prénom:22+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Prénom:22))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_DateNéLe:24; Interne date court:K1:7)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_DateNéLe:24))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_Age:23)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Age:23))
		//Plateforme
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Plateforme:139+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Plateforme:139))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_Trans_DDASS:141))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Trans_DDASS:141))
		//Famille
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_FamGroupe:102+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamGroupe:102))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_FamChef:103))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamChef:103))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_FamClé:104+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamClé:104))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_FamCompo:105+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamCompo:105))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_FamNbPers:106)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamNbPers:106))
		//Réservation
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_Réservation:91))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Réservation:91))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_NuitenCours:92)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_NuitenCours:92))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_NuitTOTAL:93)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_NuitTOTAL:93))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_NuitReste:95)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_NuitReste:95))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_RéservationDateFin:134; Interne date court:K1:7)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_RéservationDateFin:134))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Reporté:94+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Reporté:94))
		//Excusé
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_ER_Excuse:124))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ER_Excuse:124))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_ER_DateDébut:125; Interne date court:K1:7)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ER_DateDébut:125))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_ER_DateFin:126; Interne date court:K1:7)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ER_DateFin:126))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_ER_NuitEnCours:127)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ER_NuitEnCours:127))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_ER_NuitTotal:128)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ER_NuitTotal:128))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_ER_NuitReste:129)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ER_NuitReste:129))
		//Remplaçant
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_ER_Remplaçant:130))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ER_Remplaçant:130))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_ER_RemplaceQuiRéf:131)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ER_RemplaceQuiRéf:131))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_ER_RemplaceQui:132+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_ER_RemplaceQui:132))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_GestionCentreNuit:133+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_GestionCentreNuit:133))
		//Centre
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+"LC"+<>va_TAB+String:C10([HeberGement:5]HG_LC_ID:61)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_LC_ID:61))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_CentreARR:63+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_CentreARR:63))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_Priorité:57)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Priorité:57))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_DispoSpé:90))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_DispoSpé:90))
		
		
		//Statut de la fiche
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_EnAttente:64))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_EnAttente:64))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_AttenteHeur:83; h mn s:K7:1)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_AttenteHeur:83))
		
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_Transmis:65))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Transmis:65))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_TransmisHeur:84; h mn s:K7:1)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_TransmisHeur:84))
		
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_PriseCharge:66))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_PriseCharge:66))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_PrChargeHeur:85; h mn s:K7:1)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_PrChargeHeur:85))
		
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_Cloturée:67))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Cloturée:67))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_CloturéeHeur:86; h mn s:K7:1)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_CloturéeHeur:86))
		
		//Champs
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_UtilisateurP:6+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_UtilisateurP:6))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Coordinateur:7+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Coordinateur:7))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Régulateur:8+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Régulateur:8))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Permanencier:9+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Permanencier:9))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_AssistSocial:87+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_AssistSocial:87))
		
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Maraude1_1:10+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Maraude1_1:10))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_DateEntree:186)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_DateEntree:186))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Maraude2_1:98+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Maraude2_1:98))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Maraude2_2:99+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Maraude2_2:99))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Maraude3_1:100+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Maraude3_1:100))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_DateSortie:185)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_DateSortie:185))
		
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Signalement:12+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Signalement:12))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_SignalCentre:13+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_SignalCentre:13))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_CodePostal:14+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_CodePostal:14))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Gare:15+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Gare:15))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Métro:16+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Métro:16))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Emplacement:17+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Emplacement:17))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Lien:18+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Lien:18))
		
		
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Nationalité:25+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Nationalité:25))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_SituFamille:29+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_SituFamille:29))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_TempsErrance:34+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_TempsErrance:34))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_DernierHéber:35+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_DernierHéber:35))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_SituProfess:36+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_SituProfess:36))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_DernierEmplo:37+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_DernierEmplo:37))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_DuréSanEmplo:38+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_DuréSanEmplo:38))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_NiveauEtude:43+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_NiveauEtude:43))
		
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_PiècesIdté1:31+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_PiècesIdté1:31))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_PiècesIdté2:32+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_PiècesIdté2:32))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_PiècesIdté3:33+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_PiècesIdté3:33))
		
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_RupMajeur1:40+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_RupMajeur1:40))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_RupMajeur1_2:72+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_RupMajeur1_2:72))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_RupMajeur2:41+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_RupMajeur2:41))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_RupMajeur2_2:73+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_RupMajeur2_2:73))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_RupMajeur3:42+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_RupMajeur3:42))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_RupMajeur3_2:74+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_RupMajeur3_2:74))
		
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Ressources1:45+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Ressources1:45))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Ressource1_2:75+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Ressource1_2:75))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Ressources2:46+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Ressources2:46))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Ressource2_2:76+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Ressource2_2:76))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Ressources3:47+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Ressources3:47))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Ressource3_2:77+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Ressource3_2:77))
		
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_SuiviSocial1:49+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_SuiviSocial1:49))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_SuiviSocial2:50+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_SuiviSocial2:50))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_SuiviSocial3:51+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_SuiviSocial3:51))
		
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_CouvSocial1:53+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_CouvSocial1:53))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_CouvSocial2:54+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_CouvSocial2:54))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_CouvSocial3:55+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_CouvSocial3:55))
		
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_Médicalisé:56))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Médicalisé:56))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10(Num:C11([HeberGement:5]HG_Status:89))+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Status:89))
		
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Orientation1:58+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Orientation1:58))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_Orientation1Suite:59+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_Orientation1Suite:59))
		
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_AutreSolutio:88+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_AutreSolutio:88))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+[HeberGement:5]HG_AutreSolSuite:123+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_AutreSolSuite:123))
		
		
		//Famille suite
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_FamNbJour:107)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamNbJour:107))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_FamNbChambre:108)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamNbChambre:108))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_FamPrixJour:109)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamTotal:110))
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_FamTotal:110)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamPrixJour:109))
		
		<>vt_TexteRegional_HB:=<>vt_TexteRegional_HB+<>va_CR+xliff_Txt_Get_Indexed_String_($vlSTR_Std; 40)+<>va_TAB+String:C10([HeberGement:5]HG_FamNoDeBon:136)+<>va_TAB+$va_Table+<>va_TAB+String:C10(Field:C253(->[HeberGement:5]HG_FamNoDeBon:136))
End case 