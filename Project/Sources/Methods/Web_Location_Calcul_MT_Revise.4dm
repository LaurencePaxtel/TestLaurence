//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 19-12-18, 07:17:54
// ----------------------------------------------------
// Method: Web_Location_Calcul_MT_Revise
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1)

C_TEXT:C284($JSON)
C_REAL:C285($IRL_ACTUEL; $IRL_PRECEDENT)

READ WRITE:C146([Locations:84])

ALL RECORDS:C47([Locations:84])
MultiSoc_Filter(->[Locations:84])

While (Not:C34(End selection:C36([Locations:84])))
	$IRL_ACTUEL:=UTL_Get_IRL(Year of:C25([Locations:84]LOC_Date:2); UTL_Get_Trimestre([Locations:84]LOC_Date:2))
	$IRL_PRECEDENT:=UTL_Get_IRL(Year of:C25([Locations:84]LOC_Date:2)-1; UTL_Get_Trimestre([Locations:84]LOC_Date:2))
	
	If ($IRL_ACTUEL#0)
		[Locations:84]LOC_Montant_Revise:7:=([Locations:84]LOC_Montant_Initial:6*$IRL_ACTUEL)/$IRL_PRECEDENT
	Else 
		[Locations:84]LOC_Montant_Revise:7:=[Locations:84]LOC_Montant_Initial:6
	End if 
	
	SAVE RECORD:C53([Locations:84])
	NEXT RECORD:C51([Locations:84])
End while 

/*
var $locations_es : cs.LocationsSelection
var $locations_e : cs.LocationsEntity

//$locations_es:=ds.Locations.query("Ref_structure = "; Session.storage.intervenant.Ref_Structure)
$locations_es:=ds.Locations.query("LOC_Date_Sortie < :1"; Date du jour)

Pour chaque ($locations_e; $locations_es)
// 10/04/24 > 07/01/24
Si ($locations_e.LOC_Date>Ajouter à date(Date du jour(); -1; 0; 0))
$locations_e.LOC_Montant_Revise:=$locations_e.LOC_Montant_Initial
$locations_e.save()
continue
Fin de si 

$numTrimestre_i:=UTL_Get_Trimestre($locations_e.LOC_Date)
$coef_r:=1

Boucle ($i; 0; Année de(Date du jour)-Année de($locations_e.LOC_Date))

$IRL_courant:=UTL_Get_IRL(Année de($locations_e.LOC_Date)+$i; $numTrimestre_i)
$IRL_precedent:=UTL_Get_IRL(Année de($locations_e.LOC_Date)+$i-1; $numTrimestre_i)
Si ($IRL_courant#0) & ($IRL_precedent#0)
$coef_r:=$coef_r+($IRL_courant/$IRL_precedent)
Fin de si 
Fin de boucle 

$locations_e.LOC_Montant_Revise:=$locations_e.LOC_Montant_Initial*$coef_r
$locations_e.save()

Fin de chaque 
*/


ARRAY OBJECT:C1221($tb_result; 0)
$JSON:=JSON Stringify array:C1228($tb_result)
WEB SEND TEXT:C677($JSON)