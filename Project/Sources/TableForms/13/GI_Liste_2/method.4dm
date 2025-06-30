$vl_eventFF:=Form event code:C388

Case of 
	: ($vl_eventFF=Sur chargement:K2:1)
		va_VilleLib:=""
		
		vb_Ville:=True:C214
		va_Ville:=("Ville"*Num:C11(vb_Ville=True:C214))+("Metro"*Num:C11(vb_Ville=False:C215))
	: ($vl_eventFF=Sur entête:K2:17)
		SET WINDOW TITLE:C213(<>Va_Rubrique+" : "+<>Va_Thème+" : "+String:C10(Records in selection:C76([GIP:13])))
		
		If (vb_GIPsél)
			OBJECT SET VISIBLE:C603(*; "GIP_Add@"; False:C215)
		Else 
			
			If (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN) | User in group:C338(Current user:C182; <>Groupe_Coordinateur) | User in group:C338(Current user:C182; <>Groupe_Régulateur))
			Else 
				OBJECT SET VISIBLE:C603(*; "GIP_Add@"; False:C215)
			End if 
			
			OBJECT SET VISIBLE:C603(*; "GIP_Sel@"; False:C215)
		End if 
		
		OBJECT SET VISIBLE:C603(*; "GIP_Add@"; True:C214)
	: ($vl_eventFF=Sur affichage corps:K2:22)
		
		If (vb_Ville)
			va_VilleLib:=[GIP:13]GI_Ville:11
		Else 
			va_VilleLib:=[GIP:13]GI_Metro:13
		End if 
		
	: ($vl_EventFF=Sur menu sélectionné:K2:14)
		// Modifié par : Scanu Rémy - remy@connect-io.fr (22/06/2021)
		// Ajout d'un menu pour accéder à la barre d'appel sans que l'utilisateur ait besoin de redémarrer le programme
		i_MenuChoisi
End case 