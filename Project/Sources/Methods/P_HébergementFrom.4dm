//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementFrom
//{
//{          Mardi 11 Mai 2004 à 10:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)

C_LONGINT:C283($ii)

Case of 
	: ($1="")  //Rien
	: ($1="V")  //depuis la veille
		OBJECT SET VISIBLE:C603(*; "Prest_1"; False:C215)  //Prestations
		OBJECT SET VISIBLE:C603(*; "ActionPrt_1"; False:C215)  //Imprimer actions     
	: ($1="SD")  //Partie concernant la saisie différée
		
		If (<>vb_RéservationActive=False:C215)
			OBJECT SET ENTERABLE:C238([HeberGement:5]HG_Réservation:91; <>vb_RéservationActive)
			OBJECT SET ENTERABLE:C238([HeberGement:5]HG_NuitenCours:92; <>vb_RéservationActive)
			OBJECT SET ENTERABLE:C238([HeberGement:5]HG_NuitTOTAL:93; <>vb_RéservationActive)
			OBJECT SET ENTERABLE:C238([HeberGement:5]HG_Reporté:94; <>vb_RéservationActive)
			OBJECT SET VISIBLE:C603(*; "Exc_@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Remp_@"; False:C215)
		End if 
		
	: ($1="P")  //Activer montrer ou inactiver cacher Si  l'appel est "P"
		OBJECT SET VISIBLE:C603(*; "Prest_1"; False:C215)  //Imprimer actions     
		OBJECT SET VISIBLE:C603(*; "ActionPrt_1"; False:C215)  //Imprimer actions     
		OBJECT SET VISIBLE:C603(*; "ActionPrt_2"; False:C215)  //Imprimer actions     
		OBJECT SET VISIBLE:C603(*; "Notes_Note"; False:C215)  //Imprimer actions     
		OBJECT SET VISIBLE:C603(*; "Notes_Action"; False:C215)  //Imprimer actions     
		OBJECT SET VISIBLE:C603(*; "AF"; False:C215)  //Imprimer actions     
		OBJECT SET VISIBLE:C603(*; "Notes_SP"; False:C215)  //Imprimer actions     
		OBJECT SET VISIBLE:C603(*; "Notes_NR"; False:C215)  //Imprimer actions     
		OBJECT SET VISIBLE:C603(*; "Valider_1"; False:C215)  //Imprimer actions     
		OBJECT SET VISIBLE:C603(*; "Valider_RectRond"; False:C215)  //Imprimer actions     
		OBJECT SET VISIBLE:C603(*; "Notes_SP"; False:C215)  //Imprimer actions 
		
		OBJECT SET ENABLED:C1123(x1; False:C215)
		OBJECT SET ENABLED:C1123(x2; False:C215)
		OBJECT SET ENABLED:C1123(b_FamClé; False:C215)
		OBJECT SET ENABLED:C1123(b_EtatCivil; False:C215)
		
		OBJECT SET ENTERABLE:C238([HeberGement:5]HG_Réservation:91; False:C215)
		OBJECT SET ENTERABLE:C238([HeberGement:5]HG_NuitenCours:92; False:C215)
		OBJECT SET ENTERABLE:C238([HeberGement:5]HG_NuitTOTAL:93; False:C215)
		OBJECT SET ENTERABLE:C238([HeberGement:5]HG_Reporté:94; False:C215)
	: ($1="PR")  //Participation
		OBJECT SET ENABLED:C1123(b_ta_FMDis1; False:C215)
		OBJECT SET ENABLED:C1123(b_ta_FMDis2; False:C215)
		OBJECT SET ENABLED:C1123(b_ta_FMDis3; False:C215)
		OBJECT SET ENABLED:C1123(b_ta_FMDis4; False:C215)
		OBJECT SET ENABLED:C1123(b_ta_FMDis5; False:C215)
		
		OBJECT SET ENTERABLE:C238([HeberGement:5]HG_FamDistri1M:118; False:C215)
		OBJECT SET ENTERABLE:C238([HeberGement:5]HG_FamDistri2M:119; False:C215)
		OBJECT SET ENTERABLE:C238([HeberGement:5]HG_FamDistri3M:120; False:C215)
		OBJECT SET ENTERABLE:C238([HeberGement:5]HG_FamDistri4M:121; False:C215)
		OBJECT SET ENTERABLE:C238([HeberGement:5]HG_FamDistri5M:122; False:C215)
		OBJECT SET ENTERABLE:C238([HeberGement:5]HG_Participation:138; User in group:C338(Current user:C182; <>Groupe_Participe))
	: ($1="PF")  //Plateforme
		//Champ Plateforme
		OBJECT SET VISIBLE:C603(*; "139_@"; False:C215)
		
		If (User in group:C338(Current user:C182; <>Groupe_Plateforme))
			OBJECT SET VISIBLE:C603(*; "139_@"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "139_Cdr1"; True:C214)
			OBJECT SET VISIBLE:C603(*; "139_Chp"; True:C214)
			OBJECT SET ENTERABLE:C238([HeberGement:5]HG_Plateforme:139; False:C215)
		End if 
		
	: ($1="CP")  //◊ve_Si_ModeCHRS Paramètres
		
		If (<>ve_Si_ModeCHRS=1)  //Prestation
			OBJECT SET ENTERABLE:C238([HeberGement:5]HG_Réservation:91; False:C215)
			OBJECT SET ENTERABLE:C238([HeberGement:5]HG_NuitenCours:92; False:C215)
			OBJECT SET ENTERABLE:C238([HeberGement:5]HG_NuitTOTAL:93; False:C215)
			OBJECT SET ENTERABLE:C238([HeberGement:5]HG_Reporté:94; False:C215)
			
			OBJECT SET VISIBLE:C603(*; "Exc_@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Remp_@"; False:C215)
		Else 
			P_MasqueEtatCivil([HeberGement:5]HG_EtatCivil:20)  //22/4/2008
		End if 
		
	: ($1="CT")  //◊ve_Si_ModeCHRS TITRE : Prestation ou Centre
		
		If (<>ve_Si_ModeCHRS=1)  //Prestation
			va_TitreCentrePrest:=xliff_Txt_Get_Indexed_String_(31011; 5)  //"Prestation"               
		Else 
			va_TitreCentrePrest:=xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 51)  //"Centres         
		End if 
		
	: ($1="CG")  //◊vb_T_ModeCHRS=Vrai
		
		If (<>vb_T_ModeCHRS=True:C214)
			COPY ARRAY:C226(<>ta_FMGrp; <>ta_FMGrpCHRS)
			$ii:=Size of array:C274(<>ta_FMGrpCHRS)
			
			Repeat 
				
				If (<>ta_FMGrpCHRS{$ii}#(Substring:C12(<>va_UserPlateforme; 1; 4)+"@"))
					DELETE FROM ARRAY:C228(<>ta_FMGrpCHRS; $ii; 1)
				End if 
				
				$ii:=$ii-1
			Until ($ii<1)
			
		Else 
			COPY ARRAY:C226(<>ta_FMGrp; <>ta_FMGrpCHRS)
		End if 
		
End case 