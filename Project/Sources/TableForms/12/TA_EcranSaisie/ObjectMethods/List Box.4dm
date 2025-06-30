If (Form:C1466.elementCourant#Null:C1517)
	
	If ([TAbles:12]MyASquadInfo:11=Null:C1517)
		[TAbles:12]MyASquadInfo:11:=New object:C1471
	End if 
	
	[TAbles:12]MyASquadInfo:11.id:=Form:C1466.elementCourant.id
	[TAbles:12]MyASquadInfo:11.enumeration:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "Popup Liste déroulante")->currentValue
End if 