Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		
		If (vb_MRferme=False:C215)
			
			va_LibelléMRs:=""
			
			Tab_PopIn1("Suivi médical"; -><>ta_MRsm; ->va_LibelléMRs)
			
			If (va_LibelléMRs>"")
				
				// Migration
				// _o_CREATE SUBRECORD([Maraude]MR_SuiviMédicalList)
				
				C_POINTER:C301($P_SubTable)
				$P_SubTable:=->[Maraude_MR_SuiviMedicalList:61]
				
				ARRAY LONGINT:C221($rL_Selection; 0)
				LONGINT ARRAY FROM SELECTION:C647($P_SubTable->; $rL_Selection)
				
				
				CREATE RECORD:C68($P_SubTable->)
				[Maraude_MR_SuiviMedicalList:61]Ref_Maraude:5:=[Maraude:24]ID:91
				[Maraude_MR_SuiviMedicalList:61]Catégorie:1:=va_LibelléMRs
				[Maraude_MR_SuiviMedicalList:61]Commentaire:2:=""
				SAVE RECORD:C53($P_SubTable->)
				
				APPEND TO ARRAY:C911($rL_Selection; Record number:C243($P_SubTable->))
				CREATE SELECTION FROM ARRAY:C640($P_SubTable->; $rL_Selection)
				
				va_LibelléMRs:=""
				
				LAST RECORD:C200($P_SubTable->)
				EDIT ITEM:C870([Maraude_MR_SuiviMedicalList:61]Commentaire:2)
			End if 
			
		End if 
		
		
End case 
