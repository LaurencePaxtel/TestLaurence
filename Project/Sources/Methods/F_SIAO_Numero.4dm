//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : Uut_Numerote115 
//{
//{          Mardi 31 juillet 2001 à 15:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($0)
C_LONGINT:C283($ii)
C_DATE:C307($1)

$0:=Substring:C12(String:C10(Year of:C25($1); "0000"); 3; 2)+String:C10(Month of:C24($1); "00")
<>vaCPT_SIAO:="SIAO"+$0
$ii:=Uut_Numerote(-><>vaCPT_SIAO)

$0:=$0+"-"+String:C10($ii; "00000")