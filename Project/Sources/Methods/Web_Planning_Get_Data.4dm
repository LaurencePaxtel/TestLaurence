//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26/03/20, 09:16:15
// ----------------------------------------------------
// Method: Web_Planning_Get_Data
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($json; $allDay; $event_title; $event_color; $event_start; $event_end; $event_textcolor; $event_borderColor)
C_LONGINT:C283($i; $size; $duration; $selected_userid; $selected_hb_id; $current_userUID; $j)
C_BOOLEAN:C305($is_user_granted; $event_startEditable)
C_DATE:C307($start_date; $end_date)

ARRAY TEXT:C222($tb_enum_values; 0)

ARRAY LONGINT:C221($tb_tmp_id_part; 0)
ARRAY LONGINT:C221($tb_granted_users; 0)
ARRAY LONGINT:C221($tb_eve_participe_ids; 0)

ARRAY OBJECT:C1221($tb_privileges_config; 0)

$start_date:=Date:C102(WEB_UTL_GET_PARAMS("start"))
$end_date:=Date:C102(WEB_UTL_GET_PARAMS("end"))

$selected_userid:=Num:C11(WEB_UTL_GET_PARAMS("userid"))
$selected_hb_id:=Num:C11(WEB_UTL_GET_PARAMS("hb_id"))

$current_userUID:=w_userUID

If ($selected_userid>0)
	$current_userUID:=$selected_userid
End if 

READ ONLY:C145([Events:103])
READ ONLY:C145([HeBerge:4])

//==========================================//
// Privilèges : utilisateurs autorisés
//==========================================//
QUERY:C277([Preferences:81]; [Preferences:81]PREF_UID_user:7=w_userUID; *)
QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_Type:2="planning_web_privileges")
MultiSoc_Filter(->[Preferences:81])

If (Records in selection:C76([Preferences:81])=1)
	OB GET ARRAY:C1229([Preferences:81]PREF_Object_Value:12; "privileges"; $tb_privileges_config)
End if 

For ($i; 1; Size of array:C274($tb_privileges_config))
	APPEND TO ARRAY:C911($tb_granted_users; Num:C11($tb_privileges_config{$i}.id))
End for 

Case of 
	: ($selected_userid=-1)
		APPEND TO ARRAY:C911($tb_granted_users; w_userUID)
	: ($selected_userid=0)
		ARRAY LONGINT:C221($tb_granted_users; 0)
		APPEND TO ARRAY:C911($tb_granted_users; w_userUID)
	Else 
		$pos:=Find in array:C230($tb_granted_users; $selected_userid)
		ARRAY LONGINT:C221($tb_granted_users; 0)
		If ($pos>0)
			APPEND TO ARRAY:C911($tb_granted_users; $selected_userid)
		End if 
End case 

//==========================================//
// Evénements dont je suis participant
//==========================================//
QUERY:C277([Events_Details:104]; [Events_Details:104]EVD_User_ID:4=$current_userUID)
SELECTION TO ARRAY:C260([Events_Details:104]EVD_Event_ID:3; $tb_eve_participe_ids)

QUERY WITH ARRAY:C644([Events:103]ID:1; $tb_eve_participe_ids)
CREATE SET:C116([Events:103]; "events_participe")
//==========================================//

QUERY WITH ARRAY:C644([Events:103]EVE_User_ID:9; $tb_granted_users)
QUERY SELECTION:C341([Events:103]; [Events:103]EVE_Date_Du:5>=$start_date; *)

CREATE SET:C116([Events:103]; "events_granted")
UNION:C120("events_granted"; "events_participe"; "events_result")

USE SET:C118("events_result")

