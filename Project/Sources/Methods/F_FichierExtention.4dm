//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Fonction : F_FichierSuffixe
//{          Mardi 18 novembre 2004 à 18:02:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
$0:=$2

C_TEXT:C284($va_Extention)
$va_Extention:=""

Case of 
	: ($1="TXT")
		$va_Extention:=".TXT"
End case 

If (Substring:C12($2; Length:C16($2)-3; 4)=$va_Extention)
	If (<>vb_CestUnMac)
		$0:=Substring:C12($2; Length:C16($2)-4)+$va_Extention
		$0:=$2
	End if 
Else 
	If (<>vb_CestUnMac)
	Else 
		$0:=$2+$va_Extention
	End if 
End if 