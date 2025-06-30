//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 07/04/20, 03:18:50
// ----------------------------------------------------
// Method: SMS_Init
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(SMS_PARAM_TOKEN; SMS_PARAM_SENDER; SMS_PARAM_MESSAGE)

SMS_PARAM_TOKEN:=""
SMS_PARAM_SENDER:=""
SMS_PARAM_MESSAGE:=""

QUERY:C277([Preferences:81]; [Preferences:81]PREF_Type:2="planning_web_configuration"; *)
QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_UID_user:7=w_structureID)
MultiSoc_Filter(->[Preferences:81])

If (Records in selection:C76([Preferences:81])=1)
	SMS_PARAM_TOKEN:=[Preferences:81]PREF_Value_1:3
	SMS_PARAM_SENDER:=[Preferences:81]PREF_Value_2:4
	SMS_PARAM_MESSAGE:=[Preferences:81]PREF_Value_3:5
End if 
