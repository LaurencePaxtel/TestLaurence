// Method [INtervenants].IN_EcranSaisie.LB  

If (Form event code:C388=Sur double clic:K2:5)
	
	
	If (Size of array:C274(ta_UserGroupe)>0)
		
		If (ta_UserGroupe>0)
			If (i_Confirmer("Supprimer l'appartenance au groupe : "+ta_UserGroupe{ta_UserGroupe}+" ?"))
				
				C_LONGINT:C283($ii)
				$ii:=ta_UserGroupe
				DELETE FROM ARRAY:C228(ta_UserGroupe; $ii; 1)
				DELETE FROM ARRAY:C228(tl_UserGroupe; $ii; 1)
				If ($ii>Size of array:C274(ta_UserGroupe))
					$ii:=Size of array:C274(ta_UserGroupe)
				End if 
				ta_UserGroupe:=$ii
				tl_UserGroupe:=$ii
			End if 
		End if 
	End if 
	
	
End if 