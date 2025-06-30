C_OBJECT:C1216($enregistrement_o; $element_o)

If (Value type:C1509(Form:C1466.impression)#Est une collection:K8:32)
	$enregistrement_o:=Form:C1466.entitySelection.query("valeur = :1"; Form:C1466.impression).first()
	
	For each ($element_o; Form:C1466.paramImpression)
		$enregistrement_o.extraParam.detail[Form:C1466.paramImpression.indexOf($element_o)]:=$element_o
	End for each 
	
	$enregistrement_o.save()
End if 

ACCEPT:C269