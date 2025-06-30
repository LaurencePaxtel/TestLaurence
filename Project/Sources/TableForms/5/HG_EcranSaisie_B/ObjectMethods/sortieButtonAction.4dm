C_TEXT:C284($autreSolution_t)
C_OBJECT:C1216($table_o; $enregistrement_o)

If ([HeberGement:5]HG_FamChef:103=True:C214)
	CONFIRM:C162("La date de sortie est-elle celle de la fiche ouverte ("+String:C10([HeberGement:5]HG_Date:4)+") cliquez sur « Oui », si c'est le lendemain cliquez sur « Non » ?"; "Oui"; "Non")
	
	If (OK=1)
		[HeberGement:5]HG_DateSortie:185:=[HeberGement:5]HG_Date:4
	Else 
		[HeberGement:5]HG_DateSortie:185:=[HeberGement:5]HG_Date:4+1
	End if 
	
	[HeberGement:5]HG_Cloturée:67:=Not:C34(OK=1)
	[HeberGement:5]HG_Réservation:91:=False:C215
	
	If (<>ve_Si_ModeCHRS=0)  //• Si fiche d'hébergement profil Prestation
		OBJECT SET ENTERABLE:C238([HeberGement:5]HG_NuitTOTAL:93; ([HeberGement:5]HG_Réservation:91=True:C214))
		
		If ([HeberGement:5]HG_NuitenCours:92>0)
			[HeberGement:5]HG_NuitTOTAL:93:=[HeberGement:5]HG_NuitenCours:92
		Else 
			[HeberGement:5]HG_NuitTOTAL:93:=1
		End if 
		
		[HeberGement:5]HG_NuitReste:95:=0
		[HeberGement:5]HG_RéservationDateFin:134:=F_RéservationDateFin([HeberGement:5]HG_Date:4; [HeberGement:5]HG_NuitReste:95)
	End if 
	
	ALERT:C41("Veuillez remplir le champ « "+Get indexed string:C510(<>vlSTR_Std; 50)+" »")
	Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{50}; -><>ta_AtS; ->[HeberGement:5]HG_AutreSolutio:88)
	
	If ([HeberGement:5]HG_AutreSolutio:88#"")
		$autreSolution_t:=[HeberGement:5]HG_AutreSolutio:88
		
		// Modifié par : Scanu Rémy (25/04/2023)
		$modif_b:=ds:C1482.HeberGement.reportMotifSortie([HeberGement:5]ID:168; $autreSolution_t; [HeberGement:5]HG_DateSortie:185)
		
		If ($modif_b=False:C215)
			ALERT:C41("Le motif de sortie "+[HeberGement:5]HG_AutreSolutio:88+" n'a pas pu être reporté à la fiche de la veille")
		End if 
		
		CONFIRM:C162("Voulez-vous appliquer cette sortie pour tous les membres de la famille ?"; "Oui"; "Non")
		
		If (OK=1)
			// Modifié par : Scanu Rémy (16/05/2023)
			// Il ne faut prendre que les fiches hébergements des autres membres de la famille
			$table_o:=ds:C1482.HeberGement.query("HG_Date = :1 AND HG_FamClé = :2 AND HG_HB_ID # :3"; [HeberGement:5]HG_Date:4; [HeberGement:5]HG_FamClé:104; [HeberGement:5]HG_HB_ID:19)
			
			If ($table_o.length>0)
				
				For each ($enregistrement_o; $table_o)
					$enregistrement_o.HG_DateSortie:=[HeberGement:5]HG_DateSortie:185
					$enregistrement_o.HG_AutreSolutio:=$autreSolution_t
					
					$enregistrement_o.HG_Réservation:=False:C215
					$enregistrement_o.HG_Cloturée:=[HeberGement:5]HG_Cloturée:67
					
					If (<>ve_Si_ModeCHRS=0)  //• Si fiche d'hébergement profil Prestation
						
						If ([HeberGement:5]HG_NuitenCours:92>0)
							$enregistrement_o.HG_NuitTOTAL:=[HeberGement:5]HG_NuitenCours:92
						Else 
							$enregistrement_o.HG_NuitTOTAL:=1
						End if 
						
						$enregistrement_o.HG_NuitReste:=0
						$enregistrement_o.HG_RéservationDateFin:=F_RéservationDateFin([HeberGement:5]HG_Date:4; [HeberGement:5]HG_NuitReste:95)
					End if 
					
					$enregistrement_o.save()
					
					// Modifié par : Scanu Rémy (25/04/2023)
					$modif_b:=ds:C1482.HeberGement.reportMotifSortie($enregistrement_o.ID; $enregistrement_o.HG_AutreSolutio; [HeberGement:5]HG_DateSortie:185)
					
					If ($modif_b=True:C214)
						$enregistrement_o.reload()
						
						// Modifié par : Scanu Rémy (01/02/2024)
						// Finalement on ne met pas à vide le champ Autre solution pour les membre de la même famille le jour\
																												 de la fiche de la date de la fiche sur laquelle on est
						
/*
$enregistrement_o.HG_AutreSolutio:=""
$enregistrement_o.save()
*/
					End if 
					
				End for each 
				
			End if 
			
		End if 
		
	End if 
	
Else 
	ALERT:C41("Veuillez vous rendre sur la fiche du chef de famille pour effectuer la sortie")
End if 