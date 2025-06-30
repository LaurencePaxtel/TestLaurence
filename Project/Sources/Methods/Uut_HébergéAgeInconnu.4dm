//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Uut_HébergéAgeIconnu
//{
//{          Lundi 28 Juillet 1997 à 16:53:54
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_DATE:C307($1)

C_LONGINT:C283($ii; $ij)

If (rIDTG_1=1)
	$ij:=<>ve_ageHom
Else 
	$ij:=<>ve_ageFem
End if 

$ii:=Year of:C25($1)-$ij

vd_IDT_NéLe:=Date:C102("01/01/"+String:C10($ii; "0000"))
ve_IDT_Age:=Uut_HébergéAge(->vd_IDT_NéLe)