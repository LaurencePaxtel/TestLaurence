If (Form event code:C388=Sur clic:K2:4)
	
	If (<>vl_TypeApplication=4D mode distant:K5:5)
		$PR_ReportServeur:=Execute on server:C373("SER_GO_ReportsAuto"; 0; "ReporAutoServeur"; False:C215; ""; *)
	Else 
		<>PR_ReportLocal:=New process:C317("Go_ReportParProcess"; 0; "ReporAutoLocal"; False:C215; <>ref_soc_active)  // #20170623-1
		
		If (False:C215)
			
			If (<>PR_ReportLocal=0) | (<>PR_ReportLocal#0)  // #20170627-1  à enlever apres debug
				
				If (i_Confirmer("Lancer le report automatique en local ?"))
					<>PR_ReportLocal:=New process:C317("Go_ReportParProcess"; 0; "ReporAutoLocal"; False:C215; <>ref_soc_active)  // #20170623-1
				End if 
				
			Else 
				ALERT:C41("Le report automatique en local est déjà lancé !")
				Process_Show(<>PR_ReportLocal)
			End if 
			
		End if 
		
	End if 
	
End if 