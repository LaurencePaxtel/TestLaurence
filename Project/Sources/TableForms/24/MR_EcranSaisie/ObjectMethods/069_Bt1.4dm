
//_o_CREATE SUBRECORD([Maraude]MR_RéférentList)
//


Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		ARRAY LONGINT:C221($rL_Selection; 0)
		LONGINT ARRAY FROM SELECTION:C647([Maraude_MR_ReferentList:60]; $rL_Selection)
		
		CREATE RECORD:C68([Maraude_MR_ReferentList:60])
		[Maraude_MR_ReferentList:60]Ref_Maraude:10:=[Maraude:24]ID:91
		SAVE RECORD:C53([Maraude_MR_ReferentList:60])
		
		APPEND TO ARRAY:C911($rL_Selection; Record number:C243([Maraude_MR_ReferentList:60]))
		CREATE SELECTION FROM ARRAY:C640([Maraude_MR_ReferentList:60]; $rL_Selection)
		
		LAST RECORD:C200([Maraude_MR_ReferentList:60])
		EDIT ITEM:C870([Maraude_MR_ReferentList:60]Catégorie:1)
		
		
End case 