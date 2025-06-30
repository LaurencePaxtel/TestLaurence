vt_DossierChemin:=""
vt_DossierChemin:=Select folder:C670("Veuillez choisir le dossier contenant les documents exportés ?")
If (OK=1)
	P_VarParamConsoVoir(1)
	P_VarParamConsoVoir(2)
	<>vt_ConsoB_CheminDossier:=vt_DossierChemin
	vt_FullDuplexDossier:=vt_DossierChemin
	
	<>va_ConsoB_115:=False:C215
	DOCUMENT LIST:C474(vt_FullDuplexDossier; <>ta_ConsoB_Document)
	If (Size of array:C274(<>ta_ConsoB_Document)>0)
		P_VarParamConsoVoir(10)
		If (Size of array:C274(<>ta_ConsoB_Document)>0)
			<>ta_ConsoB_Document:=1
			P_ConsoVoir(<>ta_ConsoB_Document)
		End if 
	End if 
End if 

<>vl_ConsoB_DocumentLignes:=Size of array:C274(<>ta_ConsoB_Document)