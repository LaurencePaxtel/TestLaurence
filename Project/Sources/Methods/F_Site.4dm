//%attributes = {}
C_TEXT:C284($0)  //Code du site
C_TEXT:C284($1)  //Code du site
If (Length:C16($1)>=3)
	$0:=$1
Else 
	$0:=$1+(" "*(3-Length:C16($1)))
End if 