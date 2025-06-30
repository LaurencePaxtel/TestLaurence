//%attributes = {}
// FORMULAIRE HG_EcranSaisie_B

If (False:C215)
	// Signalement
	var $va_Sglt_R : Text
	$va_Sglt_R:="002/1@"
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{5}; ->$va_Sglt_R; -><>ta_TBSglt; ->[HeberGement:5]HG_Signalement:12; ->[HeberGement:5]HG_SignalCentre:13; vPtrT1_Tri)
	// Code postal
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{7}; -><>ta_TBArr; ->[HeberGement:5]HG_CodePostal:14)
	// Gare
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{8}; -><>ta_TBGare; ->[HeberGement:5]HG_Gare:15)
	// Métro
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{9}; -><>ta_TBMetro; ->[HeberGement:5]HG_Métro:16)
	// Cas spécifique
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{83}; -><>ta_FMCaS; ->[HeberGement:5]HG_FamCasSpéc:111)
	// Lien
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{11}; -><>ta_TBLien; ->[HeberGement:5]HG_Lien:18)
	// Nationalité
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{12}; -><>ta_TBNatio; ->[HeberGement:5]HG_Nationalité:25)
	// Situation de famille
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{13}; -><>ta_TBSitFam; ->[HeberGement:5]HG_SituFamille:29)
	// Temps d'Errance
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{14}; -><>ta_TBTpsErr; ->[HeberGement:5]HG_TempsErrance:34)
	// Dernier hébergement
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{15}; -><>ta_TBDerHéb; ->[HeberGement:5]HG_DernierHéber:35)
	// Sit. professionnelle
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{16}; -><>ta_TBSitPro; ->[HeberGement:5]HG_SituProfess:36)
	// Dernier emploi
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{17}; -><>ta_TBDerJob; ->[HeberGement:5]HG_DernierEmplo:37)
	// Durée sans emploi
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{18}; -><>ta_TBDurJob; ->[HeberGement:5]HG_DuréSanEmplo:38)
	
	// id1
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{25}; -><>ta_TBPIdté; ->[HeberGement:5]HG_PiècesIdté1:31)
	// id2
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{26}; -><>ta_TBPIdté2; ->[HeberGement:5]HG_PiècesIdté2:32)
	// id3
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{27}; -><>ta_TBPIdté3; ->[HeberGement:5]HG_PiècesIdté3:33)
	
	
	// Rupture 0
	Tab_PopRub3(->[HeberGement:5]HG_FicheNuméro:3; <>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{28}; ->[HeberGement:5]HG_RupMajeur1:40; ->[HeberGement:5]HG_RupMajeur1_2:72; ->[HeberGement:5]HG_RupMajeur2:41; ->[HeberGement:5]HG_RupMajeur2_2:73; ->[HeberGement:5]HG_RupMajeur3:42; ->[HeberGement:5]HG_RupMajeur3_2:74)
	// rupture 1
	var $va_RupMaj_R : Text
	$va_RupMaj_R:="017/1@"
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{28}; ->$va_RupMaj_R; -><>ta_TBRupMaj; ->[HeberGement:5]HG_RupMajeur1:40; ->[HeberGement:5]HG_RupMajeur1_2:72; vPtrT1_Tri)
	
	// rupture 2
	Début_LienTable("Ruptures majeures 2"; ->$va_RupMaj_R)
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{29}; ->$va_RupMaj_R; -><>ta_TBRupMaj2; ->[HeberGement:5]HG_RupMajeur2:41; ->[HeberGement:5]HG_RupMajeur2_2:73; vPtrT1_Tri)
	
	// rupture 3
	Début_LienTable("Ruptures majeures 3"; ->$va_RupMaj_R)
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{30}; ->$va_RupMaj_R; -><>ta_TBRupMaj3; ->[HeberGement:5]HG_RupMajeur3:42; ->[HeberGement:5]HG_RupMajeur3_2:74; vPtrT1_Tri)
	
	
	// ressources 1
	Tab_PopRub3(->[HeberGement:5]HG_FicheNuméro:3; <>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{31}; ->[HeberGement:5]HG_Ressources1:45; ->[HeberGement:5]HG_Ressource1_2:75; ->[HeberGement:5]HG_Ressources2:46; ->[HeberGement:5]HG_Ressource2_2:76; ->[HeberGement:5]HG_Ressources3:47; ->[HeberGement:5]HG_Ressource3_2:77)
	// ressources 2
	var $va_ResAct_R : Text
	Début_LienTable("Ressources actuelles 2"; ->$va_ResAct_R)
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{32}; ->$va_ResAct_R; -><>ta_TBResAct2; ->[HeberGement:5]HG_Ressources2:46; ->[HeberGement:5]HG_Ressource2_2:76; vPtrT1_Tri)
	// ressources 3
	Début_LienTable("Ressources actuelles 3"; ->$va_ResAct_R)
	Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{33}; ->$va_ResAct_R; -><>ta_TBResAct3; ->[HeberGement:5]HG_Ressources3:47; ->[HeberGement:5]HG_Ressource3_2:77; vPtrT1_Tri)
	
