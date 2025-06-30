
C_LONGINT:C283($vl_Process)
If (7=8)
	If (Form event code:C388=Sur clic:K2:4)
		<>PR_ConsoServeur:=Execute on server:C373("Go_Conso115AUTO"; 0; "ConsoAuto"; True:C214; <>ref_soc_active; *)
	End if 
End if 
If (Form event code:C388=Sur clic:K2:4)
	If (<>vl_TypeApplication=4D mode distant:K5:5)
		If (<>vb_Conso115Auto)
			$vl_Process:=Process number:C372("ConsoAutoServeur"; *)
			If ($vl_Process=0)
				<>PR_ConsoServeur:=Execute on server:C373("Go_ConsoParProcess"; 0; "ConsoAutoServeur"; True:C214; <>ref_soc_active; *)
			Else 
				ALERT:C41("La consolidation sur le serveur est active et en cours !")
			End if 
		Else 
			ALERT:C41("Vérifiez les paramètres !")
		End if 
	Else 
		ALERT:C41("Veuillez utiliser l'accès sur la palette 'Appel' !")
	End if 
End if 