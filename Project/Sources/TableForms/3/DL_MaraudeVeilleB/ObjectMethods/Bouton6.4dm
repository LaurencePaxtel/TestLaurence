If (Form event code:C388=Sur clic:K2:4)
	//••• TABLEAU •••
	//Etat civil
	If (Size of array:C274(ta_xEtCiv)>0)
		For ($ii; 1; Size of array:C274(ta_xEtCiv))
			te_xEtCiv{$ii}:=1
		End for 
	End if 
	//Signalement
	If (Size of array:C274(ta_xSglt)>0)
		For ($ii; 1; Size of array:C274(ta_xSglt))
			te_xSglt{$ii}:=1
		End for 
	End if 
	rJourNuit1:=1
	rJourNuit2:=1
	[DiaLogues:3]DL_LibelAutre:5:=""
	[DiaLogues:3]DL_Libellé:3:=""
	[DiaLogues:3]DL_LibelPlus:6:=""
	
	
	ALL RECORDS:C47([Maraude:24])
	ORDER BY:C49([Maraude:24]; [Maraude:24]MR_Date:4; >)
	FIRST RECORD:C50([Maraude:24])
	[DiaLogues:3]DL_Date:2:=[Maraude:24]MR_Date:4
	ORDER BY:C49([Maraude:24]; [Maraude:24]MR_Date:4; <)
	FIRST RECORD:C50([Maraude:24])
	[DiaLogues:3]DL_Date2:8:=[Maraude:24]MR_Date:4
	
	vL_NbFiches:=Records in selection:C76([Maraude:24])
	If (vL_NbFiches>0)
		P_MaraudeVeilleSort(2)
	End if 
End if 