// Method [TypesTables].TT_EcranSaisie.Bouton image59  
// 
Case of 
	: (Form event code:C388=Sur clic:K2:4)
		// test evenement formulaire ajoute 15/2/17
		
		If (Is new record:C668([TypesTables:11]))
			MultiSoc_Init_Structure(->[TypesTables:11])
			SAVE RECORD:C53([TypesTables:11])
		End if 
		
		FORM SET INPUT:C55([TAbles:12]; "TA_EcranSaisie")
		
		If (<>Vl_TB_NbFic=0)
			
			Ve_TypeTab:=1
			vl_TT_ID:=[TypesTables:11]TT_RéférenceID:1
			Ve_Niveau:=1
			Va_TBTTNiv:=String:C10(vl_TT_ID; "000")+"/"+String:C10(Ve_Niveau; "0")+"/"+"001"+"/"+"000"+"/"+"000"+"/"+"000"
			Va_TBCode:=String:C10(vl_TT_ID; "000")+"/"+"001"+"/"+"000"+"/"+"000"+"/"+"000"
			ADD RECORD:C56([TAbles:12]; *)
			TableEnum_Lister
			
		Else 
			
			LOAD RECORD:C52([TAbles:12])
			If ([TAbles:12]TB_RéférenceID:1>0)
				Ve_TypeTab:=2
				vl_TT_ID:=[TypesTables:11]TT_RéférenceID:1
				Ve_Niveau:=[TAbles:12]TB_Niveau:3
				Va_TBTTNiv:=[TAbles:12]TB_TT_Niveau:4
				Va_TBCode:=[TAbles:12]TB_Code:5
				TableEnum_New(Ve_TypeTab; ->vl_TT_ID; ->Ve_Niveau; ->Va_TBTTNiv; ->Va_TBCode)
				ADD RECORD:C56([TAbles:12]; *)
				TableEnum_Lister
			Else 
				StrAlerte(22; "")
			End if 
		End if 
		
End case 


