//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 16/11/21, 16:50:11
// ----------------------------------------------------
// Méthode : outilsWProCreerDocument
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)  // Instruction [simple, auto]
C_TEXT:C284($2)  // Nom du document
C_TEXT:C284($3)  // Instructions complémentaires [optionnel]
C_OBJECT:C1216($4)  // Document 4DWritePro [optionnel]

C_BOOLEAN:C305($0)

C_TEXT:C284($nomDocument_t; $tag_t)
C_TIME:C306($refDoc_h)
C_BOOLEAN:C305($creerDocument_b; $remplacerDocument_b)
C_OBJECT:C1216($table_o; $document_o; $fichier_o)

ARRAY TEXT:C222($tagdocument4WP_at; 0)

Case of 
	: ($1="simple")
		$refDoc_h:=Open document:C264(""; "4W7;4WP")  // Le fichier est ouvert
		
		If (OK=1)
			// On va extraire le nom du document ouvert
			$nomDocument_t:=outilsGetDocumentNameInPath(Document; "\\")
			
			If ($nomDocument_t="@4W7@")
				$nomDocument_t:=Replace string:C233($nomDocument_t; ".4W7"; "")
			Else 
				$nomDocument_t:=Replace string:C233($nomDocument_t; ".4WP"; "")
			End if 
			
			// On va chercher si on a pas déjà un document qui porte le même nom...
			QUERY:C277([DOCWPRO:121]; [DOCWPRO:121]nom:3=$nomDocument_t; *)
			QUERY:C277([DOCWPRO:121];  & ; [DOCWPRO:121]structureRef:2=<>ref_soc_active)
			
			If (Records in selection:C76([DOCWPRO:121])=0)
				$creerDocument_b:=True:C214
			Else 
				ALERT:C41("Une lettre portant déjà le même nom existe déjà dans la base de donnée!")
				CONFIRM:C162("Voulez-vous remplacer le document pré-existant ?")
				
				If (OK=1)
					$remplacerDocument_b:=True:C214
				End if 
				
			End if 
			
		End if 
		
	: ($1="auto")
		QUERY:C277([DOCWPRO:121]; [DOCWPRO:121]nom:3=$2; *)
		QUERY:C277([DOCWPRO:121];  & ; [DOCWPRO:121]structureRef:2=<>ref_soc_active)
		
		If (Count parameters:C259=3)
			
			If ($3="deleteBefore")
				
				If (Records in selection:C76([DOCWPRO:121])=1)
					DELETE RECORD:C58([DOCWPRO:121])
					
					UNLOAD RECORD:C212([DOCWPRO:121])
					REDUCE SELECTION:C351([DOCWPRO:121]; 0)
				End if 
				
			End if 
			
		End if 
		
		If (Records in selection:C76([DOCWPRO:121])=0) & (Count parameters:C259<4)
			$fichier_o:=Folder:C1567(Get 4D folder:C485(Dossier Resources courant:K5:16)+"document"+Séparateur dossier:K24:12; fk chemin plateforme:K87:2).file($2+".4WP")
			
			If ($fichier_o.exists=True:C214)
				$creerDocument_b:=True:C214
			Else 
				ALERT:C41("Le fichier "+$2+".4WP n'a pas pu être importé, merci de contacter le service informatique.")
				$0:=True:C214
			End if 
			
		End if 
		
		If (Records in selection:C76([DOCWPRO:121])=0) & (Count parameters:C259=4)
			$creerDocument_b:=True:C214
		End if 
		
	: ($1="autoEnregistrerSous")
		
		If (Records in selection:C76([DOCWPRO:121])=1) & ([DOCWPRO:121]nom:3#"NOUVEAU DOCUMENT")
			// Variables à copier dans le nouveau document
			$tag_t:=[DOCWPRO:121]tag:5
			$document_o:=OB Copy:C1225([DOCWPRO:121]fichier:4)
			
			$table_o:=ds:C1482.DOCWPRO.query("nom = :1 AND structureRef = :2"; $2; <>ref_soc_active)
			
			If (Num:C11($table_o.length)=0)
				$creerDocument_b:=True:C214
			Else 
				ALERT:C41("Un document portant déjà le même nom existe déjà dans la base de donnée !")
			End if 
			
		Else 
			ALERT:C41("Aucun document n'est pré-chargé")
		End if 
		
End case 

If ($creerDocument_b=True:C214)
	CREATE RECORD:C68([DOCWPRO:121])
	[DOCWPRO:121]structureRef:2:=<>ref_soc_active
	
	// Objet Write Pro et nom de la lettre
	Case of 
		: ($1="simple")
			[DOCWPRO:121]fichier:4:=WP Import document:C1318(Document)
			[DOCWPRO:121]nom:3:=$nomDocument_t
		: ($1="auto") | ($1="autoEnregistrerSous")
			
			If ($1="autoEnregistrerSous")
				[DOCWPRO:121]fichier:4:=OB Copy:C1225($document_o)
			Else 
				
				If (Count parameters:C259=4)
					[DOCWPRO:121]fichier:4:=$4
				Else 
					[DOCWPRO:121]fichier:4:=WP Import document:C1318($fichier_o.platformPath)
				End if 
				
			End if 
			
			[DOCWPRO:121]nom:3:=$2
	End case 
	
	// Tag
	Case of 
		: ($1="simple")
			APPEND TO ARRAY:C911($tagdocument4WP_at; "Perso")
		: ($1="auto")
			APPEND TO ARRAY:C911($tagdocument4WP_at; "Document officiel")
	End case 
	
	If ($1="autoEnregistrerSous")
		[DOCWPRO:121]tag:5:=$tag_t
	Else 
		[DOCWPRO:121]tag:5:=JSON Stringify array:C1228($tagdocument4WP_at)
	End if 
	
	SAVE RECORD:C53([DOCWPRO:121])
End if 

If ($remplacerDocument_b=True:C214)
	[DOCWPRO:121]fichier:4:=WP Import document:C1318(Document)
End if 

If ($1="simple")
	CLOSE DOCUMENT:C267($refDoc_h)
End if 