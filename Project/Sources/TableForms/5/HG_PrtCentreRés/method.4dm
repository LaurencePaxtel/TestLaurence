//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Formule format : HG_Li_Report  
//{
//{          Dimanche 2 Mars 1997 à 14:51:28
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur impression corps:K2:18)
		va_NomClé:=Uut_HébergéClé(->[HeberGement:5]HG_Nom:21; ->[HeberGement:5]HG_Prénom:22; ->[HeberGement:5]HG_DateNéLe:24)
		vl_Indice:=vl_Indice+1
		
		
		vl_IndiceJour:=<>tsC_NbJours{vl_Indice}
		vl_IndicePers:=<>tsC_NbPers{vl_Indice}
		vl_IndiceCh:=<>tsC_NbChbres{vl_Indice}
		vr_IndicePxJour:=<>tsC_CoutJour{vl_Indice}
		vr_IndiceTotal:=<>tsC_Cout{vl_Indice}
		
	: ($vl_EventFF=Sur impression pied de page:K2:20)
		vl_Page:=Printing page:C275
End case 
