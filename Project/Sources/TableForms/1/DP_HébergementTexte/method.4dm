$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		If (va_Appel="TH")
			OBJECT SET VISIBLE:C603(*; "Réserve_@"; True:C214)  //réservation
		Else 
			OBJECT SET VISIBLE:C603(*; "Réserve_@"; False:C215)  //réservation      
		End if 
		vPos1:=0
		vPos2:=0
		vPos2:=Length:C16([DePart:1]DP_Texte:7)+1
		HIGHLIGHT TEXT:C210([DePart:1]DP_Texte:7; vPos2; vPos2)
	: ($vl_EventFF=Sur appel extérieur:K2:11)
		ACCEPT:C269
End case 

