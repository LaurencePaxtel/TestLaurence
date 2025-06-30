$vl_FF:=Form event code:C388

Case of 
	: ($vl_FF=Sur entête:K2:17)
		SET WINDOW TITLE:C213("Liste des centres : "+String:C10(Records in selection:C76([LesCentres:9])))
		
		If (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN) | User in group:C338(Current user:C182; <>Groupe_CentreSaisie))
		Else 
			OBJECT SET ENABLED:C1123(b_AdCEL; False:C215)
			OBJECT SET ENABLED:C1123(b_DupCEL; False:C215)
		End if 
		
		OBJECT SET VISIBLE:C603(b_Print; User in group:C338(Current user:C182; <>Groupe_DEVELOP))
		OBJECT SET VISIBLE:C603(*; "Masque_CritCentre"; <>vb_T_CentreCritMasquer)
	: ($vl_FF=Sur affichage corps:K2:22)
		OBJECT SET FONT STYLE:C166([LesCentres:9]LC_Nom:4; Num:C11([LesCentres:9]LC_Excuse:49))
		P_CentreCouleurNiveau(->[LesCentres:9]LC_Nom:4; [LesCentres:9]LC_Niveau:52)
		
		If ([LesCentres:9]LC_Fermé:53)
			[LesCentres:9]LC_Nom:4:="(< "+[LesCentres:9]LC_Nom:4+" >)"
		End if 
		
End case 