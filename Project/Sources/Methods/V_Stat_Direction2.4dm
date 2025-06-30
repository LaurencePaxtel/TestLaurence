//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : V_Stat_Direction2
//{
//{          Lundi 21 Juin 2004 à 12:31:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)
Case of 
	: ($1=0)  //•••••••••••••••••••Déclaration
		//1ere partie
		
		C_TEXT:C284(va_TitreCtr)
		va_TitreCtr:=""
		C_DATE:C307(vd_Date1; vd_Date2)
		C_LONGINT:C283(vl_NbJ)
		C_TEXT:C284(vt_StTexte)
		C_LONGINT:C283(vl_Break)
		C_LONGINT:C283(vl_Break2)
		C_LONGINT:C283(vl_NbHB)
		C_LONGINT:C283(vl_NbHBd)
		C_TEXT:C284(va_OrOr)
		
		ARRAY LONGINT:C221(<>tsp_IDHBj; 0)
		ARRAY LONGINT:C221(<>tsp_Nbj; 0)
		ARRAY LONGINT:C221(<>tsp_IDHBn; 0)
		ARRAY LONGINT:C221(<>tsp_Nbn; 0)
		
		
		
		
		
		
		ARRAY TEXT:C222(<>ta_PopCT_Centre; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_ID; 0)
		
		//Demandes et Hébergements et personnes #
		ARRAY LONGINT:C221(<>tl_PopCT_DrTHg; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrTHgé; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrTDem; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_DrTPers; 0)
		
		//Nb Hébergements par personnes
		ARRAY LONGINT:C221(<>tl_PopCT_OrT; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_OrNb; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_OrJ; 0; 0)
		ARRAY LONGINT:C221(<>tl_PopCT_OrN; 0; 0)
		C_LONGINT:C283(<>vl_PopCT_OrT)
		C_LONGINT:C283(<>vl_PopCT_OrNb)
		C_LONGINT:C283(<>vl_PopCT_OrJ)
		C_LONGINT:C283(<>vl_PopCT_OrN)
		
		
		
		//Par jour
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
		
		
		
		
		ARRAY LONGINT:C221(<>tsp_IDHB; 0)
		ARRAY LONGINT:C221(<>tsp_NbJ; 0)
		ARRAY LONGINT:C221(<>tsp_NbN; 0)
		ARRAY LONGINT:C221(<>tsp_NbJc; 0)
		ARRAY LONGINT:C221(<>tsp_NbNc; 0)
		ARRAY LONGINT:C221(<>tsp_NbTout; 0)
		ARRAY LONGINT:C221(<>tsp_NbToutc; 0)
		
		ARRAY DATE:C224(<>ts_Date; 0)
		ARRAY BOOLEAN:C223(<>ts_Nuit; 0)
		ARRAY LONGINT:C221(<>ts_IDHB; 0)
		ARRAY LONGINT:C221(<>ts_IDLC; 0)
		ARRAY BOOLEAN:C223(<>ts_Cloturé; 0)
		
		ARRAY LONGINT:C221(td_ORnb; 0)
		ARRAY LONGINT:C221(td_ORJ; 0)
		ARRAY LONGINT:C221(td_ORN; 0)
		ARRAY LONGINT:C221(td_ORT; 0)
		C_LONGINT:C283(vl_ORnb)
		C_LONGINT:C283(vl_ORJ)
		C_LONGINT:C283(vl_ORN)
		C_LONGINT:C283(vl_ORT)
		
		ARRAY DATE:C224(td_DrDt; 0)
		ARRAY LONGINT:C221(td_DrAjJ; 0)
		ARRAY LONGINT:C221(td_DrAjN; 0)
		ARRAY LONGINT:C221(td_DrAjT; 0)
		ARRAY LONGINT:C221(td_DrOjJ; 0)
		ARRAY LONGINT:C221(td_DrOjN; 0)
		ARRAY LONGINT:C221(td_DrOjT; 0)
		C_LONGINT:C283(vl_DrAjJ)
		C_LONGINT:C283(vl_DrAjN)
		C_LONGINT:C283(vl_DrAjT)
		C_LONGINT:C283(vl_DrOjJ)
		C_LONGINT:C283(vl_DrOjN)
		C_LONGINT:C283(vl_DrOjT)
		
		ARRAY DATE:C224(td_DrMs; 0)
		ARRAY LONGINT:C221(td_DrAmJ; 0)
		ARRAY LONGINT:C221(td_DrAmN; 0)
		ARRAY LONGINT:C221(td_DrAmT; 0)
		ARRAY LONGINT:C221(td_DrOmJ; 0)
		ARRAY LONGINT:C221(td_DrOmN; 0)
		ARRAY LONGINT:C221(td_DrOmT; 0)
		C_LONGINT:C283(vl_DrAmJ)
		C_LONGINT:C283(vl_DrAmN)
		C_LONGINT:C283(vl_DrAmT)
		C_LONGINT:C283(vl_DrOmJ)
		C_LONGINT:C283(vl_DrOmN)
		C_LONGINT:C283(vl_DrOmT)
		
		C_LONGINT:C283(vl_DrTDem; vl_DrTPers; vl_DrTHg; vl_DrTHgé)
		
		
		
		
	: ($1=1)  //•••••••••••••••••••Mise à zéro
		//2ème partie
		ARRAY LONGINT:C221(<>tsp_IDHB; 0)
		ARRAY LONGINT:C221(<>tsp_NbJ; 0)
		ARRAY LONGINT:C221(<>tsp_NbN; 0)
		ARRAY LONGINT:C221(<>tsp_NbJc; 0)
		ARRAY LONGINT:C221(<>tsp_NbNc; 0)
		ARRAY LONGINT:C221(<>tsp_NbTout; 0)
		ARRAY LONGINT:C221(<>tsp_NbToutc; 0)
		
		ARRAY DATE:C224(<>ts_Date; 0)
		ARRAY BOOLEAN:C223(<>ts_Nuit; 0)
		ARRAY LONGINT:C221(<>ts_IDHB; 0)
		ARRAY LONGINT:C221(<>ts_IDLC; 0)
		ARRAY BOOLEAN:C223(<>ts_Cloturé; 0)
		
		ARRAY LONGINT:C221(td_ORnb; 0)
		ARRAY LONGINT:C221(td_ORJ; 0)
		ARRAY LONGINT:C221(td_ORN; 0)
		ARRAY LONGINT:C221(td_ORT; 0)
		vl_ORnb:=0
		vl_ORJ:=0
		vl_ORN:=0
		vl_ORT:=0
		
		ARRAY DATE:C224(td_DrDt; 0)
		ARRAY LONGINT:C221(td_DrAjJ; 0)
		ARRAY LONGINT:C221(td_DrAjN; 0)
		ARRAY LONGINT:C221(td_DrAjT; 0)
		ARRAY LONGINT:C221(td_DrOjJ; 0)
		ARRAY LONGINT:C221(td_DrOjN; 0)
		ARRAY LONGINT:C221(td_DrOjT; 0)
		vl_DrAjJ:=0
		vl_DrAjN:=0
		vl_DrAjT:=0
		vl_DrOjJ:=0
		vl_DrOjN:=0
		vl_DrOjT:=0
		
		
		
		ARRAY DATE:C224(td_DrMs; 0)
		ARRAY LONGINT:C221(td_DrAmJ; 0)
		ARRAY LONGINT:C221(td_DrAmN; 0)
		ARRAY LONGINT:C221(td_DrAmT; 0)
		ARRAY LONGINT:C221(td_DrOmJ; 0)
		ARRAY LONGINT:C221(td_DrOmN; 0)
		ARRAY LONGINT:C221(td_DrOmT; 0)
		vl_DrAmJ:=0
		vl_DrAmN:=0
		vl_DrAmT:=0
		vl_DrOmJ:=0
		vl_DrOmN:=0
		vl_DrOmT:=0
		
		
		vl_DrTDem:=0
		vl_DrTPers:=0
		vl_DrTHg:=0
		vl_DrTHgé:=0
		
	: ($1=2)
		
End case 