//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : V_Stat_Maraude
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
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
		
		ARRAY LONGINT:C221(<>ts_Heures; 24)
		
		C_LONGINT:C283($ii)
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
		
		//Durée
		ARRAY LONGINT:C221(<>te_Durée; 9)
		<>te_Durée{1}:=5  //5      
		<>te_Durée{2}:=10  //6 -10      
		<>te_Durée{3}:=15  //11-15   
		<>te_Durée{4}:=30  //16-30
		<>te_Durée{5}:=45  //31-45
		<>te_Durée{6}:=60  //46-60
		<>te_Durée{6}:=90  //61-90
		<>te_Durée{7}:=120  //91-120
		<>te_Durée{8}:=150  //121-150
		<>te_Durée{9}:=150  //+150
		
		ARRAY TEXT:C222(ta_Rub1; 48)
		ARRAY POINTER:C280(tp_Rub1; 48)
		ARRAY INTEGER:C220(te_Rub1; 48)
		//"No EMA"
		ta_Rub1{1}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{4}
		tp_Rub1{1}:=->[Maraude:24]MR_EMA:11
		te_Rub1{1}:=0
		//"Conseiller"
		ta_Rub1{2}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{1}
		tp_Rub1{2}:=->[Maraude:24]MR_Conseiller:7
		te_Rub1{2}:=0
		//"Opérateur"
		ta_Rub1{3}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{2}
		tp_Rub1{3}:=->[Maraude:24]MR_Opérateur:8
		te_Rub1{3}:=0
		//"Chef de bord"
		ta_Rub1{4}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{3}
		tp_Rub1{4}:=->[Maraude:24]MR_ChefBord:9
		te_Rub1{4}:=0
		//"Etat Civil"
		ta_Rub1{5}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{17}
		tp_Rub1{5}:=->[Maraude:24]MR_EtatCivil:16
		te_Rub1{5}:=0
		//"Age"
		ta_Rub1{6}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{21}
		tp_Rub1{6}:=->[Maraude:24]MR_Age:19
		te_Rub1{6}:=2
		//"Lieu de naissance"
		ta_Rub1{7}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{22}
		tp_Rub1{7}:=->[Maraude:24]MR_LieuNéOù:21
		te_Rub1{7}:=0
		//"Signalement"
		ta_Rub1{8}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{7}
		tp_Rub1{8}:=->[Maraude:24]MR_Signalt:12
		te_Rub1{8}:=0
		//"Emplacement"
		ta_Rub1{9}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{9}
		tp_Rub1{9}:=->[Maraude:24]MR_Emplacement:14
		te_Rub1{9}:=0
		//"Arrondissement CP"
		ta_Rub1{10}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{11}
		tp_Rub1{10}:=->[Maraude:24]MR_ArrondCP:15
		te_Rub1{10}:=0
		//"Heure debut de la rencontre"
		ta_Rub1{11}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{12}
		tp_Rub1{11}:=->[Maraude:24]MR_HeureDebut:22
		te_Rub1{11}:=3
		//"Heure fin de la rencontre"
		ta_Rub1{12}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{13}
		tp_Rub1{12}:=->[Maraude:24]MR_HeureFin:23
		te_Rub1{12}:=3
		//"Duré de la rencontre en minutes"
		ta_Rub1{13}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{15}
		tp_Rub1{13}:=->[Maraude:24]MR_DuréRencontr:79
		te_Rub1{13}:=4
		//"Demande"
		ta_Rub1{14}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{14}
		tp_Rub1{14}:=->[Maraude:24]MR_Demande:24
		te_Rub1{14}:=0
		//"Motif refus prise encharge"
		ta_Rub1{15}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{16}
		tp_Rub1{15}:=->[Maraude:24]MR_Motif:25
		te_Rub1{15}:=0
		//"Etat général"
		ta_Rub1{16}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{23}
		tp_Rub1{16}:=->[Maraude:24]MR_EtatGénéral:26
		te_Rub1{16}:=0
		//"Etat cutané"
		ta_Rub1{17}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{24}
		tp_Rub1{17}:=->[Maraude:24]MR_EtatCutané:27
		te_Rub1{17}:=0
		//"Relation"
		ta_Rub1{18}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{25}
		tp_Rub1{18}:=->[Maraude:24]MR_Relation:28
		te_Rub1{18}:=0
		//"Langue 1"
		ta_Rub1{19}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{26}
		tp_Rub1{19}:=->[Maraude:24]MR_Lange1:29
		te_Rub1{19}:=0
		//"Langue 2"
		ta_Rub1{20}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{27}
		tp_Rub1{20}:=->[Maraude:24]MR_Lange2:30
		te_Rub1{20}:=0
		//"Langue 3"
		ta_Rub1{21}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{28}
		tp_Rub1{21}:=->[Maraude:24]MR_Lange3:31
		te_Rub1{21}:=0
		//"Orientation médicale"
		ta_Rub1{22}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{32}
		tp_Rub1{22}:=->[Maraude:24]MR_OrMédical:32
		te_Rub1{22}:=1
		//"Orientation médicale 1"
		ta_Rub1{23}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{33}
		tp_Rub1{23}:=->[Maraude:24]MR_OrMéd:33
		te_Rub1{23}:=0
		//"Orientation sociale"
		ta_Rub1{24}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{29}
		tp_Rub1{24}:=->[Maraude:24]MR_OrSocial:35
		te_Rub1{24}:=1
		//"Orientation sociale 1"
		ta_Rub1{25}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{30}
		tp_Rub1{25}:=->[Maraude:24]MR_OrSoc:36
		te_Rub1{25}:=0
		
		ta_Rub1{26}:="Genre"
		tp_Rub1{26}:=->[Maraude:24]MR_Genre:42
		te_Rub1{26}:=1
		//"Y a t-il une fiche sociale"
		ta_Rub1{27}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{6}
		tp_Rub1{27}:=->[Maraude:24]MR_SocialOK:38
		te_Rub1{27}:=1
		//"Prise en charge EMA"
		ta_Rub1{28}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{35}
		tp_Rub1{28}:=->[Maraude:24]MR_EnChargeEMA:43
		te_Rub1{28}:=0
		//"Dernier lieu d'hébergement"
		ta_Rub1{29}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{37}
		tp_Rub1{29}:=->[Maraude:24]MR_DernierHéber:45
		te_Rub1{29}:=0
		//"Motif refus prise encharge sociale"
		ta_Rub1{30}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{36}
		tp_Rub1{30}:=->[Maraude:24]MR_RefusEMA:44
		te_Rub1{30}:=0
		//"Quel mode"
		ta_Rub1{31}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{40}
		tp_Rub1{31}:=->[Maraude:24]MR_Mode1:48
		te_Rub1{31}:=0
		//"Temps d'errance"
		ta_Rub1{32}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{42}
		tp_Rub1{32}:=->[Maraude:24]MR_Connaissance:51
		te_Rub1{32}:=0
		//"Personne chez qui aller"
		ta_Rub1{33}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{43}
		tp_Rub1{33}:=->[Maraude:24]MR_Connaissance:51
		te_Rub1{33}:=0
		//"Compagnie actuelle"
		ta_Rub1{34}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{44}
		tp_Rub1{34}:=->[Maraude:24]MR_Compagnie:52
		te_Rub1{34}:=0
		//"Question couverture sociale"
		ta_Rub1{35}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{47}
		tp_Rub1{35}:=->[Maraude:24]MR_CouvSocQuest:57
		te_Rub1{35}:=1
		//"Couverture sociale 1"
		ta_Rub1{36}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{48}
		tp_Rub1{36}:=->[Maraude:24]MR_CouvSoc1_1:58
		te_Rub1{36}:=0
		//"Couverture sociale 2"
		ta_Rub1{37}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{50}
		tp_Rub1{37}:=->[Maraude:24]MR_CouvSoc2_1:60
		te_Rub1{37}:=0
		//"Couverture sociale 3"
		ta_Rub1{38}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{52}
		tp_Rub1{38}:=->[Maraude:24]MR_CouvSoc3_1:62
		te_Rub1{38}:=0
		//"Question ressouces"
		ta_Rub1{39}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{59}
		tp_Rub1{39}:=->[Maraude:24]MR_ResourcQuest:64
		te_Rub1{39}:=1
		//"Ressources 1"
		ta_Rub1{40}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{60}
		tp_Rub1{40}:=->[Maraude:24]MR_Ressour1_1:65
		te_Rub1{40}:=0
		//"Ressources 2"
		ta_Rub1{41}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{62}
		tp_Rub1{41}:=->[Maraude:24]MR_Ressour2_1:67
		te_Rub1{41}:=0
		//"Ressources 3"
		ta_Rub1{42}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{64}
		tp_Rub1{42}:=->[Maraude:24]MR_Ressour3_1:69
		te_Rub1{42}:=0
		// "Question papiers d'identité"
		ta_Rub1{43}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{55}
		tp_Rub1{43}:=->[Maraude:24]MR_PapiersQuest:54
		te_Rub1{43}:=1
		//"Papiers d'identité"
		ta_Rub1{44}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{56}
		tp_Rub1{44}:=->[Maraude:24]MR_Papier1:55
		te_Rub1{44}:=0
		//"Question régime"
		ta_Rub1{45}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{67}
		tp_Rub1{45}:=->[Maraude:24]MR_RégimeQuest:71
		te_Rub1{45}:=1
		//"Régime"
		ta_Rub1{46}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{68}
		tp_Rub1{46}:=->[Maraude:24]MR_Régime1:72
		te_Rub1{46}:=0
		//"Question suivi social"
		ta_Rub1{47}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{71}
		tp_Rub1{47}:=->[Maraude:24]MR_SuiviSQuest:75
		te_Rub1{47}:=1
		//"Suivi social"
		ta_Rub1{48}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{72}
		tp_Rub1{48}:=->[Maraude:24]MR_SuiviS1:76
		te_Rub1{48}:=0
		
		// Modified by: Kevin HASSAL (05/08/2019)
		// Ajout du Quartier
		
		//  //"Quartier"
		//ta_Rub1{49}:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{72}
		//tp_Rub1{49}:=->[Maraude]MR_Motif
		//te_Rub1{49}:=0
		
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
		ta_Rub1:=1
		ta_Rub1{0}:=ta_Rub1{ta_Rub1}
		tp_Rub1{0}:=tp_Rub1{ta_Rub1}
		te_Rub1{0}:=te_Rub1{ta_Rub1}
		ta_Rub2:=2
		ta_Rub2{0}:=ta_Rub2{ta_Rub2}
		tp_Rub2{0}:=tp_Rub2{ta_Rub2}
		te_Rub2{0}:=te_Rub2{ta_Rub2}
		ta_Rub3:=3
		ta_Rub3{0}:=ta_Rub3{ta_Rub3}
		tp_Rub3{0}:=tp_Rub3{ta_Rub3}
		te_Rub3{0}:=te_Rub3{ta_Rub3}
		ta_Rub4:=4
		ta_Rub4{0}:=ta_Rub4{ta_Rub4}
		tp_Rub4{0}:=tp_Rub4{ta_Rub4}
		te_Rub4{0}:=te_Rub4{ta_Rub4}
		
		If (P_Item_Maraude(1; ta_Rub1))
		End if 
		If (P_Item_Maraude(2; ta_Rub2))
		End if 
		If (P_Item_Maraude(3; ta_Rub3))
		End if 
		If (P_Item_Maraude(4; ta_Rub4))
		End if 
		
	: ($1=1)  //•••••••••••••••••••Mise à zéro
		
End case 