//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_HébergementGroupeProlong  
//{
//{          Lundi 13 septembre 2004 à 11:15:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($0)
C_TEXT:C284($1)
$0:=""
$ij:=0
For ($ii; 1; Size of array:C274(<>te_GpP_Check))
	$ij:=$ij+<>te_GpP_Check{$ii}
End for 
va_GPNb:=String:C10($ij)+" sur "+String:C10(Size of array:C274(<>te_GpP_Check))
If ($1>"")
	$0:="Réservations "+va_GPNb+" pour le groupe : "+$1
Else 
	$0:="Aucune réservation  pour aucun groupe"
End if 