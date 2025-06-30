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
C_LONGINT:C283($0)
C_DATE:C307($1)

C_TEXT:C284(vaCPT_115)

vaCPT_115:="HG"+Substring:C12(String:C10(Year of:C25($1); "0000"); 3; 2)+String:C10(Month of:C24($1); "00")
Use (Storage:C1525.numerotation)
	Storage:C1525.numerotation.vaCPT_115:=vaCPT_115
End use 

$0:=Uut_Numerote(->vaCPT_115)