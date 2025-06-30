$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		vb_Passe:=False:C215
		OBJECT SET ENTERABLE:C238(va_Libellé; False:C215)
		OBJECT SET ENTERABLE:C238(vl_Numéro; False:C215)
		ta_Champs:=3
		//Table(Table(tp_Champs{ta_Champs}))->
		QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=Table name:C256((Table:C252(Table:C252(tp_Champs{ta_Champs})))))
		ORDER BY:C49([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2; >)
		vL_Nb_HG_F:=Records in selection:C76([ReferenceUnique:2])
		ta_Champs{0}:=ta_Champs{ta_Champs}
		
		va_Libellé:=""
		vl_Numéro:=0
		va_LibelléValeur:=""
		vl_Nombre:=0
		vl_NombrePG:=0
		
		
		va_LibelléClé:=""
		va_LibelléClé2:=""
		
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		If (User in group:C338(Current user:C182; <>Groupe_DEVELOP))
			OBJECT SET VISIBLE:C603(b_Passe; False:C215)
			vb_Passe:=True:C214
		Else 
			OBJECT SET VISIBLE:C603(b_Passe; True:C214)
			vb_Passe:=False:C215
			OBJECT SET ENABLED:C1123(b_Add; False:C215)
			OBJECT SET ENABLED:C1123(b_Mod; False:C215)
			OBJECT SET ENABLED:C1123(b_Sup; False:C215)
		End if 
	: ($vl_EventFF=Sur clic:K2:4)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		If ((vl_SourisX>7) & (vl_SourisX<446)) & ((vl_SourisY>57) & (vl_SourisY<343))
			If ([ReferenceUnique:2]RU_Fichier:2>"")
				
				va_Libellé:=[ReferenceUnique:2]RU_Fichier:2
				vl_Numéro:=[ReferenceUnique:2]RU_Numero:3
				va_LibelléValeur:=[ReferenceUnique:2]RU_ValeurApha:4
				vl_Nombre:=0
				vl_NombrePG:=0
				P_uNoFiche(""; ->vl_Numéro; ->vl_Nombre; ->vl_NombrePG)
				If (vb_Passe=False:C215)
					OBJECT SET ENTERABLE:C238(va_Libellé; False:C215)
					OBJECT SET ENTERABLE:C238(vl_Numéro; False:C215)
					ta_Champs:=3
				End if 
			Else 
				va_Libellé:=""
				vl_Numéro:=0
				va_LibelléValeur:=""
				vl_NombrePG:=0
				vl_Nombre:=0
			End if 
		End if 
End case 
