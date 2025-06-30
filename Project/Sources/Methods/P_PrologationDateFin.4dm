//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_PrologationDateFin
//{
//{          Diamnche 19 septembre 2004 à 18:08:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_DATE:C307($1)  //[Prolongation]PR_RésaDateDébut
C_LONGINT:C283($2)  //[Prolongation]PR_NbMois
C_POINTER:C301($3)  //[Prolongation]PR_RésaNbJours
C_POINTER:C301($4)  //[Prolongation]PR_RésaDateFin

C_LONGINT:C283($ve_Borne; $ii)

If (<>vb_ProLg_FinMois)  //Fin de mois
	$ve_Borne:=1
Else 
	$ve_Borne:=<>ve_ProLg_Le+1
End if 

$4->:=$1

For ($ii; 1; $2)
	Repeat 
		$4->:=$4->+1
	Until (Day of:C23($4->)=$ve_Borne)
	If ($ii=$2)
		$4->:=$4->-1
	End if 
End for 

$3->:=$4->-$1+1