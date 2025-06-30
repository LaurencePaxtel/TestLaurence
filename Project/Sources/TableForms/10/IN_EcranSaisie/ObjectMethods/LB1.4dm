// Method [INtervenants].IN_EcranSaisie.LB  

If (Form event code:C388=Sur double clic:K2:5)
	
	
	
	If (Size of array:C274(ta_LesPlatefomes)>0)
		If (ta_LesPlatefomes>0)
			If (i_Confirmer("Supprimer la plateforme : "+ta_LesPlatefomes{ta_LesPlatefomes}+" ?"))
				
				C_LONGINT:C283($ii)
				$ii:=ta_LesPlatefomes
				DELETE FROM ARRAY:C228(ta_LesPlatefomes; $ii; 1)
				If ($ii>Size of array:C274(ta_LesPlatefomes))
					$ii:=Size of array:C274(ta_LesPlatefomes)
				End if 
				ta_LesPlatefomes:=$ii
			End if 
		End if 
	End if 
End if 