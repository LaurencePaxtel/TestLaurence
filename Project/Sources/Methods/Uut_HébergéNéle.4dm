//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Uut_HébergéNéle 
//{
//{          Lundi 28 Juillet 1997 à 16:53:54
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)
C_DATE:C307($0)  //Né le
$0:=!00-00-00!
$ve_Age:=$1->

C_DATE:C307($vd_J)  //Date du jour
C_LONGINT:C283($ve_Age; $ve_A)  //Age et Année
If ($ve_Age>0)
	$vd_J:=Current date:C33
	$ve_A:=Year of:C25($vd_J)-$ve_Age
	$0:=Date:C102("01/01/"+String:C10($ve_A; "0000"))
	
	If (7=8)
		If (Month of:C24($vd_J)=2) & (Day of:C23($vd_J)=29)
			$0:=Date:C102(String:C10(Day of:C23($vd_J)-1; "00")+"/"+String:C10(Month of:C24($vd_J); "00")+"/"+String:C10($ve_A; "0000"))
		Else 
			$0:=Date:C102(String:C10(Day of:C23($vd_J); "00")+"/"+String:C10(Month of:C24($vd_J); "00")+"/"+String:C10($ve_A; "0000"))
		End if 
	End if 
End if 



