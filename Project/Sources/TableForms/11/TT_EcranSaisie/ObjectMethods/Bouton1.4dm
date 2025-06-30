var $kk; $ii : Integer

CONFIRM:C162("Trier la liste par ordre alphabétique…"+Char:C90(13)+"Etes-vous certain ?")

If (OK=1)
	
	If (Macintosh control down:C544) | (Windows Ctrl down:C562)
		ve_Tri1:=2
	Else 
		ve_Tri1:=1
	End if 
	
	If ([TypesTables:11]TT_NbNiveaux:2>1)
		QUERY SELECTION:C341([TAbles:12]; [TAbles:12]TB_Niveau:3=1)
	End if 
	
	If (Records in selection:C76([TAbles:12])>1)
		SELECTION TO ARRAY:C260([TAbles:12]TB_RéférenceID:1; tl_TBd_Id; [TAbles:12]TB_TT_ID:2; tl_TBd_LienId; [TAbles:12]TB_Niveau:3; tl_TBd_Niveau; [TAbles:12]TB_TT_Niveau:4; ta_TBd_Niveau; [TAbles:12]TB_Code:5; ta_TBd_Code; [TAbles:12]TB_Libellé:6; ta_TBd_Libellé; [TAbles:12]TB_Texte:7; tt_TBd_Texte; [TAbles:12]TB_Ordre:8; te_TBd_Ordre)
		SORT ARRAY:C229(ta_TBd_Libellé; tl_TBd_Id; tl_TBd_LienId; tl_TBd_Niveau; ta_TBd_Niveau; ta_TBd_Code; tt_TBd_Texte; te_TBd_Ordre)
		
		If ([TypesTables:11]TT_NbNiveaux:2<=1)
			
			For ($ii; 1; Size of array:C274(ta_TBd_Libellé))
				te_TBd_Ordre{$ii}:=$ii
				ta_TBd_Code{$ii}:=Substring:C12(ta_TBd_Code{$ii}; 1; 4)+String:C10($ii; "000")+Substring:C12(ta_TBd_Code{$ii}; 8)
				ta_TBd_Niveau{$ii}:=Substring:C12(ta_TBd_Niveau{$ii}; 1; 6)+String:C10($ii; "000")+Substring:C12(ta_TBd_Niveau{$ii}; 10)
			End for 
			
			For ($ii; 1; Size of array:C274(ta_TBd_Libellé))
				QUERY:C277([TAbles:12]; [TAbles:12]TB_RéférenceID:1=tl_TBd_Id{$ii})
				MultiSoc_Filter(->[TAbles:12])
				
				If (Records in selection:C76([TAbles:12])=1)
					
					If (i_NonVerrou(->[TAbles:12]))
						[TAbles:12]TB_Ordre:8:=te_TBd_Ordre{$ii}
						[TAbles:12]TB_Code:5:=ta_TBd_Code{$ii}
						[TAbles:12]TB_TT_Niveau:4:=ta_TBd_Niveau{$ii}
						SAVE RECORD:C53([TAbles:12])
						UNLOAD RECORD:C212([TAbles:12])
					End if 
					
				End if 
				
			End for 
			
			UNLOAD RECORD:C212([TAbles:12])
			TableEnum_Lister
		Else 
			
			If ([TypesTables:11]TT_NbNiveaux:2=2)
				UNLOAD RECORD:C212([TAbles:12])
				
				For ($ii; 1; Size of array:C274(ta_TBd_Libellé))
					te_TBd_Ordre{$ii}:=$ii
					ta_TBd_Code{$ii}:=Substring:C12(ta_TBd_Code{$ii}; 1; 4)+String:C10($ii; "000")+Substring:C12(ta_TBd_Code{$ii}; 8)
					
					If ([TypesTables:11]TT_NbNiveaux:2=2)
						QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_Niveau:4=(Substring:C12(ta_TBd_Niveau{$ii}; 1; 4)+"2/"+Substring:C12(ta_TBd_Niveau{$ii}; 7; 3)+"@"))
						MultiSoc_Filter(->[TAbles:12])
						
						If (Records in selection:C76([TAbles:12])>0)
							
							If (ve_Tri1=1)
								ORDER BY:C49([TAbles:12]; [TAbles:12]TB_Code:5; >)
							Else 
								ORDER BY:C49([TAbles:12]; [TAbles:12]TB_Libellé:6; >)
							End if 
							
							FIRST RECORD:C50([TAbles:12])
							
							Repeat 
								$kk:=$kk+1
								
								If (i_NonVerrou(->[TAbles:12]))
									[TAbles:12]TB_Code:5:=Substring:C12(ta_TBd_Niveau{$ii}; 1; 4)+String:C10($ii; "000")+"/"+String:C10($kk; "000")+"/000/000"
									SAVE RECORD:C53([TAbles:12])
									UNLOAD RECORD:C212([TAbles:12])
								End if 
								
								NEXT RECORD:C51([TAbles:12])
							Until (End selection:C36([TAbles:12]))
							
						End if 
						
					End if 
					
					ta_TBd_Niveau{$ii}:=Substring:C12(ta_TBd_Code{$ii}; 1; 4)+"1/"+Substring:C12(ta_TBd_Code{$ii}; 5)
				End for 
				
				For ($ii; 1; Size of array:C274(ta_TBd_Libellé))
					QUERY:C277([TAbles:12]; [TAbles:12]TB_RéférenceID:1=tl_TBd_Id{$ii})
					MultiSoc_Filter(->[TAbles:12])
					
					If (Records in selection:C76([TAbles:12])=1)
						
						If (i_NonVerrou(->[TAbles:12]))
							[TAbles:12]TB_Ordre:8:=te_TBd_Ordre{$ii}
							[TAbles:12]TB_Code:5:=ta_TBd_Code{$ii}
							[TAbles:12]TB_TT_Niveau:4:=ta_TBd_Niveau{$ii}
							SAVE RECORD:C53([TAbles:12])
							UNLOAD RECORD:C212([TAbles:12])
						End if 
						
					End if 
					
				End for 
				
				TableEnum_Lister
				FIRST RECORD:C50([TAbles:12])
				
				Repeat 
					
					If (i_NonVerrou(->[TAbles:12]))
						[TAbles:12]TB_TT_Niveau:4:=Substring:C12([TAbles:12]TB_Code:5; 1; 4)+String:C10([TAbles:12]TB_Niveau:3)+"/"+Substring:C12([TAbles:12]TB_Code:5; 5)
						SAVE RECORD:C53([TAbles:12])
						UNLOAD RECORD:C212([TAbles:12])
					End if 
					
					NEXT RECORD:C51([TAbles:12])
				Until (End selection:C36([TAbles:12]))
				
			End if 
			
		End if 
		
	End if 
	
	TableEnum_Lister
End if 