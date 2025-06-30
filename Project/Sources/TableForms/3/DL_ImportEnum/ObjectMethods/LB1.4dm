
C_LONGINT:C283($vl_EventFF)
$vl_EventFF:=Form event code:C388

C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124
Case of 
	: ($vl_EventFF=Sur double clic:K2:5)
		
		Case of 
			: ($P_Col_current=(->te_EnumEx_Check))
				
				If (Size of array:C274(te_EnumEx_Check)>0)
					If (te_EnumEx_Check>0)
						If (te_EnumEx_Check{te_EnumEx_Check}=1)
							te_EnumEx_Check{te_EnumEx_Check}:=0
						Else 
							te_EnumEx_Check{te_EnumEx_Check}:=1
						End if 
					End if 
				End if 
				
			: ($P_Col_current=(->tt_EnumEx_Nom))
				
				If (Size of array:C274(tt_EnumEx_Nom)>0)
					If (tt_EnumEx_Nom>0)
						If (te_EnumEx_Check{tt_EnumEx_Nom}=1)
							te_EnumEx_Check{tt_EnumEx_Nom}:=0
						Else 
							te_EnumEx_Check{tt_EnumEx_Nom}:=1
						End if 
					End if 
				End if 
			Else 
				//
		End case 
		
End case 


