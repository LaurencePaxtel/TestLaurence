//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 04/04/20, 09:28:53
// ----------------------------------------------------
// Method: Web_PLA_Get_Privileges
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($O_Data; $O_Output)
C_TEXT:C284($JSON; $search_nom)
C_LONGINT:C283($i; $count; $id_selected)
C_BOOLEAN:C305($continu; $is_usr_granted)

ARRAY OBJECT:C1221($tb_privileges_config; 0)

$i:=0
$continu:=True:C214

READ ONLY:C145([INtervenants:10])
READ ONLY:C145([Preferences:81])

ALL RECORDS:C47([INtervenants:10])
MultiSoc_Filter(->[INtervenants:10])

$O_Data:=Web_AGL_Get_Post_Json_Data

$id_selected:=Num:C11(OB Get:C1224($O_Data; "id_selected"; Est un texte:K8:3))
$search_nom:=OB Get:C1224($O_Data; "search_nom"; Est un texte:K8:3)

If ($id_selected=0)
	$id_selected:=w_userUID
End if 

READ ONLY:C145([INtervenants:10])
QUERY:C277([INtervenants:10]; [INtervenants:10]ID:16=$id_selected)
MultiSoc_Filter(->[INtervenants:10])

If (Records in selection:C76([INtervenants:10])=1)
	
	QUERY:C277([Preferences:81]; [Preferences:81]PREF_UID_user:7=$id_selected; *)
	QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_Type:2="planning_web_privileges")
	MultiSoc_Filter(->[Preferences:81])
	
	If (Records in selection:C76([Preferences:81])=1)
		OB GET ARRAY:C1229([Preferences:81]PREF_Object_Value:12; "privileges"; $tb_privileges_config)
	End if 
	
	
	QUERY:C277([INtervenants:10]; [INtervenants:10]ID:16#$id_selected)
	MultiSoc_Filter(->[INtervenants:10])
	
	
	If ($search_nom#"")
		QUERY SELECTION:C341([INtervenants:10]; [INtervenants:10]IN_NomPrénom:8="@"+$search_nom+"@")
	End if 
	
	
	If (Records in selection:C76([INtervenants:10])<20)
		$count:=Records in selection:C76([INtervenants:10])
	Else 
		$count:=20
	End if 
	
	ARRAY LONGINT:C221($tb_usr_ids; 0)
	ARRAY TEXT:C222($tb_usr_names; 0)
	ARRAY BOOLEAN:C223($tb_usr_selected; 0)
	ARRAY TEXT:C222($tb_usr_privilege; 0)
	
	//==========================================//
	// Utilisateurs
	//==========================================//
	
	While (Not:C34(End selection:C36([INtervenants:10])))
		
		APPEND TO ARRAY:C911($tb_usr_ids; [INtervenants:10]ID:16)
		APPEND TO ARRAY:C911($tb_usr_names; [INtervenants:10]IN_NomPrénom:8)
		
		C_TEXT:C284($privilege_tmp)
		
		$is_usr_granted:=False:C215
		$privilege_tmp:=""
		
		For ($i; 1; Size of array:C274($tb_privileges_config))
			If ($tb_privileges_config{$i}.id=String:C10([INtervenants:10]ID:16))
				$is_usr_granted:=True:C214
				$privilege_tmp:=$tb_privileges_config{$i}.privilege
				$i:=Size of array:C274($tb_privileges_config)
			End if 
		End for 
		
		If (Not:C34($is_usr_granted))
			APPEND TO ARRAY:C911($tb_usr_selected; False:C215)
			$i:=$i+1
		Else 
			APPEND TO ARRAY:C911($tb_usr_selected; True:C214)
		End if 
		
		APPEND TO ARRAY:C911($tb_usr_privilege; $privilege_tmp)
		
		If ($i=$count)
			LAST RECORD:C200([INtervenants:10])
		End if 
		
		NEXT RECORD:C51([INtervenants:10])
	End while 
	
	//==========================================//
	// Utilisateurs autorisés
	//==========================================//
	
	If (Records in selection:C76([Preferences:81])=1)
		
		For ($i; 1; Size of array:C274($tb_privileges_config))
			
			$id:=Num:C11($tb_privileges_config{$i}.id)
			
			QUERY:C277([INtervenants:10]; [INtervenants:10]ID:16=$id)
			MultiSoc_Filter(->[INtervenants:10])
			
			APPEND TO ARRAY:C911($tb_usr_ids; [INtervenants:10]ID:16)
			APPEND TO ARRAY:C911($tb_usr_names; [INtervenants:10]IN_NomPrénom:8)
			APPEND TO ARRAY:C911($tb_usr_selected; True:C214)
			APPEND TO ARRAY:C911($tb_usr_privilege; $tb_privileges_config{$i}.privilege)
			
		End for 
		
	End if 
Else 
	$continu:=False:C215
End if 

If (Not:C34($continu))
	OB SET:C1220($O_Output; "Status"; "Failed")
	$JSON:=JSON Stringify:C1217($O_Output)
Else 
	
	ARRAY OBJECT:C1221($tb_object; Size of array:C274($tb_usr_ids))
	C_TEXT:C284($setected)
	
	SORT ARRAY:C229($tb_usr_names; $tb_usr_ids; $tb_usr_selected; $tb_usr_privilege; >)
	
	For ($i; 1; Size of array:C274($tb_usr_ids))
		$setected:=""
		If ($tb_usr_selected{$i})
			$setected:="selected"
		End if 
		If ($tb_usr_privilege{$i}="readonly")
			$tb_usr_names{$i}:=$tb_usr_names{$i}+" (Consulter)"
		End if 
		If ($tb_usr_privilege{$i}="readwrite")
			$tb_usr_names{$i}:=$tb_usr_names{$i}+" (Consulter/Modifier)"
		End if 
		OB SET:C1220($tb_object{$i}; "userid"; $tb_usr_ids{$i}; "user_nom_prenom"; $tb_usr_names{$i}; "status"; $setected)
	End for 
	
	$JSON:=JSON Stringify array:C1228($tb_object)
End if 


WEB SEND TEXT:C677($JSON)