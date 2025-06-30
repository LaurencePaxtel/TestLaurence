//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 21/10/2020, 16:33:28
// ----------------------------------------------------
// Method: MAINT_Heberges_Telephone
// Description
// 
//
// Parameters
// ----------------------------------------------------

READ WRITE:C146([HeBerge:4])
QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Telephone:66#"")

While (Not:C34(End selection:C36([HeBerge:4])))
	[HeBerge:4]HB_Telephone:66:=Replace string:C233([HeBerge:4]HB_Telephone:66; "."; "")
	[HeBerge:4]HB_Telephone:66:=Replace string:C233([HeBerge:4]HB_Telephone:66; " "; "")
	[HeBerge:4]HB_Telephone:66:=Replace string:C233([HeBerge:4]HB_Telephone:66; "/"; "")
	[HeBerge:4]HB_Telephone:66:=Replace string:C233([HeBerge:4]HB_Telephone:66; "-"; "")
	SAVE RECORD:C53([HeBerge:4])
	NEXT RECORD:C51([HeBerge:4])
End while 

ALERT:C41("opération effectuée avec succès")
