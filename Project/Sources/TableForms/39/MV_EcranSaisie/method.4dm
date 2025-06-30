$vl_EventFF:=Form event code:C388
If (Form event code:C388=Sur chargement:K2:1)
	If (Is new record:C668([MessagerieVSM:39]))
		MultiSoc_Init_Structure(->[MessagerieVSM:39])
		[MessagerieVSM:39]MV_RéférenceID:1:=Uut_Numerote(->[MessagerieVSM:39])
		[MessagerieVSM:39]MV_Date:2:=Current date:C33(*)
		[MessagerieVSM:39]MV_Heure:3:=Current time:C178(*)
		[Messagerie:34]MS_User:4:=<>vl_UserRéfU
	Else 
	End if 
End if 