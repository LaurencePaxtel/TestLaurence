//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Uut_HébergéClé  
//{
//{          Lundi 28 Juillet 1997 à 16:53:54
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_TEXT:C284($0)
C_DATE:C307($vd_Date)
$vd_Date:=Date:C102($3)


$0:=(($1+" ")*Num:C11($1>""))
$0:=$0+(($2+" ")*Num:C11($2>""))


If ($vd_Date<!2000-01-01!)
	$0:=$0+(String:C10($vd_Date; 4)*Num:C11($vd_Date>!00-00-00!))
Else 
	$0:=$0+(String:C10($vd_Date; 7)*Num:C11($vd_Date>!00-00-00!))
End if 