End if 

C_POINTER:C301($1)

ARRAY OBJECT:C1221($rO_Paire_champs_listes; 38)

OB SET:C1220($rO_Paire_champs_listes{1}; "liste"; "Code postal")
OB SET:C1220($rO_Paire_champs_listes{1}; "field"; ->[HeberGement:5]HG_CodePostal:14)

OB SET:C1220($rO_Paire_champs_listes{2}; "liste"; "Gares")
OB SET:C1220($rO_Paire_champs_listes{2}; "field"; ->[HeberGement:5]HG_Gare:15)

OB SET:C1220($rO_Paire_champs_listes{3}; "liste"; "Metro")
OB SET:C1220($rO_Paire_champs_listes{3}; "field"; ->[HeberGement:5]HG_Métro:16)

OB SET:C1220($rO_Paire_champs_listes{4}; "liste"; "Maraude")
OB SET:C1220($rO_Paire_champs_listes{4}; "field"; ->[HeberGement:5]HG_Maraude1_1:10)

OB SET:C1220($rO_Paire_champs_listes{5}; "liste"; "Temps d'errance")
OB SET:C1220($rO_Paire_champs_listes{5}; "field"; ->[HeberGement:5]HG_TempsErrance:34)

OB SET:C1220($rO_Paire_champs_listes{6}; "liste"; "Dernier hébergement")
OB SET:C1220($rO_Paire_champs_listes{6}; "field"; ->[HeberGement:5]HG_DernierHéber:35)

OB SET:C1220($rO_Paire_champs_listes{7}; "liste"; "Situation professionnelle")
OB SET:C1220($rO_Paire_champs_listes{7}; "field"; ->[HeberGement:5]HG_SituProfess:36)

OB SET:C1220($rO_Paire_champs_listes{8}; "liste"; "Dernier emploi")
OB SET:C1220($rO_Paire_champs_listes{8}; "field"; ->[HeberGement:5]HG_DernierEmplo:37)

OB SET:C1220($rO_Paire_champs_listes{9}; "liste"; "Durée du dernier emploi")
OB SET:C1220($rO_Paire_champs_listes{9}; "field"; ->[HeberGement:5]HG_DuréSanEmplo:38)

OB SET:C1220($rO_Paire_champs_listes{10}; "liste"; "Niveau d'étude")
OB SET:C1220($rO_Paire_champs_listes{10}; "field"; ->[HeberGement:5]HG_NiveauEtude:43)

OB SET:C1220($rO_Paire_champs_listes{11}; "liste"; "Pièces d'identité")
OB SET:C1220($rO_Paire_champs_listes{11}; "field"; ->[HeberGement:5]HG_PiècesIdté1:31)

OB SET:C1220($rO_Paire_champs_listes{12}; "liste"; "Nationalité")
OB SET:C1220($rO_Paire_champs_listes{12}; "field"; ->[HeberGement:5]HG_Nationalité:25)

OB SET:C1220($rO_Paire_champs_listes{13}; "liste"; "Signalement")
OB SET:C1220($rO_Paire_champs_listes{13}; "field"; ->[HeberGement:5]HG_Signalement:12)

OB SET:C1220($rO_Paire_champs_listes{14}; "liste"; "Ressources actuelles")
OB SET:C1220($rO_Paire_champs_listes{14}; "field"; ->[HeberGement:5]HG_Ressources1:45)

OB SET:C1220($rO_Paire_champs_listes{15}; "liste"; "Suivi social")
OB SET:C1220($rO_Paire_champs_listes{15}; "field"; ->[HeberGement:5]HG_SuiviSocial1:49)

OB SET:C1220($rO_Paire_champs_listes{16}; "liste"; "Couverture sociale")
OB SET:C1220($rO_Paire_champs_listes{16}; "field"; ->[HeberGement:5]HG_SuiviSocial1:49)

OB SET:C1220($rO_Paire_champs_listes{17}; "liste"; "Ruptures majeures")
OB SET:C1220($rO_Paire_champs_listes{17}; "field"; ->[HeberGement:5]HG_RupMajeur1:40)

OB SET:C1220($rO_Paire_champs_listes{18}; "liste"; "Orientation 1")
OB SET:C1220($rO_Paire_champs_listes{18}; "field"; ->[HeberGement:5]HG_Orientation1:58)

