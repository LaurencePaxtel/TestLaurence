//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_FaxExpDispo
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

vd_DtJF:=Current date:C33
vh_HrJF:=Current time:C178
vi_Signatur:=vi_Vide
_O_PAGE SETUP:C299([HeberGement:5]; "HG_PrtFaxDListe")
PRINT SETTINGS:C106
If (OK=1)
	
	C_LONGINT:C283($Pos)
	
	QUERY:C277([INtervenants:10]; [INtervenants:10]IN_RéférenceID:1=<>vl_UserRéfU)
	
	If (Records in selection:C76([INtervenants:10])=1)
		vi_Signatur:=[INtervenants:10]IN_Signature:9
	End if 
	C_LONGINT:C283($ii)
	For ($ii; 1; Size of array:C274(ta_CTNom))
		If (tl_CTSél{$ii}=1)
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=tl_CTRéf{$ii})
			If (Records in selection:C76([LesCentres:9])=1)
				va_LC_Nom:=[LesCentres:9]LC_Nom:4
				va_LC_Ad1:=[LesCentres:9]LC_Adr1:24
				va_LC_Ad2:=[LesCentres:9]LC_Adr2:25
				va_LC_CP:=[LesCentres:9]LC_CP:27
				va_LC_Ville:=[LesCentres:9]LC_Ville:28
				va_LC_Fax1:=[LesCentres:9]LC_Télécopie1:30
				va_LC_Tel:=[LesCentres:9]LC_Téléphone:29
				va_LC_Fax:=[LesCentres:9]LC_Télécopie2:31
				va_LC_Pers:=[LesCentres:9]LC_Responsable:32
				READ ONLY:C145([DePart:1])
				QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-1)
				If (Records in selection:C76([DePart:1])=1)
					vt_Texte:=[DePart:1]DP_Texte:7
				Else 
					vt_Texte:=""
				End if 
				QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-13)
				If (Records in selection:C76([DePart:1])=1)
					vt_TexteH:=[DePart:1]DP_Texte:7
				Else 
					vt_TexteH:=""
				End if 
				ARRAY LONGINT:C221(tl_EDisID; 0)
				ARRAY TEXT:C222(tl_EDisFam; 0)
				ARRAY LONGINT:C221(tl_EDisNbP; 0)
				ARRAY BOOLEAN:C223(tb_EDisChéf; 0)
				ARRAY TEXT:C222(ta_EDisNom; 0)
				ARRAY TEXT:C222(ta_EDisPré; 0)
				ARRAY DATE:C224(td_EDisNé; 0)
				ARRAY TEXT:C222(ta_EDisEtC; 0)
				ARRAY INTEGER:C220(te_EDisRest; 0)
				
				ARRAY TEXT:C222(ta_xfaxDis; 0)
				
				ARRAY LONGINT:C221(tl_xfaxDisT; 0)
				ARRAY LONGINT:C221(te_xfaxDis; 0; 0)
				
				$vb_OK:=False:C215
				USE SET:C118("E_Hébergé")
				QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_LC_ID:61=tl_CTRéf{$ii})
				If (Records in selection:C76([HeberGement:5])>0)
					
					CREATE SET:C116([HeberGement:5]; "E_HGCT")
					USE SET:C118("E_HGCT")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_FamChef:103=True:C214)
					
					If (Records in selection:C76([HeberGement:5])>0)
						$vb_OK:=True:C214
						ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
						ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >)
						SELECTION TO ARRAY:C260([HeberGement:5]HG_HB_ID:19; tl_EDisID; [HeberGement:5]HG_FamClé:104; tl_EDisFam; [HeberGement:5]HG_FamChef:103; tb_EDisChéf; [HeberGement:5]HG_Nom:21; ta_EDisNom; [HeberGement:5]HG_Prénom:22; ta_EDisPré; [HeberGement:5]HG_DateNéLe:24; td_EDisNé; [HeberGement:5]HG_EtatCivil:20; ta_EDisEtC; [HeberGement:5]HG_NuitReste:95; te_EDisRest)
						ARRAY LONGINT:C221(tl_EDisNbP; Size of array:C274(tl_EDisID))
						
						For ($oo; 1; Size of array:C274(tl_EDisID))
							USE SET:C118("E_HGCT")
							QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_FamClé:104=tl_EDisFam{$oo})
							If (Records in selection:C76([HeberGement:5])>0)
								FIRST RECORD:C50([HeberGement:5])
								Repeat 
									
									If ([HeberGement:5]HG_FamDistri1:112="Rien") | ([HeberGement:5]HG_FamDistri1:112="Annulé")
									Else 
										If ([HeberGement:5]HG_FamDistri1:112>"")
											$Pos:=Find in array:C230(ta_xfaxDis; [HeberGement:5]HG_FamDistri1:112)
											If ($Pos>0)
											Else 
												$Pos:=Size of array:C274(ta_xfaxDis)+1
												INSERT IN ARRAY:C227(ta_xfaxDis; $Pos)
												INSERT IN ARRAY:C227(te_xfaxDis; $Pos)
												INSERT IN ARRAY:C227(te_xfaxDis{$Pos}; 1; Size of array:C274(tl_EDisID))
												ta_xfaxDis{$Pos}:=[HeberGement:5]HG_FamDistri1:112
											End if 
										End if 
									End if 
									If ([HeberGement:5]HG_FamDistri2:113="Rien") | ([HeberGement:5]HG_FamDistri2:113="Annulé")
									Else 
										If ([HeberGement:5]HG_FamDistri2:113>"")
											$Pos:=Find in array:C230(ta_xfaxDis; [HeberGement:5]HG_FamDistri2:113)
											If ($Pos>0)
											Else 
												$Pos:=Size of array:C274(ta_xfaxDis)+1
												INSERT IN ARRAY:C227(ta_xfaxDis; $Pos)
												INSERT IN ARRAY:C227(te_xfaxDis; $Pos)
												INSERT IN ARRAY:C227(te_xfaxDis{$Pos}; 1; Size of array:C274(tl_EDisID))
												ta_xfaxDis{$Pos}:=[HeberGement:5]HG_FamDistri2:113
											End if 
										End if 
									End if 
									
									If ([HeberGement:5]HG_FamDistri3:114="Rien") | ([HeberGement:5]HG_FamDistri3:114="Annulé")
									Else 
										If ([HeberGement:5]HG_FamDistri3:114>"")
											$Pos:=Find in array:C230(ta_xfaxDis; [HeberGement:5]HG_FamDistri3:114)
											If ($Pos>0)
											Else 
												$Pos:=Size of array:C274(ta_xfaxDis)+1
												INSERT IN ARRAY:C227(ta_xfaxDis; $Pos)
												INSERT IN ARRAY:C227(te_xfaxDis; $Pos)
												INSERT IN ARRAY:C227(te_xfaxDis{$Pos}; 1; Size of array:C274(tl_EDisID))
												ta_xfaxDis{$Pos}:=[HeberGement:5]HG_FamDistri3:114
											End if 
										End if 
									End if 
									
									If ([HeberGement:5]HG_FamDistri4:115="Rien") | ([HeberGement:5]HG_FamDistri4:115="Annulé")
									Else 
										If ([HeberGement:5]HG_FamDistri4:115>"")
											$Pos:=Find in array:C230(ta_xfaxDis; [HeberGement:5]HG_FamDistri4:115)
											If ($Pos>0)
											Else 
												$Pos:=Size of array:C274(ta_xfaxDis)+1
												INSERT IN ARRAY:C227(ta_xfaxDis; $Pos)
												INSERT IN ARRAY:C227(te_xfaxDis; $Pos)
												INSERT IN ARRAY:C227(te_xfaxDis{$Pos}; 1; Size of array:C274(tl_EDisID))
												ta_xfaxDis{$Pos}:=[HeberGement:5]HG_FamDistri4:115
											End if 
										End if 
									End if 
									
									
									If ([HeberGement:5]HG_FamDistri5:116="Rien") | ([HeberGement:5]HG_FamDistri5:116="Annulé")
									Else 
										If ([HeberGement:5]HG_FamDistri5:116>"")
											$Pos:=Find in array:C230(ta_xfaxDis; [HeberGement:5]HG_FamDistri5:116)
											If ($Pos>0)
											Else 
												$Pos:=Size of array:C274(ta_xfaxDis)+1
												INSERT IN ARRAY:C227(ta_xfaxDis; $Pos)
												INSERT IN ARRAY:C227(te_xfaxDis; $Pos)
												INSERT IN ARRAY:C227(te_xfaxDis{$Pos}; 1; Size of array:C274(tl_EDisID))
												ta_xfaxDis{$Pos}:=[HeberGement:5]HG_FamDistri5:116
											End if 
										End if 
									End if 
									NEXT RECORD:C51([HeberGement:5])
								Until (End selection:C36([HeberGement:5]))
							End if 
						End for 
						
						
						For ($oo; 1; Size of array:C274(tl_EDisID))
							USE SET:C118("E_HGCT")
							QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_FamClé:104=tl_EDisFam{$oo})
							If (Records in selection:C76([HeberGement:5])>0)
								tl_EDisNbP{$oo}:=Records in selection:C76([HeberGement:5])
								FIRST RECORD:C50([HeberGement:5])
								SORT ARRAY:C229(ta_xfaxDis; >)
								Repeat 
									
									If ([HeberGement:5]HG_FamDistri1:112="Rien") | ([HeberGement:5]HG_FamDistri1:112="Annulé")
									Else 
										If ([HeberGement:5]HG_FamDistri1:112>"")
											$Pos:=Find in array:C230(ta_xfaxDis; [HeberGement:5]HG_FamDistri1:112)
											If ($Pos>0)
												te_xfaxDis{$Pos}{$oo}:=te_xfaxDis{$Pos}{$oo}+1
											End if 
										End if 
									End if 
									If ([HeberGement:5]HG_FamDistri2:113="Rien") | ([HeberGement:5]HG_FamDistri2:113="Annulé")
									Else 
										If ([HeberGement:5]HG_FamDistri2:113>"")
											$Pos:=Find in array:C230(ta_xfaxDis; [HeberGement:5]HG_FamDistri2:113)
											If ($Pos>0)
												te_xfaxDis{$Pos}{$oo}:=te_xfaxDis{$Pos}{$oo}+1
											End if 
										End if 
									End if 
									
									If ([HeberGement:5]HG_FamDistri3:114="Rien") | ([HeberGement:5]HG_FamDistri3:114="Annulé")
									Else 
										If ([HeberGement:5]HG_FamDistri3:114>"")
											$Pos:=Find in array:C230(ta_xfaxDis; [HeberGement:5]HG_FamDistri3:114)
											If ($Pos>0)
												te_xfaxDis{$Pos}{$oo}:=te_xfaxDis{$Pos}{$oo}+1
											End if 
										End if 
									End if 
									
									If ([HeberGement:5]HG_FamDistri4:115="Rien") | ([HeberGement:5]HG_FamDistri4:115="Annulé")
									Else 
										If ([HeberGement:5]HG_FamDistri4:115>"")
											$Pos:=Find in array:C230(ta_xfaxDis; [HeberGement:5]HG_FamDistri4:115)
											If ($Pos>0)
												te_xfaxDis{$Pos}{$oo}:=te_xfaxDis{$Pos}{$oo}+1
											End if 
										End if 
									End if 
									
									
									If ([HeberGement:5]HG_FamDistri5:116="Rien") | ([HeberGement:5]HG_FamDistri5:116="Annulé")
									Else 
										If ([HeberGement:5]HG_FamDistri5:116>"")
											$Pos:=Find in array:C230(ta_xfaxDis; [HeberGement:5]HG_FamDistri5:116)
											If ($Pos>0)
												te_xfaxDis{$Pos}{$oo}:=te_xfaxDis{$Pos}{$oo}+1
											End if 
										End if 
									End if 
									NEXT RECORD:C51([HeberGement:5])
								Until (End selection:C36([HeberGement:5]))
								
							End if   //  Si (Fiches trouvees([HéberGement])>0) [HéberGement]HG_FamClé=tl_EDisFam{$oo}
						End for   //  Boucle ($oo;1;Taille tableau(tl_EDisID))
					End if   //  Si (Fiches trouvees([HéberGement])>0) [HéberGement]HG_FamChef=Vrai
					If ($vb_OK)
						ARRAY LONGINT:C221(tl_xfaxDisT; Size of array:C274(ta_xfaxDis))
						For ($uu; 1; Size of array:C274(ta_xfaxDis))
							tl_xfaxDisT{$uu}:=0
							For ($ww; 1; Size of array:C274(tl_EDisID))
								tl_xfaxDisT{$uu}:=tl_xfaxDisT{$uu}+te_xfaxDis{$uu}{$ww}
							End for 
						End for 
						
						//  Taille tableau(tl_EDisID)
						//  Taille tableau(ta_xfaxDis)
						ALL RECORDS:C47([HeberGement:5])
						MultiSoc_Filter(->[HeberGement:5])
						REDUCE SELECTION:C351([HeberGement:5]; Size of array:C274(ta_xfaxDis))
						
						vl_Indice:=0
						vl_IndiceLg:=0
						vl_IndiceCl:=0
						vl_IndicePa:=0
						vl_Page:=0
						v_NoPage:=0
						
						v_NbPers:=Size of array:C274(tl_EDisID)
						vReste:=Mod:C98(v_NbPers; 8)
						vDivE:=v_NbPers\8
						Nb_Pages:=vDivE+Num:C11(vReste>0)
						
						vl_IndicePa:=8
						
						vl_Indice:=1
						For ($pp; 1; Nb_Pages)
							
							vl_Page:=$pp
							If (vl_Page>1)
								vl_Indice:=vl_Indice+vl_IndicePa
							End if 
							
							$pos:=vl_Indice
							va_Fam1:=ta_EDisNom{$pos}+<>va_CR+ta_EDisPré{$pos}+<>va_CR+tl_EDisFam{$pos}+"/"+String:C10(tl_EDisNbP{$pos})+"p/"+String:C10(te_EDisRest{$pos})+"j"
							
							$pos:=vl_Indice+1
							If ($pos<=v_NbPers)
								va_Fam2:=ta_EDisNom{$pos}+<>va_CR+ta_EDisPré{$pos}+<>va_CR+tl_EDisFam{$pos}+"/"+String:C10(tl_EDisNbP{$pos})+"p/"+String:C10(te_EDisRest{$pos})+"j"
							Else 
								va_Fam2:=""
							End if 
							$pos:=vl_Indice+2
							If ($pos<=v_NbPers)
								va_Fam3:=ta_EDisNom{$pos}+<>va_CR+ta_EDisPré{$pos}+<>va_CR+tl_EDisFam{$pos}+"/"+String:C10(tl_EDisNbP{$pos})+"p/"+String:C10(te_EDisRest{$pos})+"j"
							Else 
								va_Fam3:=""
							End if 
							$pos:=vl_Indice+3
							If ($pos<=v_NbPers)
								va_Fam4:=ta_EDisNom{$pos}+<>va_CR+ta_EDisPré{$pos}+<>va_CR+tl_EDisFam{$pos}+"/"+String:C10(tl_EDisNbP{$pos})+"p/"+String:C10(te_EDisRest{$pos})+"j"
							Else 
								va_Fam4:=""
							End if 
							$pos:=vl_Indice+4
							If ($pos<=v_NbPers)
								va_Fam5:=ta_EDisNom{$pos}+<>va_CR+ta_EDisPré{$pos}+<>va_CR+tl_EDisFam{$pos}+"/"+String:C10(tl_EDisNbP{$pos})+"p/"+String:C10(te_EDisRest{$pos})+"j"
							Else 
								va_Fam5:=""
							End if 
							$pos:=vl_Indice+5
							If ($pos<=v_NbPers)
								va_Fam6:=ta_EDisNom{$pos}+<>va_CR+ta_EDisPré{$pos}+<>va_CR+tl_EDisFam{$pos}+"/"+String:C10(tl_EDisNbP{$pos})+"p/"+String:C10(te_EDisRest{$pos})+"j"
							Else 
								va_Fam6:=""
							End if 
							$pos:=vl_Indice+6
							If ($pos<=v_NbPers)
								va_Fam7:=ta_EDisNom{$pos}+<>va_CR+ta_EDisPré{$pos}+<>va_CR+tl_EDisFam{$pos}+"/"+String:C10(tl_EDisNbP{$pos})+"p/"+String:C10(te_EDisRest{$pos})+"j"
							Else 
								va_Fam7:=""
							End if 
							$pos:=vl_Indice+7
							If ($pos<=v_NbPers)
								va_Fam8:=ta_EDisNom{$pos}+<>va_CR+ta_EDisPré{$pos}+<>va_CR+tl_EDisFam{$pos}+"/"+String:C10(tl_EDisNbP{$pos})+"p/"+String:C10(te_EDisRest{$pos})+"j"
							Else 
								va_Fam8:=""
							End if 
							vl_IndiceLg:=0
							
							v_NoPage:=v_NoPage+1
							va_PagesD:=String:C10(v_NoPage)+"/"+String:C10(Nb_Pages)
							FORM SET OUTPUT:C54([HeberGement:5]; "FL_ExpDistri")
							_O_PAGE SETUP:C299([HeberGement:5]; "HG_PrtFaxDListe")
							PRINT SELECTION:C60([HeberGement:5]; *)
							
						End for 
						
					End if 
					If ($vb_OK)  //(7=8)
						$ref:=Create document:C266("")
						If (OK=1)
							USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
							
							SEND PACKET:C103($ref; String:C10(vd_DtJF; 7)+" <> "+String:C10(vh_HrJF))
							SEND PACKET:C103($ref; <>va_CR)
							SEND PACKET:C103($ref; va_LC_Nom+<>va_CR)
							SEND PACKET:C103($ref; va_LC_Ad1+<>va_CR)
							SEND PACKET:C103($ref; va_LC_Ad2+<>va_CR)
							SEND PACKET:C103($ref; va_LC_CP+" "+va_LC_Ville+<>va_CR)
							SEND PACKET:C103($ref; va_LC_Tel+" & "+va_LC_Fax+<>va_CR)
							SEND PACKET:C103($ref; va_LC_Pers+<>va_CR)
							SEND PACKET:C103($ref; <>va_CR)
							//ENVOYER PAQUET($ref;vt_Texte+◊va_Tab+◊va_Tab+vt_TexteH+◊va_CR)
							SEND PACKET:C103($ref; <>va_CR)
							SEND PACKET:C103($ref; <>va_CR)
							
							
							SEND PACKET:C103($ref; <>va_Tab)
							SEND PACKET:C103($ref; <>va_Tab)
							For ($ww; 1; Size of array:C274(tl_EDisID))
								SEND PACKET:C103($ref; ta_EDisNom{$ww}+<>va_Tab)
							End for 
							SEND PACKET:C103($ref; <>va_CR)
							SEND PACKET:C103($ref; <>va_Tab)
							SEND PACKET:C103($ref; <>va_Tab)
							For ($ww; 1; Size of array:C274(tl_EDisID))
								SEND PACKET:C103($ref; ta_EDisPré{$ww}+<>va_Tab)
							End for 
							SEND PACKET:C103($ref; <>va_CR)
							SEND PACKET:C103($ref; <>va_Tab)
							SEND PACKET:C103($ref; <>va_Tab)
							For ($ww; 1; Size of array:C274(tl_EDisID))
								SEND PACKET:C103($ref; tl_EDisFam{$ww}+"<>"+String:C10(tl_EDisNbP{$ww})+<>va_Tab)
							End for 
							SEND PACKET:C103($ref; <>va_CR)
							SEND PACKET:C103($ref; <>va_Tab)
							SEND PACKET:C103($ref; <>va_Tab)
							For ($ww; 1; Size of array:C274(tl_EDisID))
								SEND PACKET:C103($ref; String:C10(te_EDisRest{$ww})+<>va_Tab)
							End for 
							SEND PACKET:C103($ref; <>va_CR)
							SEND PACKET:C103($ref; <>va_CR)
							
							ARRAY LONGINT:C221(tl_xfaxDisT; Size of array:C274(ta_xfaxDis))
							For ($uu; 1; Size of array:C274(ta_xfaxDis))
								tl_xfaxDisT{$uu}:=0
								For ($ww; 1; Size of array:C274(tl_EDisID))
									tl_xfaxDisT{$uu}:=tl_xfaxDisT{$uu}+te_xfaxDis{$uu}{$ww}
								End for 
							End for 
							
							For ($uu; 1; Size of array:C274(ta_xfaxDis))
								SEND PACKET:C103($ref; ta_xfaxDis{$uu}+<>va_Tab)
								
								SEND PACKET:C103($ref; String:C10(tl_xfaxDisT{$uu})+<>va_Tab)
								For ($ww; 1; Size of array:C274(tl_EDisID))
									SEND PACKET:C103($ref; String:C10(te_xfaxDis{$uu}{$ww})+<>va_Tab)
								End for 
								
								SEND PACKET:C103($ref; <>va_CR)
							End for 
							SEND PACKET:C103($ref; <>va_CR)
							SEND PACKET:C103($ref; "FIN"+<>va_CR)
							
							USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
							CLOSE DOCUMENT:C267($ref)
						End if 
					End if   //  Si ($vb_OK)
				End if   //  Si (Fiches trouvees([HéberGement])>0) [HéberGement]HG_LC_ID=tl_CTRéf{$ii}
			End if   // Si (Fiches trouvees([LesCentres])=1)
		End if   // Si (tl_CTSél{$ii}=1)
		
		
	End for   //Boucle ($ii;1;Taille tableau(ta_CTNom))
	FIRST RECORD:C50([HeberGement:5])
	vl_NbHB:=Records in selection:C76([HeberGement:5])
End if 