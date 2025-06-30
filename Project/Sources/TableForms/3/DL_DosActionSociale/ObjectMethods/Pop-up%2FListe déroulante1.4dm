If (ta_MRLib>0)
	ta_MRCode:=ta_MRLib
	If (ta_MRLib<9)
		QUERY:C277([ActionSociale:26]; [ActionSociale:26]AA_DS_ID:12=[DossierSocial:25]DS_Référence:1; *)
		QUERY:C277([ActionSociale:26];  & [ActionSociale:26]AA_Domaine:3=ta_MRLib{ta_MRLib})
	Else 
		QUERY:C277([ActionSociale:26]; [ActionSociale:26]AA_DS_ID:12=[DossierSocial:25]DS_Référence:1)
	End if 
	ORDER BY:C49([ActionSociale:26]; [ActionSociale:26]AA_Référence:1; >)
Else 
	ta_MRLib:=ta_MRCode
End if 