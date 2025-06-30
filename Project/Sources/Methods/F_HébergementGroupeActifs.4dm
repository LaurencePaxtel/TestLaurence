//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_HébergementCtrlGroupe
//{
//{          Jeudi 25 mars 2004 à 16:31
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)
C_BOOLEAN:C305($2)
C_POINTER:C301($3)
C_TEXT:C284($0)
C_LONGINT:C283($ii; $ij; $ik)
C_TEXT:C284($va_Temp)

$ik:=0
$ij:=Size of array:C274(<>ta_GpClé)
vl_NbBoucleVrai:=0
For ($ii; 1; $ij)
	If (<>te_GpCheck{$ii}=1) & (<>te_GpEtat{$ii}=0)
		$ik:=$ik+1
	End if 
End for 
$3->:=$ik
$va_Temp:=((" pour le groupe <"+$1+">")*Num:C11($2=False:C215))+((" pour la famille <"+$1+">")*Num:C11($2=True:C214))
If ($ik<=0)
	$0:="Aucune réservation  pour"+$va_Temp
Else 
	$0:=String:C10($ik)+" réservation"+("s"*Num:C11($ik>1))+" sur "+String:C10($ij)+","+$va_Temp
End if 