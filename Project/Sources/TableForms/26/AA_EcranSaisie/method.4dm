If (Form event code:C388=Sur chargement:K2:1)
	If (Is new record:C668([ActionSociale:26]))
		[ActionSociale:26]AA_Référence:1:=Uut_Numerote(->[ActionSociale:26])
		[ActionSociale:26]AA_HB_ID:2:=vl_RefMrid
		[ActionSociale:26]AA_DS_ID:12:=vl_RefDS
		[ActionSociale:26]AA_Domaine:3:=ta_MRLib{ta_MRLib}
		$Pos:=ta_MRLib
	Else 
		$Pos:=Find in array:C230(ta_MRLib; [ActionSociale:26]AA_Domaine:3)
		If ($Pos>0)
		Else 
			$Pos:=1
		End if 
	End if 
	Case of 
		: ($Pos=1)
			COPY ARRAY:C226(<>ta_TBPIdté; <>ta_Domaine)
		: ($Pos=2)
			COPY ARRAY:C226(<>ta_MRcs; <>ta_Domaine)
		: ($Pos=3)
			COPY ARRAY:C226(<>ta_MRrs; <>ta_Domaine)
		: ($Pos=4)
			COPY ARRAY:C226(<>ta_MRrg; <>ta_Domaine)
		: ($Pos=5)
			COPY ARRAY:C226(<>ta_MRss; <>ta_Domaine)
		: ($Pos=6)
			COPY ARRAY:C226(<>ta_MRorS; <>ta_Domaine)
		: ($Pos=7)
			COPY ARRAY:C226(<>ta_MRaid; <>ta_Domaine)
		: ($Pos=8)
			COPY ARRAY:C226(<>ta_MRPro; <>ta_Domaine)
	End case 
	P_ChampAttribut(<>vlSTR_AA-<>vlSTR)
End if 