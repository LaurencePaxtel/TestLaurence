If (Form event code:C388=Sur clic:K2:4)
	
	If (<>vb_T_ModeCHRS=True:C214)
		
		If (JourNuit1=1)
			rJourNuit1:=1
			rJourNuit2:=0
			
			Jour_et_Nuit:=0  //Ajouté le 02/08/2019
			
			P_Profil
			OBJECT SET VISIBLE:C603(rSurDateEcheance; False:C215)
			
			rSurDateEcheance:=0
		End if 
		
	End if 
	
	P_HébergementVeilleFind
End if 