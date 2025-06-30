Class extends DataClass


Function info($RefStructure_t : Text)->$info_c : Collection
	var $trancheAge_e : cs:C1710.TrancheAgeEntity
	var $tranche_o : Object
	var $ageMin_i : Integer
	var $i : Integer
	
	$trancheAge_e:=ds:C1482.TrancheAge.query("Ref_Structure = :1"; $RefStructure_t).first()
	$info_c:=New collection:C1472()
	$tranche_o:=New object:C1471()
	$ageMin_i:=-1
	
	For ($i; 1; $trancheAge_e.TA_Tranche_0Nombre)
		$tranche_o.lib:=$trancheAge_e["TA_Tranche_"+String:C10($i)]
		$tranche_o.ageMin:=$ageMin_i
		
		Case of 
			: ($trancheAge_e.TA_Tranche_0Nombre=1)
				$tranche_o.ageMax:=$trancheAge_e["TA_TrancheAge_"+String:C10($i)]+1
			: ($trancheAge_e.TA_Tranche_0Nombre=$i)
				$tranche_o.ageMax:=200
			Else 
				$tranche_o.ageMax:=$trancheAge_e["TA_TrancheAge_"+String:C10($i)]
		End case 
		$ageMin_i:=$tranche_o.ageMax-1
		
		$info_c.push(OB Copy:C1225($tranche_o))
	End for 