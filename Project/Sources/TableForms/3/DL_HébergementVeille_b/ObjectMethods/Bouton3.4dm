//Script b_Acts

LOAD RECORD:C52([HeberGement:5])  // Migration v15

If ([HeberGement:5]HG_HB_ID:19>0)
	Process_Go2(-><>PR_HBActionFV; "Go_HébergementActionF"; "ActionsF"; 32; [HeberGement:5]HG_HB_ID:19; "V")
Else 
	StrAlerte(3; "")
End if 