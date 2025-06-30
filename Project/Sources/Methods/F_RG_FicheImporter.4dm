//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_RG_FicheImporter
//{          Lundi 15 novembre 2010 à 15:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215
C_BOOLEAN:C305($vb_OK; $vb_Creer; $vb_Modifier)
C_LONGINT:C283($vl_Fiches)
$vb_Creer:=False:C215
$vb_Modifier:=False:C215
If (7=8)
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=ta_Conso_P_Valeur{2})
	MultiSoc_Filter(->[HeBerge:4])
	If (Records in selection:C76([HeBerge:4])=0)
		READ WRITE:C146([HeBerge:4])
		CREATE RECORD:C68([HeBerge:4])
		MultiSoc_Init_Structure(->[HeBerge:4])
		[HeBerge:4]HB_ReferenceID:1:=Uut_Numerote(->[HeBerge:4])
		[HeBerge:4]HB_Clé:2:=ta_Conso_P_Valeur{2}
		[HeBerge:4]HB_Nom:3:=ta_Conso_P_Valeur{3}
		[HeBerge:4]HB_Prénom:4:=ta_Conso_P_Valeur{4}
		[HeBerge:4]HB_DateNéLe:5:=Date:C102(ta_Conso_P_Valeur{5})
		[HeBerge:4]HG_Genre:39:=(ta_Conso_P_Valeur{6}="O")
		// [HéBergé]HB_CléFam:=
		[HeBerge:4]HB_Status:18:=(ta_Conso_P_Valeur{8}="O")
		
		[HeBerge:4]HB_PièceNéOu:57:=ta_Conso_P_Valeur{9}
		[HeBerge:4]HB_PièceNationalité:58:=ta_Conso_P_Valeur{10}
		[HeBerge:4]HB_PièceCNI:59:=ta_Conso_P_Valeur{11}
		[HeBerge:4]HB_PiècePasseport:60:=ta_Conso_P_Valeur{12}
		
		[HeBerge:4]HB_Trans_RéférenceID:55:=Num:C11(ta_Conso_P_Valeur{1})
		[HeBerge:4]HB_Trans_CléFam:56:=ta_Conso_P_Valeur{7}
		
		If (ta_Conso_H_Valeur{21}="O")
			[HeBerge:4]HB_CléFam:47:=ta_Conso_H_Valeur{22}
		End if 
		
		[HeBerge:4]HB_FicheCrééele:46:=vd_DateRéelle
		vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
		SAVE RECORD:C53([HeBerge:4])
		UNLOAD RECORD:C212([HeBerge:4])
		READ ONLY:C145([HeBerge:4])
	Else 
		vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
	End if 
Else 
	
	READ WRITE:C146([HeBerge:4])
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=ta_Conso_P_Valeur{2})
	MultiSoc_Filter(->[HeBerge:4])
	If (Records in selection:C76([HeBerge:4])=0)
		CREATE RECORD:C68([HeBerge:4])
		MultiSoc_Filter(->[HeBerge:4])
		[HeBerge:4]HB_ReferenceID:1:=Uut_Numerote(->[HeBerge:4])
		[HeBerge:4]HB_Clé:2:=ta_Conso_P_Valeur{2}
		[HeBerge:4]HB_Nom:3:=ta_Conso_P_Valeur{3}
		[HeBerge:4]HB_Prénom:4:=ta_Conso_P_Valeur{4}
		[HeBerge:4]HB_DateNéLe:5:=Date:C102(ta_Conso_P_Valeur{5})
		[HeBerge:4]HG_Genre:39:=(ta_Conso_P_Valeur{6}="O")
		// [HéBergé]HB_CléFam:=
		[HeBerge:4]HB_Status:18:=(ta_Conso_P_Valeur{8}="O")
		
		[HeBerge:4]HB_PièceNéOu:57:=ta_Conso_P_Valeur{9}
		[HeBerge:4]HB_PièceNationalité:58:=ta_Conso_P_Valeur{10}
		[HeBerge:4]HB_PièceCNI:59:=ta_Conso_P_Valeur{11}
		[HeBerge:4]HB_PiècePasseport:60:=ta_Conso_P_Valeur{12}
		
		[HeBerge:4]HB_Trans_RéférenceID:55:=Num:C11(ta_Conso_P_Valeur{1})
		[HeBerge:4]HB_Trans_CléFam:56:=ta_Conso_P_Valeur{7}
		
		If (ta_Conso_H_Valeur{21}="O")
			[HeBerge:4]HB_CléFam:47:=ta_Conso_H_Valeur{22}
		End if 
		
		
		[HeBerge:4]HB_FicheCrééele:46:=vd_DateRéelle
		
		SAVE RECORD:C53([HeBerge:4])
	Else 
		Repeat 
			IDLE:C311
			LOAD RECORD:C52([HeBerge:4])
		Until (Not:C34(Locked:C147([HeBerge:4])))
		//Pour les clés de lien famille  
		If (ta_Conso_H_Valeur{21}="O")
			If ([HeBerge:4]HB_CléFam:47=ta_Conso_H_Valeur{22})
			Else 
				[HeBerge:4]HB_Trans_CléFam:56:=[HeBerge:4]HB_CléFam:47
				[HeBerge:4]HB_CléFam:47:=ta_Conso_H_Valeur{22}
				SAVE RECORD:C53([HeBerge:4])
			End if 
		End if 
		
	End if 
	vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
	UNLOAD RECORD:C212([HeBerge:4])
	READ ONLY:C145([HeBerge:4])
	
