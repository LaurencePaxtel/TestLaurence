//Script b_DupTT

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		// test evenement formulaire ajoute 15/2/17
		
		
		If (Records in set:C195("UserSet")=1)
			CREATE SET:C116([TypesTables:11]; "E_Crr")
			USE SET:C118("Userset")
			$kk:=[TypesTables:11]TT_NbNiveaux:2
			TableEnum_Lister
			If (<>Vl_TB_NbFic>0)
				SELECTION TO ARRAY:C260([TAbles:12]TB_RéférenceID:1; tl_TBd_Id; [TAbles:12]TB_TT_ID:2; tl_TBd_LienId; [TAbles:12]TB_Niveau:3; tl_TBd_Niveau; [TAbles:12]TB_TT_Niveau:4; ta_TBd_Niveau; [TAbles:12]TB_Code:5; ta_TBd_Code; [TAbles:12]TB_Libellé:6; ta_TBd_Libellé; [TAbles:12]TB_Texte:7; tt_TBd_Texte; [TAbles:12]TB_Ordre:8; te_TBd_Ordre)
				va_NewEnDup:=""
				va_NewEnDup:=Request:C163("Intitulé de la nouvelle énumération ?"; "")
				If (OK=1) & (va_NewEnDup>"")
					QUERY:C277([TypesTables:11]; [TypesTables:11]TT_Libellé:4=va_NewEnDup)
					If (Records in selection:C76([TypesTables:11])>=1)
						ALERT:C41("Cette énumération '"+va_NewEnDup+"' existe déja !")
					Else 
						If (i_Confirmer("Création de l'énumération : '"+va_NewEnDup+"' et des "+String:C10(<>Vl_TB_NbFic)+" item(s)."))
							
							$ij:=0
							$ij:=Uut_NumerotePlus(->[TAbles:12]; <>Vl_TB_NbFic)
							// LECTURE ECRITURE([TypesTables])
							CREATE RECORD:C68([TypesTables:11])
							[TypesTables:11]TT_RéférenceID:1:=Uut_Numerote(->[TypesTables:11])
							[TypesTables:11]TT_NbNiveaux:2:=$kk
							[TypesTables:11]TT_Ordre:3:=0
							[TypesTables:11]TT_Libellé:4:=va_NewEnDup
							SAVE RECORD:C53([TypesTables:11])
							For ($ii; 1; Size of array:C274(tl_TBd_LienId))
								tl_TBd_Id{$ii}:=$ij
								tl_TBd_LienId{$ii}:=[TypesTables:11]TT_RéférenceID:1
								//tl_TBd_Niveau{$ii}:=1
								ta_TBd_Niveau{$ii}:=String:C10(tl_TBd_LienId{$ii}; "000")+Substring:C12(ta_TBd_Niveau{$ii}; 4)
								ta_TBd_Code{$ii}:=String:C10(tl_TBd_LienId{$ii}; "000")+Substring:C12(ta_TBd_Code{$ii}; 4)
								//ta_TBd_Libellé{$ii}:=
								//tt_TBd_Texte{$ii}:=
								//  te_TBd_Ordre{$ii}:=
								$ij:=$ij+1
							End for 
							ADD TO SET:C119([TypesTables:11]; "E_Crr")
							UNLOAD RECORD:C212([TypesTables:11])
							// LECTURE SEULEMENT([TypesTables])
							//LECTURE ECRITURE([TAbles])
							For ($ii; 1; Size of array:C274(tl_TBd_LienId))
								CREATE RECORD:C68([TAbles:12])
								MultiSoc_Init_Structure(->[TAbles:12])
								[TAbles:12]TB_RéférenceID:1:=tl_TBd_Id{$ii}
								[TAbles:12]TB_TT_ID:2:=tl_TBd_LienId{$ii}
								[TAbles:12]TB_Niveau:3:=tl_TBd_Niveau{$ii}
								[TAbles:12]TB_TT_Niveau:4:=ta_TBd_Niveau{$ii}
								[TAbles:12]TB_Code:5:=ta_TBd_Code{$ii}
								[TAbles:12]TB_Libellé:6:=ta_TBd_Libellé{$ii}
								[TAbles:12]TB_Texte:7:=tt_TBd_Texte{$ii}
								[TAbles:12]TB_Ordre:8:=te_TBd_Ordre{$ii}
								SAVE RECORD:C53([TAbles:12])
								UNLOAD RECORD:C212([TAbles:12])
							End for 
							// LECTURE SEULEMENT([TAbles])
							
						End if 
					End if 
				End if 
			End if 
			
			USE SET:C118("E_Crr")
			CLEAR SET:C117("E_Crr")
			ORDER BY:C49([TypesTables:11]; [TypesTables:11]TT_Libellé:4; >)
		End if 
		
		
End case 

