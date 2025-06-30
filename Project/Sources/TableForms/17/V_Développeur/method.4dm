$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur affichage corps:K2:22)
		QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_Niveau:4=[TablesDemande:17]TD_TB_TT_Niveau:1)
		MultiSoc_Filter(->[TAbles:12])
		If (Records in selection:C76([TAbles:12])=1)
			vt_Champs:=[TAbles:12]TB_Libellé:6
		Else 
			vt_Champs:=""
		End if 
	: ($vl_EventFF=Sur double clic:K2:5)
		FILTER EVENT:C321
End case 