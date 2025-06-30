Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If (vPtrT2_Var1->>"")
			
			If (Form:C1466.t_TabNiv1.length>0)
				$Pos:=Find in array:C230(t_TabNiv1; vPtrT2_Var1->)
				
				If ($Pos>0)
					t_TabNiv1:=$Pos
					t_TabNiv1{0}:=t_TabNiv1{$Pos}
				End if 
				
			End if 
			
		End if 
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (04/05/2021) Et re-modifié par Scanu Rémy (06/05/2021)
		// Du fait de l'ajout d'une colonne sous forme de checkbox cette propriété n'a plus de sens... Finalement on met une ligne unique pour tous les cas
		//Si (Bool(Form.multiSelected)=Vrai)
		LISTBOX SET PROPERTY:C1440(*; "LB"; lk mode de sélection:K53:35; lk ligne unique:K53:58)
		//Fin de si 
		
		// Initialisation de certaines variables
		Form:C1466.filtre:=""
		
		Form:C1466.t_TabNiv1Init:=Form:C1466.t_TabNiv1.copy()
		Form:C1466.t_TabNiv1:=Form:C1466.t_TabNiv1Init.query("choix = :1"; "@")
		
		// Modifié par : Scanu Rémy (29/09/2023)
		OBJECT SET VISIBLE:C603(*; "allSelected"; Bool:C1537(Form:C1466.multiSelected))
	: (Form event code:C388=Sur double clic:K2:5)
		
		If (Form:C1466.t_TabNiv1.length>0)
			
			If (Form:C1466.elementSelected.length>0)
				
				If (Bool:C1537(Form:C1466.multiSelected)=False:C215)
					vb_Valider2:=True:C214
					
					ACCEPT:C269
				End if 
				
			End if 
			
		End if 
		
End case 