If (Form event code:C388=Sur clic:K2:4)
	[DePart:1]DP_Libelle:6:="@"
	va_FrappeClavier:=[DePart:1]DP_Libelle:6
	If (va_FrappeClavier="")
		REDUCE SELECTION:C351([HeBerge:4]; 0)
	Else 
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=(va_FrappeClavier+"@"))
	End if 
	
	vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
	ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
	FIRST RECORD:C50([HeBerge:4])
	REDUCE SELECTION:C351([HeberGement:5]; 0)
	vL_Nb_HG_F:=0
	va_Nb_HG_F:=""
	REDUCE SELECTION:C351([DossierSante:33]; 0)
	vL_Nb_MR_F:=0
	va_Nb_MR_F:=""
	K_BoutonDossierDem(False:C215)
	K_BoutonDossierDos(False:C215)
End if 