


If (Form event code:C388=Sur affichage corps:K2:22)
	
	If ([HeBerge:4]HB_ReferenceID:1>0)
		
		vl_NbHGi:=0  // #20180421-1
		
		SET QUERY DESTINATION:C396(Vers variable:K19:4; vl_NbHGi)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
		vL_Nb_HG_F:=vl_NbHGi
		SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
		ve_NbSP:=Num:C11([HeBerge:4]HB_Status:18)
		vl_NbSii:=F_SiaoEnCours([HeBerge:4]HB_ReferenceID:1)
		
	Else 
		vL_Nb_HG_F:=0
		vl_NbHGi:=0
		vl_NbSii:=0
	End if 
End if 