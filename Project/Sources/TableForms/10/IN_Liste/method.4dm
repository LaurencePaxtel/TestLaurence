C_LONGINT:C283($vl_eventFF)

$vl_eventFF:=Form event code:C388

Case of 
	: ($vl_eventFF=Sur chargement:K2:1)
		
		If (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN))
			
			If (User in group:C338(Current user:C182; <>Groupe_DEVELOP)=False:C215)
				OBJECT SET VISIBLE:C603(*; "IN_ListeUser"; False:C215)  // Créer User existant dans la base
			End if 
			
		Else 
			OBJECT SET VISIBLE:C603(*; "IN_Add@"; False:C215)  //Ajouter
			OBJECT SET VISIBLE:C603(*; "IN_TsSel"; False:C215)  //Tout sel
			OBJECT SET VISIBLE:C603(*; "IN_SsSel"; False:C215)  //Sous sel
			OBJECT SET VISIBLE:C603(*; "IN_ListeUser"; False:C215)  //Créer  user existant dans la base
		End if 
		
	: ($vl_eventFF=Sur affichage corps:K2:22)
		
		If ([INtervenants:10]IN_Type:2#0)
			va_Type:=Substring:C12(<>ta_Types{[INtervenants:10]IN_Type:2}; 5)
		End if 
		
	: ($vl_eventFF=Sur entête:K2:17)
		SET WINDOW TITLE:C213("Liste des utilisateurs : "+String:C10(Records in selection:C76([INtervenants:10])))
End case 