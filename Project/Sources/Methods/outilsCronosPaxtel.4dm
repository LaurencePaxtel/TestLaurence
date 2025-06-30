//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 08/03/24, 16:58:38
// ----------------------------------------------------
// Méthode : outilsCronosPaxtel
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Integer

var $verif_o; $statut_o : Object

var $societe_es : cs:C1710.SOcieteSelection

var $heberge_e : cs:C1710.HeBergeEntity
var $heberge_es : cs:C1710.HeBergeSelection

var $hebergement_es; $hebergementB_es : cs:C1710.HeberGementSelection

Case of 
	: ($1=1)  // Initialisation du worker de Cronos (Version Paxtel)
		CALL WORKER:C1389("cronosPaxtel_w"; "outilsCronosPaxtel"; 10)
	: ($1=10)
		$verif_o:=New object:C1471
		$dateDujour_d:=Current date:C33
		
		While (True:C214)
			
			If ($dateDujour_d=Current date:C33)
				$verif_o.cleLienHeberge:=String:C10(Current time:C178(*))
				$dateDujour_d:=Add to date:C393($dateDujour_d; 0; 0; 1)
			End if 
			
			Case of 
				: (Time:C179($verif_o.cleLienHeberge)<=Current time:C178(*))
					$societe_es:=ds:C1482.SOciete.all().orderBy("Ref_Structure asc")
					
					For each ($societe_e; $societe_es)
						outilsOrdaSearchSimple(->[HeberGement:5]; ->[HeberGement:5]Ref_Structure:169; $societe_e.Ref_Structure; ->$hebergement_es)
						
						$hebergement_es:=$hebergement_es.query("HG_FamChef = :1 AND HG_FamClé # :2"; True:C214; "")
						$heberge_es:=$hebergement_es.HG_HB_ID_1_HB_ReferenceID.query("HB_CléFam = :1"; "")
						
						For each ($heberge_e; $heberge_es)
							$hebergementB_es:=$heberge_e.HB_ReferenceID_1_HG_HB_ID.query("HG_FamChef = :1 AND HG_FamClé # :2"; True:C214; "").orderBy("HG_Date desc")
							
							$heberge_e.HB_CléFam:=$hebergementB_es.first().HG_FamClé
							$statut_o:=$heberge_e.save()
						End for each 
						
					End for each 
					
					$verif_o.cleLienHeberge:=String:C10(Current time:C178+?00:05:00?)
			End case 
			
			DELAY PROCESS:C323(Current process:C322; 600)
		End while 
		
End case 