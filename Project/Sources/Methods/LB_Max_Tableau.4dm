//%attributes = {}
C_POINTER:C301($tableau; $1)
C_REAL:C285($max)

$tableau:=$1
For ($i; 1; Size of array:C274($tableau->))
	If ($tableau->{$i}>$max)
		$max:=$tableau->{$i}
	End if 
End for 
$0:=$max