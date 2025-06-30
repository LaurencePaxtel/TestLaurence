If (Form event code:C388=Sur données modifiées:K2:15)
	Form:C1466.t_TabNiv1:=Form:C1466.t_TabNiv1Init.query("choix = :1"; "@"+Form:C1466.filtre+"@")
End if 