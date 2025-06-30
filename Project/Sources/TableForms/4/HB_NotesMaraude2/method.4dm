$vl_eventFF:=Form event code:C388
Case of 
	: ($vl_eventFF=Sur chargement:K2:1)
		vPos1:=0
		vPos2:=0
		vPos2:=Length:C16([HeBerge:4]HB_Maraude:41)+1
		HIGHLIGHT TEXT:C210([HeBerge:4]HB_Maraude:41; vPos2; vPos2)
		//ALERTE(Chaine(Longueur([HéBergé]HB_Maraude)))
		If (Length:C16([HeBerge:4]HB_Maraude:41)>32000)
			ALERT:C41("La note 1 est pleine, utilisez la note 2 !")
			FORM GOTO PAGE:C247(2)
			ta_PageNote:=2
		End if 
		
	: ($vl_eventFF=Sur appel extérieur:K2:11)
		CANCEL:C270
End case 
