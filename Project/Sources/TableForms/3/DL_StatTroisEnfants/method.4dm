//Formule Format : DL_StatTroisEnfants
C_LONGINT:C283($vl_EventFF)

$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		OBJECT SET VISIBLE:C603(*; "Famille_@"; False:C215)
		OBJECT SET VISIBLE:C603(bEtCv; (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN)))
		
	: ($vl_EventFF=Sur données modifiées:K2:15)
	: ($vl_EventFF=Sur clic:K2:4)
End case 