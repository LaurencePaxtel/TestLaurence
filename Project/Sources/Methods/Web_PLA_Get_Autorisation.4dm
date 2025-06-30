//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 16/04/20, 08:17:47
// ----------------------------------------------------
// Method: Web_PLA_Get_Autorisation
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($O_Data; $O_Output)
C_TEXT:C284($JSON)
C_LONGINT:C283($id_selected)
C_BOOLEAN:C305($continu)

READ ONLY:C145([INtervenants:10])

$continu:=False:C215

$O_Data:=Web_AGL_Get_Post_Json_Data

$id_selected:=Num:C11(OB Get:C1224($O_Data; "id_selected"; Est un texte:K8:3))

If ($id_selected>0)
	
	QUERY:C277([Preferences:81]; [Preferences:81]PREF_UID_user:7=w_userUID; *)
	QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_Type:2="planning_web_privileges")
	MultiSoc_Filter(->[Preferences:81])
	
	If (Records in selection:C76([Preferences:81])=1)
		
		ARRAY OBJECT:C1221($tb_privileges_config; 0)
		ARRAY OBJECT:C1221($tb_object; 1)
		
		OB GET ARRAY:C1229([Preferences:81]PREF_Object_Value:12; "privileges"; $tb_privileges_config)
		
		For ($i; 1; Size of array:C274($tb_privileges_config))
			If ($id_selected=Num:C11($tb_privileges_config{$i}.id))
				OB SET:C1220($tb_object{1}; "userid"; $id_selected; "autorisation"; $tb_privileges_config{$i}.privilege)
				$continu:=True:C214
				$i:=Size of array:C274($tb_privileges_config)
			End if 
		End for 
		
	Else 
		$continu:=False:C215
	End if 
	
Else 
	// Utilisateur courant
	ARRAY OBJECT:C1221($tb_object; 1)
	OB SET:C1220($tb_object{1}; "userid"; String:C10(w_userUID); "autorisation"; "readwrite")
	$continu:=True:C214
End if 

If ($continu)
	$JSON:=JSON Stringify array:C1228($tb_object)
Else 
	OB SET:C1220($O_Output; "Status"; "Failed")
	$JSON:=JSON Stringify:C1217($O_Output)
End if 

WEB SEND TEXT:C677($JSON)