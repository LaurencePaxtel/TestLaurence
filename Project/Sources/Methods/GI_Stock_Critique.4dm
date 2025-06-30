//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 12/06/2020, 15:37:36
// ----------------------------------------------------
// Method: GI_Stock_Critique
// Description
// Le stock d'alerte : envoie des emails d'alerte 
// envoie automatique des emails d'alerte du stock 
// quand le seuil minimum est atteint
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($1)
C_TEXT:C284($2)

C_LONGINT:C283($i)
C_TEXT:C284($HTML_CONTENT; $subject; $msg_text_1; $msg_text_2; $msg_text_3; $msg_text_4; $message; $error)

ARRAY TEXT:C222($pieces_jointes; 0)
ARRAY TEXT:C222($tb_destinataire; 0)

ARRAY LONGINT:C221($tb_id; 0)

ARRAY REAL:C219($tb_seuil_min; 0)
ARRAY REAL:C219($tb_qte_dispo; 0)

MultiSoc_Init_On_Server(Count parameters:C259; $2)

While (True:C214)
	READ ONLY:C145([Equipement:107])
	READ ONLY:C145([Stock:113])
	
	ALL RECORDS:C47([Equipement:107])
	MultiSoc_Filter(->[Equipement:107])
	
	While (Not:C34(End selection:C36([Equipement:107])))
		QUERY:C277([Stock:113]; [Stock:113]STK_EQU_ID:3=[Equipement:107]ID:1)
		MultiSoc_Filter(->[Stock:113])
		
		If (Records in selection:C76([Stock:113])=1)
			
			If ([Stock:113]STK_Stock_Disponible:5<[Equipement:107]EQU_Stock_Min:13)
				APPEND TO ARRAY:C911($tb_id; [Equipement:107]ID:1)
				APPEND TO ARRAY:C911($tb_seuil_min; [Equipement:107]EQU_Stock_Min:13)
				APPEND TO ARRAY:C911($tb_qte_dispo; [Stock:113]STK_Stock_Disponible:5)
			End if 
			
		End if 
		
		NEXT RECORD:C51([Equipement:107])
	End while 
	
	If (Size of array:C274($tb_id)>0)
		SOC_Get_Config
		
		$subject:="Le stock critique du "+String:C10(Current date:C33)
		APPEND TO ARRAY:C911($tb_destinataire; SO_Email)
		
		$msg_text_1:="Bonjour,"
		$msg_text_2:=" Vous trouverez ci-dessous le stock d'alerte à la date d'aujourd'hui : "
		
		$HTML_CONTENT:="<div style=\"width:100%;\">"
		
		$HTML_CONTENT:=$HTML_CONTENT+"<table class=\"mail\" style=\"margin:0px 20px 0px 20px;width:calc(100% - 40px);\">"
		
		$HTML_CONTENT:=$HTML_CONTENT+"<thead>"
		$HTML_CONTENT:=$HTML_CONTENT+"<tr>"
		$HTML_CONTENT:=$HTML_CONTENT+"<th style=\"padding: 4px 12px 4px 5px;text-align:left;color:#fff;background-color:#218bd6;\" class=\"entete_lignes\"  >"
		$HTML_CONTENT:=$HTML_CONTENT+"Équipement"
		$HTML_CONTENT:=$HTML_CONTENT+"</th>"
		$HTML_CONTENT:=$HTML_CONTENT+"<th style=\"padding: 4px 12px 4px 5px;text-align:left;color:#fff;background-color:#218bd6;\" class=\"entete_lignes\">"
		$HTML_CONTENT:=$HTML_CONTENT+"Type"
		$HTML_CONTENT:=$HTML_CONTENT+"</th>"
		$HTML_CONTENT:=$HTML_CONTENT+"<th style=\"padding: 4px 12px 4px 5px;color:#fff;background-color:#218bd6;\" class=\"entete_lignes\">"
		$HTML_CONTENT:=$HTML_CONTENT+"Référence fabricant"
		$HTML_CONTENT:=$HTML_CONTENT+"</th>"
		$HTML_CONTENT:=$HTML_CONTENT+"<th style=\"padding: 4px 12px 4px 5px;color:#fff;background-color:#218bd6;\" class=\"entete_lignes\">"
		$HTML_CONTENT:=$HTML_CONTENT+"Référence structure"
		$HTML_CONTENT:=$HTML_CONTENT+"</th>"
		$HTML_CONTENT:=$HTML_CONTENT+"<th style=\"padding: 4px 12px 4px 5px;color:#fff;background-color:#218bd6;\" class=\"entete_lignes\">"
		$HTML_CONTENT:=$HTML_CONTENT+"Seuil minimum"
		$HTML_CONTENT:=$HTML_CONTENT+"</th>"
		$HTML_CONTENT:=$HTML_CONTENT+"<th style=\"padding: 4px 12px 4px 5px;color:#fff;background-color:#218bd6;\" class=\"entete_lignes\">"
		$HTML_CONTENT:=$HTML_CONTENT+"Stock disponible"
		$HTML_CONTENT:=$HTML_CONTENT+"</th>"
		$HTML_CONTENT:=$HTML_CONTENT+"</tr>"
		$HTML_CONTENT:=$HTML_CONTENT+"</thead>"
		
		$HTML_CONTENT:=$HTML_CONTENT+"<tbody>"
		
		For ($i; 1; Size of array:C274($tb_id))
			QUERY:C277([Equipement:107]; [Equipement:107]ID:1=$tb_id{$i})
			MultiSoc_Filter(->[Equipement:107])
			
			QUERY:C277([Stock:113]; [Stock:113]STK_EQU_ID:3=$tb_id{$i})
			MultiSoc_Filter(->[Stock:113])
			
			$HTML_CONTENT:=$HTML_CONTENT+"<tr  class=\"item-row\">"
			$HTML_CONTENT:=$HTML_CONTENT+"<td style=\"padding: 4px 12px 4px 5px;text-align:left;border:1px solid #e0f3ff;\">"
			$HTML_CONTENT:=$HTML_CONTENT+[Equipement:107]EQU_Nom:4
			$HTML_CONTENT:=$HTML_CONTENT+"</td>"
			$HTML_CONTENT:=$HTML_CONTENT+"<td style=\"padding: 4px 12px 4px 5px;text-align:left;border:1px solid #e0f3ff;\">"
			$HTML_CONTENT:=$HTML_CONTENT+[Equipement:107]EQU_Type:5
			$HTML_CONTENT:=$HTML_CONTENT+"</td>"
			$HTML_CONTENT:=$HTML_CONTENT+"<td style=\"padding: 4px 12px 4px 5px;text-align:left;border:1px solid #e0f3ff;\">"
			$HTML_CONTENT:=$HTML_CONTENT+[Equipement:107]EQU_Reference_Fabricant:6
			$HTML_CONTENT:=$HTML_CONTENT+"</td>"
			$HTML_CONTENT:=$HTML_CONTENT+"<td style=\"padding: 4px 12px 4px 5px;text-align:left;border:1px solid #e0f3ff;\">"
			$HTML_CONTENT:=$HTML_CONTENT+[Equipement:107]EQU_Reference_Structure:7
			$HTML_CONTENT:=$HTML_CONTENT+"</td>"
			$HTML_CONTENT:=$HTML_CONTENT+"<td style=\"padding: 4px 12px 4px 5px;text-align:left;border:1px solid #e0f3ff;\">"
			$HTML_CONTENT:=$HTML_CONTENT+String:C10([Equipement:107]EQU_Stock_Min:13)
			$HTML_CONTENT:=$HTML_CONTENT+"</td>"
			$HTML_CONTENT:=$HTML_CONTENT+"<td style=\"padding: 4px 12px 4px 5px;text-align:left;border:1px solid #e0f3ff;color:red;\">"
			$HTML_CONTENT:=$HTML_CONTENT+String:C10([Stock:113]STK_Stock_Disponible:5)
			$HTML_CONTENT:=$HTML_CONTENT+"</td>"
			$HTML_CONTENT:=$HTML_CONTENT+"</tr>"
		End for 
		
		$HTML_CONTENT:=$HTML_CONTENT+"</tbody>"
		$HTML_CONTENT:=$HTML_CONTENT+"</table>"
		$HTML_CONTENT:=$HTML_CONTENT+"</div>"
		
		$msg_text_3:=$HTML_CONTENT
		$msg_text_4:="Merci !"
		
		$message:=MAIL_HTML_Generate($msg_text_1; $msg_text_2; $msg_text_3; $msg_text_4)
		$error:=MAIL_Send($subject; strc_smtp_server; [SOciete:18]SO_Email:116; ->$tb_destinataire; $message; strc_smtp_username; strc_smtp_password; ->$pieces_jointes)
	End if 
	
	DELAY PROCESS:C323(Current process:C322; UTL_Ticks_Remaining(?08:00:00?))
End while 