End if 
READ WRITE:C146([HeberGement:5])
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=vl_RéfU_HBB; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4=Date:C102(ta_Conso_P_Valeur{5}); *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Regional_Departement:154=F_OutBlancFin(<>va_Conso_FicheSiteCode))
MultiSoc_Filter(->[HeberGement:5])
$vl_Fiches:=Records in selection:C76([HeberGement:5])
Case of 
	: ($vl_Fiches=0)
		$vb_Creer:=True:C214
	: ($vl_Fiches=1)
		$vb_Modifier:=True:C214
	: ($vl_Fiches>1)
		
End case 

If ($vb_Creer)
	CREATE RECORD:C68([HeberGement:5])
	MultiSoc_Init_Structure(->[HeberGement:5])
	[HeberGement:5]HG_DateCreationFiche:149:=vd_DateRéelle
	[HeberGement:5]HG_ReferenceID:1:=Uut_Numerote(->[HeberGement:5])
	[HeberGement:5]HG_Nuit:2:=(ta_Conso_H_Valeur{2}="1")
	[HeberGement:5]HG_Date:4:=Date:C102(ta_Conso_H_Valeur{5})
	[HeberGement:5]HG_FicheNuméro:3:=i_HébérgementNoFiche("J"; [HeberGement:5]HG_Date:4; Uut_Numerote115([HeberGement:5]HG_Date:4))
	[HeberGement:5]HG_HB_ID:19:=vl_RéfU_HBB
	$vb_OK:=True:C214
