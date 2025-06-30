//%attributes = {}

var $ParticipationsWebBudget_e : cs:C1710.ParticipationsWebBudgetEntity
var $Participation_e : cs:C1710.ParticipationsEntity
var $ParticipationWeb_e : cs:C1710.ParticipationWebEntity
var $state_o : Object

var $ds : Object

$ds:=ds:C1482

$ds.startTransaction()

For each ($ParticipationsWebBudget_e; ds:C1482.ParticipationsWebBudget.query("totalParticipation # 0"))
	$ParticipationWeb_e:=ds:C1482.ParticipationWeb.new()
	$ParticipationWeb_e.salaire:=$ParticipationsWebBudget_e.salaire
	$ParticipationWeb_e.loyer:=$ParticipationsWebBudget_e.loyer
	$ParticipationWeb_e.apl:=$ParticipationsWebBudget_e.apl
	$ParticipationWeb_e.charge:=$ParticipationsWebBudget_e.charge
	$ParticipationWeb_e.ressource:=$ParticipationsWebBudget_e.ressource
	$ParticipationWeb_e.resteAVivre:=$ParticipationsWebBudget_e.resteAVivre
	$ParticipationWeb_e.tauxEffortLoyer:=$ParticipationsWebBudget_e.tauxEffortLoyer
	$ParticipationWeb_e.tauxEndettement:=$ParticipationsWebBudget_e.tauxEndettement
	$ParticipationWeb_e.commentaire:=$ParticipationsWebBudget_e.commentaire
	$ParticipationWeb_e.nbPersonneMenage:=$ParticipationsWebBudget_e.nbPersonneMenage
	$state_o:=$ParticipationWeb_e.save()
	If ($state_o.success=False:C215)
		TRACE:C157
		$ds.cancelTransaction()
	End if 
	
	$Participation_e:=ds:C1482.Participations.new()
	$Participation_e.PAR_HB_ID:=ds:C1482.HeBerge.get($ParticipationsWebBudget_e.hebergeID).HB_ReferenceID
	$Participation_e.PAR_Annee:=$ParticipationsWebBudget_e.annee
	$Participation_e.PAR_Mois:=$ParticipationsWebBudget_e.mois
	$Participation_e.PAR_Taux:=$ParticipationsWebBudget_e.forfaitParticipation
	$Participation_e.PAR_Montant_Participation:=$ParticipationsWebBudget_e.totalParticipation
	$Participation_e.Ref_Structure:=$ParticipationsWebBudget_e.Ref_Structure
	$Participation_e.PAR_participationWebID:=$ParticipationWeb_e.ID
	$state_o:=$Participation_e.save()
	If ($state_o.success=False:C215)
		TRACE:C157
		$ds.cancelTransaction()
	End if 
End for each 

$ds.validateTransaction()


ds:C1482.ParticipationsWebBudget.all().drop()
ALERT:C41("Maintenance participation web ok.")