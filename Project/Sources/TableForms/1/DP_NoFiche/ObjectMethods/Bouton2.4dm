If (Form event code:C388=Sur clic:K2:4)
	$vb_OK:=False:C215
	$vd_Date:=Current date:C33
	va_Valeur:=""
	va_Valeur:=Request:C163("Veuillez saisir le mot de passe !"; ""; "Enregistrer"; "Quitter")
	If (OK=1)
		va_Valeur:=Replace string:C233(va_Valeur; Char:C90(Character code:C91("@")); "")
		// $vb_OK:=i_PasseChiffre (1;->va_Valeur)
		$vb_OK:=(Substring:C12(va_Valeur; 1; 4)=String:C10(Year of:C25($vd_Date); "0000"))
		$vb_OK:=($vb_OK & (Substring:C12(va_Valeur; 5; 2)=String:C10(Month of:C24($vd_Date); "00")))
		$vb_OK:=($vb_OK & (Substring:C12(va_Valeur; 7; 2)=String:C10(Day of:C23($vd_Date); "00")))
		$vb_OK:=($vb_OK & (Substring:C12(va_Valeur; 9; 2)="11"))
		
		If ($vb_OK)
			OBJECT SET VISIBLE:C603(b_Passe; False:C215)
			OBJECT SET ENABLED:C1123(b_Add; True:C214)
			OBJECT SET ENABLED:C1123(b_Mod; True:C214)
			OBJECT SET ENABLED:C1123(b_Sup; True:C214)
			Case of 
				: (ta_Champs=Size of array:C274(ta_Champs))
					OBJECT SET ENTERABLE:C238(va_Libellé; False:C215)
					OBJECT SET ENTERABLE:C238(vl_Numéro; False:C215)
				: (ta_ChampsCode{ta_Champs}="T")
					OBJECT SET ENTERABLE:C238(va_Libellé; False:C215)
					OBJECT SET ENTERABLE:C238(vl_Numéro; True:C214)
				Else 
					OBJECT SET ENTERABLE:C238(va_Libellé; True:C214)
					OBJECT SET ENTERABLE:C238(vl_Numéro; True:C214)
			End case 
			vb_Passe:=True:C214
		End if 
	End if 
End if 