
var $table_p : Pointer

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If (Form:C1466.titre#Null:C1517)
			SET WINDOW TITLE:C213(String:C10(Form:C1466.titre); Frontmost window:C447)
		End if 
		
		// Modifié par : Scanu Rémy (20/04/2023)
		// Il faut déterminer si la taille du sous-formulaire en largeur est supérieur à la largeur de l'écran
		If (Num:C11(Form:C1466.largeurForm)<Screen width:C187(*))
			OBJECT SET SCROLLBAR:C843(*; "Sous formulaire"; False:C215; True:C214)
		End if 
		
		If (Form:C1466.table#Null:C1517)
			$table_p:=Formula from string:C1601("->["+Form:C1466.table+"]").call()
			OBJECT SET SUBFORM:C1138(*; "Sous formulaire"; $table_p->; Form:C1466.formName; "")
		Else 
			OBJECT SET SUBFORM:C1138(*; "Sous formulaire"; Form:C1466.formName; "")
		End if 
		
		If (Bool:C1537(Form:C1466.fullWidth)=True:C214)
			MAXIMIZE WINDOW:C453(Frontmost window:C447)
		End if 
		
	: (Form event code:C388=Sur appel extérieur:K2:11)
		// Modifié par : Scanu Rémy (06/02/2023)
		// Rajout de l'évenement "Sur appel extérieur" pour appeler cet évenement également dans le sous-formulaire
End case 