OB SET:C1220($rO_Paire_champs_listes{19}; "liste"; "Orientation 1 suite")
OB SET:C1220($rO_Paire_champs_listes{19}; "field"; ->[HeberGement:5]HG_Orientation1Suite:59)

OB SET:C1220($rO_Paire_champs_listes{20}; "liste"; "Autre solution suite")
OB SET:C1220($rO_Paire_champs_listes{20}; "field"; ->[HeberGement:5]HG_AutreSolSuite:123)

OB SET:C1220($rO_Paire_champs_listes{21}; "liste"; "Autre solution")
OB SET:C1220($rO_Paire_champs_listes{21}; "field"; ->[HeberGement:5]HG_AutreSolutio:88)

OB SET:C1220($rO_Paire_champs_listes{22}; "liste"; "FM Cas spécifique")
OB SET:C1220($rO_Paire_champs_listes{22}; "field"; ->[HeberGement:5]HG_FamCasSpéc:111)

OB SET:C1220($rO_Paire_champs_listes{23}; "liste"; "FM Distri1")
OB SET:C1220($rO_Paire_champs_listes{23}; "field"; ->[HeberGement:5]HG_FamDistri1:112)

OB SET:C1220($rO_Paire_champs_listes{24}; "liste"; "FM Distri2")
OB SET:C1220($rO_Paire_champs_listes{24}; "field"; ->[HeberGement:5]HG_FamDistri2:113)

OB SET:C1220($rO_Paire_champs_listes{25}; "liste"; "FM Distri3")
OB SET:C1220($rO_Paire_champs_listes{25}; "field"; ->[HeberGement:5]HG_FamDistri3:114)

OB SET:C1220($rO_Paire_champs_listes{26}; "liste"; "FM Distri4")
OB SET:C1220($rO_Paire_champs_listes{26}; "field"; ->[HeberGement:5]HG_FamDistri4:115)

OB SET:C1220($rO_Paire_champs_listes{27}; "liste"; "FM Distri5")
OB SET:C1220($rO_Paire_champs_listes{27}; "field"; ->[HeberGement:5]HG_FamDistri5:116)

OB SET:C1220($rO_Paire_champs_listes{28}; "liste"; "Pièces d'identité 2")
OB SET:C1220($rO_Paire_champs_listes{28}; "field"; ->[HeberGement:5]HG_PiècesIdté2:32)

OB SET:C1220($rO_Paire_champs_listes{29}; "liste"; "Pièces d'identité 3")
OB SET:C1220($rO_Paire_champs_listes{29}; "field"; ->[HeberGement:5]HG_PiècesIdté3:33)

OB SET:C1220($rO_Paire_champs_listes{30}; "liste"; "Suivi social 2")
OB SET:C1220($rO_Paire_champs_listes{30}; "field"; ->[HeberGement:5]HG_SuiviSocial2:50)

OB SET:C1220($rO_Paire_champs_listes{31}; "liste"; "Suivi social 3")
OB SET:C1220($rO_Paire_champs_listes{31}; "field"; ->[HeberGement:5]HG_SuiviSocial3:51)

OB SET:C1220($rO_Paire_champs_listes{32}; "liste"; "Couverture sociale 2")
OB SET:C1220($rO_Paire_champs_listes{32}; "field"; ->[HeberGement:5]HG_SuiviSocial2:50)

OB SET:C1220($rO_Paire_champs_listes{33}; "liste"; "Couverture sociale 3")
OB SET:C1220($rO_Paire_champs_listes{33}; "field"; ->[HeberGement:5]HG_SuiviSocial3:51)

OB SET:C1220($rO_Paire_champs_listes{34}; "liste"; "Ruptures majeures 2")
OB SET:C1220($rO_Paire_champs_listes{34}; "field"; ->[HeberGement:5]HG_RupMajeur2:41)

OB SET:C1220($rO_Paire_champs_listes{35}; "liste"; "Ruptures majeures 3")
OB SET:C1220($rO_Paire_champs_listes{35}; "field"; ->[HeberGement:5]HG_RupMajeur3:42)

OB SET:C1220($rO_Paire_champs_listes{36}; "liste"; "Ressources actuelles 2")
OB SET:C1220($rO_Paire_champs_listes{36}; "field"; ->[HeberGement:5]HG_Ressources2:46)

OB SET:C1220($rO_Paire_champs_listes{37}; "liste"; "Ressources actuelles 3")
OB SET:C1220($rO_Paire_champs_listes{37}; "field"; ->[HeberGement:5]HG_Ressources3:47)

OB SET:C1220($rO_Paire_champs_listes{38}; "liste"; "FM Groupe")
OB SET:C1220($rO_Paire_champs_listes{38}; "field"; ->[HeberGement:5]HG_FamGroupe:102)
//----
COPY ARRAY:C226($rO_Paire_champs_listes; $1->)

// EOM

