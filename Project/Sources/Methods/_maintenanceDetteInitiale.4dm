//%attributes = {}

// mise à jour du champ [HeBerge]HB_FAC_Dette_Initiale à partir du champ F A C_Solde_Anterieur de la premiere facture émise.
var $factures_e : cs:C1710.FacturesEntity
var $heberge_e : cs:C1710.HeBergeEntity
var $ds : Object

$FAC_Locataire_ID:=0

$ProgressID:=Progress New  // create a new progress bar
Progress SET TITLE($ProgressID; "Maintenance de la dette initiale")

$ds:=ds:C1482
$ds.startTransaction()
For each ($factures_e; ds:C1482.Factures.query("FAC_LOC_Date_Entree # :1"; !00-00-00!).orderBy("FAC_Locataire_ID, FAC_Annee, FAC_Mois"))
	
	If ($FAC_Locataire_ID=$factures_e.FAC_Locataire_ID)
		continue
	End if 
	
	
	$heberge_e:=ds:C1482.HeBerge.get($factures_e.FAC_Locataire_ID)
	If ($heberge_e=Null:C1517)
		continue
	End if 
	
	$heberge_e.HB_FAC_Dette_Initiale:=$factures_e.FAC_Solde_Anterieur
	
	$state_o:=$heberge_e.save()
	If ($state_o.success=False:C215)
		Progress QUIT($ProgressID)
		TRACE:C157
		$ds.cancelTransaction()
	End if 
	
	$FAC_Locataire_ID:=$factures_e.FAC_Locataire_ID
	
End for each 

$ds.validateTransaction()

Progress QUIT($ProgressID)

ALERT:C41("Fin de la maintenance de la dette initiale.")