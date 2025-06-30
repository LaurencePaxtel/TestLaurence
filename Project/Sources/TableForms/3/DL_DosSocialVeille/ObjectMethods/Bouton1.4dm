If (Form event code:C388=Sur clic:K2:4)
	//••• TABLEAU •••
	//Etat civil
	If (Size of array:C274(ta_xEtCiv)>0)
		For ($ii; 1; Size of array:C274(ta_xEtCiv))
			te_xEtCiv{$ii}:=1
		End for 
	End if 
	[DiaLogues:3]DL_LibelAutre:5:=""
	[DiaLogues:3]DL_Libellé:3:=""
	[DiaLogues:3]DL_LibelPlus:6:=""
	
	
	ALL RECORDS:C47([DossierSocial:25])
	ORDER BY:C49([DossierSocial:25]; [DossierSocial:25]DS_Date:4; >)
	FIRST RECORD:C50([DossierSocial:25])
	[DiaLogues:3]DL_Date:2:=[DossierSocial:25]DS_DateNéLe:18
	ORDER BY:C49([DossierSocial:25]; [DossierSocial:25]DS_Date:4; <)
	FIRST RECORD:C50([DossierSocial:25])
	[DiaLogues:3]DL_Date2:8:=[DossierSocial:25]DS_Date:4
	
	vL_NbFiches:=Records in selection:C76([DossierSocial:25])
	If (vL_NbFiches>0)
		P_DosSocialVeilleSort(2)
	End if 
End if 