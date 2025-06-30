var $recapFiltreAutresCriteres_t : Text

// Modifié par : Scanu Rémy (24/05/2022)
// Ajout d'un récap des filtres appliqués pour le popup "Autres critères"
Case of 
	: (Form event code:C388=Sur clic:K2:4)
		$recapFiltreAutresCriteres_t:=outilsHGListBoxGetAtrsCrtsSelct(-><>te_VeilEtCiv; -><>te_VeilGroupe; -><>te_VeilPerma; -><>te_VeilSglt; -><>te_VeilAutreSol; -><>te_VeilOrient1; -><>te_VeilTBOr1suite; -><>te_VeilAtSsuite; -><>te_VeilOrient2; -><>te_VeilRupMaj1; -><>te_VeilRupMaj2; \
			-><>te_VeilRupMaj3; -><>te_Veilidt1; -><>te_Veilidt2; -><>te_Veilidt3; -><>te_VeilDistri5; -><>te_VeilRess1; -><>te_VeilRess2; -><>te_VeilRess3; -><>te_VeilSSoc1; -><>te_VeilSSoc2; -><>te_VeilSSoc3; \
			-><>te_VeilCSoc1; -><>te_VeilCSoc2; -><>te_VeilCSoc3; -><>te_VeilNivEt; -><>te_VeilTpsEr; -><>te_VeilMetro; -><>te_VeilGare; -><>te_VeilPlateforme; -><>te_VeilDosSIAO; -><>te_VeilCentre; -><>te_VeilFMCaS; -><>te_VeilRegulateur; -><>te_ReservationProvisoire; \
			-><>te_Nationalite; -><>te_AssistanteSociale; -><>te_CodePostal; -><>te_Coordinateur; -><>te_DernierEmploi; -><>te_DernierHebergement; -><>te_DureeSansEmploi; -><>te_Genre; -><>te_Lien; -><>te_SituationFamille; -><>te_SituationProf; -><>te_Emplacement)
		
		// Modifié par : Scanu Rémy (21/12/2022)
		If ($recapFiltreAutresCriteres_t="")
			$recapFiltreAutresCriteres_t:="Aucun filtre en cours"
		End if 
		
		ALERT:C41($recapFiltreAutresCriteres_t)
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 