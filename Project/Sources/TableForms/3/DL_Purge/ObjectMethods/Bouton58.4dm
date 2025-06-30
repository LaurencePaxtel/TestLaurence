C_BOOLEAN:C305($vb_OK)
C_DATE:C307($vd_Date)
$vb_OK:=(Records in table:C83([INtervenants:10])>0)
If ($vb_OK)
	MESSAGES ON:C181
	$vd_Date:=Current date:C33
	READ WRITE:C146([INtervenants:10])
	ALL RECORDS:C47([INtervenants:10])
	APPLY TO SELECTION:C70([INtervenants:10]; [INtervenants:10]IN_DateDeModifDuMP:15:=$vd_Date)
	UNLOAD RECORD:C212([INtervenants:10])
	READ ONLY:C145([INtervenants:10])
	MESSAGES OFF:C175
	BEEP:C151
Else 
	ALERT:C41("Acune fiche utilisateur dans la base.")
End if 