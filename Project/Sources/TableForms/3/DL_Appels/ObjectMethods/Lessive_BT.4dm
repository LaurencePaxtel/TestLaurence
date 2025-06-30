If (<>PR_MachineLaver=0)
	<>PR_MachineLaver:=New process:C317("Go_MachineLaver"; 0; "Laver"; *)
Else 
	Process_Show(<>PR_MachineLaver)
End if 