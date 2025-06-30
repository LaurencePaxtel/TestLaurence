$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		If (Is new record:C668([ItemGroupe:43]))
			MultiSoc_Init_Structure(->[ItemGroupe:43])
			[ItemGroupe:43]IT_RéférenceID:1:=Uut_Numerote(->[ItemGroupe:43])
			[ItemGroupe:43]IT_Catégorie:2:=va_LibEnum
			[ItemGroupe:43]IT_Diviseur:8:=1
			OBJECT SET ENABLED:C1123(b_ValTF; False:C215)
			va_LibEnum:=""
		Else 
			va_LibEnum:=[ItemGroupe:43]IT_Libellé:3
		End if 
	: ($vl_EventFF=Sur données modifiées:K2:15)
		$vb_OK:=False:C215
		If (Modified:C32([ItemGroupe:43]IT_Libellé:3) | Modified:C32([ItemGroupe:43]IT_Diviseur:8))
			OBJECT SET ENABLED:C1123(b_ValTF; False:C215)
			$vb_OK:=False:C215
			If ([ItemGroupe:43]IT_Libellé:3>"")
				$ii:=0
				Case of 
					: ([ItemGroupe:43]IT_Catégorie:2=<>ta_ItemGroupe{1})
						$ii:=Find in array:C230(ta_yEtCiv; [ItemGroupe:43]IT_Libellé:3)
					: ([ItemGroupe:43]IT_Catégorie:2=<>ta_ItemGroupe{2})
						$ii:=Find in array:C230(ta_yCtreH; [ItemGroupe:43]IT_Libellé:3)
					: ([ItemGroupe:43]IT_Catégorie:2=<>ta_ItemGroupe{3})
						$ii:=Find in array:C230(ta_yCtreP; [ItemGroupe:43]IT_Libellé:3)
				End case 
				If ($ii>0)
					If (va_LibEnum=[ItemGroupe:43]IT_Libellé:3)
						$vb_OK:=True:C214
					Else 
						ALERT:C41("Ce libellé < "+[ItemGroupe:43]IT_Libellé:3+" > existe déjà !")
					End if 
				Else 
					$vb_OK:=True:C214
				End if 
			End if 
			
			$vb_OK:=$vb_OK & ([ItemGroupe:43]IT_Diviseur:8>0)
			If ($vb_OK)
				OBJECT SET ENABLED:C1123(b_ValTF; True:C214)
			End if 
		End if 
End case 

