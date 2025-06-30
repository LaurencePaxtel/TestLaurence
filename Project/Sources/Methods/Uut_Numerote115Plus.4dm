//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : Uut_Numerote115Plus
//{
//{          Mardi 31 juillet 2001 à 15:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($0)
C_DATE:C307($1)
C_LONGINT:C283($2)
var $vaCPT_115 : Text

Use (Storage:C1525.numerotation)
	Storage:C1525.numerotation.vaCPT_115:="HG"+Substring:C12(String:C10(Year of:C25($1); "0000"); 3; 2)+String:C10(Month of:C24($1); "00")
End use 
$vaCPT_115:=Storage:C1525.numerotation.vaCPT_115
$0:=Uut_NumerotePlus(->$vaCPT_115; $2)