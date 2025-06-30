//%attributes = {}
If (<>PR_AppelBAL=0)
	<>PR_AppelBAL:=New process:C317("Go_BAL"; 0; "BAL")  //updt
Else 
	Process_Show(<>PR_AppelBAL)
End if 