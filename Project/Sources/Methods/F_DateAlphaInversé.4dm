//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Fonction:  F_DateAlphaInversé
//{          Jeudi 7 octobre 2010 à 12:15:00
//{          Modifiée : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_TEXT:C284($0)
C_DATE:C307($1)

$0:=""

If ($1>!00-00-00!)
	$0:=String:C10(Year of:C25($1); "0000")+String:C10(Month of:C24($1); "00")+String:C10(Day of:C23($1); "00")
End if 