If (Form event code:C388=Sur clic:K2:4)
	
	If (<>vb_T_ModeCHRS=True:C214)
		
		If (JourNuit2=1)
			rJourNuit1:=0
			rJourNuit2:=1
			
			P_Profil_CHRS
			OBJECT SET VISIBLE:C603(rSurDateEcheance; True:C214)
		End if 
		
	End if 
	
	P_HébergementVeilleFind
End if 