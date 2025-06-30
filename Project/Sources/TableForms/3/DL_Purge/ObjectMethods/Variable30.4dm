//Script b_SHGDT

If (vd_DtDébTr>!00-00-00!)
	i_Message("Recherche en cours …")
	If (vd_DtFinTr<=vd_DtDébTr)
		QUERY:C277([Messagerie:34]; [Messagerie:34]MS_Date:2=vd_DtDébTr)
		MultiSoc_Filter(->[Messagerie:34])
	End if 
	If (vd_DtFintr>vd_DtDébTr)
		QUERY:C277([Messagerie:34]; [Messagerie:34]MS_Date:2>=vd_DtDébTr; *)
		QUERY:C277([Messagerie:34];  & [Messagerie:34]MS_Date:2<=vd_DtFintr)
		MultiSoc_Filter(->[Messagerie:34])
	End if 
	CLOSE WINDOW:C154
	If (Records in selection:C76([Messagerie:34])>0)
		CONFIRM:C162("Il y a "+String:C10(Records in selection:C76([Messagerie:34]))+" messages transmis."+Char:C90(13)+"Confirmez-vous la suppression ?")
		If (OK=1)
			i_Message("Suppression en cours …")
			READ WRITE:C146([Messagerie:34])
			DELETE SELECTION:C66([Messagerie:34])
			READ ONLY:C145([Messagerie:34])
			CLOSE WINDOW:C154
		End if 
	Else 
		ALERT:C41("Aucune fiche trouvée !")
	End if 
Else 
	ALERT:C41("Vous devez saisir une date !")
End if 