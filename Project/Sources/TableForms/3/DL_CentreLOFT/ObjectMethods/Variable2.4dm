If (Form event code:C388=Sur données modifiées:K2:15)
	If (F_HebergementPrestation("H"; <>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{51}; !00-00-00!; va_CtrLib))
		
		<>va_LOFTCtrNom:=va_RH_Typ1
		<>va_LOFTCtrCP:=va_RH_Typ2
		<>vl_LOFTCtrRéf:=vl_RH_RéfID
		<>vb_LOFTCtrMéd:=vb_RH_Médic
		<>vl_LOFTCtrMéd:=Num:C11(<>vb_LOFTCtrMéd=True:C214)
	Else 
	End if 
	va_CtrLib:=""
End if 