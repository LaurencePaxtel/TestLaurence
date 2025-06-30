//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_FichierSuffixe
//{
//{          Mardi 18 novembre 2004 à 18:02:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($0)
C_TEXT:C284($1)

$0:=$1
If (Substring:C12($1; Length:C16($1)-3; 4)=".TXT")
	If (<>vb_CestUnMac)
		$0:=Substring:C12($1; Length:C16($1)-4)+".TXT"
		$0:=$1
	End if 
Else 
	If (<>vb_CestUnMac)
	Else 
		$0:=$1+".TXT"
	End if 
End if 