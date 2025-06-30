$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		If (Is new record:C668([PreSentation:44]))
			MultiSoc_Init_Structure(->[PreSentation:44])
			[PreSentation:44]PS_RéférenceID:1:=Uut_Numerote(->[PreSentation:44])
			[PreSentation:44]PS_Scénario:2:=va_LibScénario
			[PreSentation:44]PS_Catégorie:3:=va_LibEnum
			[PreSentation:44]PS_Diviseur:9:=1
			OBJECT SET ENABLED:C1123(b_ValTF; False:C215)
			va_LibEnum:=""
		Else 
			va_LibEnum:=[PreSentation:44]PS_Libellé:4
		End if 
	: ($vl_EventFF=Sur données modifiées:K2:15)
		$vb_OK:=False:C215
		If (Modified:C32([PreSentation:44]PS_Libellé:4) | Modified:C32([PreSentation:44]PS_Diviseur:9))
			OBJECT SET ENABLED:C1123(b_ValTF; False:C215)
			$vb_OK:=False:C215
			If ([PreSentation:44]PS_Libellé:4>"")
				$ii:=0
				Case of 
					: ([PreSentation:44]PS_Catégorie:3=<>ta_ItemGroupe{1})
						$ii:=Find in array:C230(ta_yEtCiv; [PreSentation:44]PS_Libellé:4)
					: ([PreSentation:44]PS_Catégorie:3=<>ta_ItemGroupe{2})
						$ii:=Find in array:C230(ta_yCtreH; [PreSentation:44]PS_Libellé:4)
					: ([PreSentation:44]PS_Catégorie:3=<>ta_ItemGroupe{3})
						$ii:=Find in array:C230(ta_yCtreP; [PreSentation:44]PS_Libellé:4)
				End case 
				If ($ii>0)
					If (va_LibEnum=[PreSentation:44]PS_Libellé:4)
						$vb_OK:=True:C214
					Else 
						ALERT:C41("Ce libellé < "+[PreSentation:44]PS_Libellé:4+" > existe déjà !")
					End if 
				Else 
					$vb_OK:=True:C214
				End if 
			End if 
			
			$vb_OK:=$vb_OK & ([PreSentation:44]PS_Diviseur:9>0)
			If ($vb_OK)
				OBJECT SET ENABLED:C1123(b_ValTF; True:C214)
			End if 
		End if 
End case 

