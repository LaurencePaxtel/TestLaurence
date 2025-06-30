// Je ré-initialise tout
Form:C1466.quantiteDateAu:=Replace string:C233(Form:C1466.quantiteDateAu; "/"; "")

// J'ajoute le formatage type Date
Form:C1466.quantiteDateAu:=Substring:C12(Form:C1466.quantiteDateAu; 0; 2)+"/"+Substring:C12(Form:C1466.quantiteDateAu; 3; 2)+"/"+Substring:C12(Form:C1466.quantiteDateAu; 5)

If (Form:C1466.quantiteDateAu="__/__/____")
	OB REMOVE:C1226(Form:C1466; "quantiteDateAu")
End if 