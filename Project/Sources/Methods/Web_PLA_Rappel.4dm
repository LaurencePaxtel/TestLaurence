//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 06/04/20, 17:00:12
// ----------------------------------------------------
// Method: Web_PLA_Rappel
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($1)

C_TEXT:C284($JSON; $json_record; $json_custom; $event_start; $EVE_Rappel)
C_LONGINT:C283($SECONDS_PER_MINUTE; $SECONDS_PER_HOUR; $SECONDS_PER_DAY; $rappel_minutes; $delai_attente; $rappel_heures; $rappel_jours; $remaining_days)
C_BOOLEAN:C305($instant_rappel)
C_TIME:C306($time_now; $time_now_seconds)

ARRAY LONGINT:C221($tb_eve_participe_ids; 0)
ARRAY LONGINT:C221($tb_events_id; 0)
ARRAY LONGINT:C221($tb_remining_time; 0)

// Constantes
$SECONDS_PER_MINUTE:=60
$SECONDS_PER_HOUR:=3600
$SECONDS_PER_DAY:=86400

If (Count parameters:C259>0)
	$instant_rappel:=$1
End if 

READ ONLY:C145([Events:103])

//==========================================//
// Mes événements
//==========================================//
QUERY:C277([Events:103]; [Events:103]EVE_User_ID:9=w_userUID; *)
QUERY:C277([Events:103];  & ; [Events:103]EVE_Date_Du:5>=Current date:C33(*))
MultiSoc_Filter(->[Events:103])

CREATE SET:C116([Events:103]; "my_events")

//==========================================//
// Evénements dont je suis participant
//==========================================//
QUERY:C277([Events_Details:104]; [Events_Details:104]EVD_User_ID:4=w_userUID)
SELECTION TO ARRAY:C260([Events_Details:104]EVD_Event_ID:3; $tb_eve_participe_ids)

QUERY WITH ARRAY:C644([Events:103]ID:1; $tb_eve_participe_ids)
QUERY SELECTION:C341([Events:103]; [Events:103]EVE_Date_Du:5>=Current date:C33(*))
MultiSoc_Filter(->[Events:103])

CREATE SET:C116([Events:103]; "events_participe")

UNION:C120("my_events"; "events_participe"; "events_result")
USE SET:C118("events_result")

ORDER BY:C49([Events:103]; [Events:103]EVE_Rappel:12; >)

