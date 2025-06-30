// Je ré-initialise tout
Form:C1466.date:=Replace string:C233(String:C10(Form:C1466.date); "/"; "")

// J'ajoute le formatage type Date
Form:C1466.date:=Substring:C12(Form:C1466.date; 0; 2)+"/"+Substring:C12(Form:C1466.date; 3; 2)+"/"+Substring:C12(Form:C1466.date; 5)

If (Form:C1466.date="__/__/____")
	OB REMOVE:C1226(Form:C1466; "date")
End if 