If (Form event code:C388=Sur clic:K2:4)
	MESSAGES ON:C181
	If ([DePart:1]DP_Libelle:6>"")
		If (Length:C16([DePart:1]DP_Libelle:6)=1) & ([DePart:1]DP_Libelle:6="@")
			ALL RECORDS:C47([HeBerge:4])
		Else 
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=([DePart:1]DP_Libelle:6+"@"))
		End if 
		MultiSoc_Filter(->[HeBerge:4])
	Else 
		REDUCE SELECTION:C351([HeBerge:4]; 0)
	End if 
	vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
	ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
	FIRST RECORD:C50([HeBerge:4])
	REDUCE SELECTION:C351([HeberGement:5]; 0)
	vL_Nb_HG_F:=0
	va_Nb_HG_F:=""
	REDUCE SELECTION:C351([DossierInfirmie:27]; 0)
	vL_Nb_MR_F:=0
	va_Nb_MR_F:=""
	MESSAGES OFF:C175
	K_BoutonDossierDem(False:C215)
	K_BoutonDossierDos(False:C215)
End if 