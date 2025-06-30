C_LONGINT:C283($vl_EventFF)
C_BOOLEAN:C305($B_Dummy)

$vl_EventFF:=Form event code:C388

Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		$B_Dummy:=F_User_Changer(-1; [INtervenants:10]IN_RéfUser:11)
		
		P_UserFFsaisie(Sur chargement:K2:1)
		OBJECT SET ENTERABLE:C238([INtervenants:10]IN_DateDeModifDuMP:15; User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	: ($vl_EventFF=Sur données modifiées:K2:15)
		P_UserFFsaisie(Sur données modifiées:K2:15)
End case 
