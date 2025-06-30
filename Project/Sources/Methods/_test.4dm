//%attributes = {}


Début_LoadTables("Code postal"; -><>ta_TBMetro)

$heberge_es:=ds:C1482.HeBerge.all()

For each ($heberge_e; $heberge_es)
	
	If ($heberge_e.situationBudgetaire#Null:C1517)
		//ds.ParticipationsWebBudget.init($heberge_e.ID)
		//ds.ParticipationsWebDette.init($heberge_e.ID)
	End if 
	
End for each 