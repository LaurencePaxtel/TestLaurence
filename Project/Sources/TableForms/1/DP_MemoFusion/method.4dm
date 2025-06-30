$vl_eventFF:=Form event code:C388
Case of 
	: ($vl_eventFF=Sur chargement:K2:1)
		vPos1:=0
		vPos2:=0
		vPos2:=Length:C16([DePart:1]DP_Texte:7)+1
		HIGHLIGHT TEXT:C210([DePart:1]DP_Texte:7; vPos2; vPos2)
	: ($vl_eventFF=Sur appel extérieur:K2:11)
		CANCEL:C270
End case 
