If (<>PR_ConsoClientA=0)
	If (i_Confirmer("Lancer la consolidation  ?"))
		<>PR_ConsoClientA:=New process:C317("Go_ConsoParClient"; 0; "ConsoAutoClient"; False:C215; *)
	End if 
Else 
	ALERT:C41("La consolidation sur le client est active et en cours !")
End if 

