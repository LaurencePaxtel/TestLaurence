Case of 
	: (Form event code:C388=Sur clic:K2:4)
		C_TEXT:C284($nomDocument_t)
		C_OBJECT:C1216($table_o)
		
		If (Records in selection:C76([DOCWPRO:121])=1)
			CONFIRM:C162("Un document est en cours d'édition, voulez-vous le sauvegarder ?"; "Oui"; "Non")
			
			If (OK=1)
				SAVE RECORD:C53([DOCWPRO:121])
			End if 
			
			UNLOAD RECORD:C212([DOCWPRO:121])
		End if 
		
		REDUCE SELECTION:C351([DOCWPRO:121]; 0)
		
		$nomDocument_t:=Request:C163("Nom du document ?"; "Nouveau document"; "Créer"; "Annuler")
		
		If ($nomDocument_t#"")
			$table_o:=ds:C1482.DOCWPRO.query("nom = :1 AND structureRef = :2"; $nomDocument_t; <>ref_soc_active)
			
			If ($table_o.length=0)
				CREATE RECORD:C68([DOCWPRO:121])
				[DOCWPRO:121]nom:3:=$nomDocument_t
				[DOCWPRO:121]fichier:4:=WP New:C1317
				[DOCWPRO:121]tag:5:=JSON Stringify:C1217(New collection:C1472("Perso"))
				[DOCWPRO:121]structureRef:2:=<>ref_soc_active
				SAVE RECORD:C53([DOCWPRO:121])
				
				Form:C1466.tag:=New collection:C1472(New object:C1471("lib"; "Perso"))
				
				OBJECT Get pointer:C1124(Objet nommé:K67:5; "chargeData")->index:=-1
				OBJECT Get pointer:C1124(Objet nommé:K67:5; "chargeData")->currentValue:="Choix du cas des « données » chargé"
				SET WINDOW TITLE:C213("Modification de la lettre "+[DOCWPRO:121]nom:3)
				
				ALERT:C41("Le document qui porte le nom "+$nomDocument_t+" a bien été créé avec succès")
			Else 
				ALERT:C41("Un document porte déjà ce nom, merci d'en choisir un autre")
			End if 
			
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 