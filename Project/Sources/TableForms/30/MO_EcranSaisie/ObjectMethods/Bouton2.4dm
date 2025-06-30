
C_TEXT:C284(vt_memoNote)
C_TEXT:C284(va_DateEtHeure)



_O_PAGE SETUP:C299([MemO:30]; "MO_Prt_Page")
PRINT SETTINGS:C106
If (OK=1)
	$Pos1:=0
	$Pos2:=0
	
	GET HIGHLIGHT:C209([MemO:30]MO_Note:5; $Pos1; $Pos2)
	If ($Pos1#$Pos2) & ($Pos2>$Pos1)
		vt_memoNote:=Substring:C12([MemO:30]MO_Note:5; $Pos1; $Pos2-$Pos1)
	Else 
		vt_memoNote:=[MemO:30]MO_Note:5
	End if 
	va_DateEtHeure:="le "+String:C10(Current date:C33)+" à "+String:C10(Current time:C178)
	
	FORM SET OUTPUT:C54([MemO:30]; "MO_Prt_Page")
	FORM SET INPUT:C55([MemO:30]; "MO_Prt_Page")
	PRINT RECORD:C71([MemO:30]; *)
End if 