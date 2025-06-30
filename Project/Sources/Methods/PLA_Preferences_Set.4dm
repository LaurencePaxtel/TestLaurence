//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 04/04/20, 11:55:17
// ----------------------------------------------------
// Method: PLA_Preferences_Set
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $table)
C_TEXT:C284($2; $libelle; $type; $pref_type; $Status; $usr_granted_ids)
C_OBJECT:C1216($O_Output; $O_Data)
C_BOOLEAN:C305($continu)
C_LONGINT:C283($userID)

$table:=$1
$libelle:=$2
$O_Output:=New object:C1471
$continu:=True:C214
$status:="Success"
$userID:=w_userUID

$O_Data:=Web_AGL_Get_Post_Json_Data

$O_Data:=OB Get:C1224($O_Data; $libelle; Est un objet:K8:27)

$type:=OB Get:C1224($O_Data; "type"; Est un texte:K8:3)
$pref_type:=OB Get:C1224($O_Data; "pref_type"; Est un texte:K8:3)

Case of 
	: ($type="structure")
		$userID:=w_structureID
		
	: ($pref_type="planning_web_privileges")
		$userID:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))
End case 

READ WRITE:C146([Preferences:81])

QUERY:C277([Preferences:81]; [Preferences:81]PREF_Type:2=$pref_type; *)
QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_UID_user:7=$userID)
MultiSoc_Filter(->[Preferences:81])


Case of 
	: (Records in selection:C76([Preferences:81])=0)
		
		CREATE RECORD:C68([Preferences:81])
		MultiSoc_Init_Structure(->[Preferences:81])
		[Preferences:81]PREF_UID_user:7:=$userID
		[Preferences:81]PREF_Type:2:=$pref_type
		
	: (Records in selection:C76([Preferences:81])=1)
		
		If (Locked:C147([Preferences:81]))
			$continu:=False:C215
		End if 
		
	Else 
		$continu:=False:C215
		
End case 

If ($continu)
	
	Case of 
		: ($pref_type="planning_web_view")
			
			[Preferences:81]PREF_Value_1:3:=OB Get:C1224($O_Data; "pref_value"; Est un texte:K8:3)
			
		: ($pref_type="planning_web_configuration")
			
			[Preferences:81]PREF_Value_1:3:=OB Get:C1224($O_Data; "pref_sms_token"; Est un texte:K8:3)
			[Preferences:81]PREF_Value_2:4:=OB Get:C1224($O_Data; "pref_sms_sender"; Est un texte:K8:3)
			[Preferences:81]PREF_Value_3:5:=OB Get:C1224($O_Data; "pref_sms_message"; Est un texte:K8:3)
			
		: ($pref_type="planning_web_privileges")
			
			C_TEXT:C284($mode; $mode_nv)
			C_LONGINT:C283($i; $j)
			C_BOOLEAN:C305($is_usr_granted)
			
			ARRAY TEXT:C222($tb_usr_granted_ids; 0)
			ARRAY OBJECT:C1221($tb_privileges_config_old; 0)
			
			OB GET ARRAY:C1229([Preferences:81]PREF_Object_Value:12; "privileges"; $tb_privileges_config_old)
			
			$usr_granted_ids:=OB Get:C1224($O_Data; "pla_priv_usr_ids"; Est un texte:K8:3)
			$mode_nv:=OB Get:C1224($O_Data; "mode"; Est un texte:K8:3)
			
			UTL_Cut_Text(->$usr_granted_ids; ->$tb_usr_granted_ids; ",")
			
			ARRAY OBJECT:C1221($tb_privileges_config; Size of array:C274($tb_usr_granted_ids))
			
			For ($i; 1; Size of array:C274($tb_usr_granted_ids))
				
				$is_usr_granted:=False:C215
				$mode:=$mode_nv
				
				For ($j; 1; Size of array:C274($tb_privileges_config_old))
					If ($tb_privileges_config_old{$j}.id=String:C10($tb_usr_granted_ids{$i}))
						$mode:=$tb_privileges_config_old{$j}.privilege
						$j:=Size of array:C274($tb_privileges_config_old)
					End if 
				End for 
				
				OB SET:C1220($tb_privileges_config{$i}; "id"; $tb_usr_granted_ids{$i}; "privilege"; $mode)
				
			End for 
			
			OB SET ARRAY:C1227([Preferences:81]PREF_Object_Value:12; "privileges"; $tb_privileges_config)
			
	End case 
	
	
	SAVE RECORD:C53([Preferences:81])
	
Else 
	$status:="Failed"
End if 

OB SET:C1220($O_Output; "Status"; $status)
$T_Json:=JSON Stringify:C1217($O_Output)
WEB SEND TEXT:C677($T_Json)