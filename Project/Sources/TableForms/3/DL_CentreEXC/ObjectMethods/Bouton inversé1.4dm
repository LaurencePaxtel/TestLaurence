If (Form event code:C388=Sur clic:K2:4)
	If ((Macintosh control down:C544) | (Windows Ctrl down:C562))
		SORT ARRAY:C229(ta_CCE_Nom; te_CCE_Check; tb_CCE_Check; tl_CCE_Réf; ta_CCE_Lieu; ta_CCE_Ville; <)
	Else 
		SORT ARRAY:C229(ta_CCE_Nom; te_CCE_Check; tb_CCE_Check; tl_CCE_Réf; ta_CCE_Lieu; ta_CCE_Ville; >)
	End if 
End if 
