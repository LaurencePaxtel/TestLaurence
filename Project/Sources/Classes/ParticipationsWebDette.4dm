Class extends DataClass

Function searchAndCreateRecordIfDontExist($hebergeID_el : Integer; $date_d : Date; $commentaire_t : Text; $dette_c : Collection; $nbPersonneMenage_el : Integer; $refStructure_t : Text)->$participationWebDette_e : cs:C1710.ParticipationsWebDetteEntity
	var $statut_o : Object
	
	var $participationWebDette_es : cs:C1710.ParticipationsWebDetteSelection
	
	$participationWebDette_es:=ds:C1482.ParticipationsWebDette.query("hebergeID = :1"; $hebergeID_el)
	
	Case of 
		: ($participationWebDette_es.length>1)  // Pas normal de se retrouver dans ce cas
			TRACE:C157
		: ($participationWebDette_es.length=1)
			$participationWebDette_e:=$participationWebDette_es[0]
		Else   // Création de la fiche [ParticipationsWebDette]
			$participationWebDette_e:=ds:C1482.ParticipationsWebDette.new()
			$participationWebDette_e.hebergeID:=$hebergeID_el
			$participationWebDette_e.date:=$date_d
			$participationWebDette_e.dette:=New object:C1471("detail"; $dette_c)
			$participationWebDette_e.nbPersonneMenage:=$nbPersonneMenage_el
			
			If ($participationWebDette_e.nbPersonneMenage=0)
				$participationWebDette_e.nbPersonneMenage:=1
			End if 
			
			$participationWebDette_e.Ref_Structure:=$refStructure_t
			$statut_o:=$participationWebDette_e.save()
	End case 
	