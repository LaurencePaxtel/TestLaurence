If (Form event code:C388=Sur chargement:K2:1) | (Form event code:C388=Sur données modifiées:K2:15)
/*
Si (Position("/"; [HeberGement]HG_Maraude3_2)=0)
[HeberGement]HG_Maraude3_2:=outilsStringToDate([HeberGement]HG_Maraude3_2)
	
Si (Événement formulaire code=Sur chargement) & (Nouvel enregistrement([HeberGement])=Faux)
STOCKER ENREGISTREMENT([HeberGement])
Fin de si 
	
Fin de si 
*/
	If (Form event code:C388=Sur données modifiées:K2:15)
		
		//Si (outilsRegexValidate(2; [HeberGement]HG_Maraude3_2)=Vrai)
		If ([HeberGement:5]HG_DateSortie:185#!00-00-00!)
			
			If (Old:C35([HeberGement:5]HG_DateSortie:185)#[HeberGement:5]HG_DateSortie:185)
				variableModif_c.push(OBJECT Get name:C1087(Objet courant:K67:2))
			Else 
				CONFIRM:C162("Voulez-vous forcer la mise à jour des fiches antérieures ?"; "Oui"; "Non")
				
				If (OK=1)
					variableModif_c.push(OBJECT Get name:C1087(Objet courant:K67:2))
				End if 
				
			End if 
			
		Else 
			ALERT:C41("La date renseignée est au mauvais format, merci de ré-essayer")
		End if 
		
	End if 
	
End if 