If (7=8)
	If (i_Confirmer("Lancer la consolidation ?"))
		If (<>PR_ConsoPoste=0)
			<>PR_ConsoPoste:=New process:C317("Go_Conso115AUTO"; 0; "ConsoAutoPoste"; False:C215; *)
		Else 
			Process_Show(<>PR_ConsoPoste)
		End if 
	End if 
End if 

C_LONGINT:C283($vl_Process)
If (Form event code:C388=Sur clic:K2:4)
	If (<>vl_TypeApplication=4D mode distant:K5:5)
		
		$vl_Process:=Process number:C372("ConsoAutoServeur"; *)
		
		If (<>vb_Conso115Auto)
			
			If ($vl_Process=0)
				ALERT:C41("La consolidation sur le serveur est activée mais n'est pas lancée !")
			Else 
				ALERT:C41("La consolidation sur le serveur est active et en cours !")
			End if 
			
		Else 
			
			If ($vl_Process=0)
				
				If (<>PR_ConsoLocal=0)
					<>PR_ConsoLocal:=New process:C317("Go_ConsoParProcess"; 0; "ConsoAutoLocal"; False:C215)  //updt
				Else 
					ALERT:C41("La consolidation  en local est déjà lancé !")
					Process_Show(<>PR_ConsoLocal)
				End if 
				
			Else 
				ALERT:C41("La consolidation sur le serveur est en cours et le paramètre Auto désactivé!")
			End if 
		End if 
		
	Else 
		If (<>PR_ConsoLocal=0)
			<>PR_ConsoLocal:=New process:C317("Go_ConsoParProcess"; 0; "ConsoAutoLocal"; False:C215)  //updt
		Else 
			ALERT:C41("La consolidation automatique en local est déjà lancé !")
			Process_Show(<>PR_ConsoLocal)
		End if 
	End if 
End if 