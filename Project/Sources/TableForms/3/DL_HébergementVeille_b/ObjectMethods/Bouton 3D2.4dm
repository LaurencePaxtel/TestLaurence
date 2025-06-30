//Script b_Acts

LOAD RECORD:C52([HeberGement:5])  // Migration v15

If ([HeberGement:5]HG_HB_ID:19>0)
	C_TEXT:C284($vt_Temp)
	$vt_Temp:=F_DonneesDistri
	
	Process_Go20(-><>PR_HBActionV; "Go_HébergementAction"; "Actions"; 0; [HeberGement:5]HG_HB_ID:19; "V"; $vt_Temp)
Else 
	StrAlerte(3; "")
End if 