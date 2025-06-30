//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Fonction : F_OutBlancFin
//{          Lundi 15 novembre 2010 à 15:08:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($0)
$0:=""

C_TEXT:C284($1)
C_TEXT:C284($va_Temp)
$va_Temp:=$1
If ($va_Temp>"")
	Repeat 
		If ($va_Temp[[Length:C16($va_Temp)]]=" ")
			$va_Temp:=Substring:C12($va_Temp; 1; Length:C16($va_Temp)-1)
		End if 
	Until ($va_Temp[[Length:C16($va_Temp)]]#" ") | ($va_Temp="")
	$0:=$va_Temp
End if 