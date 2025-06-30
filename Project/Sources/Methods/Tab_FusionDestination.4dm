//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Tab_FusionDestination
//{
//{          Mardi 12 avril 2005 à 17:15:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_TEXT:C284($va_Civ)
C_LONGINT:C283($ii)
C_BOOLEAN:C305($vb_OK)

Case of 
	: ($1=0)  //Déclarations    
		ARRAY LONGINT:C221(tl_FileEtCivRéf; $2)
		
		ARRAY TEXT:C222(ta_FileEtCivRéf; $2)
		ARRAY TEXT:C222(ta_FileEtCiv; $2)
		ARRAY TEXT:C222(ta_FilexEtCiv; $2)
		
		ARRAY INTEGER:C220(te_FileEtCivOrdre; $2)
		ARRAY INTEGER:C220(te_FileEtCivEtat; $2)
		ARRAY INTEGER:C220(te_FileEtCivDiv; $2)
		
		ARRAY LONGINT:C221(tl_yEtCivRéf; $2)
		
		ARRAY TEXT:C222(ta_yEtCivRéf; $2)
		ARRAY TEXT:C222(ta_yEtCiv; $2)
		
		ARRAY INTEGER:C220(te_yEtCivOrdre; $2)
		ARRAY INTEGER:C220(te_yEtCivEtat; $2)
		ARRAY INTEGER:C220(te_yEtCivDiv; $2)
		ARRAY INTEGER:C220(te_yEtCivCheck; $2)
	: ($1=1)  //Synchro des items
		tl_yEtCivRéf:=$2
		ta_yEtCivRéf:=$2
		ta_yEtCiv:=$2
		ta_yxEtCiv:=$2
		te_yEtCivOrdre:=$2
		te_yEtCivEtat:=$2
		te_yEtCivDiv:=$2
		te_yEtCivCheck:=$2
	: ($1=2)  //Selection vers tableau
		QUERY:C277([TableFusions:42]; [TableFusions:42]TF_RéférenceTable:2=va_CodeEnum)
		MultiSoc_Filter(->[TableFusions:42])
		
		If (Records in selection:C76([TableFusions:42])>0)
			SELECTION TO ARRAY:C260([TableFusions:42]TF_RéférenceID:1; tl_FileEtCivRéf; [TableFusions:42]TF_RéférenceTable:2; ta_FileEtCivRéf; [TableFusions:42]TF_Libellé:3; ta_FileEtCiv; [TableFusions:42]TF_LibelléOrigine:4; ta_FilexEtCiv; [TableFusions:42]TF_Ordre:5; te_FileEtCivOrdre; [TableFusions:42]TF_Etat:6; te_FileEtCivEtat; [TableFusions:42]TF_Diviseur:7; te_FileEtCivDiv)
			SORT ARRAY:C229(ta_FileEtCiv; tl_FileEtCivRéf; ta_FileEtCivRéf; ta_FilexEtCiv; te_FileEtCivOrdre; te_FileEtCivEtat; te_FileEtCivDiv; >)
			
			Repeat 
				$ii:=$ii+1
				
				If ($va_Civ=ta_FileEtCiv{$ii})
				Else 
					Tab_FusionDestination(20; 0; 0)
					$jj:=Size of array:C274(tl_yEtCivRéf)
					
					tl_yEtCivRéf{$jj}:=tl_FileEtCivRéf{$ii}
					ta_yEtCivRéf{$jj}:=ta_FileEtCivRéf{$ii}
					ta_yEtCiv{$jj}:=ta_FileEtCiv{$ii}
					te_yEtCivOrdre{$jj}:=te_FileEtCivOrdre{$ii}
					te_yEtCivEtat{$jj}:=0
					te_yEtCivDiv{$jj}:=te_FileEtCivDiv{$ii}
					te_yEtCivCheck{$jj}:=0
				End if 
				
				$va_Civ:=ta_FileEtCiv{$ii}
			Until ($ii>=Size of array:C274(ta_FileEtCiv))
			
		End if 
		
		Tab_FusionDestination(1; 0; 0)
		
	: ($1=3)  //Nb de etat civils rattachés
		vl_NbItems:=0
		
		For ($ii; 1; Size of array:C274(tl_yEtCivRéf))
			te_yEtCivEtat{$ii}:=0
			
			For ($jj; 1; Size of array:C274(tl_FileEtCivRéf))
				
				If (ta_yEtCiv{$ii}=ta_FileEtCiv{$jj}) & (ta_FilexEtCiv{$jj}>"")
					te_yEtCivEtat{$ii}:=te_yEtCivEtat{$ii}+1
				End if 
				
			End for 
			
			vl_NbItems:=vl_NbItems+te_yEtCivEtat{$ii}
		End for 
		
	: ($1=4)  //Click dans tableau Item de fusion
		
		//RAZ du tableau d'état civil  partie lien
		For ($ii; 1; Size of array:C274(ta_xEtCiv))
			te_xEtCiv{$ii}:=0
		End for 
		
		For ($ii; 1; Size of array:C274(tl_FileEtCivRéf))
			
			If (ta_yEtCiv{$2}=ta_FileEtCiv{$ii})
				$jj:=Find in array:C230(ta_xEtCiv; ta_FilexEtCiv{$ii})
				
				If ($jj>0)
					te_xEtCiv{$jj}:=Num:C11($jj>0)
				End if 
				
			End if 
			
		End for 
		
	: ($1=5)  //Trier
		tl_yEtCivRéf{0}:=tl_yEtCivRéf{ta_yEtCiv}
		
		Case of 
			: ($2=1)
				
				If ($3=1)
					SORT ARRAY:C229(ta_yEtCiv; tl_yEtCivRéf; ta_yEtCivRéf; te_yEtCivOrdre; te_yEtCivEtat; te_yEtCivDiv; <)
				Else 
					SORT ARRAY:C229(ta_yEtCiv; tl_yEtCivRéf; ta_yEtCivRéf; te_yEtCivOrdre; te_yEtCivEtat; te_yEtCivDiv; >)
				End if 
				
			: ($2=2)
				
				If ($3=1)
					SORT ARRAY:C229(te_yEtCivOrdre; tl_yEtCivRéf; ta_yEtCivRéf; ta_yEtCiv; te_yEtCivEtat; te_yEtCivDiv; <)
				Else 
					SORT ARRAY:C229(te_yEtCivOrdre; tl_yEtCivRéf; ta_yEtCivRéf; ta_yEtCiv; te_yEtCivEtat; te_yEtCivDiv; >)
				End if 
				
			: ($2=3)
		End case 
		
		$ii:=Find in array:C230(tl_yEtCivRéf; tl_yEtCivRéf{0})
		
		If ($ii<0)
			$ii:=0
		End if 
		
		Tab_FusionDestination(1; $ii; 0)
	: ($1=10)  //Ajouter une ligne de tableau général
		$ii:=Size of array:C274(tl_FileEtCivRéf)+1
		
		INSERT IN ARRAY:C227(tl_FileEtCivRéf; $ii)
		INSERT IN ARRAY:C227(ta_FileEtCivRéf; $ii)
		INSERT IN ARRAY:C227(ta_FileEtCiv; $ii)
		INSERT IN ARRAY:C227(ta_FilexEtCiv; $ii)
		INSERT IN ARRAY:C227(te_FileEtCivOrdre; $ii)
		INSERT IN ARRAY:C227(te_FileEtCivEtat; $ii)
		INSERT IN ARRAY:C227(te_FileEtCivDiv; $ii)
	: ($1=11)  //Affectation une ligne de tableau général
		$ii:=$2
		
		tl_FileEtCivRéf{$ii}:=[TableFusions:42]TF_RéférenceID:1
		ta_FileEtCivRéf{$ii}:=[TableFusions:42]TF_RéférenceTable:2
		ta_FileEtCiv{$ii}:=[TableFusions:42]TF_Libellé:3
		ta_FilexEtCiv{$ii}:=[TableFusions:42]TF_LibelléOrigine:4
		te_FileEtCivOrdre{$ii}:=[TableFusions:42]TF_Ordre:5
		te_FileEtCivEtat{$ii}:=[TableFusions:42]TF_Etat:6
		te_FileEtCivDiv{$ii}:=[TableFusions:42]TF_Diviseur:7
	: ($1=12)  //Affectation de plusieurs lignes de tableau général
		i_Message("Mise à jour en cours…")
		READ WRITE:C146([TableFusions:42])
		
		For ($ii; 1; Size of array:C274(tl_FileEtCivRéf))
			
			If (ta_FileEtCiv{$ii}=va_LibEnum)
				ta_FileEtCiv{$ii}:=ta_yEtCiv{$2}
				te_FileEtCivOrdre{$ii}:=te_yEtCivOrdre{$2}
				te_FileEtCivDiv{$ii}:=te_yEtCivDiv{$2}
				
				QUERY:C277([TableFusions:42]; [TableFusions:42]TF_RéférenceID:1=tl_FileEtCivRéf{$ii})
				MultiSoc_Filter(->[TableFusions:42])
				
				If (Records in selection:C76([TableFusions:42])=1)
					
					Repeat 
						LOAD RECORD:C52([TableFusions:42])
					Until (Not:C34(Locked:C147([TableFusions:42])))
					
					[TableFusions:42]TF_Libellé:3:=ta_FileEtCiv{$ii}
					[TableFusions:42]TF_Ordre:5:=te_FileEtCivOrdre{$ii}
					[TableFusions:42]TF_Diviseur:7:=te_FileEtCivDiv{$ii}
					SAVE RECORD:C53([TableFusions:42])
					UNLOAD RECORD:C212([TableFusions:42])
				End if 
				
				UNLOAD RECORD:C212([TableFusions:42])
			End if 
			
		End for 
		
		READ ONLY:C145([TableFusions:42])
		CLOSE WINDOW:C154
	: ($1=13)  //Suppression de plusieurs lignes de tableau général
		i_Message("Mise à jour en cours…")
		READ WRITE:C146([TableFusions:42])
		
		For ($ii; 1; Size of array:C274(tl_FileEtCivRéf))
			
			If (ta_FileEtCiv{$ii}=va_LibEnum)
				te_FileEtCivEtat{$ii}:=-105
				
				QUERY:C277([TableFusions:42]; [TableFusions:42]TF_RéférenceID:1=tl_FileEtCivRéf{$ii})
				MultiSoc_Filter(->[TableFusions:42])
				
				If (Records in selection:C76([TableFusions:42])=1)
					
					Repeat 
						LOAD RECORD:C52([TableFusions:42])
					Until (Not:C34(Locked:C147([TableFusions:42])))
					
					DELETE RECORD:C58([TableFusions:42])
				End if 
				
				UNLOAD RECORD:C212([TableFusions:42])
			End if 
			
		End for 
		
		READ ONLY:C145([TableFusions:42])
		
		If (Size of array:C274(tl_FileEtCivRéf)>0)
			$ii:=1
			
			Repeat 
				
				If (te_FileEtCivEtat{$ii}=-105)
					DELETE FROM ARRAY:C228(tl_FileEtCivRéf; $ii; 1)
					DELETE FROM ARRAY:C228(ta_FileEtCivRéf; $ii; 1)
					DELETE FROM ARRAY:C228(ta_FileEtCiv; $ii; 1)
					DELETE FROM ARRAY:C228(ta_FilexEtCiv; $ii; 1)
					DELETE FROM ARRAY:C228(te_FileEtCivOrdre; $ii; 1)
					DELETE FROM ARRAY:C228(te_FileEtCivEtat; $ii; 1)
					DELETE FROM ARRAY:C228(te_FileEtCivDiv; $ii; 1)
				Else 
					$ii:=$ii+1
				End if 
				
			Until ($ii>Size of array:C274(tl_FileEtCivRéf))
			
		End if 
		
		CLOSE WINDOW:C154
	: ($1=20)  //Ajouter une ligne de tableau à l'écran
		$ii:=Size of array:C274(tl_yEtCivRéf)+1
		
		INSERT IN ARRAY:C227(tl_yEtCivRéf; $ii)
		INSERT IN ARRAY:C227(ta_yEtCivRéf; $ii)
		INSERT IN ARRAY:C227(ta_yEtCiv; $ii)
		INSERT IN ARRAY:C227(te_yEtCivOrdre; $ii)
		INSERT IN ARRAY:C227(te_yEtCivEtat; $ii)
		INSERT IN ARRAY:C227(te_yEtCivDiv; $ii)
		INSERT IN ARRAY:C227(te_yEtCivCheck; $ii)
	: ($1=21)  //Affectation une ligne de tableau à l'écran
		$ii:=$2
		
		tl_yEtCivRéf{$ii}:=[TableFusions:42]TF_RéférenceID:1
		ta_yEtCivRéf{$ii}:=[TableFusions:42]TF_RéférenceTable:2
		ta_yEtCiv{$ii}:=[TableFusions:42]TF_Libellé:3
		te_yEtCivOrdre{$ii}:=[TableFusions:42]TF_Ordre:5
		te_yEtCivEtat{$ii}:=[TableFusions:42]TF_Etat:6
		te_yEtCivDiv{$ii}:=[TableFusions:42]TF_Diviseur:7
		te_yEtCivCheck{$ii}:=0
	: ($1=23)  //Suppression une ligne de tableau à l'écran
		DELETE FROM ARRAY:C228(tl_yEtCivRéf; $2; 1)
		DELETE FROM ARRAY:C228(ta_yEtCivRéf; $2; 1)
		DELETE FROM ARRAY:C228(ta_yEtCiv; $2; 1)
		DELETE FROM ARRAY:C228(te_yEtCivOrdre; $2; 1)
		DELETE FROM ARRAY:C228(te_yEtCivEtat; $2; 1)
		DELETE FROM ARRAY:C228(te_yEtCivDiv; $2; 1)
		DELETE FROM ARRAY:C228(te_yEtCivCheck; $2; 1)
		
		If ($2>Size of array:C274(ta_yEtCiv))
			$2:=Size of array:C274(ta_yEtCiv)
		End if 
		
		Tab_FusionDestination(1; $2; 0)
		Tab_FusionDestination(4; $2; 0)
		Tab_FusionDestination(3; $2; 0)
	: ($1=30)  //Click sur le bouton rattacher
		
		If (Size of array:C274(ta_xEtCiv)>0) & (Size of array:C274(ta_yEtCiv)>0)
			
			If (ta_xEtCiv>0) & (ta_yEtCiv>0)
				
				If (i_Confirmer("Rattacher : "+ta_xEtCiv{ta_xEtCiv}+" < à > "+ta_yEtCiv{ta_yEtCiv}))
					$vb_OK:=True:C214
				End if 
				
			End if 
			
		End if 
		
		If ($vb_OK)
			$ii:=ta_xEtCiv
			
			Tab_FusionDestination(31; ta_xEtCiv; ta_yEtCiv)
			Tab_FusionDestination(3; 0; 0)
			Tab_FusionOrigine(3; 0; 0)
			Tab_FusionOrigine(1; $ii; 0)
			Tab_FusionDestination(4; ta_yEtCiv; 0)
		End if 
		
	: ($1=31)  //Confirmer le rattachement
		$ii:=Find in array:C230(ta_FilexEtCiv; ta_xEtCiv{$2})
		
		If ($ii>0)
			
			If (i_Confirmer(ta_xEtCiv{$2}+" est déjà rattaché à : "+ta_FileEtCiv{$ii}+<>va_CR+"Veuillez confirmer le transfert ?"))
				Tab_FusionDestination(33; $ii; $3)
			End if 
			
		Else 
			Tab_FusionDestination(32; $2; $3)
		End if 
		
	: ($1=32)  //Rattacher  `Confirmer le rattachement
		$vb_OK:=True:C214
		$ii:=Find in array:C230(ta_FileEtCiv; ta_yEtCiv{$3})
		
		If ($ii>0)
			
			If (ta_FilexEtCiv{$ii}>"")
			Else 
				$vb_OK:=False:C215
			End if 
			
		End if 
		
		READ WRITE:C146([TableFusions:42])
		
		If ($vb_OK)  //on crée une nouvelle fiche
			CREATE RECORD:C68([TableFusions:42])
			MultiSoc_Init_Structure(->[TableFusions:42])
			[TableFusions:42]TF_RéférenceID:1:=Uut_Numerote(->[TableFusions:42])
			[TableFusions:42]TF_RéférenceTable:2:=va_CodeEnum
			[TableFusions:42]TF_Libellé:3:=ta_yEtCiv{$3}
			[TableFusions:42]TF_LibelléOrigine:4:=ta_xEtCiv{$2}
			
			Tab_FusionDestination(10; 0; 0)
			$ii:=Size of array:C274(tl_FileEtCivRéf)
		Else 
			QUERY:C277([TableFusions:42]; [TableFusions:42]TF_RéférenceID:1=tl_FileEtCivRéf{$ii})
			MultiSoc_Filter(->[TableFusions:42])
			
			Repeat 
				LOAD RECORD:C52([TableFusions:42])
			Until (Not:C34(Locked:C147([TableFusions:42])))
			
			[TableFusions:42]TF_Libellé:3:=ta_yEtCiv{$3}
			[TableFusions:42]TF_LibelléOrigine:4:=ta_xEtCiv{$2}
		End if 
		
		[TableFusions:42]TF_Ordre:5:=te_yEtCivOrdre{$3}
		[TableFusions:42]TF_Etat:6:=0
		[TableFusions:42]TF_Diviseur:7:=te_yEtCivDiv{$3}
		SAVE RECORD:C53([TableFusions:42])
		
		Tab_FusionDestination(11; $ii; 0)
		
		UNLOAD RECORD:C212([TableFusions:42])
		READ ONLY:C145([TableFusions:42])
	: ($1=33)  //Détacher  puis rattacher  
		ta_FileEtCiv{$2}:=""
		te_FileEtCivOrdre{$2}:=0
		te_FileEtCivEtat{$2}:=0
		te_FileEtCivDiv{$2}:=1
		
		i_Message("Mise à jour en cours…")
		READ WRITE:C146([TableFusions:42])
		
		QUERY:C277([TableFusions:42]; [TableFusions:42]TF_RéférenceID:1=tl_FileEtCivRéf{$2})
		MultiSoc_Filter(->[TableFusions:42])
		
		If (Records in selection:C76([TableFusions:42])=1)
			
			Repeat 
				LOAD RECORD:C52([TableFusions:42])
			Until (Not:C34(Locked:C147([TableFusions:42])))
			
			[TableFusions:42]TF_Libellé:3:=ta_yEtCiv{$3}
			[TableFusions:42]TF_Ordre:5:=te_yEtCivOrdre{$3}
			[TableFusions:42]TF_Etat:6:=0
			[TableFusions:42]TF_Diviseur:7:=te_yEtCivDiv{$3}
			SAVE RECORD:C53([TableFusions:42])
			UNLOAD RECORD:C212([TableFusions:42])
		End if 
		
		UNLOAD RECORD:C212([TableFusions:42])
		
		READ ONLY:C145([TableFusions:42])
		CLOSE WINDOW:C154
		
		ta_FileEtCiv{$2}:=ta_yEtCiv{$3}
		te_FileEtCivOrdre{$2}:=te_yEtCivOrdre{$3}
		te_FileEtCivEtat{$2}:=0
		te_FileEtCivDiv{$2}:=te_yEtCivDiv{$3}
	: ($1=50)  //Ajouter une fiche dans la table
		READ WRITE:C146([TableFusions:42])
		
		FORM SET INPUT:C55([TableFusions:42]; "TF_EcranSaisie")
		$vl_Fenetre:=i_FenêtreNo(495; 140; 4; "Libellé de fusion : nouveau"; 3; "")
		
		ADD RECORD:C56([TableFusions:42]; *)
		
		If (OK=1)
			Tab_FusionDestination(10; 0; 0)
			Tab_FusionDestination(11; Size of array:C274(tl_FileEtCivRéf); 0)
			
			Tab_FusionDestination(20; 0; 0)
			Tab_FusionDestination(21; Size of array:C274(tl_yEtCivRéf); 0)
		End if 
		
		UNLOAD RECORD:C212([TableFusions:42])
		
		CLOSE WINDOW:C154($vl_Fenetre)
		READ ONLY:C145([TableFusions:42])
	: ($1=51)  //Modifier une fiche dans la table
		
		If (Size of array:C274(tl_yEtCivRéf)>0)
			
			If (ta_yEtCiv>0)
				$vb_OK:=True:C214
			End if 
			
		End if 
		
		If ($vb_OK)
			READ WRITE:C146([TableFusions:42])
			
			QUERY:C277([TableFusions:42]; [TableFusions:42]TF_RéférenceID:1=tl_yEtCivRéf{ta_yEtCiv})
			MultiSoc_Filter(->[TableFusions:42])
			
			If (Records in selection:C76([TableFusions:42])=1)
				va_LibEnum:=""
				FORM SET INPUT:C55([TableFusions:42]; "TF_EcranSaisie")
				
				Repeat 
					LOAD RECORD:C52([TableFusions:42])
				Until (Not:C34(Locked:C147([TableFusions:42])))
				
				$vl_Fenetre:=i_FenêtreNo(495; 140; 4; "Libellé de fusion : modifier"; 3; "")
				MODIFY RECORD:C57([TableFusions:42]; *)
				
				If (OK=1)
					//Modification de la fiche à l'écran
					Tab_FusionDestination(21; ta_yEtCiv; 0)
					
					//Modifications générales
					Tab_FusionDestination(12; ta_yEtCiv; 0)
					
					Tab_FusionOrigine(3; 0; 0)
					Tab_FusionDestination(3; 0; 0)
				End if 
				
				UNLOAD RECORD:C212([TableFusions:42])
				CLOSE WINDOW:C154($vl_Fenetre)
			End if 
			
			UNLOAD RECORD:C212([TableFusions:42])
			READ ONLY:C145([TableFusions:42])
		End if 
		
	: ($1=52)  //Supprimer une fiche dans la table
		
		If (Size of array:C274(tl_yEtCivRéf)>0)
			
			If (ta_yEtCiv>0)
				$vb_OK:=True:C214
			End if 
			
		End if 
		
		If ($vb_OK)
			
			If (i_Confirmer("Confirmez-vous la suppression de l'item : "+ta_yEtCiv{ta_yEtCiv}))
				va_LibEnum:=ta_yEtCiv{ta_yEtCiv}
				
				//Suppressions générales
				Tab_FusionDestination(13; 0; 0)
				
				//Suppression de la fiche à l'écran
				Tab_FusionDestination(23; ta_yEtCiv; 0)
			End if 
			
		End if 
		
	: ($1=60)  //Supprimer une fiche dans la table
		
		If (i_Confirmer("Transferer les données d'état civil à l'identique ?"))
			
			If (i_Confirmer("Transferer les données d'état civil à l'identique ?"+<>va_CR+"Confirmez-vous"))
				
				If (Size of array:C274(ta_xEtCiv)>0)
					i_Message("Transfert en cours…")
					MESSAGES ON:C181
					
					READ WRITE:C146([TableFusions:42])
					
					ALL RECORDS:C47([TableFusions:42])
					MultiSoc_Filter(->[TableFusions:42])
					
					DELETE SELECTION:C66([TableFusions:42])
					
					For ($ii; 1; Size of array:C274(ta_xEtCiv))
						i_Message("Transfert en cours : "+String:C10(Size of array:C274(ta_xEtCiv))+" / "+String:C10($ii))
						
						CREATE RECORD:C68([TableFusions:42])
						MultiSoc_Init_Structure(->[TableFusions:42])
						
						[TableFusions:42]TF_RéférenceID:1:=Uut_Numerote(->[TableFusions:42])
						[TableFusions:42]TF_RéférenceTable:2:=va_CodeEnum
						[TableFusions:42]TF_Libellé:3:=ta_xEtCiv{$ii}
						[TableFusions:42]TF_LibelléOrigine:4:=ta_xEtCiv{$ii}
						[TableFusions:42]TF_Ordre:5:=$ii
						[TableFusions:42]TF_Etat:6:=0
						[TableFusions:42]TF_Diviseur:7:=1
						
						SAVE RECORD:C53([TableFusions:42])
						UNLOAD RECORD:C212([TableFusions:42])
					End for 
					
					READ ONLY:C145([TableFusions:42])
					
					//Etat civil
					Tab_FusionOrigine(0; 0; 0)
					Tab_FusionOrigine(2; 0; 0)
					Tab_FusionDestination(0; 0; 0)
					Tab_FusionDestination(2; 0; 0)
					Tab_FusionOrigine(3; 0; 0)
					Tab_FusionDestination(3; 0; 0)
					
					CLOSE WINDOW:C154
				End if 
				
			End if 
			
		End if 
		
End case 