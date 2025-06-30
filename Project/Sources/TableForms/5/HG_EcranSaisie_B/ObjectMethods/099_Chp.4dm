If (Form event code:C388=Sur chargement:K2:1) | (Form event code:C388=Sur données modifiées:K2:15)
	
	If (Position:C15("/"; [HeberGement:5]HG_Maraude2_2:99)=0)
		[HeberGement:5]HG_Maraude2_2:99:=outilsStringToDate([HeberGement:5]HG_Maraude2_2:99)
		
		If (Form event code:C388=Sur chargement:K2:1) & (Is new record:C668([HeberGement:5])=False:C215)
			SAVE RECORD:C53([HeberGement:5])
		End if 
		
	End if 
	
	If (Form event code:C388=Sur données modifiées:K2:15)
		
		If (outilsRegexValidate(2; [HeberGement:5]HG_Maraude2_2:99)=False:C215)
			ALERT:C41("La date renseignée est au mauvais format, merci de ré-essayer")
		End if 
		
	End if 
	
End if 