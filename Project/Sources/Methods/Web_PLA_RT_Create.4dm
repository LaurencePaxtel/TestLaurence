//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26/04/20, 09:44:03
// ----------------------------------------------------
// Method: Web_PLA_RT_Create
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_DATE:C307($1)

C_LONGINT:C283($nombre_jours; $i; $j; $eve_origine_id)
C_BOOLEAN:C305($do_duplicate)
C_DATE:C307($current_date; $calc_date_au)

ARRAY LONGINT:C221($tb_eve_id; 0)

$current_date:=$1

READ ONLY:C145([Events:103])
QUERY:C277([Events:103]; [Events:103]EVE_Recurrence:13#"")

SELECTION TO ARRAY:C260([Events:103]ID:1; $tb_eve_id)

For ($i; 1; Size of array:C274($tb_eve_id))
	QUERY:C277([Events:103]; [Events:103]ID:1=$tb_eve_id{$i})
	
	Case of 
		: ([Events:103]EVE_Recurrence:13="Quotidienne")
			$eve_origine_id:=[Events:103]ID:1
			
			QUERY:C277([Events:103]; [Events:103]EVE_ID_Origine:17=$eve_origine_id; *)
			QUERY:C277([Events:103];  & ; [Events:103]EVE_Date_Du:5=$current_date; *)
			QUERY:C277([Events:103];  & ; [Events:103]EVE_Date_Au:6=$current_date)
			
			If (Records in selection:C76([Events:103])=0)
				QUERY:C277([Events:103]; [Events:103]ID:1=$tb_eve_id{$i})
				DUPLICATE RECORD:C225([Events:103])
				
				[Events:103]EVE_Date_Du:5:=$current_date
				[Events:103]EVE_Date_Au:6:=$current_date
				[Events:103]EVE_Recurrence:13:=""
				[Events:103]EVE_ID_Origine:17:=$eve_origine_id
				SAVE RECORD:C53([Events:103])
				
				$do_duplicate:=True:C214
			End if 
			
		: ([Events:103]EVE_Recurrence:13="Hebdomadaire")
			
			If (Day number:C114($current_date)=Day number:C114([Events:103]EVE_Date_Du:5))
				$eve_origine_id:=[Events:103]ID:1
				$nombre_jours:=[Events:103]EVE_Date_Au:6-[Events:103]EVE_Date_Du:5
				$calc_date_au:=Add to date:C393($current_date; 0; 0; $nombre_jours)
				
				QUERY:C277([Events:103]; [Events:103]EVE_ID_Origine:17=$eve_origine_id; *)
				QUERY:C277([Events:103];  & ; [Events:103]EVE_Date_Du:5=$current_date; *)
				QUERY:C277([Events:103];  & ; [Events:103]EVE_Date_Au:6=$calc_date_au)
				
				If (Records in selection:C76([Events:103])=0)
					QUERY:C277([Events:103]; [Events:103]ID:1=$tb_eve_id{$i})
					DUPLICATE RECORD:C225([Events:103])
					
					[Events:103]EVE_Date_Du:5:=$current_date
					[Events:103]EVE_Date_Au:6:=$calc_date_au
					[Events:103]EVE_Recurrence:13:=""
					[Events:103]EVE_ID_Origine:17:=$eve_origine_id
					SAVE RECORD:C53([Events:103])
					
					$do_duplicate:=True:C214
				End if 
				
			End if 
			
		: ([Events:103]EVE_Recurrence:13="Mensuel")
			
			If (Month of:C24($current_date)#Month of:C24([Events:103]EVE_Date_Du:5))
				
				If (Day of:C23($current_date)=Day of:C23([Events:103]EVE_Date_Du:5))
					$eve_origine_id:=[Events:103]ID:1
					$nombre_jours:=[Events:103]EVE_Date_Au:6-[Events:103]EVE_Date_Du:5
					$calc_date_au:=Add to date:C393($current_date; 0; 0; $nombre_jours)
					
					QUERY:C277([Events:103]; [Events:103]EVE_ID_Origine:17=$eve_origine_id; *)
					QUERY:C277([Events:103];  & ; [Events:103]EVE_Date_Du:5=$current_date; *)
					QUERY:C277([Events:103];  & ; [Events:103]EVE_Date_Au:6=$calc_date_au)
					
					If (Records in selection:C76([Events:103])=0)
						QUERY:C277([Events:103]; [Events:103]ID:1=$tb_eve_id{$i})
						
						DUPLICATE RECORD:C225([Events:103])
						[Events:103]EVE_Date_Du:5:=$current_date
						[Events:103]EVE_Date_Au:6:=$calc_date_au
						[Events:103]EVE_Recurrence:13:=""
						[Events:103]EVE_ID_Origine:17:=$eve_origine_id
						SAVE RECORD:C53([Events:103])
						
						$do_duplicate:=True:C214
					End if 
					
				End if 
				
			End if 
			
		: ([Events:103]EVE_Recurrence:13="Annuel")
			
			If (Year of:C25($current_date)#Year of:C25([Events:103]EVE_Date_Du:5))
				
				If (Month of:C24($current_date)=Month of:C24([Events:103]EVE_Date_Du:5))
					
					If (Day of:C23($current_date)=Day of:C23([Events:103]EVE_Date_Du:5))
						$eve_origine_id:=[Events:103]ID:1
						$nombre_jours:=[Events:103]EVE_Date_Au:6-[Events:103]EVE_Date_Du:5
						$calc_date_au:=Add to date:C393($current_date; 0; 0; $nombre_jours)
						
						QUERY:C277([Events:103]; [Events:103]EVE_ID_Origine:17=$eve_origine_id; *)
						QUERY:C277([Events:103];  & ; [Events:103]EVE_Date_Du:5=$current_date; *)
						QUERY:C277([Events:103];  & ; [Events:103]EVE_Date_Au:6=$calc_date_au)
						
						If (Records in selection:C76([Events:103])=0)
							QUERY:C277([Events:103]; [Events:103]ID:1=$tb_eve_id{$i})
							
							DUPLICATE RECORD:C225([Events:103])
							[Events:103]EVE_Date_Du:5:=$current_date
							[Events:103]EVE_Date_Au:6:=$calc_date_au
							[Events:103]EVE_Recurrence:13:=""
							[Events:103]EVE_ID_Origine:17:=$eve_origine_id
							SAVE RECORD:C53([Events:103])
							
							$do_duplicate:=True:C214
						End if 
						
					End if 
					
				End if 
				
			End if 
			
	End case 
	
	If ($do_duplicate)
		QUERY:C277([Events_Details:104]; [Events_Details:104]EVD_Event_ID:3=$tb_eve_id{$i})
		
		ARRAY LONGINT:C221($tb_eve_detail_id; 0)
		SELECTION TO ARRAY:C260([Events_Details:104]ID:1; $tb_eve_detail_id)
		
		For ($j; 1; Size of array:C274($tb_eve_detail_id))
			QUERY:C277([Events_Details:104]; [Events_Details:104]ID:1=$tb_eve_detail_id{$j})
			DUPLICATE RECORD:C225([Events_Details:104])
			
			[Events_Details:104]EVD_Event_ID:3:=[Events:103]ID:1
			SAVE RECORD:C53([Events_Details:104])
		End for 
		
	End if 
	
	CLEAR VARIABLE:C89($do_duplicate)
	UNLOAD RECORD:C212([Events:103])
End for 