//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : v_Stat_DirectionCentre
//{
//{          Lundi 21 Juin 2004 à 12:31:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($ii)

Case of 
	: ($1=0)  //•••••••••••••••••••Déclaration
		//1ere partie
		C_TEXT:C284(va_TitreCtr; vt_StTexte; va_OrOr)
		C_LONGINT:C283(vl_NbJ; vl_Break; vl_Break2; vl_NbHB; vl_NbHBd)
		C_DATE:C307(vd_Date1; vd_Date2)
		
		va_TitreCtr:=""
		
		//Nombre de fiches
		C_LONGINT:C283(vl_NbHB)
		
		//PopUp des centres
		ARRAY TEXT:C222(<>ta_PopCT_Centre; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_ID; 0)
		
		//Demandes et Hébergements et personnes #
		C_LONGINT:C283(<>vl_DrTHg; <>vl_DrTHgé; <>vl_DrTDem; <>vlDrTPers)
		
		ARRAY LONGINT:C221(<>tl_PopCT_DrTHg; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrTHgé; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrTDem; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrTPers; 0)
		
		//Pour calcul des par personne
		ARRAY LONGINT:C221(<>tl_PopCT_IDHB; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_NbJ; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_NbN; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_NbJc; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_NbNc; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_NbTout; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_NbToutc; 0; 0)
		
		//Nb Hébergements par personnes
		ARRAY LONGINT:C221(<>tl_PopCT_OrT; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_OrNb; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_OrJ; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_OrN; 0; 0)
		
		//Affichage
		ARRAY LONGINT:C221(<>tl_PopA_OrT; 0)
		ARRAY LONGINT:C221(<>tl_PoA_OrNb; 0)
		ARRAY LONGINT:C221(<>tl_PopA_OrJ; 0)
		ARRAY LONGINT:C221(<>tl_PopA_OrN; 0)
		
		C_LONGINT:C283(<>vl_PopA_OrT)
		C_LONGINT:C283(<>vl_PopA_OrNb)
		C_LONGINT:C283(<>vl_PopA_OrJ)
		C_LONGINT:C283(<>vl_PopA_OrN)
		
		ARRAY DATE:C224(<>td_PopCT_Date; 0)
		
		//Par jour
		//Par jour : Affichage
		ARRAY DATE:C224(<>td_PopA_DrDt; 0)
		
		ARRAY LONGINT:C221(<>tl_PopA_DrAjJ; 0)
		ARRAY LONGINT:C221(<>tl_PopA_DrAjN; 0)
		ARRAY LONGINT:C221(<>tl_PoA_DrAjT; 0)
		ARRAY LONGINT:C221(<>tl_PopA_DrOjJ; 0)
		ARRAY LONGINT:C221(<>tl_PopA_DrOjN; 0)
		ARRAY LONGINT:C221(<>tl_PoA_DrOjT; 0)
		
		//Par jour : Calcul
		ARRAY DATE:C224(<>td_PopCT_DrDt; 0; 0)
		
		ARRAY LONGINT:C221(<>tl_PopCT_DrAjJ; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrAjN; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrAjT; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrOjJ; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrOjN; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrOjT; 0; 0)
		
		C_LONGINT:C283(<>vl_PopCT_DrAjJ)
		C_LONGINT:C283(<>vl_PopCT_DrAjN)
		C_LONGINT:C283(<>vl_PopCT_DrAjT)
		C_LONGINT:C283(<>vl_PopCT_DrOjJ)
		C_LONGINT:C283(<>vl_PopCT_DrOjN)
		C_LONGINT:C283(<>vl_PopCT_DrOjT)
		
		
		//Par mois
		//Par mois : Affichage
		ARRAY DATE:C224(<>td_PopA_DrMs; 0)
		
		ARRAY LONGINT:C221(<>tl_PopA_DrAmJ; 0)
		ARRAY LONGINT:C221(<>tl_PopA_DrAmN; 0)
		ARRAY LONGINT:C221(<>tl_PopA_DrAmT; 0)
		ARRAY LONGINT:C221(<>tl_PopA_DrOmJ; 0)
		ARRAY LONGINT:C221(<>tl_PopA_DrOmN; 0)
		ARRAY LONGINT:C221(<>tl_PopA_DrOmT; 0)
		
		//Par mois : Calcul
		ARRAY DATE:C224(<>td_PopCT_DrMs; 0; 0)
		
		ARRAY LONGINT:C221(<>tl_PopCT_DrAmJ; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrAmN; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrAmT; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrOmJ; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrOmN; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrOmT; 0; 0)
		
		C_LONGINT:C283(<>vl_PopCT_DrAmJ)
		C_LONGINT:C283(<>vl_PopCT_DrAmN)
		C_LONGINT:C283(<>vl_PopCT_DrAmT)
		C_LONGINT:C283(<>vl_PopCT_DrOmJ)
		C_LONGINT:C283(<>vl_PopCT_DrOmN)
		C_LONGINT:C283(<>vl_PopCT_DrOmT)
		
		ARRAY DATE:C224(<>ts_Date; 0)
		
		ARRAY LONGINT:C221(<>ts_IDHB; 0)
		ARRAY LONGINT:C221(<>ts_IDLC; 0)
		
		ARRAY BOOLEAN:C223(<>ts_Nuit; 0)
		ARRAY BOOLEAN:C223(<>ts_Cloturé; 0)
	: ($1=1)  //•••••••••••••••••••Mise à zéro
		
		
	: ($1=2)
		//Hébergements et Personnes par Demande et Affectation    
		ARRAY LONGINT:C221(<>tl_PopCT_DrTHg; $2)
		ARRAY LONGINT:C221(<>tl_PopCT_DrTHgé; $2)
		ARRAY LONGINT:C221(<>tl_PopCT_DrTDem; $2)
		ARRAY LONGINT:C221(<>tl_PopCT_DrTPers; $2)
		
		//Pour calcul des par personne
		ARRAY LONGINT:C221(<>tl_PopCT_IDHB; $2; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_NbJ; $2; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_NbN; $2; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_NbJc; $2; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_NbNc; $2; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_NbTout; $2; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_NbToutc; $2; 0)
		
		//Nb Hébergements par personnes
		ARRAY LONGINT:C221(<>tl_PopCT_OrT; $2; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_OrNb; $2; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_OrJ; $2; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_OrN; $2; 0)
		
		//Par jour
		ARRAY DATE:C224(<>td_PopCT_DrDt; $2; 0)
		
		ARRAY LONGINT:C221(<>tl_PopCT_DrAjJ; $2; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrAjN; $2; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrAjT; $2; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrOjJ; $2; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrOjN; $2; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrOjT; $2; 0)
		
		//Par mois
		ARRAY DATE:C224(<>td_PopCT_DrMs; $2; 0)
		
		ARRAY LONGINT:C221(<>tl_PopCT_DrAmJ; $2; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrAmN; $2; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrAmT; $2; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrOmJ; $2; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrOmN; $2; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrOmT; $2; 0)
	: ($1=3)
		//Par jour 
		<>vl_PopCT_DrAjJ:=0
		<>vl_PopCT_DrAjN:=0
		<>vl_PopCT_DrAjT:=0
		<>vl_PopCT_DrOjJ:=0
		<>vl_PopCT_DrOjN:=0
		<>vl_PopCT_DrOjT:=0
		
		$ii:=Size of array:C274(<>td_PopCT_DrDt{$2})
		ARRAY DATE:C224(<>td_PopA_DrDt; $ii)
		
		ARRAY LONGINT:C221(<>tl_PopA_DrAjJ; $ii)
		ARRAY LONGINT:C221(<>tl_PopA_DrAjN; $ii)
		ARRAY LONGINT:C221(<>tl_PoA_DrAjT; $ii)
		ARRAY LONGINT:C221(<>tl_PopA_DrOjJ; $ii)
		ARRAY LONGINT:C221(<>tl_PopA_DrOjN; $ii)
		ARRAY LONGINT:C221(<>tl_PoA_DrOjT; $ii)
		
		For ($ii; 1; Size of array:C274(<>td_PopCT_DrDt{$2}))
			<>td_PopA_DrDt{$ii}:=<>td_PopCT_DrDt{$2}{$ii}
			<>tl_PopA_DrAjJ{$ii}:=<>tl_PopCT_DrAjJ{$2}{$ii}
			<>tl_PopA_DrAjN{$ii}:=<>tl_PopCT_DrAjN{$2}{$ii}
			<>tl_PoA_DrAjT{$ii}:=<>tl_PopCT_DrAjT{$2}{$ii}
			<>tl_PopA_DrOjJ{$ii}:=<>tl_PopCT_DrOjJ{$2}{$ii}
			<>tl_PopA_DrOjN{$ii}:=<>tl_PopCT_DrOjN{$2}{$ii}
			<>tl_PoA_DrOjT{$ii}:=<>tl_PopCT_DrOjT{$2}{$ii}
			
			<>vl_PopCT_DrAjJ:=<>vl_PopCT_DrAjJ+<>tl_PopA_DrAjJ{$ii}
			<>vl_PopCT_DrAjN:=<>vl_PopCT_DrAjN+<>tl_PopA_DrAjN{$ii}
			<>vl_PopCT_DrAjT:=<>vl_PopCT_DrAjT+<>tl_PoA_DrAjT{$ii}
			<>vl_PopCT_DrOjJ:=<>vl_PopCT_DrOjJ+<>tl_PopA_DrOjJ{$ii}
			<>vl_PopCT_DrOjN:=<>vl_PopCT_DrOjN+<>tl_PopA_DrOjN{$ii}
			<>vl_PopCT_DrOjT:=<>vl_PopCT_DrOjT+<>tl_PoA_DrOjT{$ii}
		End for 
		
		//Par mois
		$ii:=Size of array:C274(<>td_PopCT_DrMs{$2})
		ARRAY DATE:C224(<>td_PopA_DrMs; $ii)
		
		ARRAY LONGINT:C221(<>tl_PopA_DrAmJ; $ii)
		ARRAY LONGINT:C221(<>tl_PopA_DrAmN; $ii)
		ARRAY LONGINT:C221(<>tl_PopA_DrAmT; $ii)
		ARRAY LONGINT:C221(<>tl_PopA_DrOmJ; $ii)
		ARRAY LONGINT:C221(<>tl_PopA_DrOmN; $ii)
		ARRAY LONGINT:C221(<>tl_PopA_DrOmT; $ii)
		
		<>vl_PopCT_DrAmJ:=0
		<>vl_PopCT_DrAmN:=0
		<>vl_PopCT_DrAmT:=0
		<>vl_PopCT_DrOmJ:=0
		<>vl_PopCT_DrOmN:=0
		<>vl_PopCT_DrOmT:=0
		
		For ($ii; 1; Size of array:C274(<>td_PopCT_DrMs{$2}))
			<>td_PopA_DrMs{$ii}:=<>td_PopCT_DrMs{$2}{$ii}
			<>tl_PopA_DrAmJ{$ii}:=<>tl_PopCT_DrAmJ{$2}{$ii}
			<>tl_PopA_DrAmN{$ii}:=<>tl_PopCT_DrAmN{$2}{$ii}
			<>tl_PopA_DrAmT{$ii}:=<>tl_PopCT_DrAmT{$2}{$ii}
			<>tl_PopA_DrOmJ{$ii}:=<>tl_PopCT_DrOmJ{$2}{$ii}
			<>tl_PopA_DrOmN{$ii}:=<>tl_PopCT_DrOmN{$2}{$ii}
			<>tl_PopA_DrOmT{$ii}:=<>tl_PopCT_DrOmT{$2}{$ii}
			
			<>vl_PopCT_DrAmJ:=<>vl_PopCT_DrAmJ+<>tl_PopA_DrAmJ{$ii}
			<>vl_PopCT_DrAmN:=<>vl_PopCT_DrAmN+<>tl_PopA_DrAmN{$ii}
			<>vl_PopCT_DrAmT:=<>vl_PopCT_DrAmT+<>tl_PopA_DrAmT{$ii}
			<>vl_PopCT_DrOmJ:=<>vl_PopCT_DrOmJ+<>tl_PopA_DrOmJ{$ii}
			<>vl_PopCT_DrOmN:=<>vl_PopCT_DrOmN+<>tl_PopA_DrOmN{$ii}
			<>vl_PopCT_DrOmT:=<>vl_PopCT_DrOmT+<>tl_PopA_DrOmT{$ii}
		End for 
		
		If (rSomme=1)
			<>vl_DrTDem:=<>tl_PopCT_DrTDem{0}
			<>vl_DrTPers:=<>tl_PopCT_DrTPers{0}
			<>vl_DrTHg:=<>tl_PopCT_DrTHg{0}
			<>vl_DrTHgé:=<>tl_PopCT_DrTHgé{0}
		Else 
			<>vl_DrTDem:=<>tl_PopCT_DrTDem{$2}
			<>vl_DrTPers:=<>tl_PopCT_DrTPers{$2}
			<>vl_DrTHg:=<>tl_PopCT_DrTHg{$2}
			<>vl_DrTHgé:=<>tl_PopCT_DrTHgé{$2}
		End if 
		
		$ii:=Size of array:C274(<>tl_PopCT_OrT{$2})
		
		ARRAY LONGINT:C221(<>tl_PopA_OrT; $ii)
		ARRAY LONGINT:C221(<>tl_PoA_OrNb; $ii)
		ARRAY LONGINT:C221(<>tl_PopA_OrJ; $ii)
		ARRAY LONGINT:C221(<>tl_PopA_OrN; $ii)
		
		<>vl_PopA_OrT:=0
		<>vl_PopA_OrNb:=0
		<>vl_PopA_OrJ:=0
		<>vl_PopA_OrN:=0
		
		For ($ii; 1; Size of array:C274(<>tl_PopCT_OrT{$2}))
			<>tl_PopA_OrJ{$ii}:=<>tl_PopCT_OrJ{$2}{$ii}
			<>tl_PopA_OrN{$ii}:=<>tl_PopCT_OrN{$2}{$ii}
			<>tl_PoA_OrNb{$ii}:=<>tl_PopCT_OrNb{$2}{$ii}
			<>tl_PopA_OrT{$ii}:=<>tl_PopCT_OrT{$2}{$ii}
			
			<>vl_PopA_OrJ:=<>vl_PopA_OrJ+<>tl_PopA_OrJ{$ii}
			<>vl_PopA_OrN:=<>vl_PopA_OrN+<>tl_PopA_OrN{$ii}
			<>vl_PopA_OrT:=<>vl_PopA_OrT+<>tl_PopA_OrT{$ii}
			<>vl_PopA_OrNb:=<>vl_PopA_OrNb+(<>tl_PoA_OrNb{$ii}*<>tl_PopA_OrT{$ii})
		End for 
		
End case 