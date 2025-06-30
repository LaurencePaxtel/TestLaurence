// Method [TypesTables].TT_EcranSaisie.Bouton image3  
// 
Case of 
	: (Form event code:C388=Sur clic:K2:4)
		// test evenement formulaire ajoute 15/2/17
		
		FORM SET INPUT:C55([TAbles:12]; "TA_EcranSaisie")
		If (<>Vl_TB_NbFic=0)
			ALERT:C41("Vous devez utiliser le bouton '+1' !")
		Else 
			LOAD RECORD:C52([TAbles:12])
			If ([TAbles:12]TB_RéférenceID:1>0)
				If (([TAbles:12]TB_Niveau:3+1)>[TypesTables:11]TT_NbNiveaux:2)
					ALERT:C41("Le nombre de niveaux est limité à "+String:C10([TAbles:12]TB_Niveau:3)+" !")
				Else 
					Ve_TypeTab:=3
					vl_TT_ID:=[TypesTables:11]TT_RéférenceID:1
					Ve_Niveau:=[TAbles:12]TB_Niveau:3
					Va_TBTTNiv:=[TAbles:12]TB_TT_Niveau:4
					Va_TBCode:=[TAbles:12]TB_Code:5
					TableEnum_New(Ve_TypeTab; ->vl_TT_ID; ->Ve_Niveau; ->Va_TBTTNiv; ->Va_TBCode)
					ADD RECORD:C56([TAbles:12]; *)
					TableEnum_Lister
				End if 
			Else 
				StrAlerte(22; "")
			End if 
		End if 
		
End case 