//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_FaxExpDispo
//{
//{          Jeudi 28 juin 2007 à 12:29:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)
C_LONGINT:C283($vl_Type; $vl_Position1; $vl_Position2)
C_BOOLEAN:C305($vb_OK)
C_REAL:C285($vr_Taux)
$vl_Type:=Type:C295($1->)
$vb_OK:=False:C215
$vr_Taux:=0

C_TEXT:C284($va_Libellé)
$va_Libellé:=""


Case of 
	: ($vl_Type=Est un champ alpha:K8:1)
		$va_Libellé:=$1->
	: ($vl_Type=Est un numérique:K8:4)
		$va_Libellé:=[HeberGement:5]HG_FamDistri5:116
		
End case 

[HeberGement:5]HG_FamDistri5M:122:=0
//Extraire le taux dans le libellé : Participation (20;50)    
If ($va_Libellé>"")
	$vl_Position1:=Position:C15("("; $va_Libellé)
	$vl_Position2:=Position:C15(")"; $va_Libellé)
	If ($vl_Position1>0) & ($vl_Position2>0) & ($vl_Position2>$vl_Position1)
		$vr_Taux:=Num:C11(Substring:C12($va_Libellé; $vl_Position1+1; $vl_Position2-$vl_Position1-1))
		
		
		[HeberGement:5]HG_FamDistri5M:122:=Round:C94(([HeberGement:5]HG_FamDistri1M:118+[HeberGement:5]HG_FamDistri2M:119+[HeberGement:5]HG_FamDistri3M:120+[HeberGement:5]HG_FamDistri4M:121)*$vr_Taux/100; 2)
		
	End if 
End if 