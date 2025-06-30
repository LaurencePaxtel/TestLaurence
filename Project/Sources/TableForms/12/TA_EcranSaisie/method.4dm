Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If (Is new record:C668([TAbles:12]))
			MultiSoc_Init_Structure(->[TAbles:12])
			
			If ([TAbles:12]TB_RéférenceID:1=0)
				[TAbles:12]TB_RéférenceID:1:=Uut_Numerote(->[TAbles:12])
			End if 
			
			[TAbles:12]TB_TT_ID:2:=vl_TT_ID
			[TAbles:12]TB_Niveau:3:=Ve_Niveau
			[TAbles:12]TB_TT_Niveau:4:=Va_TBTTNiv
			[TAbles:12]TB_Code:5:=Va_TBCode
		End if 
		
		If ([TAbles:12]TB_TT_ID:2=8)
			OBJECT SET VISIBLE:C603(*; "EtCV_@"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "EtCV_@"; False:C215)
		End if 
		
		// Modifié par : Scanu Rémy (19/12/2023)
		// Ajout Champ & Listbox pour sélection de l'ID chez MyaSquad
		Form:C1466.MyASquadEnumeration:=New collection:C1472
End case 