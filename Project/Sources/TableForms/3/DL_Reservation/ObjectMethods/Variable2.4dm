// Je ré-initialise tout
Form:C1466.dateDu:=Replace string:C233(String:C10(Form:C1466.dateDu); "/"; "")

// J'ajoute le formatage type Date
Form:C1466.dateDu:=Substring:C12(Form:C1466.dateDu; 0; 2)+"/"+Substring:C12(Form:C1466.dateDu; 3; 2)+"/"+Substring:C12(Form:C1466.dateDu; 5)

If (Form:C1466.dateDu="__/__/____")
	OB REMOVE:C1226(Form:C1466; "dateDu")
End if 