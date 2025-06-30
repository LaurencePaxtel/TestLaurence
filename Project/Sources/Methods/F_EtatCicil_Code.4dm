//%attributes = {}
C_TEXT:C284($0)
$0:=""
C_TEXT:C284($1)

If ($1>"") & (Position:C15("("; $1)>0)
	$1:=Substring:C12($1; Position:C15("("; $1)+1)
	$1:=Substring:C12($1; 1; Position:C15(")"; $1)-1)
	$0:=$1
End if 