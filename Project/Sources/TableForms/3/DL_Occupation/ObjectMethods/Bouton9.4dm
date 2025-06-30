If (<>PR_DesStats=0)
	<>PR_DesStats:=New process:C317("Go_PrésentationDesStats"; 0; "DesStats"; *)
Else 
	Process_Show(<>PR_DesStats)
End if 