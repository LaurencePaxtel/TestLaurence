//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_RG_LesFiches
//{          Lundi 8 novembre 2010 à 15:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
vl_ThermoIndice:=vl_ThermoIndice+1
If (vb_SurServeur=False:C215)
	If (Mod:C98(vl_ThermoIndice; vl_ThermoPas)=0)
		<>va_TransfertRegional_Action:=<>va_TransfertRegional_Action1  //"Thermo"
		POST OUTSIDE CALL:C329(<>PR_ConsoRParam)
	End if 
End if 

If (vb_Message)
	i_MessageSeul("Export : "+String:C10(vl_Thermomètre; "## ### ##0")+" / "+String:C10(vl_ThermoIndice; "## ### ##0"))
End if 

vb_Ok:=F_Report_FullDuplexFichier(->vt_TitreDocument; vd_DateRéelle; vd_HeureRéelle; <>va_ConsoR_Site; [HeberGement:5]HG_FicheNuméro:3; [HeberGement:5]HG_EtatCivil:20; [HeberGement:5]HG_Age:23)
If (vb_Ok)
	vt_TitreDocument:=F_FichierSuffixe(vt_TitreDocument)
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
	MultiSoc_Filter(->[HeBerge:4])
	vb_Ok:=F_RG_Hébergé
	vb_Ok:=F_RG_Hebergements
	<>vt_TexteRegional_ST:="INFOS REGIONALES"+<>va_TAB+String:C10(vd_HeureRéelle; Interne date court:K1:7)+<>va_TAB+String:C10(vd_HeureRéelle; h mn s:K7:1)+<>va_TAB+"-1"+<>va_CR
	<>vt_TexteRegional_ST:=<>vt_TexteRegional_ST+<>vt_TexteRegional_HB
	<>vt_TexteRegional_ST:=<>vt_TexteRegional_ST+<>vt_TexteRegional_HG
	<>vt_TexteRegional_ST:=<>vt_TexteRegional_ST+"SSPFINREGIONALSSP"+<>va_TAB+<>va_CR
	
	vh_Ref:=Create document:C266(<>vt_ConsoRegion_Dosssier+vt_TitreDocument)
	If (OK=1)
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		If (<>vb_CestUnMac)
			SEND PACKET:C103(vh_Ref; <>vt_TexteRegional_ST)
		Else 
			SEND PACKET:C103(vh_Ref; _O_Mac to Win:C463(<>vt_TexteRegional_ST))
		End if 
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267(vh_Ref)
	End if 
End if 
