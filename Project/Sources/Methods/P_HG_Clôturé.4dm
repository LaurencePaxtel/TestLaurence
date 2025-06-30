//%attributes = {}

If ([HeberGement:5]HG_Cloturée:67=True:C214)
	If ([HeberGement:5]HG_LC_ID:61<=0)
	Else 
		OBJECT SET ENTERABLE:C238([HeberGement:5]HG_CentreNom:62; False:C215)
		OBJECT SET ENTERABLE:C238([HeberGement:5]HG_CentreARR:63; False:C215)
	End if 
End if 