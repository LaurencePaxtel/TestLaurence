//Formule Format : ListeInclueCorrection
If (Form event code:C388=Sur affichage corps:K2:22)
	va_NomClé:=Uut_HébergéClé(->[HeberGement:5]HG_Nom:21; ->[HeberGement:5]HG_Prénom:22; ->[HeberGement:5]HG_DateNéLe:24)
	va_Item:=tp_ItemRub{ta_ItemRub}->
	If (ta_ItemRub2=Size of array:C274(ta_ItemRub2))
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[HeberGement:5]HG_LC_ID:61)
		MultiSoc_Filter(->[LesCentres:9])
		va_Item2:=[LesCentres:9]LC_Nom:4
	Else 
		va_Item2:=tp_ItemRub2{ta_ItemRub2}->
	End if 
End if 