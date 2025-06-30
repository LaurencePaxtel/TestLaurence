If (Form event code:C388=Sur clic:K2:4)
	
	If (Modified record:C314([GrouPe:36]))
		
		If (i_Confirmer("Ce groupe : "+[GrouPe:36]GP_Intitulé:4+" est "+("une famille"*Num:C11([GrouPe:36]GP_Famille:6=True:C214))+("un simple groupe"*Num:C11([GrouPe:36]GP_Famille:6=False:C215))))
			$vb_OK:=True:C214
			
			If ([GrouPe:36]GP_ProlongationExclu:8)
				
				If ([GrouPe:36]GP_ProlongationExcluNote:10="")
					$vb_OK:=False:C215
					ALERT:C41("Vous devez donner les raisons de l'exclusion !")
				End if 
				
			End if 
			
			If ($vb_OK)
				[GrouPe:36]Ref_Structure:15:=<>ref_soc_active
				
				If ([GrouPe:36]GP_ProlongationExclu:8=False:C215)
					[GrouPe:36]GP_ProlongationExcluDate:9:=!00-00-00!
				End if 
				
				ACCEPT:C269
			End if 
			
		End if 
		
	Else 
		ACCEPT:C269
	End if 
	
End if 