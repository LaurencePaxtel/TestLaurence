//%attributes = {}
C_TEXT:C284($0)
C_LONGINT:C283($1)

QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$1)

If (Records in selection:C76([HeBerge:4])=1)
	$0:=[HeBerge:4]HB_Clé:2
End if 