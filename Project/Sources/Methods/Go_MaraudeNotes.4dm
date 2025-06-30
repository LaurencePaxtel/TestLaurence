//%attributes = {}
ARRAY TEXT:C222(ta_PageNote; 2)
ta_PageNote{1}:="Note 1"
ta_PageNote{2}:="Note 2"

READ WRITE:C146([HeBerge:4])
// QUERY([HeBerge];[HeBerge]HB_ReferenceID=[Maraude]MR_HB_ID)
RELATE ONE:C42([Maraude:24]MR_HB_ID:10)
If (Records in selection:C76([HeBerge:4])=1)
	If (i_NonVerrou(->[HeBerge:4]))
		
		
		// Modified by: Kevin HASSAL (11-12-2018)
		// Privilèges : Notes maraude modifié
		
		$vb_OK:=(<>vb_T_NoteNonModifiables=False:C215)
		$vb_OK:=$vb_OK | (User in group:C338(Current user:C182; "Notes modife"))
		
		If (($vb_OK) & (User in group:C338(Current user:C182; <>Groupe_NotesMARModife)))
			FORM SET INPUT:C55([HeBerge:4]; "HB_NotesMaraude2")
		Else 
			FORM SET INPUT:C55([HeBerge:4]; "HB_NotesMaraude2F")
		End if 
		
		
		C_LONGINT:C283($vl_Fenetre)
		$vl_Fenetre:=i_FenêtreNo(492; 552; 4; "Notes Maraude du demandeur"; 3; "Quit_HBNotesMR")
		MODIFY RECORD:C57([HeBerge:4]; *)
		UNLOAD RECORD:C212([HeBerge:4])
		CLOSE WINDOW:C154($vl_Fenetre)
	End if 
End if 
READ ONLY:C145([HeBerge:4])