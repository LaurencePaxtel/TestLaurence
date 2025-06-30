// Je ré-initialise tout
Form:C1466.quantiteMaxDateDu:=Replace string:C233(Form:C1466.quantiteMaxDateDu; "/"; "")

// J'ajoute le formatage type Date
Form:C1466.quantiteMaxDateDu:=Substring:C12(Form:C1466.quantiteMaxDateDu; 0; 2)+"/"+Substring:C12(Form:C1466.quantiteMaxDateDu; 3; 2)+"/"+Substring:C12(Form:C1466.quantiteMaxDateDu; 5)

If (Form:C1466.quantiteMaxDateDu="__/__/____")
	OB REMOVE:C1226(Form:C1466; "quantiteMaxDateDu")
End if 