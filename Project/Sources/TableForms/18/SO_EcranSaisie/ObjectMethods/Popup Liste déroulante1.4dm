var $index_el : Integer
var $init_b; $stop_b : Boolean
var $modele_c : Collection

var $docwpro_e : cs:C1710.DOCWPROEntity
var $societe_e : cs:C1710.SOcieteEntity

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		OBJECT Get pointer:C1124(Objet courant:K67:2)->:=New object:C1471()
		OBJECT Get pointer:C1124(Objet courant:K67:2)->values:=New collection:C1472("Ancien modèle"; "Modèle 4D Write Pro")
		
		If ([SOciete:18]modele:135["4D"]=Null:C1517)
			OBJECT Get pointer:C1124(Objet courant:K67:2)->index:=-1
			OBJECT Get pointer:C1124(Objet courant:K67:2)->currentValue:="Choix du modèle"
		Else 
			$modele_c:=[SOciete:18]modele:135["4D"].query("type = :1"; "participation")
			$index_el:=OBJECT Get pointer:C1124(Objet courant:K67:2)->values.indexOf($modele_c[0].modele)
			
			OBJECT Get pointer:C1124(Objet courant:K67:2)->index:=$index_el
			OBJECT Get pointer:C1124(Objet courant:K67:2)->currentValue:=$modele_c[0].modele
		End if 
		
	: (Form event code:C388=Sur données modifiées:K2:15)
		
		If (OBJECT Get pointer:C1124(Objet courant:K67:2)->currentValue="Modèle 4D Write Pro")
			$position_t:="center"
			outilsCreateWindowsForm("selectValue"; ->$position_t; New object:C1471("collection"; New collection:C1472(New object:C1471("document"; "Appel participation"); New object:C1471("document"; "Facture participation")); \
				"property"; "document"; "selectSubTitle"; "Merci de sélectionner le document"; "title"; "Choix du document :"))
			
			$init_b:=(selectValue_t="")
			
			If (selectValue_t#"")
				outilsOrdaSearchSimple("DOCWPRO"; "nom"; selectValue_t; ->$docwpro_e; "first")
				$stop_b:=($docwpro_e=Null:C1517)
				
				If ($stop_b=True:C214)
					$init_b:=True:C214
					ALERT:C41("Impossible de choisir le modèle « Modèle 4D Write Pro » car le document « "+selectValue_t+" » n'est pas présent dans la base de donnée.")
				End if 
				
			End if 
			
			If ($init_b=True:C214)
				outilsOrdaSearchSimple(->[SOciete:18]; ->[SOciete:18]ID:94; [SOciete:18]ID:94; ->$societe_e; "first")
				
				If ($societe_e#Null:C1517)
					$modele_c:=$societe_e.modele["4D"].query("type = :1"; "participation")
					
					If ($modele_c[0].modele="Ancien modèle")
						OBJECT Get pointer:C1124(Objet courant:K67:2)->index:=0
						OBJECT Get pointer:C1124(Objet courant:K67:2)->currentValue:=$modele_c[0].modele
					Else 
						OBJECT Get pointer:C1124(Objet courant:K67:2)->index:=-1
						OBJECT Get pointer:C1124(Objet courant:K67:2)->currentValue:="Choix du modèle"
					End if 
					
				End if 
				
			End if 
			
		End if 
		
		If ($stop_b=False:C215)
			$modele_c:=[SOciete:18]modele:135["4D"].query("type = :1"; "participation")
			
			$modele_c[0].modele:=OBJECT Get pointer:C1124(Objet courant:K67:2)->currentValue
			OB REMOVE:C1226($modele_c[0]; "document")
			
			If ($modele_c[0].modele="Modèle 4D Write Pro")
				$modele_c[0].document:=selectValue_t
			End if 
			
		End if 
		
End case 