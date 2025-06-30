C_LONGINT:C283($vl_EventFF)

$vl_EventFF:=Form event code:C388

Case of 
	: ($vl_EventFF=Sur entête:K2:17)
		SET WINDOW TITLE:C213("Liste des tables : "+String:C10(Records in selection:C76([TypesTables:11])))
	: ($vl_EventFF=Sur affichage corps:K2:22)
		va_LibNivea:=String:C10([TypesTables:11]TT_NbNiveaux:2)+" niveau"+("x"*Num:C11([TypesTables:11]TT_NbNiveaux:2>1))
End case 