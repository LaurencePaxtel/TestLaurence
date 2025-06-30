//{        modifié  Lundi 02 février 2004 à 14:27:00
C_LONGINT:C283($EventFF)
C_BOOLEAN:C305($B_Planning)

$EventFF:=Form event code:C388

Case of 
	: ($EventFF=Sur chargement:K2:1)
		
		If (<>vb_UserLOFT)
			OBJECT SET ENABLED:C1123(b_AppA; False:C215)
			OBJECT SET ENABLED:C1123(b_AppD; False:C215)
			OBJECT SET VISIBLE:C603(*; "vStd_@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "vLoft@"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "vStd_@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "vLoft@"; False:C215)
		End if 
		
		OBJECT SET VISIBLE:C603(*; "Trans_@"; False:C215)
		
		OBJECT SET VISIBLE:C603(*; "vCarto"; False:C215)
		OBJECT SET VISIBLE:C603(*; "vRapport_A"; False:C215)
		
		OBJECT SET VISIBLE:C603(*; "v_Trans"; False:C215)
		OBJECT SET VISIBLE:C603(b_Trans; False:C215)
		
		// #20170605-3
		$B_Planning:=(User in group:C338(Current user:C182; <>Group_Planning_1_C))
		$B_Planning:=$B_Planning | (User in group:C338(Current user:C182; <>Planning_1_Modif_C))
		$B_Planning:=$B_Planning | (User in group:C338(Current user:C182; <>Planning_1_Elargi_C))
		
		OBJECT SET VISIBLE:C603(*; "button_calendrier"; $B_Planning)
	: ($EventFF=Sur appel extérieur:K2:11)
		CANCEL:C270
End case 