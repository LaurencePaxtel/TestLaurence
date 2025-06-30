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
	
	
	
	OBJECT SET FONT STYLE:C166(va_DateGPPR; Normal:K14:1)
	
	_O_OBJECT SET COLOR:C271(*; "Groupe_@"; -(Noir:K11:16+(256*Gris clair:K11:13)))
	
	If ([GrouPe:36]GP_ProlongationExclu:8)
		_O_OBJECT SET COLOR:C271(*; "Groupe_@"; -(Rouge:K11:4+(256*Gris clair:K11:13)))
	Else 
		If (ve_NbGPPR=0)
		Else 
			If (vb_ValDateGPPR)
				_O_OBJECT SET COLOR:C271(*; "Groupe_@"; -(Vert:K11:9+(256*Gris clair:K11:13)))
				OBJECT SET FONT STYLE:C166(va_DateGPPR; Italique:K14:3)
			Else 
				_O_OBJECT SET COLOR:C271(*; "Groupe_@"; -(Bleu:K11:7+(256*Gris clair:K11:13)))
			End if 
		End if 
	End if 
	
End if 
