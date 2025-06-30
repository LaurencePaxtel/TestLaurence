//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_HébergementGroupeTitre  
//{
//{          Lundi 08 mars 2004 à 12:02:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($0)
C_TEXT:C284($1)
$0:=""

C_LONGINT:C283($ii; $ij)
$ij:=0
For ($ii; 1; Size of array:C274(<>te_GpCheck))
	$ij:=$ij+<>te_GpCheck{$ii}
End for 

va_GPNb:=String:C10($ij)+" sur "+String:C10(Size of array:C274(<>te_GpCheck))

If ($1>"")
	$0:="Réservations "+va_GPNb+" pour le groupe : "+$1
Else 
	$0:="Aucune réservation  pour aucun groupe"
End if 