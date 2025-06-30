//%attributes = {}
C_DATE:C307($0)

QUERY:C277([HeberGement:5]; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin)
MultiSoc_Filter(->[HeberGement:5])

If (Records in selection:C76([HeberGement:5])>0)
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
	
	$0:=[HeberGement:5]HG_Date:4
End if 
