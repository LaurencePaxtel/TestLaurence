//%attributes = {}
//{==================================================}
//{ LOGICIEL : DBsolutions matrice	
//{ © DBsolutions/Paxtel
//{          Fonction : i_Color
//{
//{          Jeudi 5 juillet 2007 à 10:17:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($0)

//C_LONGINT($1)
//C_LONGINT($2)
//C_LONGINT($vl_Temp;$vl_Temp1;$vl_Temp2)
//Case of 
//: ($1=1)
//$vl_Temp:=$2
//$vl_Temp:=$vl_Temp\256
//$vl_Temp:=$vl_Temp+1
//$0:=$vl_Temp

//: ($1=2)
//$vl_Temp:=$2
//$vl_Temp:=$vl_Temp-1
//$0:=(256*$vl_Temp)

//: ($1=3)
//$0:=$2+1

//: ($1=4)
//$0:=$2-1
//End case 

