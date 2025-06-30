C_LONGINT:C283($vl_eventFF)
$vl_eventFF:=Form event code:C388
Case of 
	: ($vl_eventFF=Sur chargement:K2:1)
		
		SET TIMER:C645(-1)
		
	: ($vl_eventFF=Sur minuteur:K2:25)
		
		SET TIMER:C645(0)
		Handle saisie note hebergement("longueur")
		
	: ($vl_eventFF=Sur changement de page:K2:54)
		
		Handle saisie note hebergement("curseur_fin")  // #Fix20170517-3
		
	: ($vl_eventFF=Sur appel extérieur:K2:11)
		CANCEL:C270
End case 


