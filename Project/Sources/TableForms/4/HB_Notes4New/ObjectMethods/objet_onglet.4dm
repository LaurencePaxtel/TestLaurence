var $menuNom_t : Text
var $menuIndex_el : Integer
var $liste_p : Pointer

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		GET LIST ITEM:C378(*; "objet_onglet"; *; $menuIndex_el; $menuNom_t)
		
		Case of 
			: ($menuNom_t="Note")
				FORM GOTO PAGE:C247(1)
			: ($menuNom_t="Photo")
				FORM GOTO PAGE:C247(2)
			: ($menuNom_t="Administratif")
				FORM GOTO PAGE:C247(3)
		End case 
		
	: (Form event code:C388=Sur chargement:K2:1)
		$liste_p:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "objet_onglet")
		VARIABLE TO VARIABLE:C635(Current process:C322; $liste_p->; <>L_Onglet_notes_C)
End case 