//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{          Procédure : P_SIAO_VeilleColonne  
//{          Jeudi 24 février 2011 à 11:30
//{          Modifiée :   Lundi 26 mars 2012 à 11:30
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
Case of 
	: ($1=0)
		ARRAY TEXT:C222(ta_ColSiao_ColA; 17)
		ARRAY TEXT:C222(ta_ColSiao_ColACas; 17)
		ARRAY POINTER:C280(tp_ColSiao_ColA; 17)
		
		ARRAY TEXT:C222(ta_ColSiao_ColB; 0)
		ARRAY TEXT:C222(ta_ColSiao_ColBCas; 0)
		ARRAY POINTER:C280(tp_ColSiao_ColB; 0)
		
		ta_ColSiao_ColA{1}:="Couverture sociale"
		tp_ColSiao_ColA{1}:=->[SIAO_Situations:52]Ss_Intitule:9  // P3/$va_SousTheme:="A"/Rang1
		ta_ColSiao_ColACas{1}:="03A1"
		
		ta_ColSiao_ColA{2}:="Situation professionnelle"
		tp_ColSiao_ColA{2}:=->[SIAO_Situations:52]Ss_Intitule:9  // P4/$va_SousTheme:="A"/Rang1
		ta_ColSiao_ColACas{2}:="04A1"
		
		ta_ColSiao_ColA{3}:="Sans situation professionnelle"
		tp_ColSiao_ColA{3}:=->[SIAO_Situations:52]Ss_Intitule:9  // P4/$va_SousTheme:="B"/Rang1
		ta_ColSiao_ColACas{3}:="04B1"
		
		ta_ColSiao_ColA{4}:="Ressources"
		tp_ColSiao_ColA{4}:=->[SIAO_Situations:52]Ss_Intitule:9  // P5/$va_SousTheme:="A"/Rang1
		ta_ColSiao_ColACas{4}:="05A1"
		
		ta_ColSiao_ColA{5}:="Crédit"
		tp_ColSiao_ColA{5}:=->[SIAO_Situations:52]Ss_Intitule:9  // P6/$va_SousTheme:="A"/Rang1
		ta_ColSiao_ColACas{5}:="06A1"
		
		ta_ColSiao_ColA{6}:="Logement ou hébergement actuel"
		tp_ColSiao_ColA{6}:=->[SIAO_Situations:52]Ss_Intitule:9  // P7/$va_SousTheme:="A"/Rang1
		ta_ColSiao_ColACas{6}:="07A1"
		
		ta_ColSiao_ColA{7}:="Logement souhaité"
		tp_ColSiao_ColA{7}:=->[SIAO:50]Si_Log_Souhaite1:22
		ta_ColSiao_ColACas{7}:="XX22"
		
		ta_ColSiao_ColA{8}:="Motif de la demande"
		tp_ColSiao_ColA{8}:=->[SIAO_Situations:52]Ss_Intitule:9  // P7/$va_SousTheme:="B"/Rang1
		ta_ColSiao_ColACas{8}:="07B1"
		
		ta_ColSiao_ColA{9}:="Dossier Dalo"
		tp_ColSiao_ColA{9}:=->[SIAO_Situations:52]Ss_Check_1:11  // P8/$va_SousTheme:="B"/Rang3
		ta_ColSiao_ColACas{9}:="08B3"
		
		ta_ColSiao_ColA{10}:="Dossier Daho"
		tp_ColSiao_ColA{10}:=->[SIAO_Situations:52]Ss_Check_1:11  // P8/$va_SousTheme:="B"/Rang6
		ta_ColSiao_ColACas{10}:="08B6"
		
		ta_ColSiao_ColA{11}:="Besoin d'accompagnement"
		tp_ColSiao_ColA{11}:=->[SIAO_Situations:52]Ss_Intitule:9  // P10/$va_SousTheme:="A"/Rang1
		ta_ColSiao_ColACas{11}:="10A1"
		
		ta_ColSiao_ColA{12}:="Logement adapté"
		tp_ColSiao_ColA{12}:=->[SIAO_Situations:52]Ss_Intitule:9  // P10/$va_SousTheme:="B"/Rang1
		ta_ColSiao_ColACas{12}:="10B1"
		
		ta_ColSiao_ColA{13}:="Type d'accompagnement préconisé"
		tp_ColSiao_ColA{13}:=->[SIAO_Situations:52]Ss_Intitule:9  // P10/$va_SousTheme:="C"/Rang1
		ta_ColSiao_ColACas{13}:="10C1"
		
		ta_ColSiao_ColA{14}:="Proposition d'orientation de la personne ayant effectué l'entretien"
		tp_ColSiao_ColA{14}:=->[SIAO_Situations:52]Ss_Intitule:9  // P12/$va_SousTheme:="B"/Rang1
		ta_ColSiao_ColACas{14}:="12B1"
		
		ta_ColSiao_ColA{15}:="Proposition d'orientation du SIAO"
		tp_ColSiao_ColA{15}:=->[SIAO_Situations:52]Ss_Intitule:9  // P12/$va_SousTheme:="C"/Rang1
		ta_ColSiao_ColACas{15}:="12C1"
		
		
		ta_ColSiao_ColA{16}:="Site d'accueil"
		tp_ColSiao_ColA{16}:=->[SIAO:50]Si_Origine_SiteAccueil:18
		ta_ColSiao_ColACas{16}:="XX18"
		
		ta_ColSiao_ColA{17}:="SIAO Compétent"
		tp_ColSiao_ColA{17}:=->[SIAO:50]Si_Trans_Competent:35
		ta_ColSiao_ColACas{17}:="XX35"
		
		COPY ARRAY:C226(ta_ColSiao_ColA; ta_ColSiao_ColB)
		COPY ARRAY:C226(ta_ColSiao_ColACas; ta_ColSiao_ColBCas)
		COPY ARRAY:C226(tp_ColSiao_ColA; tp_ColSiao_ColB)
		
		ta_ColSiao_ColA:=15
		ta_ColSiao_ColB:=7
		
		ta_ColSiao_ColACas:=ta_ColSiao_ColA
		tp_ColSiao_ColA:=ta_ColSiao_ColA
		
		ta_ColSiao_ColBCas:=ta_ColSiao_ColB
		tp_ColSiao_ColB:=ta_ColSiao_ColB
		
		C_TEXT:C284(va_TitreProposition; va_TitreLogement)
		C_TEXT:C284(va_ColProposition; va_ColPropositionTVrai; va_ColPropositionTFaux)
		va_ColPropositionTVrai:="Propostion SIAO"
		va_ColPropositionTFaux:="Propostion du professionnel"
		C_TEXT:C284(va_ColLogement; va_ColLogementTVrai; va_ColLogementTFaux)
		
		va_ColLogementTVrai:="Logement actuel"
		va_ColLogementTFaux:="Logement souhaité"
		
		C_BOOLEAN:C305(vb_ColProposition; vb_ColLogement)
		vb_ColProposition:=True:C214
		va_ColProposition:=va_ColPropositionTVrai
		vb_ColLogement:=True:C214
		va_ColLogement:=va_ColLogementTVrai
		
		
		va_ColProposition:=ta_ColSiao_ColA{ta_ColSiao_ColA}
		
		va_ColLogement:=ta_ColSiao_ColB{ta_ColSiao_ColB}
		
		
		
	: ($1=1)
		If (vb_ColProposition)
			vb_ColProposition:=False:C215
			va_ColProposition:=va_ColPropositionTFaux
		Else 
			vb_ColProposition:=True:C214
			va_ColProposition:=va_ColPropositionTVrai
		End if 
		REDRAW:C174([SIAO:50])
		
	: ($1=2)
		If (vb_ColLogement)
			vb_ColLogement:=False:C215
			va_ColLogement:=va_ColLogementTFaux
		Else 
			vb_ColLogement:=True:C214
			va_ColLogement:=va_ColLogementTVrai
		End if 
		REDRAW:C174([SIAO:50])
		
		
End case 