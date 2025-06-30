//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Fonction : F_Fiche115
//{          Mercredi 25 mai 2011 à 12:35
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215

If (<>vb_T_ModeCHRS)
	$0:=([HeberGement:5]HG_Nuit:2=False:C215) & ([HeberGement:5]HG_Trans_FicheNuméro:143>"")
Else 
	$0:=([HeberGement:5]HG_Nuit:2=False:C215)
	$0:=$0 & ([HeberGement:5]HG_LC_ID:61><>vl_T_CentreCodeDebut)
	$0:=$0 & ([HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin)
End if 