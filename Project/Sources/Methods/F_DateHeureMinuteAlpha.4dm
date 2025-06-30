//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Fonction:  F_DateHeureMinuteAlpha
//{          Lundi 18 juillet 2004 à 11:15:00
//{          Modifiée : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($0)
C_DATE:C307($1)
C_TIME:C306($2)

If ($1>!00-00-00!) & ($2>?00:00:00?)
	$0:=String:C10(Year of:C25($1); "0000")+String:C10(Month of:C24($1); "00")+String:C10(Day of:C23($1); "00")
	$0:=$0+String:C10($2; h mn:K7:2)
End if 