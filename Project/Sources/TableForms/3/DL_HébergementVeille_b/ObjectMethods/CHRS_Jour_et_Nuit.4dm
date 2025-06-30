If (Form event code:C388=Sur clic:K2:4)
	
	If (<>vb_T_ModeCHRS=True:C214)
		
		If (JourNuit3=1)
			rJourNuit1:=1
			rJourNuit2:=1
			
			rSurDateEcheance:=0
			
			P_Profil
			OBJECT SET VISIBLE:C603(rSurDateEcheance; True:C214)
		End if 
		
	End if 
	
	P_HébergementVeilleFind
End if 