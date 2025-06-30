//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 15/06/2020, 12:27:57
// ----------------------------------------------------
// Method: WEB_URL_GET_PARAM
// Description
// Get params for POST
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $url; $2; $param; $param_value; $other_param_value; $result)
C_LONGINT:C283($pos_start; $pos)
ARRAY TEXT:C222($tb_result; 0)

$url:=$1
$param:=$2
$result:=""

$pos_start:=Position:C15($param; $url)

If ($pos_start>0)
	
	$param_value:=Substring:C12($url; $pos_start; Length:C16($url))
	
	$pos:=Position:C15("&"; $param_value)
	If ($pos>0)
		$other_param_value:=Substring:C12($param_value; $pos; Length:C16($param_value))
		$param_value:=Replace string:C233($param_value; $other_param_value; "")
	End if 
	
	UTL_Cut_Text(->$param_value; ->$tb_result; "=")
	
	If (Size of array:C274($tb_result)=2)
		$result:=$tb_result{2}
	End if 
	
End if 

$0:=$result