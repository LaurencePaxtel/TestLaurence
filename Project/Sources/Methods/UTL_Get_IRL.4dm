//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 19-12-18, 05:30:37
// ----------------------------------------------------
// Method: UTL_Get_IRL
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $year; $2; $trimestre)
C_REAL:C285($0; $result)

$year:=$1
$trimestre:=$2
$result:=0

READ ONLY:C145([IRL_CONFIG:85])

QUERY:C277([IRL_CONFIG:85]; [IRL_CONFIG:85]IRC_Annee:4=$year; *)
QUERY:C277([IRL_CONFIG:85];  & ; [IRL_CONFIG:85]IRC_Trimestre:3=$trimestre)

If (Records in selection:C76([IRL_CONFIG:85])=1)
	$result:=[IRL_CONFIG:85]IRC_IRL:2
End if 

$0:=$result