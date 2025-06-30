//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 07/04/20, 14:25:00
// ----------------------------------------------------
// Method: Web_PLA_Notification_Send
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($O_Output; $O_Data)
C_BOOLEAN:C305($continu)
C_LONGINT:C283($id_event)
C_TEXT:C284($type_notification; $message_body)

$O_Output:=New object:C1471
$continu:=True:C214
$status:="Success"

$O_Data:=Web_AGL_Get_Post_Json_Data

$O_Data:=OB Get:C1224($O_Data; "pla"; Est un objet:K8:27)

$type_notification:=OB Get:C1224($O_Data; "type_notification"; Est un texte:K8:3)
$id_event:=Num:C11(OB Get:C1224($O_Data; "id_event"; Est un texte:K8:3))
$type_envoi:=OB Get:C1224($O_Data; "type_envoi"; Est un texte:K8:3)

READ ONLY:C145([Events:103])
READ ONLY:C145([INtervenants:10])
READ ONLY:C145([HeBerge:4])

QUERY:C277([Events:103]; [Events:103]ID:1=$id_event)

If (Records in selection:C76([Events:103])=1)
	
	QUERY:C277([INtervenants:10]; [INtervenants:10]ID:16=[Events:103]EVE_User_ID:9)
	MultiSoc_Filter(->[INtervenants:10])
	
	SOC_Get_Config
	
	SMS_Init
	
	$message_body:=Replace string:C233(SMS_PARAM_MESSAGE; "$date_du"; String:C10([Events:103]EVE_Date_Du:5))
	$message_body:=Replace string:C233($message_body; "$date_au"; String:C10([Events:103]EVE_Date_Au:6))
	$message_body:=Replace string:C233($message_body; "$heure_du"; String:C10([Events:103]EVE_Heure_Du:7))
	$message_body:=Replace string:C233($message_body; "$heure_au"; String:C10([Events:103]EVE_Heure_Au:8))
	$message_body:=Replace string:C233($message_body; "$utilisateur_nom"; [INtervenants:10]IN_NomPrénom:8)
	$message_body:=Replace string:C233($message_body; "$structure_adresse3"; txt_strc_adresse)
	$message_body:=Replace string:C233($message_body; "$structure_adresse1"; txt_strc_nom)
	$message_body:=Replace string:C233($message_body; "$structure_adresse2"; txt_strc_nom_suite)
	$message_body:=Replace string:C233($message_body; "$structure_ville"; SO_Ville)
	$message_body:=Replace string:C233($message_body; "$notes"; String:C10([Events:103]EVE_Notes:4))
	
	Case of 
		: ($type_envoi="user")
			
			QUERY:C277([Events_Details:104]; [Events_Details:104]EVD_Event_ID:3=[Events:103]ID:1)
			MultiSoc_Filter(->[Events_Details:104])
			
			ARRAY LONGINT:C221($tb_participants_ids; 0)
			SELECTION TO ARRAY:C260([Events_Details:104]EVD_User_ID:4; $tb_participants_ids)
			
			QUERY WITH ARRAY:C644([INtervenants:10]ID:16; $tb_participants_ids)
			
			//=====================================//
			// SMS
			//=====================================//
			If ($type_notification="sms")
				
				While (Not:C34(End selection:C36([INtervenants:10])))
					
					SMS_Send([INtervenants:10]IN_Telephone:19; $message_body)
					
					NEXT RECORD:C51([INtervenants:10])
				End while 
				
			End if 
			//=====================================//
			// E-mail
			//=====================================//
			
			If ($type_notification="email")
				
				ARRAY TEXT:C222($tb_destinataire; 0)
				SELECTION TO ARRAY:C260([INtervenants:10]IN_Email:20; $tb_destinataire)
				
				$message:=$message_body
				$subject:="Notification"
				
				$error:=MAIL_Send($subject; strc_smtp_server; [SOciete:18]SO_Email:116; ->$tb_destinataire; $message; strc_smtp_username; strc_smtp_password)
				
				If ($error#"")
					$continu:=False:C215
				End if 
				
			End if 
			
		: ($type_envoi="heberge")
			
			
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Events:103]EVE_HB_ID:14)
			
			If (Records in selection:C76([HeBerge:4])=1)
				
				Case of 
					: ($type_notification="sms")
						SMS_Send([HeBerge:4]HB_Telephone:66; $message_body)
						
					: ($type_notification="email")
						
						ARRAY TEXT:C222($tb_destinataire; 0)
						APPEND TO ARRAY:C911($tb_destinataire; [HeBerge:4]HB_Email:68)
						
						$message:=$message_body
						$subject:="Notification"
						
						$error:=MAIL_Send($subject; strc_smtp_server; [SOciete:18]SO_Email:116; ->$tb_destinataire; $message; strc_smtp_username; strc_smtp_password)
						
						If ($error#"")
							$continu:=False:C215
						End if 
						
						
				End case 
				
				
			Else 
				$continu:=False:C215
			End if 
			
			
	End case 
	
	
	
	
	
	
Else 
	$continu:=False:C215
End if 

If (Not:C34($continu))
	$status:="Failed"
End if 

OB SET:C1220($O_Output; "status"; $status)
$T_Json:=JSON Stringify:C1217($O_Output)
WEB SEND TEXT:C677($T_Json)