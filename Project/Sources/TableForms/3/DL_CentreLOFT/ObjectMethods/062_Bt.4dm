//Script b_RecHéb
<>vl_NoHHisto:=0
If (Macintosh control down:C544) | (Windows Ctrl down:C562)
	
	
	<>va_LOFTCtrNom:=""
	<>va_LOFTCtrCP:=""
	<>vl_LOFTCtrRéf:=0
	<>vb_LOFTCtrMéd:=False:C215
	<>vl_LOFTCtrMéd:=0
	<>va_LOFTCtrPlateF:=""
Else 
	If (F_HebergementPrestation("H"; <>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{51}; !00-00-00!; "@"))
		
		<>va_LOFTCtrNom:=va_RH_Typ1
		<>va_LOFTCtrCP:=va_RH_Typ2
		<>vl_LOFTCtrRéf:=vl_RH_RéfID
		<>vb_LOFTCtrMéd:=vb_RH_Médic
		<>vl_LOFTCtrMéd:=Num:C11(<>vb_LOFTCtrMéd=True:C214)
		<>va_LOFTCtrPlateF:=""
	Else 
	End if 
End if 