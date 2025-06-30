//Script b_RecHéb
If (Macintosh control down:C544) | (Windows Ctrl down:C562)
	[Prolongation:38]PR_CentreNoms:10:=""
	[Prolongation:38]PR_LC_ID:9:=0
Else 
	If (F_HebergementPrestation("H"; <>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{51}; !00-00-00!; "@"))
		
		[Prolongation:38]PR_CentreNoms:10:=va_RH_Typ1
		[Prolongation:38]PR_LC_ID:9:=vl_RH_RéfID
	End if 
End if 
