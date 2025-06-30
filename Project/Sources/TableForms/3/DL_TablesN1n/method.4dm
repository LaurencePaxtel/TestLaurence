//Formule format : D_TablesN1
$vl_EventFF:=Form event code:C388

Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		
		If (vb_EtCv)
			$Pos:=Find in array:C230(t_TabNiv1; va_IDT_TypTrans)
			
			If ($Pos>0)
				t_TabNiv1:=$Pos
				t_TabNiv1{0}:=t_TabNiv1{$Pos}
				
				// Modifié par : Scanu Rémy (23/01/2023)
				LISTBOX SELECT ROW:C912(*; "Zone de défilement1"; $Pos)
			End if 
			
		End if 
		
		If (vb_EtCv)
			vaTab1Titre:="Choix : [F1] = Homme seul, [F2] = femme seule"
		Else 
			vaTab1Titre:="Choix"
		End if 
		
	: ($vl_EventFF=Sur double clic:K2:5)
		
		If (Size of array:C274(t_TabNiv1)>0)
			
			If (t_TabNiv1>0)
				t_TabNiv1{0}:=t_TabNiv1{t_TabNiv1}
				vb_Valider2:=True:C214
				
				ACCEPT:C269
			End if 
			
		End if 
		
End case 