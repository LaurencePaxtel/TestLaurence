If (Form event code:C388=Sur clic:K2:4)
	$Pos1:=0
	$Pos2:=0
	GET HIGHLIGHT:C209([DePart:1]DP_Texte:7; $Pos1; $Pos2)
	
	[DePart:1]DP_Texte:7:=Insert string:C231([DePart:1]DP_Texte:7; <>vt_Hotel+" - "; $Pos1)
	$Pos2:=$Pos1+Length:C16(<>vt_Hotel)+3
	
	HIGHLIGHT TEXT:C210([DePart:1]DP_Texte:7; $Pos2; $Pos2)
End if 