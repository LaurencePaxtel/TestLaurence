//%attributes = {}
QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DispoDuJour:12=0)
MultiSoc_Filter(->[CentresLits:16])
If (Records in selection:C76([CentresLits:16])>0)
	MESSAGES ON:C181
	READ WRITE:C146([CentresLits:16])
	APPLY TO SELECTION:C70([CentresLits:16]; wUut_MajLitApp)
	MESSAGES OFF:C175
	READ ONLY:C145([CentresLits:16])
End if 