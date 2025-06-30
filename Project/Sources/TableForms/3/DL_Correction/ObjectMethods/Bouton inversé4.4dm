//Script b_RecHéb
<>vl_NoHHisto:=0
va_CtrLib:=""
If (Macintosh control down:C544) | (Windows Ctrl down:C562)
	[DiaLogues:3]DL_Libellé:3:=""
Else 
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{19}; -><>ta_TBMaraud; ->[DiaLogues:3]DL_Libellé:3)
End if 