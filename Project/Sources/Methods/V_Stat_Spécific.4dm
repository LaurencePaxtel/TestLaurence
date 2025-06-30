//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : V_Stat_Spécific
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

C_LONGINT:C283($ii)

Case of 
	: ($1=0)  //•••••••••••••••••••Déclaration
		C_DATE:C307(vd_Date1; vd_Date2)
		C_LONGINT:C283(vl_NbJ)
		C_TEXT:C284(vt_StTexte)
		C_LONGINT:C283(vl_NbHB)
		C_LONGINT:C283(vl_NbHBd)
		C_LONGINT:C283(vl_HBdif)
		
		vl_NbHB:=0
		vl_NbHBd:=0
		vl_HBdif:=0
		
		ARRAY TEXT:C222(ta_Rub1; 0)
		ARRAY POINTER:C280(tp_Rub1; 0)
		ARRAY INTEGER:C220(te_Rub1; 0)
		
		ARRAY TEXT:C222(ta_Rub2; 0)
		ARRAY POINTER:C280(tp_Rub2; 0)
		ARRAY INTEGER:C220(te_Rub2; 0)
		
		ARRAY TEXT:C222(ta_Rub3; 0)
		ARRAY POINTER:C280(tp_Rub3; 0)
		ARRAY INTEGER:C220(te_Rub3; 0)
		
		ARRAY TEXT:C222(ta_Rub4; 0)
		ARRAY POINTER:C280(tp_Rub4; 0)
		ARRAY INTEGER:C220(te_Rub4; 0)
		
		//Les critères 1
		ARRAY INTEGER:C220(te_Sel1; 0)
		ARRAY TEXT:C222(ta_it1; 0)
		
		ARRAY LONGINT:C221(tl_Nb1; 0)
		C_LONGINT:C283(vl_Tot1)
		
		ARRAY LONGINT:C221(tl_Nb1_1; 0)
		C_LONGINT:C283(vl_Tot1_1)
		
		//Les critères 2
		ARRAY INTEGER:C220(te_Sel2; 0)
		ARRAY TEXT:C222(ta_it2; 0)
		
		ARRAY LONGINT:C221(tl_Nb2; 0)
		C_LONGINT:C283(vl_Tot2)
		
		ARRAY LONGINT:C221(tl_Nb2_2; 0)
		C_LONGINT:C283(vl_Tot2_2)
		
		//Les critères 3
		ARRAY INTEGER:C220(te_Sel3; 0)
		ARRAY TEXT:C222(ta_it3; 0)
		
		ARRAY LONGINT:C221(tl_Nb3; 0)
		C_LONGINT:C283(vl_Tot3)
		
		ARRAY LONGINT:C221(tl_Nb3_3; 0)
		C_LONGINT:C283(vl_Tot3_3)
		
		//Les critères 4
		ARRAY INTEGER:C220(te_Sel4; 0)
		ARRAY TEXT:C222(ta_it4; 0)
		
		ARRAY LONGINT:C221(tl_Nb4; 0)
		C_LONGINT:C283(vl_Tot4)
		
		ARRAY LONGINT:C221(tl_Nb4_4; 0)
		C_LONGINT:C283(vl_Tot4_4)
		
		ARRAY TEXT:C222(ta_Rub1; 49)
		ARRAY POINTER:C280(tp_Rub1; 49)
		ARRAY INTEGER:C220(te_Rub1; 49)
		
		ARRAY LONGINT:C221(<>ts_Heures; 24)
		
		For ($ii; 1; 24)
			<>ts_Heures{$ii}:=$ii-1
		End for 
		
		//Age
		ARRAY INTEGER:C220(<>te_TBAge; 9)
		
		<>te_TBAge{1}:=3
		<>te_TBAge{2}:=18
		<>te_TBAge{3}:=24
		<>te_TBAge{4}:=29
		<>te_TBAge{5}:=39
		<>te_TBAge{6}:=49
		<>te_TBAge{7}:=59
		<>te_TBAge{8}:=69
		<>te_TBAge{9}:=70
		
		ta_Rub1{1}:="HeureAppel"
		tp_Rub1{1}:=->[HeberGement:5]HG_HeureAppel:5
		te_Rub1{1}:=3
		
		ta_Rub1{2}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{19}  //"Maraude"  
		tp_Rub1{2}:=->[HeberGement:5]HG_Maraude1_1:10
		te_Rub1{2}:=0
		
		ta_Rub1{3}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{5}  //"Signalement"
		tp_Rub1{3}:=->[HeberGement:5]HG_Signalement:12
		te_Rub1{3}:=0
		
		ta_Rub1{4}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{7}  //"Code Postal"
		tp_Rub1{4}:=->[HeberGement:5]HG_CodePostal:14
		te_Rub1{4}:=0
		
		ta_Rub1{5}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{8}  //"Gare"
		tp_Rub1{5}:=->[HeberGement:5]HG_Gare:15
		te_Rub1{5}:=0
		
		ta_Rub1{6}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{9}  //"Métro"
		tp_Rub1{6}:=->[HeberGement:5]HG_Métro:16
		te_Rub1{6}:=0
		
		ta_Rub1{7}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{10}  //"Emplacement"
		tp_Rub1{7}:=->[HeberGement:5]HG_Emplacement:17
		te_Rub1{7}:=0
		
		ta_Rub1{8}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{40}  //"Etat Civil"
		tp_Rub1{8}:=->[HeberGement:5]HG_EtatCivil:20
		te_Rub1{8}:=0
		
		// Modifié par : Scanu Rémy (28/09/2023)
		// Ajout item Etat civil fusionné
		ta_Rub1{9}:="Etats civils fusionnés"
		tp_Rub1{9}:=->[HeberGement:5]HG_EtatCivilFusion:183
		te_Rub1{9}:=0
		
		ta_Rub1{10}:="Age"
		tp_Rub1{10}:=->[HeberGement:5]HG_Age:23
		te_Rub1{10}:=2
		
		ta_Rub1{11}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{12}  //"Nationalité"
		tp_Rub1{11}:=->[HeberGement:5]HG_Nationalité:25
		te_Rub1{11}:=0
		
		ta_Rub1{12}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{43}  //"Status"
		tp_Rub1{12}:=->[HeberGement:5]HG_Status:89
		te_Rub1{12}:=1
		
		ta_Rub1{13}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{11}  //"Lien de parenté"
		tp_Rub1{13}:=->[HeberGement:5]HG_Lien:18
		te_Rub1{13}:=0
		
		ta_Rub1{14}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{13}  //"Situation de Famille"
		tp_Rub1{14}:=->[HeberGement:5]HG_SituFamille:29
		te_Rub1{14}:=0
		
		ta_Rub1{15}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{25}  //"Pièces Idté 1"
		tp_Rub1{15}:=->[HeberGement:5]HG_PiècesIdté1:31
		te_Rub1{15}:=0
		
		ta_Rub1{16}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{26}  //"Pièces Idté 2"
		tp_Rub1{16}:=->[HeberGement:5]HG_PiècesIdté2:32
		te_Rub1{16}:=0
		
		ta_Rub1{17}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{27}  //"Pièces Idté 3"
		tp_Rub1{17}:=->[HeberGement:5]HG_PiècesIdté3:33
		te_Rub1{17}:=0
		
		ta_Rub1{18}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{14}  //"Temps d'errance"
		tp_Rub1{18}:=->[HeberGement:5]HG_TempsErrance:34
		te_Rub1{18}:=0
		
		ta_Rub1{19}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{15}  //"Dernier hébergement"
		tp_Rub1{19}:=->[HeberGement:5]HG_DernierHéber:35
		te_Rub1{19}:=0
		
		ta_Rub1{20}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{16}  //"Situation professionnelle"
		tp_Rub1{20}:=->[HeberGement:5]HG_SituProfess:36
		te_Rub1{20}:=0
		
		ta_Rub1{21}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{17}  //"Dernier emploi"
		tp_Rub1{21}:=->[HeberGement:5]HG_DernierEmplo:37
		te_Rub1{21}:=0
		
		ta_Rub1{22}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{18}  //"Duré sans emploi"
		tp_Rub1{22}:=->[HeberGement:5]HG_DuréSanEmplo:38
		te_Rub1{22}:=0
		
		ta_Rub1{23}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{28}  //"Rupture majeure 1"
		tp_Rub1{23}:=->[HeberGement:5]HG_RupMajeur1:40
		te_Rub1{23}:=0
		
		ta_Rub1{24}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{29}  //"Rupture majeure 2"
		tp_Rub1{24}:=->[HeberGement:5]HG_RupMajeur2:41
		te_Rub1{24}:=0
		
		ta_Rub1{25}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{30}  //"Rupture majeure 3"
		tp_Rub1{25}:=->[HeberGement:5]HG_RupMajeur3:42
		te_Rub1{25}:=0
		
		ta_Rub1{26}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{41}  //"Niveau d'étude"
		tp_Rub1{26}:=->[HeberGement:5]HG_NiveauEtude:43
		te_Rub1{26}:=0
		
		ta_Rub1{27}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{31}  //"Ressources 1"
		tp_Rub1{27}:=->[HeberGement:5]HG_Ressources1:45
		te_Rub1{27}:=0
		
		ta_Rub1{28}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{32}  //"Ressources 2"
		tp_Rub1{28}:=->[HeberGement:5]HG_Ressources2:46
		te_Rub1{28}:=0
		
		ta_Rub1{29}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{33}  //"Ressources 3"
		tp_Rub1{29}:=->[HeberGement:5]HG_Ressources3:47
		te_Rub1{29}:=0
		
		ta_Rub1{30}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{34}  //"Suivi social 1"
		tp_Rub1{30}:=->[HeberGement:5]HG_SuiviSocial1:49
		te_Rub1{30}:=0
		
		ta_Rub1{31}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{35}  //"Suivi social 2"
		tp_Rub1{31}:=->[HeberGement:5]HG_SuiviSocial2:50
		te_Rub1{31}:=0
		
		ta_Rub1{32}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{36}  //"Suivi social 3"
		tp_Rub1{32}:=->[HeberGement:5]HG_SuiviSocial3:51
		te_Rub1{32}:=0
		
		ta_Rub1{33}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{37}  //"Couverture sociale 1"
		tp_Rub1{33}:=->[HeberGement:5]HG_CouvSocial1:53
		te_Rub1{33}:=0
		
		ta_Rub1{34}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{38}  //"Couverture sociale 2"
		tp_Rub1{34}:=->[HeberGement:5]HG_CouvSocial2:54
		te_Rub1{34}:=0
		
		ta_Rub1{35}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{39}  //"Couverture sociale 3"
		tp_Rub1{35}:=->[HeberGement:5]HG_CouvSocial3:55
		te_Rub1{35}:=0
		
		ta_Rub1{36}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{42}  //"Lit médicalisé"
		tp_Rub1{36}:=->[HeberGement:5]HG_Médicalisé:56
		te_Rub1{36}:=1
		
		ta_Rub1{37}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{48}  //"Orientation 1"
		tp_Rub1{37}:=->[HeberGement:5]HG_Orientation1:58
		te_Rub1{37}:=0
		
		ta_Rub1{38}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{49}  //"Orientation 2"
		tp_Rub1{38}:=->[HeberGement:5]HG_Orientation2:60
		te_Rub1{38}:=0
		
		ta_Rub1{39}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{50}  //"Autre solution"
		tp_Rub1{39}:=->[HeberGement:5]HG_AutreSolutio:88
		te_Rub1{39}:=0
		
		ta_Rub1{40}:="Genre"
		tp_Rub1{40}:=->[HeberGement:5]HG_Genre:96
		te_Rub1{40}:=1
		
		ta_Rub1{41}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{62}  //"Famille groupe"
		tp_Rub1{41}:=->[HeberGement:5]HG_FamGroupe:102
		te_Rub1{41}:=0
		
		ta_Rub1{42}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{63}  //"Famille responsable"
		tp_Rub1{42}:=->[HeberGement:5]HG_FamChef:103
		te_Rub1{42}:=1
		
		ta_Rub1{43}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{65}  //"Famille composition "
		tp_Rub1{43}:=->[HeberGement:5]HG_FamCompo:105
		te_Rub1{43}:=0
		
		ta_Rub1{44}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{78}  //"Famille distri 1"
		tp_Rub1{44}:=->[HeberGement:5]HG_FamDistri1:112
		te_Rub1{44}:=0
		
		ta_Rub1{45}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{79}  //"Famille distri 2"
		tp_Rub1{45}:=->[HeberGement:5]HG_FamDistri2:113
		te_Rub1{45}:=0
		
		ta_Rub1{46}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{80}  //"Famille distri 3"
		tp_Rub1{46}:=->[HeberGement:5]HG_FamDistri3:114
		te_Rub1{46}:=0
		
		ta_Rub1{47}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{81}  //"Famille distri 4"
		tp_Rub1{47}:=->[HeberGement:5]HG_FamDistri4:115
		te_Rub1{47}:=0
		
		ta_Rub1{48}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{82}  //"Famille distri 5"
		tp_Rub1{48}:=->[HeberGement:5]HG_FamDistri5:116
		te_Rub1{48}:=0
		
		ta_Rub1{49}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{83}  //"Famille cas spécif"
		tp_Rub1{49}:=->[HeberGement:5]HG_FamCasSpéc:111
		te_Rub1{49}:=0
		
		SORT ARRAY:C229(ta_Rub1; tp_Rub1; te_Rub1; >)
		
		COPY ARRAY:C226(ta_Rub1; ta_Rub2)
		COPY ARRAY:C226(tp_Rub1; tp_Rub2)
		COPY ARRAY:C226(te_Rub1; te_Rub2)
		
		COPY ARRAY:C226(ta_Rub1; ta_Rub3)
		COPY ARRAY:C226(tp_Rub1; tp_Rub3)
		COPY ARRAY:C226(te_Rub1; te_Rub3)
		
		COPY ARRAY:C226(ta_Rub1; ta_Rub4)
		COPY ARRAY:C226(tp_Rub1; tp_Rub4)
		COPY ARRAY:C226(te_Rub1; te_Rub4)
		
		//$ii:=Chercher dans tableau(ta_Rub1; "Etat civil")
		$ii:=Find in array:C230(ta_Rub1; "Service")  //LPC 02/10/2023
		
		If ($ii>0)
			ta_Rub1:=$ii
		Else 
			ta_Rub1:=1
		End if 
		
		ta_Rub1{0}:=ta_Rub1{ta_Rub1}
		tp_Rub1{0}:=tp_Rub1{ta_Rub1}
		te_Rub1{0}:=te_Rub1{ta_Rub1}
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (13/07/2021)
		If ($ii>0)
			ta_Rub2:=1
		Else 
			ta_Rub2:=2
		End if 
		
		ta_Rub2{0}:=ta_Rub2{ta_Rub2}
		tp_Rub2{0}:=tp_Rub2{ta_Rub2}
		te_Rub2{0}:=te_Rub2{ta_Rub2}
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (13/07/2021)
		If ($ii>0)
			ta_Rub3:=2
		Else 
			ta_Rub3:=3
		End if 
		
		ta_Rub3{0}:=ta_Rub3{ta_Rub3}
		tp_Rub3{0}:=tp_Rub3{ta_Rub3}
		te_Rub3{0}:=te_Rub3{ta_Rub3}
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (13/07/2021)
		If ($ii>0)
			ta_Rub4:=3
		Else 
			ta_Rub4:=4
		End if 
		
		ta_Rub4{0}:=ta_Rub4{ta_Rub4}
		tp_Rub4{0}:=tp_Rub4{ta_Rub4}
		te_Rub4{0}:=te_Rub4{ta_Rub4}
		
		P_Item_Spécific(1; ta_Rub1)
		P_Item_Spécific(2; ta_Rub2)
		P_Item_Spécific(3; ta_Rub3)
		P_Item_Spécific(4; ta_Rub4)
	: ($1=1)  //•••••••••••••••••••Mise à zéro
End case 