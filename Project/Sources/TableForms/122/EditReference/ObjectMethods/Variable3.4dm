// Je ré-initialise tout
Form:C1466.quantiteMaxDateAu:=Replace string:C233(Form:C1466.quantiteMaxDateAu; "/"; "")

// J'ajoute le formatage type Date
Form:C1466.quantiteMaxDateAu:=Substring:C12(Form:C1466.quantiteMaxDateAu; 0; 2)+"/"+Substring:C12(Form:C1466.quantiteMaxDateAu; 3; 2)+"/"+Substring:C12(Form:C1466.quantiteMaxDateAu; 5)

If (Form:C1466.quantiteMaxDateAu="__/__/____")
	OB REMOVE:C1226(Form:C1466; "quantiteMaxDateAu")
End if 