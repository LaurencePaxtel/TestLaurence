var $ii; $Position : Integer

var $intervenant_e : cs:C1710.INtervenantsEntity

ARRAY LONGINT:C221(tl_UU_GP; 0)

If (Form event code:C388=Sur clic:K2:4)
	READ WRITE:C146([INtervenants:10])
	
	If (Records in set:C195("UserSet")=1)
		USE SET:C118("UserSet")
		$ii:=[INtervenants:10]IN_RéférenceID:1
		
		If ([INtervenants:10]IN_Login:3="*Administrateur")
			ALERT:C41("Vous ne pouvez pas effacer le mot de passe administrateur !")
		Else 
			
			If ([INtervenants:10]IN_RéférenceID:1>0)
				ON ERR CALL:C155("i_Error")
				
				If (i_Confirmer("Effacer le mot de passe de "+[INtervenants:10]IN_Login:3+<>va_CR+"Confirmez-vous ?"))
					$Position:=Find in array:C230(ta_UserLog; [INtervenants:10]IN_Login:3)
					
					If ($Position>0)
						vl_UU_Réf:=0
						va_UU_Nom:=""
						va_UU_Proc:=""
						va_UU_MP:=""
						vl_UU_NbAccès:=0
						vd_UU_Date:=!00-00-00!
						
						vl_UU_Réf:=tl_UserNo{$Position}
						
						// Modifié par : Scanu Rémy (20/02/2024)
						// On abandonne la gestion des mots de passe sur 4D mais on passe par la table [INtervenants]
						outilsOrdaSearchSimple(->[INtervenants:10]; ->[INtervenants:10]IN_RéfUser:11; vl_UU_Réf; ->$intervenant_e; "first")
						
						If ($intervenant_e#Null:C1517)
							[INtervenants:10]IN_HashPassword:22:=Generate password hash:C1533("")
							SAVE RECORD:C53([INtervenants:10])
						End if 
						
						BEEP:C151
					Else 
						ALERT:C41("Cet utilisateur n'est pas référencé : veuillez consulter l'administrateur !")
					End if 
					
					ON ERR CALL:C155("")
				End if 
				
			Else 
				StrAlerte(22; "")
			End if 
			
		End if 
		
		USE SET:C118("E_Courant")
		ORDER BY:C49([INtervenants:10]; [INtervenants:10]IN_Nom:4; >)
		
		SET QUERY DESTINATION:C396(Vers ensemble:K19:2; "UserSet")
		
		QUERY:C277([INtervenants:10]; [INtervenants:10]IN_RéférenceID:1=$ii)
		MultiSoc_Filter(->[INtervenants:10])
		SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
		
		HIGHLIGHT RECORDS:C656
	Else 
		StrAlerte(28; "")
	End if 
	
End if 