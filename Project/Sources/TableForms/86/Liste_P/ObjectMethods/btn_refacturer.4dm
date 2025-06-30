C_LONGINT:C283($i_el)
C_OBJECT:C1216($enregistrement_o)

// Modifié par : Scanu Rémy (21/12/2021)
Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If (Current user:C182="apaxtel")
			OBJECT SET VISIBLE:C603(*; "btn_refacturer"; True:C214)
		End if 
		
	: (Form event code:C388=Sur clic:K2:4)
		
		For ($i_el; 1; Size of array:C274(tb_liste_choix))
			
			If (tb_liste_choix{$i_el}=True:C214)
				outilsOrdaSearchSimple("Participations"; "ID"; tb_liste_id{$i_el}; ->$enregistrement_o; "first")
				
				If ($enregistrement_o#Null:C1517)
					$enregistrement_o.PAR_Facture:=False:C215
					$enregistrement_o.save()
				End if 
				
			End if 
			
		End for 
		
		FAC_P_Get_Records
End case 