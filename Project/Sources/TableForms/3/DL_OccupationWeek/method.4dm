If (Form event code:C388=Sur chargement:K2:1)
	
	vl_Rafraichir:=1
	P_OccupationRafraichir(->vl_Rafraichir)
	vd_Date1:=Current date:C33
	//vd_Date2
	P_SemaineDate(1; Current date:C33; ->vd_Date1; ->vd_Date2)
	
	OBJECT SET VISIBLE:C603(b_DétailPlus; False:C215)
	
End if 