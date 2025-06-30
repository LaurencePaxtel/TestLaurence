//%attributes = {}
C_TEXT:C284($1)

If ((Application type:C494=4D Server:K5:6)=False:C215)
	$1:=Char:C90(13)+$1
	GOTO XY:C161(5; 5)
	
	MESSAGE:C88($1)
End if 