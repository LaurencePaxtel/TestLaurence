//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 21/02/20, 10:13:54
// ----------------------------------------------------
// Method: HG_Dupliquer_new_value
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1; $P_Array)
$P_Array:=$1
C_POINTER:C301($2; $P_Field)
$P_Field:=$2
C_POINTER:C301($3; $P_Output)
$P_Output:=$3

ARRAY OBJECT:C1221($rO_Duplique; 0)
COPY ARRAY:C226($P_Array->; $rO_Duplique)

C_TEXT:C284($T_Name)
$T_Name:=Field name:C257($P_Field)

C_LONGINT:C283($i)
$i:=0

C_BOOLEAN:C305($B_Duplique)
C_TEXT:C284($T_field)
Repeat 
	$i:=$i+1
	$B_Duplique:=$rO_Duplique{$i}.checked
	$T_field:=$rO_Duplique{$i}.field
Until ($T_field=$T_Name)

If ($B_Duplique)
	
	$P_Field->:=$P_Output->
	
End if 
