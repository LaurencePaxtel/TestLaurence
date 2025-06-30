//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_DatesMoisEnCours
//{
//{          Mercredi 3 février 2010 à 12:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215

C_LONGINT:C283($ii; $kk; $vl_NbMois; $ve_MoisEnCours)

C_LONGINT:C283($1)
Case of 
	: ($1=0)
		C_LONGINT:C283(vl_MoisColEtatCivil; vl_MoisLigneEtatCivil)
		vl_MoisLigneEtatCivil:=4
		C_LONGINT:C283(ve_MoisCasNew)
		ve_MoisCasNew:=0
		
		
		
		ARRAY TEXT:C222(ta_MoisColEtatCivil; vl_MoisLigneEtatCivil)
		ta_MoisColEtatCivil{1}:="Homme seul"  //(HS)
		ta_MoisColEtatCivil{2}:="Femme seule"  //(FS)
		ta_MoisColEtatCivil{3}:="Couples"  //(HC-FC)
		ta_MoisColEtatCivil{4}:="Familles"  //(HF-HE-FF-FE FP-HP)
		
		
		
		ARRAY TEXT:C222(ta_MoisColDemande; 3)
		ta_MoisColDemande{1}:="Toutes les demandes"
		ta_MoisColDemande{2}:="Les demandes satisfaites"
		ta_MoisColDemande{3}:="Les demandes non satisfaites"
		ta_MoisColDemande:=2
		ta_MoisColDemande{0}:=ta_MoisColDemande{ta_MoisColDemande}
		
		C_DATE:C307(vd_DateAfficheDebut; vd_DateAfficheFin)
		C_LONGINT:C283(ve_MoisAfficheDebut; ve_MoisAfficheFin)
		C_TEXT:C284(va_MoisAffiche1; va_MoisAffiche2; va_MoisAffiche3; va_MoisAffiche4; va_MoisAffiche5; va_MoisAffiche6)
		C_TEXT:C284(va_MoisAffiche7; va_MoisAffiche8; va_MoisAffiche9; va_MoisAffiche10; va_MoisAffiche11; va_MoisAffiche12)
		ve_MoisAfficheDebut:=0
		ve_MoisAfficheFin:=0
		
		ARRAY LONGINT:C221(tl_3TP_Fiches; 0)
		ARRAY LONGINT:C221(tl_3TP_FichesOld; 0)
		ARRAY LONGINT:C221(tl_3TP_FichesOldFirst; 0)
		
		ARRAY LONGINT:C221(tl_MoisCol1; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisCol2; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisCol3; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisCol4; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisCol5; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisCol6; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisCol7; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisCol8; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisCol9; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisCol10; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisCol11; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisCol12; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisCol12; vl_MoisLigneEtatCivil)
		
		C_LONGINT:C283(vl_MoisCol1)
		C_LONGINT:C283(vl_MoisCol2)
		C_LONGINT:C283(vl_MoisCol3)
		C_LONGINT:C283(vl_MoisCol4)
		C_LONGINT:C283(vl_MoisCol5)
		C_LONGINT:C283(vl_MoisCol6)
		C_LONGINT:C283(vl_MoisCol7)
		C_LONGINT:C283(vl_MoisCol8)
		C_LONGINT:C283(vl_MoisCol9)
		C_LONGINT:C283(vl_MoisCol10)
		C_LONGINT:C283(vl_MoisCol11)
		C_LONGINT:C283(vl_MoisCol12)
		C_LONGINT:C283(vl_MoisColTOTAL)
		
		ARRAY LONGINT:C221(tl_MoisColNuit1; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColNuit2; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColNuit3; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColNuit4; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColNuit5; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColNuit6; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColNuit7; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColNuit8; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColNuit9; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColNuit10; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColNuit11; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColNuit12; vl_MoisLigneEtatCivil)
		
		C_LONGINT:C283(vl_MoisColNuit1)
		C_LONGINT:C283(vl_MoisColNuit2)
		C_LONGINT:C283(vl_MoisColNuit3)
		C_LONGINT:C283(vl_MoisColNuit4)
		C_LONGINT:C283(vl_MoisColNuit5)
		C_LONGINT:C283(vl_MoisColNuit6)
		C_LONGINT:C283(vl_MoisColNuit7)
		C_LONGINT:C283(vl_MoisColNuit8)
		C_LONGINT:C283(vl_MoisColNuit9)
		C_LONGINT:C283(vl_MoisColNuit10)
		C_LONGINT:C283(vl_MoisColNuit11)
		C_LONGINT:C283(vl_MoisColNuit12)
		C_LONGINT:C283(vl_MoisColNuitTotal)
		
		ARRAY LONGINT:C221(tl_MoisColPers1; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColPers2; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColPers3; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColPers4; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColPers5; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColPers6; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColPers7; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColPers8; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColPers9; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColPers10; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColPers11; vl_MoisLigneEtatCivil)
		ARRAY LONGINT:C221(tl_MoisColPers12; vl_MoisLigneEtatCivil)
		
		C_LONGINT:C283(vl_MoisColPers1)
		C_LONGINT:C283(vl_MoisColPers2)
		C_LONGINT:C283(vl_MoisColPers3)
		C_LONGINT:C283(vl_MoisColPers4)
		C_LONGINT:C283(vl_MoisColPers5)
		C_LONGINT:C283(vl_MoisColPers6)
		C_LONGINT:C283(vl_MoisColPers7)
		C_LONGINT:C283(vl_MoisColPers8)
		C_LONGINT:C283(vl_MoisColPers9)
		C_LONGINT:C283(vl_MoisColPers10)
		C_LONGINT:C283(vl_MoisColPers11)
		C_LONGINT:C283(vl_MoisColPers12)
		C_LONGINT:C283(vl_MoisColPersTotal)
		
		ARRAY INTEGER:C220(te_MoisDateAffiche; 0)
		ARRAY DATE:C224(td_DateAfficheDebut; 0)
		ARRAY DATE:C224(td_DateAfficheFin; 0)
		
		ARRAY LONGINT:C221(tl_3TP_Pers1; 0)
		ARRAY LONGINT:C221(tl_3TP_Pers2; 0)
		ARRAY LONGINT:C221(tl_3TP_Pers3; 0)
		ARRAY LONGINT:C221(tl_3TP_Pers4; 0)
		
		//Pour conserver les fiches d'hébregemnts respectifs
		ARRAY LONGINT:C221(tl_MoisColFicN1_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN1_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN1_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN1_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN2_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN2_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN2_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN2_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN3_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN3_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN3_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN3_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN4_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN4_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN4_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN4_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN5_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN5_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN5_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN5_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN6_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN6_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN6_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN6_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN7_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN7_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN7_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN7_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN8_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN8_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN8_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN8_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN9_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN9_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN9_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN9_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN10_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN10_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN10_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN10_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN11_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN11_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN11_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN11_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN12_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN12_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN12_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN12_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP1_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP1_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP1_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP1_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP2_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP2_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP2_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP2_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP3_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP3_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP3_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP3_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP4_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP4_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP4_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP4_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP5_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP5_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP5_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP5_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP6_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP6_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP6_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP6_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP7_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP7_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP7_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP7_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP8_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP8_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP8_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP8_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP9_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP9_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP9_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP9_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP10_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP10_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP10_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP10_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP11_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP11_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP11_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP11_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP12_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP12_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP12_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP12_4; 0)
		
		
		
		//Les personnes nouvelles
		ARRAY LONGINT:C221(tl_MoisColPersNew1; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew2; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew3; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew4; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew5; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew6; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew7; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew8; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew9; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew10; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew11; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew12; 0)
		
		
		C_LONGINT:C283(vl_MoisColPersNew1)
		C_LONGINT:C283(vl_MoisColPersNew2)
		C_LONGINT:C283(vl_MoisColPersNew3)
		C_LONGINT:C283(vl_MoisColPersNew4)
		C_LONGINT:C283(vl_MoisColPersNew5)
		C_LONGINT:C283(vl_MoisColPersNew6)
		C_LONGINT:C283(vl_MoisColPersNew7)
		C_LONGINT:C283(vl_MoisColPersNew8)
		C_LONGINT:C283(vl_MoisColPersNew9)
		C_LONGINT:C283(vl_MoisColPersNew10)
		C_LONGINT:C283(vl_MoisColPersNew11)
		C_LONGINT:C283(vl_MoisColPersNew12)
		C_LONGINT:C283(vl_MoisColPersNewTotal)
		
	: ($1=1)
		ve_MoisCasNew:=0
		
		ARRAY LONGINT:C221(tl_3TP_Fiches; 0)
		ARRAY LONGINT:C221(tl_3TP_FichesOld; 0)
		
		ARRAY LONGINT:C221(tl_3TP_Pers1; 0)
		ARRAY LONGINT:C221(tl_3TP_Pers2; 0)
		ARRAY LONGINT:C221(tl_3TP_Pers3; 0)
		ARRAY LONGINT:C221(tl_3TP_Pers4; 0)
		
		ve_MoisAfficheDebut:=0
		ve_MoisAfficheFin:=0
		
		ARRAY INTEGER:C220(te_MoisDateAffiche; 0)
		ARRAY DATE:C224(td_DateAfficheDebut; 0)
		ARRAY DATE:C224(td_DateAfficheFin; 0)
		
		va_MoisAffiche1:=""
		va_MoisAffiche2:=""
		va_MoisAffiche3:=""
		va_MoisAffiche4:=""
		va_MoisAffiche5:=""
		va_MoisAffiche6:=""
		va_MoisAffiche7:=""
		va_MoisAffiche8:=""
		va_MoisAffiche9:=""
		va_MoisAffiche10:=""
		va_MoisAffiche11:=""
		va_MoisAffiche12:=""
		For ($ii; 1; vl_MoisLigneEtatCivil)
			tl_MoisCol1{$ii}:=0
			tl_MoisCol2{$ii}:=0
			tl_MoisCol3{$ii}:=0
			tl_MoisCol4{$ii}:=0
			tl_MoisCol5{$ii}:=0
			tl_MoisCol6{$ii}:=0
			tl_MoisCol7{$ii}:=0
			tl_MoisCol8{$ii}:=0
			tl_MoisCol9{$ii}:=0
			tl_MoisCol10{$ii}:=0
			tl_MoisCol11{$ii}:=0
			tl_MoisCol12{$ii}:=0
			
			tl_MoisColNuit1{$ii}:=0
			tl_MoisColNuit2{$ii}:=0
			tl_MoisColNuit3{$ii}:=0
			tl_MoisColNuit4{$ii}:=0
			tl_MoisColNuit5{$ii}:=0
			tl_MoisColNuit6{$ii}:=0
			tl_MoisColNuit7{$ii}:=0
			tl_MoisColNuit8{$ii}:=0
			tl_MoisColNuit9{$ii}:=0
			tl_MoisColNuit10{$ii}:=0
			tl_MoisColNuit11{$ii}:=0
			tl_MoisColNuit12{$ii}:=0
			
			tl_MoisColPers1{$ii}:=0
			tl_MoisColPers2{$ii}:=0
			tl_MoisColPers3{$ii}:=0
			tl_MoisColPers4{$ii}:=0
			tl_MoisColPers5{$ii}:=0
			tl_MoisColPers6{$ii}:=0
			tl_MoisColPers7{$ii}:=0
			tl_MoisColPers8{$ii}:=0
			tl_MoisColPers9{$ii}:=0
			tl_MoisColPers10{$ii}:=0
			tl_MoisColPers11{$ii}:=0
			tl_MoisColPers12{$ii}:=0
			
			
		End for 
		
		vl_MoisCol1:=0
		vl_MoisCol2:=0
		vl_MoisCol3:=0
		vl_MoisCol4:=0
		vl_MoisCol5:=0
		vl_MoisCol6:=0
		vl_MoisCol7:=0
		vl_MoisCol8:=0
		vl_MoisCol9:=0
		vl_MoisCol10:=0
		vl_MoisCol11:=0
		vl_MoisCol12:=0
		vl_MoisColTOTAL:=0
		
		vl_MoisColNuit1:=0
		vl_MoisColNuit2:=0
		vl_MoisColNuit3:=0
		vl_MoisColNuit4:=0
		vl_MoisColNuit5:=0
		vl_MoisColNuit6:=0
		vl_MoisColNuit7:=0
		vl_MoisColNuit8:=0
		vl_MoisColNuit9:=0
		vl_MoisColNuit10:=0
		vl_MoisColNuit11:=0
		vl_MoisColNuit12:=0
		vl_MoisColNuitTotal:=0
		
		vl_MoisColPers1:=0
		vl_MoisColPers2:=0
		vl_MoisColPers3:=0
		vl_MoisColPers4:=0
		vl_MoisColPers5:=0
		vl_MoisColPers6:=0
		vl_MoisColPers7:=0
		vl_MoisColPers8:=0
		vl_MoisColPers9:=0
		vl_MoisColPers10:=0
		vl_MoisColPers11:=0
		vl_MoisColPers12:=0
		vl_MoisColPersTotal:=0
		
		//Pour conserver les fiches d'hébregemnts respectifs
		ARRAY LONGINT:C221(tl_MoisColFicN1_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN1_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN1_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN1_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN2_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN2_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN2_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN2_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN3_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN3_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN3_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN3_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN4_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN4_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN4_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN4_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN5_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN5_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN5_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN5_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN6_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN6_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN6_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN6_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN7_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN7_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN7_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN7_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN8_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN8_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN8_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN8_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN9_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN9_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN9_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN9_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN10_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN10_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN10_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN10_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN11_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN11_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN11_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN11_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicN12_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN12_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN12_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicN12_4; 0)
		
		
		ARRAY LONGINT:C221(tl_MoisColFicP1_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP1_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP1_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP1_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP2_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP2_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP2_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP2_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP3_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP3_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP3_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP3_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP4_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP4_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP4_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP4_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP5_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP5_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP5_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP5_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP6_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP6_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP6_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP6_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP7_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP7_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP7_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP7_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP8_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP8_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP8_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP8_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP9_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP9_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP9_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP9_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP10_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP10_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP10_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP10_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP11_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP11_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP11_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP11_4; 0)
		
		ARRAY LONGINT:C221(tl_MoisColFicP12_1; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP12_2; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP12_3; 0)
		ARRAY LONGINT:C221(tl_MoisColFicP12_4; 0)
		
		//Les personnes nouvelles
		ARRAY LONGINT:C221(tl_MoisColPersNew1; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew2; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew3; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew4; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew5; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew6; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew7; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew8; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew9; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew10; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew11; 0)
		ARRAY LONGINT:C221(tl_MoisColPersNew12; 0)
		//Les personnes nouvelles
		vl_MoisColPersNew1:=0
		vl_MoisColPersNew2:=0
		vl_MoisColPersNew3:=0
		vl_MoisColPersNew4:=0
		vl_MoisColPersNew5:=0
		vl_MoisColPersNew6:=0
		vl_MoisColPersNew7:=0
		vl_MoisColPersNew8:=0
		vl_MoisColPersNew9:=0
		vl_MoisColPersNew10:=0
		vl_MoisColPersNew11:=0
		vl_MoisColPersNew12:=0
		vl_MoisColPersNewTotal:=0
		
		//Les personnes differentes
		ARRAY LONGINT:C221(tl_MoisColPersDif1; 0)
		ARRAY LONGINT:C221(tl_MoisColPersDif2; 0)
		ARRAY LONGINT:C221(tl_MoisColPersDif3; 0)
		ARRAY LONGINT:C221(tl_MoisColPersDif4; 0)
		ARRAY LONGINT:C221(tl_MoisColPersDif5; 0)
		ARRAY LONGINT:C221(tl_MoisColPersDif6; 0)
		ARRAY LONGINT:C221(tl_MoisColPersDif7; 0)
		ARRAY LONGINT:C221(tl_MoisColPersDif8; 0)
		ARRAY LONGINT:C221(tl_MoisColPersDif9; 0)
		ARRAY LONGINT:C221(tl_MoisColPersDif10; 0)
		ARRAY LONGINT:C221(tl_MoisColPersDif11; 0)
		ARRAY LONGINT:C221(tl_MoisColPersDif12; 0)
		
		
	: ($1=2)
		
		
		
		C_DATE:C307(D_date; D_date2)
		If (Application type:C494#4D Server:K5:6)
			D_date:=[DiaLogues:3]DL_Date:2
			D_date2:=[DiaLogues:3]DL_Date2:8
		End if 
		
		vd_DateAfficheDebut:=D_date
		ve_MoisAfficheDebut:=Month of:C24(vd_DateAfficheDebut)
		ve_MoisAfficheFin:=Month of:C24(D_date2)
		
		
		
		If (ve_MoisAfficheDebut>0) & (ve_MoisAfficheFin>0)
			Case of 
				: (ve_MoisAfficheDebut=ve_MoisAfficheFin)
					$vl_NbMois:=1
				: (ve_MoisAfficheDebut<ve_MoisAfficheFin)
					$vl_NbMois:=ve_MoisAfficheFin-ve_MoisAfficheDebut+1
				: (ve_MoisAfficheDebut>ve_MoisAfficheFin)
					$vl_NbMois:=12-ve_MoisAfficheDebut+1
					$vl_NbMois:=$vl_NbMois+ve_MoisAfficheFin
			End case 
			$ve_MoisEnCours:=ve_MoisAfficheDebut
			
			C_LONGINT:C283($L_ref)
			If (Application type:C494#4D Server:K5:6)
				$L_ref:=4D_Progression_Open("")
			End if 
			
			For ($ii; 1; $vl_NbMois)
				
				If (Application type:C494#4D Server:K5:6)
					
					C_OBJECT:C1216($O_Progression)
					OB SET:C1220($O_Progression; \
						"progress ref"; $L_ref; \
						"progress titel"; "Supervision journalière par période mensuelle"; \
						"progress message"; "Calcul en cours... du "+String:C10(D_date)+" au "+String:C10(D_date2); \
						"progress compteur"; $ii; \
						"progress max"; $vl_NbMois; \
						"progress stop"; -1\
						)
					4D_Progression_Send(->$O_Progression)
					
					
				End if 
				
				P_TroisTypoMois($ii; $ve_MoisEnCours)
				
				//   ◊vp_PointeurMoisX:=Pointeur vers("va_MoisAffiche"+Chaine($ii))
				//◊vp_PointeurMoisX->:=◊ta_LesMois{$ve_MoisEnCours}
				$kk:=Size of array:C274(td_DateAfficheDebut)+1
				INSERT IN ARRAY:C227(td_DateAfficheDebut; $kk; 1)
				INSERT IN ARRAY:C227(td_DateAfficheFin; $kk; 1)
				INSERT IN ARRAY:C227(te_MoisDateAffiche; $kk; 1)
				te_MoisDateAffiche{$kk}:=$ve_MoisEnCours
				If ($ii=1)
				Else 
					vd_DateAfficheDebut:=Add to date:C393(vd_DateAfficheDebut; 0; 1; 0)
				End if 
				td_DateAfficheDebut{$ii}:=vd_DateAfficheDebut
				vd_DateAfficheDebut:=Date:C102("1/"+String:C10(Month of:C24(vd_DateAfficheDebut))+"/"+String:C10(Year of:C25(vd_DateAfficheDebut)))
				If ($ii=$vl_NbMois)
					vd_DateAfficheFin:=D_date2
				Else 
					vd_DateAfficheFin:=Add to date:C393(vd_DateAfficheDebut; 0; 1; -1)
				End if 
				td_DateAfficheFin{$ii}:=vd_DateAfficheFin
				$ve_MoisEnCours:=$ve_MoisEnCours+1
				If ($ve_MoisEnCours=13)
					$ve_MoisEnCours:=1
				End if 
			End for 
			
			If (Application type:C494#4D Server:K5:6)
				4D_Progression_Close($L_ref)
			End if 
		End if 
		
		P_TroisTypo
		
		
End case 