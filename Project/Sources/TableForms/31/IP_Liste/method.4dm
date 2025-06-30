$vl_eventFF:=Form event code:C388

Case of 
	: ($vl_eventFF=Sur entête:K2:17)
		SET WINDOW TITLE:C213("Liste des profils : "+String:C10(Records in selection:C76([IntervenantsProfils:31])))
	: ($vl_eventFF=Sur chargement:K2:1)
		
		If (User in group:C338(Current user:C182; <>Groupe_DEVELOP)=False:C215) & (User in group:C338(Current user:C182; <>Groupe_ADMIN)=False:C215)
			OBJECT SET VISIBLE:C603(*; "IN_Add@"; False:C215)  // Ajouter
			OBJECT SET VISIBLE:C603(*; "IN_TsSel"; False:C215)  // Tout sel
			OBJECT SET VISIBLE:C603(*; "IN_SsSel"; False:C215)  // Sous sel
		End if 
		
End case 