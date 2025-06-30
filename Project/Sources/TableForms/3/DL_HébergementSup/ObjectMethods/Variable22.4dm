//Script b_S1HG
va_LaCleDelafiche:=""
If (va_MPmot1>"")
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3=va_MPmot1)
	MultiSoc_Filter(->[HeberGement:5])
	If (Records in selection:C76([HeberGement:5])=1)
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
		MultiSoc_Filter(->[HeBerge:4])
		va_LaCleDelafiche:=[HeBerge:4]HB_Clé:2
		If ([HeberGement:5]HG_Cloturée:67)
			OBJECT SET ENABLED:C1123(b_Val; False:C215)
			ALERT:C41("La fiche n° : "+va_MPmot1+"  est clôturée et ne peut pas être supprimée !")
		Else 
			OBJECT SET ENABLED:C1123(b_Val; True:C214)
		End if 
	Else 
		
		OBJECT SET ENABLED:C1123(b_Val; False:C215)
		ALERT:C41("La fiche n° : "+va_MPmot1+"  n'existe pas !")
	End if 
Else 
	OBJECT SET ENABLED:C1123(b_Val; False:C215)
End if 