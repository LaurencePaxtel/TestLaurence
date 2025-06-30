//Script b_115
CONFIRM:C162("Confirmez vous la suppression des images dans raison sociale ?")
If (OK=1)
	
	_O_DELETE RESOURCE:C501("PICT"; 30001)
	_O_DELETE RESOURCE:C501("PICT"; 30002)
	_O_DELETE RESOURCE:C501("PICT"; 30003)
	_O_DELETE RESOURCE:C501("PICT"; 30004)
	
	_O_DELETE RESOURCE:C501("PICT"; 30011)
	_O_DELETE RESOURCE:C501("PICT"; 30012)
	_O_DELETE RESOURCE:C501("PICT"; 30013)
	_O_DELETE RESOURCE:C501("PICT"; 30014)
	_O_DELETE RESOURCE:C501("PICT"; 30015)
	
	
	<>vi_FondDépart:=<>vi_FondVide
	<>vi_FondSigne:=<>vi_FondVide
	<>vi_FondLogoPetit:=<>vi_FondVide
	<>vi_FondLogoLarge:=<>vi_FondVide
	
	
End if 
