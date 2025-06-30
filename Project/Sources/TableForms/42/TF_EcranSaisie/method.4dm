$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		If (Is new record:C668([TableFusions:42]))
			MultiSoc_Init_Structure(->[TableFusions:42])
			[TableFusions:42]TF_RéférenceID:1:=Uut_Numerote(->[TableFusions:42])
			[TableFusions:42]TF_RéférenceTable:2:=va_CodeEnum
			[TableFusions:42]TF_Diviseur:7:=1
			OBJECT SET ENABLED:C1123(b_ValTF; False:C215)
			va_LibEnum:=""
		Else 
			va_LibEnum:=[TableFusions:42]TF_Libellé:3
		End if 
	: ($vl_EventFF=Sur données modifiées:K2:15)
		$vb_OK:=False:C215
		If (Modified:C32([TableFusions:42]TF_Libellé:3) | Modified:C32([TableFusions:42]TF_Diviseur:7))
			OBJECT SET ENABLED:C1123(b_ValTF; False:C215)
			$vb_OK:=False:C215
			If ([TableFusions:42]TF_Libellé:3>"")
				$ii:=Find in array:C230(ta_yEtCiv; [TableFusions:42]TF_Libellé:3)
				If ($ii>0)
					If (va_LibEnum=[TableFusions:42]TF_Libellé:3)
						$vb_OK:=True:C214
					Else 
						ALERT:C41("Ce libellé < "+[TableFusions:42]TF_Libellé:3+" > existe déjà !")
					End if 
				Else 
					$vb_OK:=True:C214
				End if 
			End if 
			$vb_OK:=$vb_OK & ([TableFusions:42]TF_Diviseur:7>0)
			If ($vb_OK)
				OBJECT SET ENABLED:C1123(b_ValTF; True:C214)
			End if 
		End if 
End case 

