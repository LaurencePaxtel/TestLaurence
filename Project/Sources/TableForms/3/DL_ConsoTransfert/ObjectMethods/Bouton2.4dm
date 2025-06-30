If (Form event code:C388=Sur clic:K2:4)
	
	If (<>PR_ConsoTransfertAuto=0)
		
		If (i_Confirmer("Voulez-vous lancer le process de tranfert de fiches au 115"))
			<>PR_ConsoTransfertAuto:=New process:C317("Go_uConsoTransfertS"; 0; "ConsoTransServeur"; False:C215; *)
		End if 
		
	Else 
		ALERT:C41("Le process de tranferts de fiches est lancé !")
	End if 
	
End if 