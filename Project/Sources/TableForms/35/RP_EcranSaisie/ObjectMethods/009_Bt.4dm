If (Form event code:C388=Sur clic:K2:4)
	vaRP_Perma:=""
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_HG-<>vlSTR}{3}; -><>ta_InPerm; ->vaRP_Perma)
	If (vaRP_Perma>"")
		If ([Rapport:35]RP_LesSurveillantsChefs:5>"")
			[Rapport:35]RP_LesSurveillantsChefs:5:=[Rapport:35]RP_LesSurveillantsChefs:5+"; "+vaRP_Perma
		Else 
			[Rapport:35]RP_LesSurveillantsChefs:5:=vaRP_Perma
		End if 
	End if 
End if 