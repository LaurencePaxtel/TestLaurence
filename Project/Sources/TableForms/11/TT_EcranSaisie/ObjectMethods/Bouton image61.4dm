// Method [TypesTables].TT_EcranSaisie.Bouton image61  
// 

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		// test evenement formulaire ajoute 15/2/17
		
		LOAD RECORD:C52([TAbles:12])
		If ([TAbles:12]TB_RéférenceID:1>0)
			Case of 
				: ([TAbles:12]TB_Niveau:3=[TypesTables:11]TT_NbNiveaux:2)
					CONFIRM:C162("Supprimer la fiche : "+Substring:C12([TAbles:12]TB_Libellé:6; 1; 15)+"…"+Char:C90(13)+"Etes-vous certain ?")
					If (OK=1)
						DELETE RECORD:C58([TAbles:12])
						TableEnum_Lister
					End if 
				: ([TAbles:12]TB_Niveau:3<[TypesTables:11]TT_NbNiveaux:2)
					CONFIRM:C162("Supprimer la fiche : "+Substring:C12([TAbles:12]TB_Libellé:6; 1; 15)+"…"+" entraine la suppression des sous thèmes !"+Char:C90(13)+"Etes-vous certain ?")
					If (OK=1)
						Ve_TypeTab:=[TypesTables:11]TT_NbNiveaux:2
						vl_TT_ID:=[TypesTables:11]TT_RéférenceID:1
						Ve_Niveau:=[TAbles:12]TB_Niveau:3
						Va_TBTTNiv:=[TAbles:12]TB_TT_Niveau:4
						Va_TBCode:=[TAbles:12]TB_Code:5
						TableEnum_Sup(Ve_TypeTab; ->vl_TT_ID; ->Ve_Niveau; ->Va_TBTTNiv; ->Va_TBCode)
						QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_Niveau:4=Va_TBTTNiv)
						MultiSoc_Filter(->[TAbles:12])
						DELETE RECORD:C58([TAbles:12])
						TableEnum_Lister
					End if 
			End case 
			
		Else 
			StrAlerte(22; "")
		End if 
		
End case 