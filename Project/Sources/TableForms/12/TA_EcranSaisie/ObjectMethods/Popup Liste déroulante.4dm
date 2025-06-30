var $enumeration_t : Text
var $enumeration_o : Object

var $myASquad_cs : cs:C1710.MyASquad

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		OBJECT Get pointer:C1124->:=New object:C1471
		OBJECT Get pointer:C1124->values:=New collection:C1472("administrative-positions"; "professional-situations"; "family-statuses"; "remuneration-types")
		OBJECT Get pointer:C1124->index:=-1
	: (Form event code:C388=Sur données modifiées:K2:15)
		$myASquad_cs:=cs:C1710.MyASquad.new()
		
		$enumeration_t:=$myASquad_cs.getEnumeration(OBJECT Get pointer:C1124->currentValue)
		$enumeration_o:=JSON Parse:C1218($enumeration_t)
		
		Form:C1466.MyASquadEnumeration:=$enumeration_o.data
End case 