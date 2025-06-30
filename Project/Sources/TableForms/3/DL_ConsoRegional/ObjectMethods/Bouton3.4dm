If (Form event code:C388=Sur clic:K2:4)
	If (User in group:C338(Current user:C182; <>Groupe_Regional) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
		
		If (<>PR_ConsoRGClient#0)
			ALERT:C41("La consolidation régionale automatique en local est déjà lancé !")
			Process_Show(<>PR_ConsoRGClient)
		Else 
			If (i_Confirmer("Veuillez vérifier qu'aucun autre poste n'a lancé la consolidation régionale ?"))
				OBJECT SET ENABLED:C1123(b_Lancer; False:C215)
				P_VarConso_Regional(5)
				
				<>PR_ConsoRGClientA:=New process:C317("Go_ConsoRGParClient"; 0; "ConsoRGAutoClient"; False:C215; 1)
			End if 
		End if 
	End if 
End if 