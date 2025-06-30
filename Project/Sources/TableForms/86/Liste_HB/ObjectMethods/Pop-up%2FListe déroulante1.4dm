If (Form event code:C388=Sur clic:K2:4)
	
	If (Size of array:C274(ta_PlageEnCours)>0)
		If (ta_PlageEnCours>0)
		Else 
			If (Find in array:C230(ta_PlageEnCours; ta_PlageEnCours{0})>0)
				ta_PlageEnCours:=Find in array:C230(ta_PlageEnCours; ta_PlageEnCours{0})
			Else 
				ta_PlageEnCours:=1
			End if 
		End if 
		ta_PlageEnCours{0}:=ta_PlageEnCours{ta_PlageEnCours}
		Case of 
			: (ta_PlageEnCours=1)  //"Aujourd'hui"
				ve_Date_Cas:=0
			: (ta_PlageEnCours=2)  //Semaine en cours"
				ve_Date_Cas:=1
			: (ta_PlageEnCours=3)  //Quinzaine en cours"
				ve_Date_Cas:=2
			: (ta_PlageEnCours=4)  //"Mois en cours"
				ve_Date_Cas:=4
			: (ta_PlageEnCours=5)  //"Trimestre en cours"
				ve_Date_Cas:=13
			: (ta_PlageEnCours=6)  //"Semestre en cours"
				ve_Date_Cas:=16
			: (ta_PlageEnCours=7)  //"Année en cours"
				ve_Date_Cas:=12
		End case 
	Else 
		ve_Date_Cas:=0
	End if 
	
	If (F_PlageEnCours(ve_Date_Cas; 0; ->txt_filtre_date1; ->txt_filtre_date2))
		//FAC_Get_Records 
	End if 
End if 