If (OBJECT Get pointer:C1124(Objet courant:K67:2)->=False:C215) & (OBJECT Get pointer:C1124(Objet nommé:K67:5; "hebergement")->=False:C215)
	ALERT:C41("Au moins une des deux cases « Hébergement » ou « Prestation » doit être coché")
	OBJECT Get pointer:C1124(Objet courant:K67:2)->:=True:C214
End if 