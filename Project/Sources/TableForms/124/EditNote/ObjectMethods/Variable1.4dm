// Je ré-initialise tout
Form:C1466.heure:=Replace string:C233(String:C10(Form:C1466.heure); ":"; "")

// J'ajoute le formatage type Date
Form:C1466.heure:=Substring:C12(Form:C1466.heure; 0; 2)+":"+Substring:C12(Form:C1466.heure; 3; 2)+":"+Substring:C12(Form:C1466.heure; 5)

If (Form:C1466.heure="__:__:__")
	OB REMOVE:C1226(Form:C1466; "heure")
End if 