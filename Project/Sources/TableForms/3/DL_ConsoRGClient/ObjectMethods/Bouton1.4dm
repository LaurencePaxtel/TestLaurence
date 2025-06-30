If (<>PR_ConsoRGClientA=0)
	If (i_Confirmer("Lancer la consolidation régionale  ?"))
		<>PR_ConsoRGClientA:=New process:C317("Go_ConsoRGParClient"; 0; "ConsoRGAutoClient"; False:C215; 0; *)
	End if 
Else 
	ALERT:C41("La consolidation sur le client est active et en cours !")
End if 

