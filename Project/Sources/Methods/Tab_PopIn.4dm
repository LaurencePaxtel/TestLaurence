//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Tab_PopIn
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)  //Indice du tableau
C_POINTER:C301($2)  //Ptr Tableau
C_POINTER:C301($3)  //Ptr Rubrique
If (Size of array:C274($2->)>0)
	If ($1>0)
		$3->:=$2->{$1}
	End if 
End if 