//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 27/09/2020, 08:49:29
// ----------------------------------------------------
// Method: LB_Move_Column
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptr_tableau)
C_LONGINT:C283($avant; $apres; $2; $3)
$avant:=$2
$apres:=$3
$ptr_tableau:=$1

Case of 
	: ($apres<$avant)
		INSERT IN ARRAY:C227($ptr_tableau->; $apres; 1)
		$ptr_tableau->{$apres}:=$ptr_tableau->{$avant+1}
		DELETE FROM ARRAY:C228($ptr_tableau->; $avant+1; 1)
	: ($apres>$avant)
		INSERT IN ARRAY:C227($ptr_tableau->; $apres+1; 1)
		$ptr_tableau->{$apres+1}:=$ptr_tableau->{$avant}
		DELETE FROM ARRAY:C228($ptr_tableau->; $avant; 1)
End case 