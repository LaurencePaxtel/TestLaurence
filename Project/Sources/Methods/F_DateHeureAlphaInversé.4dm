//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Fonction:  F_DateHeureAlphaInversé
//{          Mercredi 13 avril 2011 à 11:30
//{          Modifiée : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_TEXT:C284($0)
C_DATE:C307($1)
C_TIME:C306($2)

$0:=""

If ($1>!00-00-00!)
	$0:=String:C10(Year of:C25($1); "0000")+String:C10(Month of:C24($1); "00")+String:C10(Day of:C23($1); "00")
Else 
	$0:="00000000"
End if 
If ($2>?00:00:00?)
	
	$0:=$0+Replace string:C233(String:C10($2; h mn s:K7:1); ":"; "")
Else 
	$0:=$0+"000000"
End if 