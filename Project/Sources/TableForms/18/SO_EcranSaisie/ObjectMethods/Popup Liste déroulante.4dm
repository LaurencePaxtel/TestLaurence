var $index_el : Integer
var $stop_b : Boolean

var $docwpro_e : cs:C1710.DOCWPROEntity

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		OBJECT Get pointer:C1124(Objet courant:K67:2)->:=New object:C1471()
		OBJECT Get pointer:C1124(Objet courant:K67:2)->values:=New collection:C1472("Ancien modèle"; "Modèle 4D Write Pro")
		
		If ([SOciete:18]SO_ChoixModeleFactureLoyerWeb:133="")
			OBJECT Get pointer:C1124(Objet courant:K67:2)->index:=-1
			OBJECT Get pointer:C1124(Objet courant:K67:2)->currentValue:="Choix du modèle"
		Else 
			$index_el:=OBJECT Get pointer:C1124(Objet courant:K67:2)->values.indexOf([SOciete:18]SO_ChoixModeleFactureLoyerWeb:133)
			
			OBJECT Get pointer:C1124(Objet courant:K67:2)->index:=$index_el
			OBJECT Get pointer:C1124(Objet courant:K67:2)->currentValue:=[SOciete:18]SO_ChoixModeleFactureLoyerWeb:133
		End if 
		
	: (Form event code:C388=Sur données modifiées:K2:15)
		
		If (OBJECT Get pointer:C1124(Objet courant:K67:2)->currentValue="Modèle 4D Write Pro")
			outilsOrdaSearchSimple("DOCWPRO"; "nom"; "Quittance loyer"; ->$docwpro_e; "first")
			$stop_b:=($docwpro_e=Null:C1517)
			
			If ($stop_b=True:C214)
				
				If (Old:C35([SOciete:18]SO_ChoixModeleFactureLoyerWeb:133)="Ancien modèle")
					OBJECT Get pointer:C1124(Objet courant:K67:2)->index:=0
					OBJECT Get pointer:C1124(Objet courant:K67:2)->currentValue:=[SOciete:18]SO_ChoixModeleFactureLoyerWeb:133
				Else 
					OBJECT Get pointer:C1124(Objet courant:K67:2)->index:=-1
					OBJECT Get pointer:C1124(Objet courant:K67:2)->currentValue:="Choix du modèle"
				End if 
				
				ALERT:C41("Impossible de choisir le modèle « Modèle 4D Write Pro » car le document « Quittance loyer » n'est pas présent dans la base de donnée.")
			End if 
			
		End if 
		
		If ($stop_b=False:C215)
			[SOciete:18]SO_ChoixModeleFactureLoyerWeb:133:=OBJECT Get pointer:C1124(Objet courant:K67:2)->currentValue
		End if 
		
End case 