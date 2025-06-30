//%attributes = {}
C_TEXT:C284($0)
C_DATE:C307($1; $D_Date)  //Date
C_LONGINT:C283($2; $L_Long)  //Entier long

$D_Date:=$1
$L_Long:=$2

$0:=String:C10(\
Year of:C25($D_Date); "0000")\
+String:C10(Month of:C24($D_Date); "00")\
+String:C10(Day of:C23($D_Date); "00")+"/"\
+String:C10($L_Long; "0000000000")