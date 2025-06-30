//Script b_RecHéb
<>vl_NoHHisto:=0
va_CtrLib:=""
If (Macintosh control down:C544) | (Windows Ctrl down:C562)
	[DiaLogues:3]DL_LibelAutre:5:=""
Else 
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{7}; -><>ta_TBArr; ->[DiaLogues:3]DL_LibelAutre:5)
End if 