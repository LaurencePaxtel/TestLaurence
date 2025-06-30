//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Uut_FaxClé  
//{
//{          Lundi 28 Juillet 1997 à 16:53:54
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)  //Date
C_POINTER:C301($2)  //Jour ou Nuit 1 ou 2
C_POINTER:C301($3)  //Accepté ou non 1 ou 0


C_TEXT:C284($0)
$0:=String:C10(Year of:C25($1->); "0000")+String:C10(Month of:C24($1->); "00")+String:C10(Day of:C23($1->); "00")+"/"+("J"*Num:C11($2->=False:C215))+("N"*Num:C11($2->=True:C214))+"/"+String:C10(Num:C11($3->=True:C214))