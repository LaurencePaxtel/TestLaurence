//Script b_SLitsSHG
i_Message("recherche en cours …")
READ ONLY:C145([HeBerge:4])
READ ONLY:C145([HeberGement:5])
READ ONLY:C145([RenseiGnements:20])
CREATE EMPTY SET:C140([HeBerge:4]; "E_ToutHB")
CREATE EMPTY SET:C140([HeBerge:4]; "E_SelHB")
CREATE EMPTY SET:C140([HeBerge:4]; "E_DelHB")
CREATE EMPTY SET:C140([HeBerge:4]; "E_SelHBr")
CREATE EMPTY SET:C140([HeBerge:4]; "E_DelHBr")
CREATE EMPTY SET:C140([HeBerge:4]; "E_Del")
ALL RECORDS:C47([HeBerge:4])
MultiSoc_Filter(->[HeBerge:4])
CREATE SET:C116([HeBerge:4]; "E_ToutHB")

ALL RECORDS:C47([HeberGement:5])
MultiSoc_Filter(->[HeberGement:5])
RELATE ONE SELECTION:C349([HeberGement:5]; [HeBerge:4])
MultiSoc_Filter(->[HeBerge:4])
CREATE SET:C116([HeBerge:4]; "E_SelHB")
DIFFERENCE:C122("E_ToutHB"; "E_SelHB"; "E_DelHB")


ALL RECORDS:C47([RenseiGnements:20])
MultiSoc_Filter(->[RenseiGnements:20])
RELATE ONE SELECTION:C349([RenseiGnements:20]; [HeBerge:4])
CREATE SET:C116([HeBerge:4]; "E_SelHBr")
DIFFERENCE:C122("E_ToutHB"; "E_SelHBr"; "E_DelHBr")

INTERSECTION:C121("E_DelHB"; "E_DelHBr"; "E_Del")
CLOSE WINDOW:C154
If (Records in set:C195("E_Del")>0)
	CONFIRM:C162("Il y a "+String:C10(Records in set:C195("E_Del"))+" Clé(s) sans fiche d'hébergement ni de prestation."+Char:C90(13)+"Confirmez-vous la suppression ?")
	If (OK=1)
		i_Message("Suppression en cours …")
		READ WRITE:C146([HeBerge:4])
		USE SET:C118("E_Del")
		DELETE SELECTION:C66([HeBerge:4])
		READ ONLY:C145([HeBerge:4])
		CLOSE WINDOW:C154
	End if 
End if 
CLEAR SET:C117("E_ToutHB")
CLEAR SET:C117("E_SelHB")
CLEAR SET:C117("E_DelHB")
CLEAR SET:C117("E_SelHBr")
CLEAR SET:C117("E_DelHBr")
CLEAR SET:C117("E_Del")


