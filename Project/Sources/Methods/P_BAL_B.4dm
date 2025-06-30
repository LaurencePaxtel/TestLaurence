//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_BAL_B
//{
//{          Lundi 26 février 2007 à 18:34:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_BOOLEAN:C305($vb_OK; $vb_OK2; $vb_OK3; $vb_OK4)
C_LONGINT:C283($vl_NbDocu; $ii; $vl_Position; $vl_Indice)
C_TIME:C306($h_RefDoc; vh_Réf)
C_TEXT:C284($vt_Buffer)
C_LONGINT:C283($ve_Table; $ve_Champ)
C_TEXT:C284($va_Dummy)
$h_RefDoc:=?00:00:00?

Case of 
	: ($1=1)  //Accepté
		ve_DocuStatut:=1
		P_Bal_A(-2)
		//   ALLER A PAGE(1)
		
	: ($1=2)  //Lecture des documents du répertoire du centre
		$vb_OK:=(vt_RépCentre>"")
		ARRAY TEXT:C222(tt_TransDocuDisk; 0)
		ARRAY TEXT:C222(tt_TransDocu; 0)
		ARRAY INTEGER:C220(te_TransDocuCas; 0)
		ARRAY TEXT:C222(ta_TransDocuTri; 0)
		ARRAY DATE:C224(td_DocuDates; 0)
		ARRAY TEXT:C222(ta_DocuDates; 0)
		vl_DateNombre:=0
		vA_DateNombre:=""
		If ($vb_OK)
			DOCUMENT LIST:C474(vt_RépCentre; tt_TransDocuDisk)
			$vl_NbDocu:=Size of array:C274(tt_TransDocuDisk)
			//TO 07022615h54J15789 HS63
			If ($vl_NbDocu>0)
				
				va_DateDocu:=Substring:C12(String:C10(Year of:C25(vd_DateDocu); "0000"); 3; 2)+String:C10(Month of:C24(vd_DateDocu); "00")+String:C10(Day of:C23(vd_DateDocu); "00")
				ARRAY TEXT:C222(tt_TransDocu; $vl_NbDocu)
				ARRAY INTEGER:C220(te_TransDocuCas; $vl_NbDocu)
				ARRAY TEXT:C222(ta_TransDocuTri; $vl_NbDocu)
				For ($ii; 1; $vl_NbDocu)
					te_TransDocuCas{$ii}:=0
					ta_TransDocuTri{$ii}:="0000000"
					tt_TransDocu{$ii}:=""
					
					//la liste des dates contenue dans les documents
					If (Substring:C12(tt_TransDocuDisk{$ii}; 4; 2)>="00") & (Substring:C12(tt_TransDocuDisk{$ii}; 4; 2)<="99")
						$vl_Position:=Find in array:C230(ta_DocuDates; Substring:C12(tt_TransDocuDisk{$ii}; 4; 6))
						If ($vl_Position>0)
							//Cette date est déja référencée
						Else 
							$vl_Position:=Size of array:C274(td_DocuDates)+1
							
							INSERT IN ARRAY:C227(td_DocuDates; $vl_Position; 1)
							INSERT IN ARRAY:C227(ta_DocuDates; $vl_Position; 1)
							ta_DocuDates{$vl_Position}:=Substring:C12(tt_TransDocuDisk{$ii}; 4; 6)
							td_DocuDates{$vl_Position}:=Date:C102(Substring:C12(ta_DocuDates{$vl_Position}; 5; 2)+"/"+Substring:C12(ta_DocuDates{$vl_Position}; 3; 2)+"/"+Substring:C12(ta_DocuDates{$vl_Position}; 1; 2))
						End if 
					End if 
					
					$vb_OK:=True:C214
					//Problème de l'extension TXT
					If (<>vb_CestUnMac)
					Else 
						If (Substring:C12(tt_TransDocuDisk{$ii}; Length:C16(tt_TransDocuDisk{$ii})-3)=".TXT")
							tt_TransDocuDisk{$ii}:=Substring:C12(tt_TransDocuDisk{$ii}; 1; Length:C16(tt_TransDocuDisk{$ii})-4)
						Else 
							$vb_OK:=False:C215
						End if 
					End if 
					If ($vb_OK)
						//C'est la bonne date
						If (Substring:C12(tt_TransDocuDisk{$ii}; 4; 6)=va_DateDocu)
							//Critere de tri extrait
							$vl_Position:=Position:C15("h"; tt_TransDocuDisk{$ii})
							If ($vl_Position>0)
								ta_TransDocuTri{$ii}:=Substring:C12(tt_TransDocuDisk{$ii}; 1; ($vl_Position+2))
							End if 
							//Statut de la fiche (acceptée refusée ou pas lue)           
							$vl_Position:=Position:C15("_"; tt_TransDocuDisk{$ii})
							If ($vl_Position>0)
								te_TransDocuCas{$ii}:=Num:C11(tt_TransDocuDisk{$ii}[[$vl_Position+1]]="A")+(-1*Num:C11(tt_TransDocuDisk{$ii}[[$vl_Position+1]]="R"))
								tt_TransDocu{$ii}:=Substring:C12(tt_TransDocuDisk{$ii}; 1; $vl_Position-1)
							Else 
								tt_TransDocu{$ii}:=tt_TransDocuDisk{$ii}
							End if 
						End if 
					End if 
					
				End for 
				SORT ARRAY:C229(ta_TransDocuTri; tt_TransDocuDisk; tt_TransDocu; te_TransDocuCas; >)
				//Suppression des fiches ne répondant pas aux bons critères
				If (ta_TransDocuTri{1}="0000000") & (7=7)
					
					$ii:=1
					Repeat 
						If (ta_TransDocuTri{$ii}="0000000")
							DELETE FROM ARRAY:C228(tt_TransDocuDisk; $ii; 1)
							DELETE FROM ARRAY:C228(tt_TransDocu; $ii; 1)
							DELETE FROM ARRAY:C228(te_TransDocuCas; $ii; 1)
							DELETE FROM ARRAY:C228(ta_TransDocuTri; $ii; 1)
						Else 
							$ii:=$ii+1
							
						End if 
					Until ($ii>Size of array:C274(ta_TransDocuTri))
					SORT ARRAY:C229(ta_TransDocuTri; tt_TransDocuDisk; tt_TransDocu; te_TransDocuCas; >)
				End if 
			End if 
		End if 
		vl_RépNombre:=Size of array:C274(tt_TransDocu)
		vl_DateNombre:=Size of array:C274(td_DocuDates)
		va_DateNombre:=""
		If (vl_DateNombre>0)
			va_DateNombre:=String:C10(vl_DateNombre)+" jour"+("s"*Num:C11(vl_DateNombre>1))+" à vérifier"
		End if 
		
		Case of 
			: (<>va_T_QuelleBoiteLettres=<>va_T_LaBoiteLettres)  //BoîteAuxLettres
				SET WINDOW TITLE:C213("Boite aux lettres ("+String:C10(vl_RépNombre)+") : "+<>vt_T_DossierRep)
			: (<>va_T_QuelleBoiteLettres=<>va_T_LaBoiteDalo)  //BoîteDalo
				SET WINDOW TITLE:C213("Boite des documents joints par mail : "+String:C10(vl_RépNombre))
		End case 
		
		
		$vl_Position:=0
		If (Size of array:C274(td_DocuDates)>0)
			SORT ARRAY:C229(td_DocuDates; ta_DocuDates; >)
			$vl_Position:=Find in array:C230(td_DocuDates; vd_DateDocu)
			If ($vl_Position<0)
				$vl_Position:=0
			End if 
		End if 
		td_DocuDates:=$vl_Position
		ta_DocuDates:=$vl_Position
		
		
	: ($1=3)
		vt_DocuDécode:=""
		va_DocuIndice:=""
		va_DocuTitre:=""
		va_DocuEtCv:=""
		va_DocuDateFiche:=""
		vd_DocuDateFiche:=!00-00-00!
		va_DocuNo:=""
		va_DocuCle:=""
		va_DocuNom:=""
		va_DocuPrenom:=""
		va_DocuNele:=""
		va_DocuOrient1:=""
		va_DocuAge:=""
		va_DocuNC:=""
		va_DocuNT:=""
		va_DocuCleFam:=""
		vb_DocuChefFam:=False:C215
		va_DocuE:=""
		vt_DocuT:=""
		ve_DocuStatut:=0
		va_DocuStatut:=""
		$vb_OK2:=False:C215
		$vb_OK3:=False:C215
		$vb_OK4:=False:C215
		$vb_OK:=False:C215
		If (Size of array:C274(tt_TransDocu)>0)
			If (tt_TransDocu>0)
				vt_DocuDécode:="Fiche d'hébergement n°  "+Substring:C12(tt_TransDocu{tt_TransDocu}; 16; 5)
				vt_DocuDécode:=vt_DocuDécode+"       '"+Substring:C12(tt_TransDocu{tt_TransDocu}; 22; 2)+"'   de   "+Substring:C12(tt_TransDocu{tt_TransDocu}; 24; 2)+" an"+("s"*Num:C11(Num:C11(Substring:C12(tt_TransDocu{tt_TransDocu}; 24; 2))>1))
				vt_DocuDécode:=vt_DocuDécode+<>va_CR+"Envoi du  "+Substring:C12(tt_TransDocu{tt_TransDocu}; 8; 2)+"/"+Substring:C12(tt_TransDocu{tt_TransDocu}; 6; 2)+"/20"+Substring:C12(tt_TransDocu{tt_TransDocu}; 4; 2)
				vt_DocuDécode:=vt_DocuDécode+"  à  "+Substring:C12(tt_TransDocu{tt_TransDocu}; 10; 2)+":"+Substring:C12(tt_TransDocu{tt_TransDocu}; 13; 2)
				vt_DocuDécode:=vt_DocuDécode+"   (site : "+Substring:C12(tt_TransDocu{tt_TransDocu}; 1; 3)+")"
				
				tt_TransDocuDisk:=tt_TransDocu
				te_TransDocuCas:=tt_TransDocu
				ta_TransDocuTri:=tt_TransDocu
				ve_DocuStatut:=te_TransDocuCas{te_TransDocuCas}
				va_DocuStatut:=("accepté"*Num:C11(ve_DocuStatut>0))+("refusé"*Num:C11(ve_DocuStatut<0))+("en attente"*Num:C11(ve_DocuStatut=0))
				
				If (<>vb_CestUnMac)
					vt_CheminDuDocu:=vt_RépCentre+tt_TransDocuDisk{tt_TransDocuDisk}
				Else 
					vt_CheminDuDocu:=vt_RépCentre+tt_TransDocuDisk{tt_TransDocuDisk}+".TXT"
				End if 
				If (Test path name:C476(vt_CheminDuDocu)=Est un document:K24:1)
					
					$h_RefDoc:=Open document:C264(vt_CheminDuDocu)
					If (OK=1)
						
						USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // Filtre import. BS Migration v15
						Repeat 
							RECEIVE PACKET:C104($h_RefDoc; $vt_Buffer; <>va_CR)
							$vt_Buffer:=Replace string:C233($vt_Buffer; <>va_LF; "")
							If ($vt_Buffer#"SSPFINEXPORTSSP")
								If ($vl_Indice=0)
									//1 ère ligne du document      
								Else 
									$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
									$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
									$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
									Case of 
										: ($vl_Indice=1)  //Etat civil
											va_DocuEtCv:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
										: ($vl_Indice=2)  //Date
											va_DocuDateFiche:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
											vd_DocuDateFiche:=Date:C102(va_DocuDateFiche)
											va_DocuDateFiche:=String:C10(vd_DocuDateFiche; Système date long:K1:3)
										: ($vl_Indice=3)  //Fiche n°
											va_DocuNo:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
										: ($vl_Indice=4)  //Clé
											va_DocuCle:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
										: ($vl_Indice=5)
											va_DocuNom:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
										: ($vl_Indice=6)
											va_DocuPrenom:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
										: ($vl_Indice=7)
											va_DocuNele:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
										: ($vl_Indice=8)
											va_DocuAge:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
											
										: ($vl_Indice=9)  //Nuit en cours
											va_DocuNC:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
										: ($vl_Indice=10)
											va_DocuNT:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
										: ($vl_Indice=11)
											vt_ContenuNote:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
											// : ($vl_Indice=32)
											//va_DocuCleFam:=Sous chaine($vt_Buffer;1;$vl_Position-1)        
									End case 
									If (<>vb_FullDuplexDataB)
										Case of 
											: ($vl_Indice=35)
												va_DocuOrient1:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
												OBJECT SET VISIBLE:C603(*; "Orient1Std"; True:C214)
												OBJECT SET VISIBLE:C603(*; "Orient1Rouge"; False:C215)
												If (va_DocuOrient1[[1]]="*")
													va_DocuOrient1:=Substring:C12(va_DocuOrient1; 2)
													If (Position:C15("*"; va_DocuOrient1)>0)
														OBJECT SET VISIBLE:C603(*; "Orient1Rouge"; True:C214)
													End if 
												End if 
												va_DocuOrient1:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
												
											: ($vl_Indice=41)
												va_DocuCleFam:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
										End case 
									Else 
										If ($vb_OK2=False:C215) | ($vb_OK3=False:C215) | ($vb_OK4=False:C215)
											If ($vl_Indice>33)
												$ve_Table:=0
												$ve_Champ:=0
												$va_Dummy:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
												$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
												$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
												$ve_Table:=Num:C11(Substring:C12($vt_Buffer; 1; $vl_Position-1))
												$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
												$ve_Champ:=Num:C11($vt_Buffer)
												If ($ve_Table>0) & ($ve_Champ>0)
													
													If (Field:C253($ve_Table; $ve_Champ)=(->[HeberGement:5]HG_Orientation1:58))
														$vb_OK2:=True:C214
														va_DocuOrient1:=$va_Dummy
														
														OBJECT SET VISIBLE:C603(*; "Orient1Std"; True:C214)
														OBJECT SET VISIBLE:C603(*; "Orient1Rouge"; False:C215)
														If ($va_Dummy[[1]]="*")
															$va_Dummy:=Substring:C12($va_Dummy; 2)
															If (Position:C15("*"; $va_Dummy)>0)
																OBJECT SET VISIBLE:C603(*; "Orient1Rouge"; True:C214)
															End if 
														End if 
														
														
													End if 
													
													If (Field:C253($ve_Table; $ve_Champ)=(->[HeberGement:5]HG_FamClé:104))
														$vb_OK3:=True:C214
														va_DocuCleFam:=$va_Dummy
													End if 
													
													If (Field:C253($ve_Table; $ve_Champ)=(->[HeberGement:5]HG_FamChef:103))
														$vb_OK4:=True:C214
														vb_DocuChefFam:=($va_Dummy="O")
													End if 
													
												End if 
											End if 
										End if 
									End if 
								End if 
								$vl_Indice:=$vl_Indice+1
							End if 
							$vb_OK:=($vt_Buffer="SSPFINEXPORTSSP")
						Until ($vb_OK)
						$vb_OK:=True:C214
						CLOSE DOCUMENT:C267($h_RefDoc)
						
						USE CHARACTER SET:C205(*; 1)  // reset Filtre import. BS Migration v15
					End if 
				End if 
			End if 
		End if 
		
		If ($vb_OK)
			$vb_OK:=False:C215
			//Les données strites de la fiche
			va_DocuIndice:=tt_TransDocu{tt_TransDocu}
			//La note de transfer
			If (vt_ContenuNote>"")
				vt_DocuT:=vt_ContenuNote
				vt_DocuT:=Replace string:C233(vt_DocuT; "/TD>"; "")
				vt_DocuT:=Replace string:C233(vt_DocuT; "≤"; <>va_CR)
				vt_DocuT:=Substring:C12(vt_DocuT; 3)
			End if 
			// ALLER A PAGE(2)
		End if 
	: ($1=4)  //inactivée
End case 