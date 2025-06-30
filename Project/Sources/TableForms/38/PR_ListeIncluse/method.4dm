If (Form event code:C388=Sur affichage corps:K2:22)
	va_PR_GPLib:="???"
	ve_NbGPGH:=0
	QUERY:C277([GrouPe:36]; [GrouPe:36]GP_ReferenceID:1=[Prolongation:38]PR_GPHB_Référence:5)
	MultiSoc_Filter(->[GrouPe:36])
	If (Records in selection:C76([GrouPe:36])=1)
		va_PR_GPLib:=[GrouPe:36]GP_Intitulé:4
		QUERY:C277([GrouPe:36]; [GrouPe:36]GP_ReferenceID:1=[Prolongation:38]PR_GPHB_Référence:5)
		MultiSoc_Filter(->[GrouPe:36])
		If (Records in selection:C76([GrouPe:36])=1)
			va_PR_GPLib:=[GrouPe:36]GP_Intitulé:4
			QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_GP_Référence:2=[GrouPe:36]GP_ReferenceID:1)
			MultiSoc_Filter(->[GroupeHeberges:37])
			ve_NbGPGH:=Records in selection:C76([GroupeHeberges:37])
		End if 
	End if 
End if 