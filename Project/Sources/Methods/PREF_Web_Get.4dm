//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 04/04/20, 12:17:17
// ----------------------------------------------------
// Method: PREF_Web_Get
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($JSON; $type; $pref_type; $PREF_Value_2)
C_LONGINT:C283($userID)
C_OBJECT:C1216($O_Data)

var $preference_e : cs:C1710.PreferencesEntity

ARRAY OBJECT:C1221($tb_object; 1)

$userID:=w_userUID
$O_Data:=Web_AGL_Get_Post_Json_Data

$type:=OB Get:C1224($O_Data; "type"; Is text)
$pref_type:=OB Get:C1224($O_Data; "pref_type"; Is text)

Case of 
	: ($type="structure")
		$userID:=w_structureID
End case 

READ WRITE:C146([Preferences:81])

QUERY:C277([Preferences:81]; [Preferences:81]PREF_Type:2=$pref_type; *)
QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_UID_user:7=$userID)
MultiSoc_Filter(->[Preferences:81])

// Modifié par : Scanu Rémy (06/02/2023)
If (Records in selection:C76([Preferences:81])=0)
	$preference_e:=ds:C1482.Preferences.new()
	
	$preference_e.PREF_Type:=$pref_type
	$preference_e.PREF_UID_user:=$userID
	$preference_e.Ref_Structure:=ref_soc_active
	$preference_e.save()
	
	QUERY:C277([Preferences:81]; [Preferences:81]UID:1=$preference_e.UID)
End if 

$PREF_Value_2:=[Preferences:81]PREF_Value_2:4

If ($PREF_Value_2="")
	$PREF_Value_2:=Nom_Structure
End if 

OB SET:C1220($tb_object{1}; "pref_value_1"; [Preferences:81]PREF_Value_1:3; "pref_value_2"; $PREF_Value_2; "pref_value_3"; [Preferences:81]PREF_Value_3:5)
$JSON:=JSON Stringify array:C1228($tb_object)

WEB SEND TEXT:C677($JSON)