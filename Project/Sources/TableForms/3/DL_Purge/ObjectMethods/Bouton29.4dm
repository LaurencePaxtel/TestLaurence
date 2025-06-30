//Script 
C_DATE:C307($vd_Date)
CONFIRM:C162("Mise à jour de la date de validité des mots de passe des utilisateurs à la date ")
If (OK=1)
	$vd_Date:=Current date:C33(*)
	i_Message("Mise à jour de la date de validité des mots de passe : modification en cours")
	READ WRITE:C146([INtervenants:10])
	ALL RECORDS:C47([INtervenants:10])
	APPLY TO SELECTION:C70([INtervenants:10]; [INtervenants:10]IN_DateDeModifDuMP:15:=$vd_Date)
	READ ONLY:C145([INtervenants:10])
	CLOSE WINDOW:C154
End if 