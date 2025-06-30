//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : Uut_NumeroteLitsType
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($0)
C_DATE:C307($1)  //Date
C_TEXT:C284($2)  //Alpha  J: Jour; N:Nuit

$0:=String:C10(Year of:C25($1); "0000")+String:C10(Month of:C24($1); "00")+String:C10(Day of:C23($1); "00")+"/"+$2