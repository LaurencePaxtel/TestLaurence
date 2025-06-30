// Je ré-initialise tout
Form:C1466.quantiteDateDu:=Replace string:C233(Form:C1466.quantiteDateDu; "/"; "")

// J'ajoute le formatage type Date
Form:C1466.quantiteDateDu:=Substring:C12(Form:C1466.quantiteDateDu; 0; 2)+"/"+Substring:C12(Form:C1466.quantiteDateDu; 3; 2)+"/"+Substring:C12(Form:C1466.quantiteDateDu; 5)

If (Form:C1466.quantiteDateDu="__/__/____")
	OB REMOVE:C1226(Form:C1466; "quantiteDateDu")
End if 