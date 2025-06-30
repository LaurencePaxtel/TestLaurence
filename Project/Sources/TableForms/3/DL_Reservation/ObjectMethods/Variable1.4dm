// Je ré-initialise tout
Form:C1466.dateAu:=Replace string:C233(String:C10(Form:C1466.dateAu); "/"; "")

// J'ajoute le formatage type Date
Form:C1466.dateAu:=Substring:C12(Form:C1466.dateAu; 0; 2)+"/"+Substring:C12(Form:C1466.dateAu; 3; 2)+"/"+Substring:C12(Form:C1466.dateAu; 5)

If (Form:C1466.dateAu="__/__/____")
	OB REMOVE:C1226(Form:C1466; "dateAu")
End if 