If (Form event code:C388=Sur affichage corps:K2:22)
	vl_NbHGip:=0
	ve_NbGPPR:=0
	va_DateGPPR:=""
	vd_DateGPPR:=!00-00-00!
	vb_ValDateGPPR:=False:C215
	SET QUERY DESTINATION:C396(Vers variable:K19:4; vl_NbHGip)
	QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_GP_Référence:2=[GrouPe:36]GP_ReferenceID:1)
	ve_NbGPGH:=vl_NbHGip
	SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
	
	
	QUERY:C277([Prolongation:38]; [Prolongation:38]PR_GPHB_Référence:5=[GrouPe:36]GP_ReferenceID:1)
	ve_NbGPPR:=Records in selection:C76([Prolongation:38])
	If (ve_NbGPPR>0)
		ORDER BY:C49([Prolongation:38]; [Prolongation:38]PR_RésaDateDébut:6; <)
		vd_DateGPPR:=[Prolongation:38]PR_RésaDateDébut:6
		vb_ValDateGPPR:=[Prolongation:38]PR_ProlongationEffectuée:11
		va_DateGPPR:=String:C10(vd_DateGPPR; Système date court:K1:1)
	End if 
	
	If (vb_ValDateGPPR)
		OBJECT SET FONT STYLE:C166(va_DateGPPR; Italique:K14:3)
	Else 
		OBJECT SET FONT STYLE:C166(va_DateGPPR; Normal:K14:1)
	End if 
End if 