End if 
If ($vb_Creer | $vb_Modifier)
	[HeberGement:5]HG_EtatCivil:20:=ta_Conso_H_Valeur{11}
	//  [HéberGement]HG_HB_ID:=vl_RéfU_HBB
	[HeberGement:5]HG_Genre:96:=(ta_Conso_H_Valeur{13}="O")
	[HeberGement:5]HG_Nom:21:=ta_Conso_H_Valeur{14}
	[HeberGement:5]HG_Prénom:22:=ta_Conso_H_Valeur{15}
	[HeberGement:5]HG_DateNéLe:24:=Date:C102(ta_Conso_H_Valeur{16})
	[HeberGement:5]HG_Age:23:=Num:C11(ta_Conso_H_Valeur{17})
	
	[HeberGement:5]HG_Plateforme:139:=ta_Conso_H_Valeur{18}
	[HeberGement:5]HG_PlateformeCentre:140:=ta_Conso_H_Valeur{19}
	
	[HeberGement:5]HG_FamGroupe:102:=ta_Conso_H_Valeur{20}
	[HeberGement:5]HG_FamChef:103:=(ta_Conso_H_Valeur{21}="O")
	[HeberGement:5]HG_FamClé:104:=ta_Conso_H_Valeur{22}
	[HeberGement:5]HG_FamCompo:105:=ta_Conso_H_Valeur{23}
	[HeberGement:5]HG_FamCompoVar:117:=ta_Conso_H_Valeur{24}
	[HeberGement:5]HG_FamNbPers:106:=Num:C11(ta_Conso_H_Valeur{25})
	[HeberGement:5]HG_FamNbJour:107:=Num:C11(ta_Conso_H_Valeur{26})
	[HeberGement:5]HG_FamNbChambre:108:=Num:C11(ta_Conso_H_Valeur{26})
	[HeberGement:5]HG_FamPrixJour:109:=Num:C11(ta_Conso_H_Valeur{28})
	[HeberGement:5]HG_FamTotal:110:=Num:C11(ta_Conso_H_Valeur{29})
	[HeberGement:5]HG_FamNoDeBon:136:=Num:C11(ta_Conso_H_Valeur{30})
	[HeberGement:5]HG_Participation:138:=(ta_Conso_H_Valeur{31}="O")
	
	
	[HeberGement:5]HG_FamDistri1:112:=ta_Conso_H_Valeur{32}
	[HeberGement:5]HG_FamDistri1M:118:=Num:C11(ta_Conso_H_Valeur{33})
	[HeberGement:5]HG_FamDistri2:113:=ta_Conso_H_Valeur{34}
	[HeberGement:5]HG_FamDistri2M:119:=Num:C11(ta_Conso_H_Valeur{35})
	[HeberGement:5]HG_FamDistri3:114:=ta_Conso_H_Valeur{36}
	[HeberGement:5]HG_FamDistri3M:120:=Num:C11(ta_Conso_H_Valeur{37})
	[HeberGement:5]HG_FamDistri4:115:=ta_Conso_H_Valeur{38}
	[HeberGement:5]HG_FamDistri4M:121:=Num:C11(ta_Conso_H_Valeur{39})
	[HeberGement:5]HG_FamDistri5:116:=ta_Conso_H_Valeur{40}
	[HeberGement:5]HG_FamDistri5M:122:=Num:C11(ta_Conso_H_Valeur{41})
	
	[HeberGement:5]HG_FamCasSpéc:111:=ta_Conso_H_Valeur{42}
	[HeberGement:5]HG_FamVérifiéeLe:137:=Date:C102(ta_Conso_H_Valeur{43})
	
	[HeberGement:5]HG_Réservation:91:=(ta_Conso_H_Valeur{44}="O")
	[HeberGement:5]HG_NuitenCours:92:=Num:C11(ta_Conso_H_Valeur{45})
	[HeberGement:5]HG_NuitTOTAL:93:=Num:C11(ta_Conso_H_Valeur{46})
	[HeberGement:5]HG_NuitReste:95:=Num:C11(ta_Conso_H_Valeur{47})
	[HeberGement:5]HG_RéservationDateFin:134:=Date:C102(ta_Conso_H_Valeur{48})
	[HeberGement:5]HG_Reporté:94:=ta_Conso_H_Valeur{49}
	
	[HeberGement:5]HG_ER_Excuse:124:=(ta_Conso_H_Valeur{50}="O")
	[HeberGement:5]HG_ER_DateDébut:125:=Date:C102(ta_Conso_H_Valeur{51})
	[HeberGement:5]HG_ER_DateFin:126:=Date:C102(ta_Conso_H_Valeur{52})
	[HeberGement:5]HG_ER_NuitEnCours:127:=Num:C11(ta_Conso_H_Valeur{53})
	[HeberGement:5]HG_ER_NuitTotal:128:=Num:C11(ta_Conso_H_Valeur{54})
	[HeberGement:5]HG_ER_NuitReste:129:=Num:C11(ta_Conso_H_Valeur{55})
	
	[HeberGement:5]HG_ER_Remplaçant:130:=(ta_Conso_H_Valeur{56}="O")
	[HeberGement:5]HG_ER_RemplaceQuiRéf:131:=Num:C11(ta_Conso_H_Valeur{57})
	[HeberGement:5]HG_ER_RemplaceQui:132:=ta_Conso_H_Valeur{58}
	
	[HeberGement:5]HG_LC_ID:61:=Num:C11(ta_Conso_H_Valeur{59})
	[HeberGement:5]HG_CentreNom:62:=ta_Conso_H_Valeur{60}
	[HeberGement:5]HG_CentreARR:63:=ta_Conso_H_Valeur{61}
	[HeberGement:5]HG_Priorité:57:=Num:C11(ta_Conso_H_Valeur{62})
	[HeberGement:5]HG_DispoSpé:90:=(ta_Conso_H_Valeur{63}="O")
	
	[HeberGement:5]HG_EnAttente:64:=(ta_Conso_H_Valeur{64}="O")
	[HeberGement:5]HG_AttenteHeur:83:=Time:C179(ta_Conso_H_Valeur{65})
	[HeberGement:5]HG_Transmis:65:=(ta_Conso_H_Valeur{66}="O")
	[HeberGement:5]HG_TransmisHeur:84:=Time:C179(ta_Conso_H_Valeur{67})
	[HeberGement:5]HG_PriseCharge:66:=(ta_Conso_H_Valeur{68}="O")
	[HeberGement:5]HG_PrChargeHeur:85:=Time:C179(ta_Conso_H_Valeur{69})
	[HeberGement:5]HG_Cloturée:67:=(ta_Conso_H_Valeur{70}="O")
	[HeberGement:5]HG_CloturéeHeur:86:=Time:C179(ta_Conso_H_Valeur{71})
	
	[HeberGement:5]HG_UtilisateurP:6:=ta_Conso_H_Valeur{72}
	[HeberGement:5]HG_Coordinateur:7:=ta_Conso_H_Valeur{73}
	[HeberGement:5]HG_Régulateur:8:=ta_Conso_H_Valeur{74}
	[HeberGement:5]HG_Permanencier:9:=ta_Conso_H_Valeur{75}
	[HeberGement:5]HG_AssistSocial:87:=ta_Conso_H_Valeur{76}
	
	[HeberGement:5]HG_Maraude1_1:10:=ta_Conso_H_Valeur{77}
	[HeberGement:5]HG_DateEntree:186:=Date:C102(ta_Conso_H_Valeur{78})
	[HeberGement:5]HG_Maraude2_1:98:=ta_Conso_H_Valeur{79}
	[HeberGement:5]HG_Maraude2_2:99:=ta_Conso_H_Valeur{80}
	[HeberGement:5]HG_Maraude3_1:100:=ta_Conso_H_Valeur{81}
	[HeberGement:5]HG_DateSortie:185:=Date:C102(ta_Conso_H_Valeur{82})
	
	[HeberGement:5]HG_Signalement:12:=ta_Conso_H_Valeur{83}
	[HeberGement:5]HG_SignalCentre:13:=ta_Conso_H_Valeur{84}
	[HeberGement:5]HG_CodePostal:14:=ta_Conso_H_Valeur{85}
	[HeberGement:5]HG_Gare:15:=ta_Conso_H_Valeur{86}
	[HeberGement:5]HG_Métro:16:=ta_Conso_H_Valeur{87}
	[HeberGement:5]HG_Emplacement:17:=ta_Conso_H_Valeur{88}
	[HeberGement:5]HG_Lien:18:=ta_Conso_H_Valeur{89}
	
	[HeberGement:5]HG_Nationalité:25:=ta_Conso_H_Valeur{90}
	[HeberGement:5]HG_SituFamille:29:=ta_Conso_H_Valeur{91}
	[HeberGement:5]HG_TempsErrance:34:=ta_Conso_H_Valeur{92}
	[HeberGement:5]HG_DernierHéber:35:=ta_Conso_H_Valeur{93}
	[HeberGement:5]HG_SituProfess:36:=ta_Conso_H_Valeur{94}
	[HeberGement:5]HG_DernierEmplo:37:=ta_Conso_H_Valeur{95}
	[HeberGement:5]HG_DuréSanEmplo:38:=ta_Conso_H_Valeur{96}
	[HeberGement:5]HG_NiveauEtude:43:=ta_Conso_H_Valeur{97}
	
	[HeberGement:5]HG_PiècesIdté1:31:=ta_Conso_H_Valeur{98}
	[HeberGement:5]HG_PiècesIdté2:32:=ta_Conso_H_Valeur{99}
	[HeberGement:5]HG_PiècesIdté3:33:=ta_Conso_H_Valeur{100}
	
	[HeberGement:5]HG_RupMajeur1:40:=ta_Conso_H_Valeur{101}
	[HeberGement:5]HG_RupMajeur1_2:72:=ta_Conso_H_Valeur{102}
	[HeberGement:5]HG_RupMajeur2:41:=ta_Conso_H_Valeur{103}
	[HeberGement:5]HG_RupMajeur2_2:73:=ta_Conso_H_Valeur{104}
	[HeberGement:5]HG_RupMajeur3:42:=ta_Conso_H_Valeur{105}
	[HeberGement:5]HG_RupMajeur3_2:74:=ta_Conso_H_Valeur{106}
	
	[HeberGement:5]HG_Ressources1:45:=ta_Conso_H_Valeur{107}
	[HeberGement:5]HG_Ressource1_2:75:=ta_Conso_H_Valeur{108}
	[HeberGement:5]HG_Ressources2:46:=ta_Conso_H_Valeur{109}
	[HeberGement:5]HG_Ressource2_2:76:=ta_Conso_H_Valeur{110}
	[HeberGement:5]HG_Ressources3:47:=ta_Conso_H_Valeur{111}
	[HeberGement:5]HG_Ressource3_2:77:=ta_Conso_H_Valeur{112}
	
	[HeberGement:5]HG_SuiviSocial1:49:=ta_Conso_H_Valeur{113}
	[HeberGement:5]HG_SuiviSocial2:50:=ta_Conso_H_Valeur{114}
	[HeberGement:5]HG_SuiviSocial3:51:=ta_Conso_H_Valeur{115}
	
	[HeberGement:5]HG_CouvSocial1:53:=ta_Conso_H_Valeur{116}
	[HeberGement:5]HG_CouvSocial2:54:=ta_Conso_H_Valeur{117}
	[HeberGement:5]HG_CouvSocial3:55:=ta_Conso_H_Valeur{118}
	
	
	[HeberGement:5]HG_Médicalisé:56:=(ta_Conso_H_Valeur{119}="O")
	[HeberGement:5]HG_Status:89:=(ta_Conso_H_Valeur{120}="O")
	
	[HeberGement:5]HG_Orientation1:58:=ta_Conso_H_Valeur{121}
	[HeberGement:5]HG_Orientation1Suite:59:=ta_Conso_H_Valeur{122}
	
	[HeberGement:5]HG_AutreSolutio:88:=ta_Conso_H_Valeur{123}
	[HeberGement:5]HG_AutreSolSuite:123:=ta_Conso_H_Valeur{124}
	
	
	//Autres
	[HeberGement:5]HG_VstVsm:135:=(ta_Conso_H_Valeur{125}="O")
	[HeberGement:5]HG_1_TransHeure:70:=Time:C179(ta_Conso_H_Valeur{126})
	
	//Fax
	[HeberGement:5]HG_CléFax:69:=ta_Conso_H_Valeur{127}
	//Trans
	[HeberGement:5]HG_Trans_DDASS:141:=(ta_Conso_H_Valeur{128}="O")
	[HeberGement:5]HG_Trans_RéférenceID:142:=Num:C11(ta_Conso_H_Valeur{129})
	[HeberGement:5]HG_Trans_FicheNuméro:143:=ta_Conso_H_Valeur{130}
	[HeberGement:5]HG_Trans_HB_ID:144:=Num:C11(ta_Conso_H_Valeur{131})
	[HeberGement:5]HG_Trans_LC_ID:145:=Num:C11(ta_Conso_H_Valeur{132})
	[HeberGement:5]HG_Trans_FamClé:147:=ta_Conso_H_Valeur{133}
	[HeberGement:5]HG_Trans_Plateforme:148:=ta_Conso_H_Valeur{134}
	
End if 
UNLOAD RECORD:C212([HeberGement:5])
READ ONLY:C145([HeberGement:5])