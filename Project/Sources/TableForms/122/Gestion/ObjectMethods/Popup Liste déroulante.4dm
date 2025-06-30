C_LONGINT:C283($pos_el)

C_COLLECTION:C1488($collection_c)

$collection_c:=New collection:C1472

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		ARRAY TEXT:C222(structure_at; 0)
		
		If (Current user:C182="apaxtel")
			$collection_c:=ds:C1482.Structures.all().toCollection().orderBy("Ref_Structure asc").extract("Ref_Structure")
		Else 
			$collection_c.push(<>ref_soc_active)
		End if 
		
		COLLECTION TO ARRAY:C1562($collection_c; structure_at)
		structure_at{0}:="Choix de la structure"
		
		$pos_el:=Find in array:C230(structure_at; <>ref_soc_active)
		
		If ($pos_el>0)
			structure_at:=$pos_el
		End if 
		
	: (Form event code:C388=Sur données modifiées:K2:15)
		OBJECT SET ENABLED:C1123(*; "Popup Liste déroulante1"; True:C214)
		OBJECT SET ENABLED:C1123(*; "Popup Liste déroulante2"; True:C214)
		
		Form:C1466.reinitialisation:=True:C214
		POST OUTSIDE CALL:C329(Current process:C322)
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 