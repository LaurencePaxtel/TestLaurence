C_BOOLEAN:C305($continue_b)
C_OBJECT:C1216($table_o; $notDrop_o; $enregistrement_o; $retour_o; $autreTable_o)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (Form:C1466.elementSelected.length>0)
			$continue_b:=True:C214
			
			$notDrop_o:=ds:C1482.HeberGement.newSelection()
			$table_o:=ds:C1482.HeberGement.query("Ref_Structure = :1"; Form:C1466.elementSelected[0].STRC_Initiales)
			
			$autreTable_o:=ds:C1482.HeBerge.query("Ref_Structure = :1"; Form:C1466.elementSelected[0].STRC_Initiales)
			
			If ($table_o.length>0)
				CONFIRM:C162(String:C10($table_o.length)+" fiche(s) d'hébergements et "+String:C10($autreTable_o.length)+" fiche(s) d'hébergés liées à la structure "+[Structures:79]STRC_Initiales:2+" ont été trouvés dans la base de donnée,"+\
					"celles-ci vont donc être supprimées, êtes-vous sûr de vouloir continuer ?"; "Oui"; "Non")
				
				If (OK=1)
					// Modifié par : Scanu Rémy - remy@connect-io.fr (11/06/2021)
					outilsProgressBar(0; "Initialisation"; True:C214)
					
					For each ($enregistrement_o; $table_o) Until ($continue_b=False:C215)
						outilsProgressBar($enregistrement_o.indexOf($table_o)/$table_o.length; "Suppression de la fiche hébergement "+String:C10($enregistrement_o.indexOf($table_o)+1)+"/"+String:C10($table_o.length))
						
						$retour_o:=$enregistrement_o.drop()
						
						If ($retour_o.success=False:C215)
							$notDrop_o.add($enregistrement_o)
						End if 
						
						If (progressBar_el=0)
							$continue_b:=False:C215
						End if 
						
					End for each 
					
					If ($continue_b=True:C214)
						
						For each ($enregistrement_o; $autreTable_o) Until ($continue_b=False:C215)
							outilsProgressBar($enregistrement_o.indexOf($autreTable_o)/$autreTable_o.length; "Suppression de la fiche hébergé "+String:C10($enregistrement_o.indexOf($autreTable_o)+1)+"/"+String:C10($autreTable_o.length))
							
							$retour_o:=$enregistrement_o.drop()
							
							If ($retour_o.success=False:C215)
								$notDrop_o.add($enregistrement_o)
							End if 
							
							If (progressBar_el=0)
								$continue_b:=False:C215
							End if 
							
						End for each 
						
						If ($continue_b=True:C214)
							$autreTable_o:=ds:C1482.CentresLits.query("Ref_Structure = :1"; Form:C1466.elementSelected[0].STRC_Initiales)
							
							For each ($enregistrement_o; $autreTable_o) Until ($continue_b=False:C215)
								outilsProgressBar($enregistrement_o.indexOf($autreTable_o)/$autreTable_o.length; "Suppression de la fiche CentresLits "+String:C10($enregistrement_o.indexOf($autreTable_o)+1)+"/"+String:C10($autreTable_o.length))
								
								$retour_o:=$enregistrement_o.drop()
								
								If ($retour_o.success=False:C215)
									$notDrop_o.add($enregistrement_o)
								End if 
								
								If (progressBar_el=0)
									$continue_b:=False:C215
								End if 
								
							End for each 
							
						End if 
						
					End if 
					
					outilsProgressBar(1; "arrêt")
					
					Case of 
						: ($notDrop_o.length>0)
							ALERT:C41(String:C10($notDrop_o.length)+" fiche(s) d'hébergements et/ou hébergés n'ont pas pu être supprimées,"+\
								" la structure ne peut donc être supprimée, merci de recommerncer.")
							$continue_b:=False:C215
						: ($continue_b=False:C215)
							ALERT:C41("Le processus de suppression a été intérrompu, merci de recommencer.")
						Else 
							ALERT:C41("Toutes les fiches hébergements liées à la structure ont été supprimées.")
					End case 
					
				Else 
					$continue_b:=False:C215
				End if 
				
			End if 
			
			If ($continue_b)
				SOciete_es:=ds:C1482.SOciete.query("Ref_Structure IS :1"; Form:C1466.elementSelected[0].Ref_Structure)
				
				If (SOciete_es.length=1)
					$state_o:=SOciete_es.first().drop()
					If (Not:C34($state_o.success))
						ALERT:C41("Erreur lors de la suppression de la société lié à la structure.")
						$continue_b:=False:C215
					End if 
				End if 
				
				If ($continue_b=True:C214)
					
					$notDrop_o:=Form:C1466.elementSelected.drop()
					
					If ($notDrop_o.length#0)
						ALERT:C41("Un problème est survenu lors de la suppression de(s) structure(s) sélectionnée(s), merci de ré-essayer")
					End if 
					
					Form:C1466.entitySelection:=ds:C1482.Structures.all()
				End if 
				
			Else 
				ALERT:C41("Suppression impossible, aucune structure de sélectionner")
			End if 
			
		End if 
		
End case 