While (Not:C34(End selection:C36([Events:103])))
	$remaining_days:=[Events:103]EVE_Date_Du:5-Current date:C33(*)
	
	$time_now:=Current time:C178
	$time_now_seconds:=$time_now*1
	
	$eve_heure_du_seconds:=[Events:103]EVE_Heure_Du:7*1
	$remaining_seconds:=($remaining_days*$SECONDS_PER_DAY)+($eve_heure_du_seconds)-$time_now_seconds
	
	Case of 
		: (([Events:103]EVE_Rappel:12="@min") | ([Events:103]EVE_Rappel:12="@minute@"))
			
			If ($time_now_seconds<$eve_heure_du_seconds)
				$EVE_Rappel:=Replace string:C233([Events:103]EVE_Rappel:12; "min"; "")
				$EVE_Rappel:=Replace string:C233($EVE_Rappel; "minute"; "")
				$EVE_Rappel:=Replace string:C233($EVE_Rappel; "s"; "")
				$rappel_minutes:=Num:C11(Replace string:C233($EVE_Rappel; " "; ""))
				
				$rappel_seconds:=$rappel_minutes*$SECONDS_PER_MINUTE
				
				If ($instant_rappel)
					
					If ($rappel_seconds>=120)
						$delai_attente:=$rappel_seconds-120
					End if 
					
					If ($rappel_seconds>=$remaining_seconds) & ($remaining_seconds>$delai_attente)
						APPEND TO ARRAY:C911($tb_events_id; [Events:103]ID:1)
						APPEND TO ARRAY:C911($tb_remining_time; $remaining_seconds)
					End if 
					
				Else 
					
					If ($rappel_seconds>=$remaining_seconds) & ($remaining_seconds>0)
						APPEND TO ARRAY:C911($tb_events_id; [Events:103]ID:1)
						APPEND TO ARRAY:C911($tb_remining_time; $remaining_seconds)
					End if 
					
				End if 
				
			End if 
			
		: (([Events:103]EVE_Rappel:12="@h") | ([Events:103]EVE_Rappel:12="@heure@"))
			
			If ($time_now_seconds<$eve_heure_du_seconds)
				$EVE_Rappel:=Replace string:C233([Events:103]EVE_Rappel:12; "h"; "")
				$EVE_Rappel:=Replace string:C233($EVE_Rappel; "heure"; "")
				$EVE_Rappel:=Replace string:C233($EVE_Rappel; "s"; "")
				$rappel_heures:=Num:C11(Replace string:C233($EVE_Rappel; " "; ""))
				
				$rappel_seconds:=$rappel_heures*$SECONDS_PER_HOUR
				
				If ($instant_rappel)
					
					If ($rappel_seconds>=120)
						$delai_attente:=$rappel_seconds-120
					End if 
					
					If ($rappel_seconds>=$remaining_seconds) & ($remaining_seconds>$delai_attente)
						APPEND TO ARRAY:C911($tb_events_id; [Events:103]ID:1)
						APPEND TO ARRAY:C911($tb_remining_time; $remaining_seconds)
					End if 
					
				Else 
					
					If ($rappel_seconds>=$remaining_seconds) & ($remaining_seconds>0)
						APPEND TO ARRAY:C911($tb_events_id; [Events:103]ID:1)
						APPEND TO ARRAY:C911($tb_remining_time; $remaining_seconds)
					End if 
					
				End if 
				
			End if 
			
		: (([Events:103]EVE_Rappel:12="@j") | ([Events:103]EVE_Rappel:12="@jour@"))
			$EVE_Rappel:=Replace string:C233([Events:103]EVE_Rappel:12; "j"; "")
			$EVE_Rappel:=Replace string:C233($EVE_Rappel; "jour"; "")
			$EVE_Rappel:=Replace string:C233($EVE_Rappel; "s"; "")
			$rappel_jours:=Num:C11(Replace string:C233($EVE_Rappel; " "; ""))
			
			$rappel_seconds:=$rappel_jours*$SECONDS_PER_DAY
			
			If ($instant_rappel)
				
				If ($rappel_seconds>=120)
					$delai_attente:=$rappel_seconds-120
				End if 
				
				If ($rappel_seconds>=$remaining_seconds) & ($remaining_seconds>$delai_attente)
					APPEND TO ARRAY:C911($tb_events_id; [Events:103]ID:1)
					APPEND TO ARRAY:C911($tb_remining_time; $remaining_seconds)
				End if 
				
			Else 
				
				If ($rappel_seconds>=$remaining_seconds) & ($remaining_seconds>0)
					APPEND TO ARRAY:C911($tb_events_id; [Events:103]ID:1)
					APPEND TO ARRAY:C911($tb_remining_time; $remaining_seconds)
				End if 
				
			End if 
			
	End case 
	
	CLEAR VARIABLE:C89($delai_attente)
	NEXT RECORD:C51([Events:103])
End while 


SORT ARRAY:C229($tb_remining_time; $tb_events_id; >)

$JSON:="["

For ($i; 1; Size of array:C274($tb_events_id))
	QUERY:C277([Events:103]; [Events:103]ID:1=$tb_events_id{$i})
	MultiSoc_Filter(->[Events:103])
	
	$o_data_record:=Web_UTL_Record_To_JSON(->[Events:103])
	
	// Modifié par : Scanu Rémy (14/09/2022)
	$json_record:=JSON Stringify:C1217($o_data_record)
	
	$event_start:=String:C10([Events:103]EVE_Date_Du:5; ISO date:K1:8)
	
	$json_custom:=",\"eve_date_du_iso\":"+"\""+$event_start+"\""
	$json_custom:=$json_custom+",\"eve_temps_restant\":"+"\""+UTL_Get_Remaining_Time($tb_remining_time{$i})+"\""
	$json_custom:=$json_custom+"}"
	
	$json_record:=Replace string:C233($json_record; "}"; $json_custom)
	$JSON:=$JSON+$json_record
	
	If ($i<Size of array:C274($tb_events_id))
		$JSON:=$JSON+","
	End if 
	
End for 

$JSON:=$JSON+"]"

CLEAR SET:C117("my_events")
CLEAR SET:C117("events_participe")
CLEAR SET:C117("events_result")

WEB SEND TEXT:C677($JSON)