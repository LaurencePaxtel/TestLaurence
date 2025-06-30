var $hebergeID_el : Integer

LOAD RECORD:C52([HeBerge:4])

If ([HeBerge:4]HB_ReferenceID:1>0)
	$hebergeID_el:=[HeBerge:4]ID:65
	UNLOAD RECORD:C212([HeBerge:4])
	
	Process_Go2(-><>PR_HBNotes; "Go_HébergementNotesNew"; "Notes"; 0; $hebergeID_el; "N")
Else 
	StrAlerte(3; "")
End if 