If ($selected_hb_id#0)
	QUERY SELECTION:C341([Events:103]; [Events:103]EVE_HB_ID:14=$selected_hb_id)
End if 

MultiSoc_Filter(->[Events:103])

$size:=Records in selection:C76([Events:103])
ARRAY OBJECT:C1221($tb_result; $size)

FIRST RECORD:C50([Events:103])
$values_c:=UTL_Web_Get_Enumeration_Values("Planning: Types RDV")
If ($values_c.length#0)
	COLLECTION TO ARRAY:C1562($values_c; $tb_enum_values)
End if 


ARRAY TEXT:C222($tb_types_color; Size of array:C274($tb_enum_values))
SORT ARRAY:C229($tb_enum_values; >)

For ($i; 1; Size of array:C274($tb_enum_values))
	
	Case of 
		: ($i=1)
			$tb_types_color{$i}:="#F15a24"  //"orange"
		: ($i=2)
			$tb_types_color{$i}:="#3bb44a"  //"green"
		: ($i=3)
			$tb_types_color{$i}:="purple"
		: ($i=4)
			$tb_types_color{$i}:="#c1272d"  //"red"
		: ($i=5)
			$tb_types_color{$i}:="#4d4d4d"  //"grey" light
		: ($i=6)
			$tb_types_color{$i}:="#333333"  //"grey" foncé
		Else 
			$tb_types_color{$i}:="#0d72b9"
	End case 
	
End for 

For ($i; 1; $size)
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Events:103]EVE_HB_ID:14)
	MultiSoc_Filter(->[HeBerge:4])
	
	// Modifié par : Scanu Rémy (19/09/2022)
	// A la place du champ [Events]EVE_Type, on met le champ [Events]EVE_Titre
	If ((Records in selection:C76([HeBerge:4])=1) & ([HeBerge:4]HB_Clé:2#""))
		$event_title:=[HeBerge:4]HB_Clé:2+" - "+[Events:103]EVE_Titre:3
	Else 
		QUERY:C277([Events_Details:104]; [Events_Details:104]EVD_Event_ID:3=[Events:103]ID:1)
		MultiSoc_Filter(->[Events_Details:104])
		
		SELECTION TO ARRAY:C260([Events_Details:104]EVD_User_ID:4; $tb_tmp_id_part)
		QUERY WITH ARRAY:C644([INtervenants:10]ID:16; $tb_tmp_id_part)
		
		If ((Records in selection:C76([INtervenants:10])>0) & ([INtervenants:10]IN_NomPrénom:8#""))
			$event_title:=[INtervenants:10]IN_NomPrénom:8+" - "+[Events:103]EVE_Titre:3
		Else 
			$event_title:=[Events:103]EVE_Titre:3
		End if 
		
	End if 
	
	$pos:=Find in array:C230($tb_enum_values; [Events:103]EVE_Type:10)
	
	If ($pos>0)
		$event_color:=$tb_types_color{$pos}
	End if 
	
	$event_start:=String:C10([Events:103]EVE_Date_Du:5; ISO date:K1:8; [Events:103]EVE_Heure_Du:7)
	$event_end:=String:C10([Events:103]EVE_Date_Au:6; ISO date:K1:8; [Events:103]EVE_Heure_Au:8)
	
	$allDay:="false"
	$duration:=[Events:103]EVE_Date_Au:6-[Events:103]EVE_Date_Du:5
	
	If ($duration>0)
		$allDay:="true"
		$event_end:=String:C10(Add to date:C393([Events:103]EVE_Date_Au:6; 0; 0; 1); ISO date:K1:8; [Events:103]EVE_Heure_Au:8)  //Fix
	Else 
		$duration:=([Events:103]EVE_Heure_Au:8-[Events:103]EVE_Heure_Du:7)/3600
		If ($duration>=12)
			$allDay:="true"
		End if 
	End if 
	
	//==========================================//
	// Privilèges 
	//==========================================//
	$event_startEditable:=True:C214
	$event_textcolor:="#FFFFFF"
	$event_borderColor:="#000"
	
	$mode:="readwrite"
	$is_user_granted:=True:C214
	
	If (w_userUID#[Events:103]EVE_User_ID:9)
		$is_user_granted:=False:C215
		$mode:="denied"
		
		QUERY:C277([Preferences:81]; [Preferences:81]PREF_UID_user:7=w_userUID; *)
		QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_Type:2="planning_web_privileges")
		MultiSoc_Filter(->[Preferences:81])
		
		If (Records in selection:C76([Preferences:81])=1)
			OB GET ARRAY:C1229([Preferences:81]PREF_Object_Value:12; "privileges"; $tb_privileges_config)
			
			For ($j; 1; Size of array:C274($tb_privileges_config))
				
				If ($tb_privileges_config{$j}.id=String:C10([Events:103]EVE_User_ID:9))
					$mode:=$tb_privileges_config{$j}.privilege
					$is_user_granted:=True:C214
					
					$j:=Size of array:C274($tb_privileges_config)
				End if 
				
			End for 
			
		End if 
		
	End if 
	
	If ($is_user_granted)
		
		If ($mode="readwrite")
			$event_startEditable:=True:C214
		Else 
			$event_startEditable:=False:C215
			$event_borderColor:="#d1cfcf"
		End if 
		
	Else   // Events dans lesquels je suis participant
		$event_startEditable:=False:C215
		$event_borderColor:="#d1cfcf"
	End if 
	//==========================================//
	
	If ($allDay="true")
		OB SET:C1220($tb_result{$i}; "id"; String:C10([Events:103]ID:1); "title"; $event_title; "start"; $event_start; "end"; $event_end; "color"; $event_color; "allDay"; $allDay; "startEditable"; $event_startEditable)
	Else 
		OB SET:C1220($tb_result{$i}; "id"; String:C10([Events:103]ID:1); "title"; $event_title; "start"; $event_start; "end"; $event_end; "color"; $event_color; "startEditable"; $event_startEditable)
	End if 
	
	CLEAR VARIABLE:C89($event_color)
	CLEAR VARIABLE:C89($tb_tmp_id_part)
	CLEAR VARIABLE:C89($tb_privileges_config)
	
	NEXT RECORD:C51([Events:103])
End for 

CLEAR SET:C117("events_participe")
CLEAR SET:C117("events_granted")
CLEAR SET:C117("events_result")

$json:=JSON Stringify array:C1228($tb_result)

WEB SEND TEXT:C677($json)