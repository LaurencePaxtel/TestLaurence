If (Form event code:C388=Sur affichage corps:K2:22)
	
	vl_NbHGi:=0  // #20180421-1
	
	SET QUERY DESTINATION:C396(Vers variable:K19:4; vl_NbHGi)
	QUERY:C277([RenseiGnements:20]; [RenseiGnements:20]RG_HB_ID:2=[HeBerge:4]HB_ReferenceID:1)
	SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
	ve_NbSP:=Num:C11([HeBerge:4]HB_Status:18)
End if 