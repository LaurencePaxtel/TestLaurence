If (Form event code:C388=Sur données modifiées:K2:15)
	
	If (F_HebergementPrestation("P"; <>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{51}; !00-00-00!; va_CtrLib))
		<>va_PointeCtrNom:=va_RH_Typ1
		<>va_PointeCtrCP:=va_RH_Typ2
		<>vl_PointeCtrRéf:=vl_RH_RéfID
		<>vb_PointeCtrMéd:=vb_RH_Médic
		<>vl_PointeCtrMéd:=Num:C11(<>vb_PointeCtrMéd=True:C214)
	End if 
	
	va_CtrLib:=""
End if 