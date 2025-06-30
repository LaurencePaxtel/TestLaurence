If (Form event code:C388=Sur clic:K2:4)
	If (<>vb_T_ModeCHRS=True:C214)
		
		
		If (JourNuit2=1)
			rJourNuit1:=0
			rJourNuit2:=1
			P_Profil_CHRS
			ta_xCritères{1}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{40}
			ta_xCritères{2}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{62}
			ta_xCritères{3}:="Permanencier"
			ta_xCritères{4}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{5}
			ta_xCritères{5}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{50}
			ta_xCritères{6}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{48}
			ta_xCritères{7}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{49}
			ta_xCritères{8}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{28}
			ta_xCritères{9}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{29}
			ta_xCritères{10}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{30}
			
			ta_xCritères{11}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{25}
			ta_xCritères{12}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{26}
			ta_xCritères{13}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{27}
			ta_xCritères{14}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{82}
			
			
			ta_xCritères{0}:=ta_xCritères{ta_xCritères}
		End if 
		
	End if 
	P_HébergementVeilleFind
End if 