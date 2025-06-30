
C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124


Case of 
	: ($vl_EventFF=Sur clic:K2:4)
		
		Case of 
			: ($P_Col_current=(->tl_CTSél))
				
				If (Size of array:C274(tl_CTSél)>0)
					Rec_TransFamille(2; ->[DiaLogues:3]DL_Date:2; ->Vb_JouNuit; ->Vb_Valide; tl_CTSél)
				Else 
					Rec_TransFamille(2; ->[DiaLogues:3]DL_Date:2; ->Vb_JouNuit; ->Vb_Valide; 0)
				End if 
				
			: ($P_Col_current=(->ta_CTNom))
				
				If (Size of array:C274(ta_CTNom)>0)
					Rec_TransFamille(2; ->[DiaLogues:3]DL_Date:2; ->Vb_JouNuit; ->Vb_Valide; ta_CTNom)
				Else 
					Rec_TransFamille(2; ->[DiaLogues:3]DL_Date:2; ->Vb_JouNuit; ->Vb_Valide; 0)
				End if 
			Else 
				//
		End case 
		
		
	: ($vl_EventFF=Sur double clic:K2:5)
		
		Case of 
			: ($P_Col_current=(->tl_CTSél))
				
				If (Size of array:C274(tl_CTSél)>0)
					If (tl_CTSél>0)
						If (tl_CTSél{tl_CTSél}=1)
							tl_CTSél{tl_CTSél}:=0
						Else 
							tl_CTSél{tl_CTSél}:=1
						End if 
					End if 
				End if 
			Else 
				//
		End case 
		
End case 


