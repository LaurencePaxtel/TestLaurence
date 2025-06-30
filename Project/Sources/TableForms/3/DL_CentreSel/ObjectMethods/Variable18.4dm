If (Form event code:C388=Sur clic:K2:4)
	If (b_SelRCel=1)
		If ([LesCentres:9]LC_RéférenceID:1>0)
			vb_RecHéb:=True:C214
			va_RH_Typ1:=[LesCentres:9]LC_Nom:4
			va_RH_Typ2:=[LesCentres:9]LC_Lieu:5
			vl_RH_RéfID:=[LesCentres:9]LC_RéférenceID:1
			vb_RH_Médic:=[LesCentres:9]LC_LitMédicalis:47
			CANCEL:C270
		Else 
			StrAlerte(21; "")
		End if 
	End if 
End if 