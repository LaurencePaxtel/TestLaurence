If (<>PR_SomOrient1=0)
	<>PR_SomOrient1:=New process:C317("Go_SommeVeille"; 0; "SommeVeille"; -><>PR_SomOrient1; Current date:C33; *)
	
Else 
	Process_Show(<>PR_SomOrient1)
End if 
