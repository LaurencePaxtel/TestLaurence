
C_TEXT:C284(vt_memoNote)
C_TEXT:C284(va_DateEtHeure)



_O_PAGE SETUP:C299([DePart:1]; "DP_MemoFusionPrt")
PRINT SETTINGS:C106
If (OK=1)
	$Pos1:=0
	$Pos2:=0
	
	GET HIGHLIGHT:C209([DePart:1]DP_Texte:7; $Pos1; $Pos2)
	If ($Pos1#$Pos2) & ($Pos2>$Pos1)
		vt_memoNote:=Substring:C12([DePart:1]DP_Texte:7; $Pos1; $Pos2-$Pos1)
	Else 
		vt_memoNote:=[DePart:1]DP_Texte:7
	End if 
	va_DateEtHeure:="le "+String:C10(Current date:C33)+" à "+String:C10(Current time:C178)
	
	FORM SET OUTPUT:C54([DePart:1]; "DP_MemoFusionPrt")
	FORM SET INPUT:C55([DePart:1]; "DP_MemoFusionPrt")
	PRINT RECORD:C71([DePart:1]; *)
End if 