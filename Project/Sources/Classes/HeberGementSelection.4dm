Class extends EntitySelection

Function getSituationUnique()->$hebergement_es : cs:C1710.HeberGementSelection
	var $heberge_c : Collection
	
	var $hebergement_e : cs:C1710.HeberGementEntity
	var $hebergementB_es : cs:C1710.HeberGementSelection
	
	// On tri par hébergé et par date
	$hebergementB_es:=This:C1470.orderBy("HG_HB_ID asc, HG_Date desc")
	
	$heberge_c:=New collection:C1472
	$hebergement_es:=ds:C1482.HeberGement.newSelection()
	
	// On ne prend que les dernières fiches de chaque hébergé
	For each ($hebergement_e; $hebergementB_es)
		
		If ($heberge_c.indexOf($hebergement_e.HG_HB_ID)<0)
			$hebergement_es.add($hebergement_e)
			$heberge_c.push($hebergement_e.HG_HB_ID)
		End if 
		
	End for each 