Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		ARRAY TEXT:C222($tag_at; 0)
		
		CONFIRM:C162("Voulez-vous ouvrir un document stocké dans le logiciel ?"; "Oui"; "Non")
		
		If (OK=1)
			outilsBibliothequeNumerique
		Else 
			outilsWProCreerDocument("simple")
		End if 
		
		If (Records in selection:C76([DOCWPRO:121])=1) & ([DOCWPRO:121]nom:3#"NOUVEAU DOCUMENT")
			JSON PARSE ARRAY:C1219([DOCWPRO:121]tag:5; $tag_at)
			
			Form:C1466.tag:=New collection:C1472
			ARRAY TO COLLECTION:C1563(Form:C1466.tag; $tag_at; "lib")
			
			If ([DOCWPRO:121]chargeData:6#"")
				OBJECT Get pointer:C1124(Objet nommé:K67:5; "chargeData")->index:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "chargeData")->values.indexOf([DOCWPRO:121]chargeData:6)
				OBJECT Get pointer:C1124(Objet nommé:K67:5; "chargeData")->currentValue:=[DOCWPRO:121]chargeData:6
			Else 
				OBJECT Get pointer:C1124(Objet nommé:K67:5; "chargeData")->index:=-1
				OBJECT Get pointer:C1124(Objet nommé:K67:5; "chargeData")->currentValue:="Choix du cas des « données » chargé"
			End if 
			
			SET WINDOW TITLE:C213("Modification de la lettre "+[DOCWPRO:121]nom:3)
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 