
P_VarParamConsoVoir(1)
P_VarParamConsoVoir(2)

$vb_OK:=F_Report_FullDuplexDossier(11; <>vt_T_CheminRép)
If ($vb_OK=False:C215)
	ALERT:C41("Absence de repertoire TRANS")
End if 

If ($vb_OK)
	// on cherche le répertoire on l'on RÉCUPÈRE les fiches
	//  ◊va_Rép_TransReport:="115Report"
	//  ◊va_Rép_TransReportLU:="115LU"
	vt_FullDuplexDossier:=<>vt_T_CheminRép+<>va_Rép_TransReport+Séparateur dossier:K24:12
	$vb_OK:=F_Report_FullDuplexDossier(11; vt_FullDuplexDossier)
	If ($vb_OK)
		
	Else 
		ALERT:C41("Absence de repertoire")
	End if 
End if 


If ($vb_OK)  //•y a t il des fiches
	<>vt_ConsoB_CheminDossier:=vt_FullDuplexDossier
	DOCUMENT LIST:C474(vt_FullDuplexDossier; <>ta_ConsoB_Document)
	If (Size of array:C274(<>ta_ConsoB_Document)>0)
		<>ta_ConsoB_Document:=1
		P_ConsoVoir(<>ta_ConsoB_Document)
	End if 
End if 

<>vl_ConsoB_DocumentLignes:=Size of array:C274(<>ta_ConsoB_Document)