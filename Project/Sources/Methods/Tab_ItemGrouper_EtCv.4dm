//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Tab_ItemGrouper_EtCv
//{
//{          Lundi 26 janvier 2009 à 14:45:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($ii)
C_BOOLEAN:C305($vb_OK)

Case of 
	: ($1=0)  //Origines : Déclarations
		ARRAY TEXT:C222(ta_xEtCiv; $2)
		ARRAY INTEGER:C220(te_xEtCiv; $2)
		ARRAY INTEGER:C220(te_xEtCiv_Etat; $2)
		
		ARRAY LONGINT:C221(tl_yEtCiv_Réf; $2)
		ARRAY TEXT:C222(ta_yEtCiv_Réf; $2)
		ARRAY TEXT:C222(ta_yEtCiv; $2)
		ARRAY INTEGER:C220(te_yEtCiv_Ordre; $2)
		ARRAY INTEGER:C220(te_yEtCiv_Etat; $2)
		ARRAY INTEGER:C220(te_yEtCiv_Div; $2)
		ARRAY INTEGER:C220(te_yEtCiv_Check; $2)
		
		ARRAY LONGINT:C221(tl_FileEtCiv_Réf; $2)
		ARRAY TEXT:C222(ta_FileEtCiv_Réf; $2)
		ARRAY TEXT:C222(ta_FileEtCiv; $2)
		ARRAY TEXT:C222(ta_FilexEtCiv; $2)
		ARRAY LONGINT:C221(tl_FilexEtCiv_Réf; $2)
		ARRAY INTEGER:C220(te_FileEtCiv_Ordre; $2)
		ARRAY INTEGER:C220(te_FileEtCiv_Etat; $2)
		ARRAY INTEGER:C220(te_FileEtCiv_Div; $2)
		
		vl_NbEtCv:=0
		vl_NbEtCvGpe:=0
		vl_NbEtCvNA:=0
		vl_NbEtCvItem:=0
		vl_NbEtCvLiés:=0
		
	: ($1=1)  //Origines : Synchro    
		Case of 
			: ($3=1)
				ta_xEtCiv:=$2
				te_xEtCiv:=$2
				te_xEtCiv_Etat:=$2
			: ($3=2)
				tl_yEtCiv_Réf:=$2
				ta_yEtCiv_Réf:=$2
				ta_yEtCiv:=$2
				te_yEtCiv_Ordre:=$2
				te_yEtCiv_Etat:=$2
				te_yEtCiv_Div:=$2
				te_yEtCiv_Check:=$2
			: ($3=3)
				tl_FileEtCiv_Réf:=$2
				ta_FileEtCiv_Réf:=$2
				ta_FileEtCiv:=$2
				ta_FilexEtCiv:=$2
				tl_FilexEtCiv_Réf:=$2
				te_FileEtCiv_Ordre:=$2
				te_FileEtCiv_Etat:=$2
				te_FileEtCiv_Div:=$2
		End case 
		
	: ($1=2)  //Chargement des données
		//Tableau de gauche
		COPY ARRAY:C226(<>ta_TBEtCiv; ta_xEtCiv)
		vl_NbEtCv:=Size of array:C274(ta_xEtCiv)
		ARRAY INTEGER:C220(te_xEtCiv; vl_NbEtCv)
		ARRAY INTEGER:C220(te_xEtCiv_Etat; vl_NbEtCv)
		For ($ii; 1; vl_NbEtCv)
			te_xEtCiv{$ii}:=0
			te_xEtCiv_Etat{$ii}:=0
		End for 
		If (vl_NbEtCv>0)
			$ii:=1
		Else 
			$ii:=0
		End if 
		SORT ARRAY:C229(ta_xEtCiv; te_xEtCiv; te_xEtCiv_Etat; >)
		Tab_ItemGrouper_EtCv(1; $ii; 1)
		
		//Tableau de droite
		QUERY:C277([ItemGroupe:43]; [ItemGroupe:43]IT_Catégorie:2=<>ta_ItemGroupe{1}; *)
		QUERY:C277([ItemGroupe:43];  & ; [ItemGroupe:43]IT_LibelléOrigneID:5=0)
		MultiSoc_Filter(->[ItemGroupe:43])
		//Par convention pour l'état civil qui ne fait pas référence à une table
		//Le champ :[ItemGroupe]IT_LibelléOrigneID=0 pour les items de regroupement
		//Le champ :[ItemGroupe]IT_LibelléOrigneID=1 pour tous les liens
		vl_NbEtCvGpe:=Records in selection:C76([ItemGroupe:43])
		ORDER BY:C49([ItemGroupe:43]; [ItemGroupe:43]IT_Libellé:3; >)
		SELECTION TO ARRAY:C260([ItemGroupe:43]IT_RéférenceID:1; tl_yEtCiv_Réf; [ItemGroupe:43]IT_Catégorie:2; ta_yEtCiv_Réf; [ItemGroupe:43]IT_Libellé:3; ta_yEtCiv; [ItemGroupe:43]IT_Ordre:6; te_yEtCiv_Ordre; [ItemGroupe:43]IT_Diviseur:8; te_yEtCiv_Div)
		ARRAY INTEGER:C220(te_yEtCiv_Etat; vl_NbEtCvGpe)
		ARRAY INTEGER:C220(te_yEtCiv_Check; vl_NbEtCvGpe)
		For ($ii; 1; vl_NbEtCvGpe)
			te_yEtCiv_Etat{$ii}:=0
			te_yEtCiv_Check{$ii}:=0
		End for 
		//Tableau caché
		QUERY:C277([ItemGroupe:43]; [ItemGroupe:43]IT_Catégorie:2=<>ta_ItemGroupe{1}; *)
		QUERY:C277([ItemGroupe:43];  & ; [ItemGroupe:43]IT_LibelléOrigneID:5>0)
		MultiSoc_Filter(->[ItemGroupe:43])
		vl_NbEtCvNA:=Records in selection:C76([ItemGroupe:43])
		ORDER BY:C49([ItemGroupe:43]; [ItemGroupe:43]IT_Libellé:3; >)
		SELECTION TO ARRAY:C260([ItemGroupe:43]IT_RéférenceID:1; tl_FileEtCiv_Réf; [ItemGroupe:43]IT_Catégorie:2; ta_FileEtCiv_Réf; [ItemGroupe:43]IT_Libellé:3; ta_FileEtCiv; [ItemGroupe:43]IT_LibelléOrigine:4; ta_FilexEtCiv; [ItemGroupe:43]IT_LibelléOrigneID:5; tl_FilexEtCiv_Réf; [ItemGroupe:43]IT_Ordre:6; te_FileEtCiv_Ordre; [ItemGroupe:43]IT_Etat:7; te_FileEtCiv_Etat; [ItemGroupe:43]IT_Diviseur:8; te_FileEtCiv_Div)
		
		Tab_ItemGrouper_EtCv(3; 0; 1)  //Relié ou pas
		
		Tab_ItemGrouper_EtCv(3; 0; 2)  //Nombre d'états civils reliés
		
		If (vl_NbEtCv>0)
			$ii:=1
		Else 
			$ii:=0
		End if 
		Tab_ItemGrouper_EtCv(1; $ii; 1)  //Synchroniser       
		Tab_ItemGrouper_EtCv(4; $ii; 1)  //Clic dans le tableau de gauche
		
	: ($1=3)  //Tableaux : Statut de l'état
		Case of 
			: ($3=1)  //Origine rattachée ou non 
				For ($ii; 1; Size of array:C274(ta_xEtCiv))
					$jj:=Find in array:C230(ta_FilexEtCiv; ta_xEtCiv{$ii})
					te_xEtCiv_Etat{$ii}:=Num:C11($jj>0)
				End for 
				
			: ($3=2)  //Groupement : nb d'état civil relié reliés
				//Nb de etat civils rattachés
				vl_NbEtCvItem:=0
				For ($ii; 1; Size of array:C274(tl_yEtCiv_Réf))
					te_yEtCiv_Etat{$ii}:=0
					For ($jj; 1; Size of array:C274(tl_FileEtCiv_Réf))
						If (ta_yEtCiv{$ii}=ta_FileEtCiv{$jj}) & (ta_FilexEtCiv{$jj}>"")
							te_yEtCiv_Etat{$ii}:=te_yEtCiv_Etat{$ii}+1
						End if 
					End for 
					vl_NbEtCvItem:=vl_NbEtCvItem+te_yEtCiv_Etat{$ii}
				End for 
				
			: ($3=3)  //Groupement :Total reliés
				vl_NbEtCvItem:=0
				For ($ii; 1; Size of array:C274(tl_yEtCiv_Réf))
					vl_NbEtCvItem:=vl_NbEtCvItem+te_yEtCiv_Etat{$ii}
				End for 
				
		End case 
		
		
		
	: ($1=4)  //Tableaux : Clic
		Case of 
			: ($3=1)  //Origine
				For ($ii; 1; Size of array:C274(tl_yEtCiv_Réf))
					te_yEtCiv_Check{$ii}:=0
				End for 
				$jj:=0
				If ($2>0)
					$ii:=Find in array:C230(ta_FilexEtCiv; ta_xEtCiv{$2})
					If ($ii>0)
						$jj:=Find in array:C230(ta_yEtCiv; ta_FileEtCiv{$ii})
						If ($jj>0)
							te_yEtCiv_Check{$jj}:=1
						End if 
					End if 
				End if 
				
			: ($3=2)
				For ($ii; 1; Size of array:C274(ta_xEtCiv))
					te_xEtCiv{$ii}:=0
				End for 
				For ($ii; 1; Size of array:C274(tl_FileEtCiv_Réf))
					If (ta_yEtCiv{$2}=ta_FileEtCiv{$ii})
						$jj:=Find in array:C230(ta_xEtCiv; ta_FilexEtCiv{$ii})
						If ($jj>0)
							te_xEtCiv{$jj}:=Num:C11($jj>0)
						End if 
					End if 
				End for 
			: ($3=3)
		End case 
		
	: ($1=5)  //Tableaux : Ajouter
		Case of 
			: ($3=1)
				$ii:=Size of array:C274(ta_xEtCiv)+1
				INSERT IN ARRAY:C227(ta_xEtCiv; $ii)
				INSERT IN ARRAY:C227(te_xEtCiv; $ii)
				INSERT IN ARRAY:C227(te_xEtCiv_Etat; $ii)
			: ($3=2)
				$ii:=Size of array:C274(tl_yEtCiv_Réf)+1
				INSERT IN ARRAY:C227(tl_yEtCiv_Réf; $ii)
				INSERT IN ARRAY:C227(ta_yEtCiv_Réf; $ii)
				INSERT IN ARRAY:C227(ta_yEtCiv; $ii)
				INSERT IN ARRAY:C227(te_yEtCiv_Ordre; $ii)
				INSERT IN ARRAY:C227(te_yEtCiv_Etat; $ii)
				INSERT IN ARRAY:C227(te_yEtCiv_Div; $ii)
				INSERT IN ARRAY:C227(te_yEtCiv_Check; $ii)
			: ($3=3)
				$ii:=Size of array:C274(tl_FileEtCiv_Réf)+1
				INSERT IN ARRAY:C227(tl_FileEtCiv_Réf; $ii)
				INSERT IN ARRAY:C227(ta_FileEtCiv_Réf; $ii)
				INSERT IN ARRAY:C227(ta_FileEtCiv; $ii)
				INSERT IN ARRAY:C227(ta_FilexEtCiv; $ii)
				INSERT IN ARRAY:C227(tl_FilexEtCiv_Réf; $ii)
				INSERT IN ARRAY:C227(te_FileEtCiv_Ordre; $ii)
				INSERT IN ARRAY:C227(te_FileEtCiv_Etat; $ii)
				INSERT IN ARRAY:C227(te_FileEtCiv_Div; $ii)
		End case 
		
	: ($1=6)  //Tableaux : Affecter
		$ii:=$2
		Case of 
			: ($3=1)
			: ($3=2)
				tl_yEtCiv_Réf{$ii}:=[ItemGroupe:43]IT_RéférenceID:1
				ta_yEtCiv_Réf{$ii}:=[ItemGroupe:43]IT_Catégorie:2
				ta_yEtCiv{$ii}:=[ItemGroupe:43]IT_Libellé:3
				te_yEtCiv_Ordre{$ii}:=[ItemGroupe:43]IT_Ordre:6
				te_yEtCiv_Etat{$ii}:=[ItemGroupe:43]IT_Etat:7
				te_yEtCiv_Div{$ii}:=[ItemGroupe:43]IT_Diviseur:8
				te_yEtCiv_Check{$ii}:=0
			: ($3=3)
				tl_FileEtCiv_Réf{$ii}:=[ItemGroupe:43]IT_RéférenceID:1
				ta_FileEtCiv_Réf{$ii}:=[ItemGroupe:43]IT_Catégorie:2
				ta_FileEtCiv{$ii}:=[ItemGroupe:43]IT_Libellé:3
				ta_FilexEtCiv{$ii}:=[ItemGroupe:43]IT_LibelléOrigine:4
				tl_FilexEtCiv_Réf{$ii}:=[ItemGroupe:43]IT_LibelléOrigneID:5
				te_FileEtCiv_Ordre{$ii}:=[ItemGroupe:43]IT_Ordre:6
				te_FileEtCiv_Etat{$ii}:=[ItemGroupe:43]IT_Etat:7
				te_FileEtCiv_Div{$ii}:=[ItemGroupe:43]IT_Diviseur:8
		End case 
		
	: ($1=7)  //Tableaux : Affecter plusieurs lignes  :synchro apres modif
		i_Message("Mise à jour en cours…")
		READ WRITE:C146([ItemGroupe:43])
		For ($ii; 1; Size of array:C274(tl_FileEtCiv_Réf))
			If (ta_FileEtCiv{$ii}=va_LibEnum)
				ta_FileEtCiv{$ii}:=ta_yEtCiv{$2}
				te_FileEtCiv_Ordre{$ii}:=te_yEtCiv_Ordre{$2}
				te_FileEtCiv_Div{$ii}:=te_yEtCiv_Div{$2}
				QUERY:C277([ItemGroupe:43]; [ItemGroupe:43]IT_RéférenceID:1=tl_FileEtCiv_Réf{$ii})
				MultiSoc_Filter(->[ItemGroupe:43])
				If (Records in selection:C76([ItemGroupe:43])=1)
					Repeat 
						LOAD RECORD:C52([ItemGroupe:43])
					Until (Not:C34(Locked:C147([ItemGroupe:43])))
					[ItemGroupe:43]IT_Libellé:3:=ta_FileEtCiv{$ii}
					[ItemGroupe:43]IT_Ordre:6:=te_FileEtCiv_Ordre{$ii}
					[ItemGroupe:43]IT_Diviseur:8:=te_FileEtCiv_Div{$ii}
					SAVE RECORD:C53([ItemGroupe:43])
					UNLOAD RECORD:C212([ItemGroupe:43])
				End if 
				UNLOAD RECORD:C212([ItemGroupe:43])
			End if 
		End for 
		READ ONLY:C145([ItemGroupe:43])
		CLOSE WINDOW:C154
		
	: ($1=8)  //Tableaux : Suppression de plusieurs lignes de tableau général  : synchro sup
		Case of 
			: ($3=1)
				
			: ($3=2)
				DELETE FROM ARRAY:C228(tl_yEtCiv_Réf; $2; 1)
				DELETE FROM ARRAY:C228(ta_yEtCiv_Réf; $2; 1)
				DELETE FROM ARRAY:C228(ta_yEtCiv; $2; 1)
				DELETE FROM ARRAY:C228(te_yEtCiv_Ordre; $2; 1)
				DELETE FROM ARRAY:C228(te_yEtCiv_Etat; $2; 1)
				DELETE FROM ARRAY:C228(te_yEtCiv_Div; $2; 1)
				DELETE FROM ARRAY:C228(te_yEtCiv_Check; $2; 1)
				
			: ($3=3)
				DELETE FROM ARRAY:C228(tl_FileEtCiv_Réf; $2; 1)
				DELETE FROM ARRAY:C228(ta_FileEtCiv_Réf; $2; 1)
				DELETE FROM ARRAY:C228(ta_FileEtCiv; $2; 1)
				DELETE FROM ARRAY:C228(ta_FilexEtCiv; $2; 1)
				DELETE FROM ARRAY:C228(tl_FilexEtCiv_Réf; $2; 1)
				DELETE FROM ARRAY:C228(te_FileEtCiv_Ordre; $2; 1)
				DELETE FROM ARRAY:C228(te_FileEtCiv_Etat; $2; 1)
				DELETE FROM ARRAY:C228(te_FileEtCiv_Div; $2; 1)
		End case 
		
	: ($1=9)  //Trier
		tl_yEtCiv_Réf{0}:=tl_yEtCiv_Réf{ta_yEtCiv}
		Case of 
			: ($2=1)
				If ($3=1)
					SORT ARRAY:C229(ta_yEtCiv; te_yEtCiv_Ordre; tl_yEtCiv_Réf; ta_yEtCiv_Réf; te_yEtCiv_Etat; te_yEtCiv_Div; te_yEtCiv_Check; <)
				Else 
					SORT ARRAY:C229(ta_yEtCiv; te_yEtCiv_Ordre; tl_yEtCiv_Réf; ta_yEtCiv_Réf; te_yEtCiv_Etat; te_yEtCiv_Div; te_yEtCiv_Check; >)
				End if 
				
			: ($2=2)
				If ($3=1)
					SORT ARRAY:C229(te_yEtCiv_Ordre; tl_yEtCiv_Réf; ta_yEtCiv_Réf; ta_yEtCiv; te_yEtCiv_Etat; te_yEtCiv_Div; te_yEtCiv_Check; <)
				Else 
					SORT ARRAY:C229(te_yEtCiv_Ordre; tl_yEtCiv_Réf; ta_yEtCiv_Réf; ta_yEtCiv; te_yEtCiv_Etat; te_yEtCiv_Div; te_yEtCiv_Check; >)
				End if 
			: ($2=3)
		End case 
		$ii:=Find in array:C230(tl_yEtCiv_Réf; tl_yEtCiv_Réf{0})
		If ($ii<0)
			$ii:=0
		End if 
		Tab_ItemGrouper_EtCv(1; $ii; 2)
		
	: ($1=20)  //Demande de liaison
		
		$vb_OK:=($2>0)
		$vb_OK:=$vb_OK & ($3>0)
		If ($vb_OK)
			//Recherche dans le tableau caché l'existance d'un lien éventuel
			$ii:=Find in array:C230(ta_FilexEtCiv; ta_xEtCiv{$2})
			If ($ii>0)
				If (i_Confirmer(ta_xEtCiv{$2}+" est déjà rattaché à : "+ta_FileEtCiv{$ii}+<>va_CR+"Veuillez confirmer le transfert ?"))
					//Commencer par détacher puis rattacher
					Tab_ItemGrouper_EtCv(22; $2; $3)  //Modifier la liaison
				End if 
			Else   //Pas de lien
				Tab_ItemGrouper_EtCv(21; $2; $3)
			End if 
		End if 
		
		
	: ($1=21)  //Effectuer la liaison
		READ WRITE:C146([ItemGroupe:43])
		CREATE RECORD:C68([ItemGroupe:43])
		MultiSoc_Init_Structure(->[ItemGroupe:43])
		[ItemGroupe:43]IT_RéférenceID:1:=Uut_Numerote(->[ItemGroupe:43])
		[ItemGroupe:43]IT_Catégorie:2:=<>ta_ItemGroupe{1}
		[ItemGroupe:43]IT_Libellé:3:=ta_yEtCiv{$3}
		[ItemGroupe:43]IT_LibelléOrigine:4:=ta_xEtCiv{$2}
		[ItemGroupe:43]IT_LibelléOrigneID:5:=1
		[ItemGroupe:43]IT_Ordre:6:=te_yEtCiv_Ordre{$3}
		[ItemGroupe:43]IT_Etat:7:=0
		[ItemGroupe:43]IT_Diviseur:8:=te_yEtCiv_Div{$3}
		SAVE RECORD:C53([ItemGroupe:43])
		Tab_ItemGrouper_EtCv(5; 0; 3)
		$ii:=Size of array:C274(tl_FileEtCiv_Réf)
		Tab_ItemGrouper_EtCv(6; $ii; 3)
		UNLOAD RECORD:C212([ItemGroupe:43])
		READ ONLY:C145([ItemGroupe:43])
		//Tab_ItemGrouper_EtCv (3;0;1)
		te_xEtCiv{$2}:=1  //Signe Plus de la liaison activée 		
		te_xEtCiv_Etat{$2}:=1  //Signe X de l'existance de la laison 
		Tab_ItemGrouper_EtCv(3; 0; 2)
		Tab_ItemGrouper_EtCv(4; $2; 1)
		
	: ($1=22)  //Modifier la liaison
		i_Message("Mise à jour en cours…")
		$ii:=Find in array:C230(ta_FilexEtCiv; ta_xEtCiv{$2})
		READ WRITE:C146([ItemGroupe:43])
		QUERY:C277([ItemGroupe:43]; [ItemGroupe:43]IT_RéférenceID:1=tl_FileEtCiv_Réf{$ii})
		MultiSoc_Filter(->[ItemGroupe:43])
		If (Records in selection:C76([ItemGroupe:43])=1)
			Repeat 
				LOAD RECORD:C52([ItemGroupe:43])
			Until (Not:C34(Locked:C147([ItemGroupe:43])))
			[ItemGroupe:43]IT_Libellé:3:=ta_yEtCiv{$3}
			//[ItemGroupe]IT_LibelléOrigine:=ta_xEtCiv{$2}
			//[ItemGroupe]IT_LibelléOrigneID:=1
			[ItemGroupe:43]IT_Ordre:6:=te_yEtCiv_Ordre{$3}
			[ItemGroupe:43]IT_Etat:7:=0
			[ItemGroupe:43]IT_Diviseur:8:=te_yEtCiv_Div{$3}
			SAVE RECORD:C53([ItemGroupe:43])
			UNLOAD RECORD:C212([ItemGroupe:43])
			ta_FileEtCiv{$ii}:=ta_yEtCiv{$3}
			te_FileEtCiv_Ordre{$ii}:=te_yEtCiv_Ordre{$3}
			te_FileEtCiv_Etat{$ii}:=0
			te_FileEtCiv_Div{$ii}:=te_yEtCiv_Div{$3}
			
			te_xEtCiv{$2}:=1  //Signe Plus de la liaison activée 		
			te_xEtCiv_Etat{$2}:=1  //Signe X de l'existance de la laison 
		End if 
		UNLOAD RECORD:C212([ItemGroupe:43])
		READ ONLY:C145([ItemGroupe:43])
		Tab_ItemGrouper_EtCv(3; 0; 1)
		Tab_ItemGrouper_EtCv(3; 0; 2)
		Tab_ItemGrouper_EtCv(4; $2; 1)
		
	: ($1=30)  //Supprimer une liaison
		$vb_OK:=($2>0)
		$vb_OK:=$vb_OK & (Find in array:C230(ta_FilexEtCiv; ta_xEtCiv{$2})>0)
		If ($vb_OK)
			$ii:=Find in array:C230(ta_FilexEtCiv; ta_xEtCiv{$2})
			If ($ii>0)
				$jj:=Find in array:C230(ta_yEtCiv; ta_FileEtCiv{$ii})
				If ($jj>0)
				Else 
					$jj:=0
				End if 
				If (i_Confirmer(ta_xEtCiv{$2}+" est rattaché à : "+ta_yEtCiv{$jj}+<>va_CR+"Veuillez confirmer la suppression de la liaison ?"))
					READ WRITE:C146([ItemGroupe:43])
					QUERY:C277([ItemGroupe:43]; [ItemGroupe:43]IT_RéférenceID:1=tl_FileEtCiv_Réf{$ii})
					MultiSoc_Filter(->[ItemGroupe:43])
					If (Records in selection:C76([ItemGroupe:43])=1)
						Repeat 
							LOAD RECORD:C52([ItemGroupe:43])
						Until (Not:C34(Locked:C147([ItemGroupe:43])))
						DELETE RECORD:C58([ItemGroupe:43])
						UNLOAD RECORD:C212([ItemGroupe:43])
						//Supprimer la ligne de tableau
						Tab_ItemGrouper_EtCv(8; $ii; 3)
						
						te_xEtCiv{$2}:=0  //Signe Plus de la liaison desactivée 		
						te_xEtCiv_Etat{$2}:=0  //Effacer le Signe X de l'existance de la laison
						Tab_ItemGrouper_EtCv(3; 0; 2)
						Tab_ItemGrouper_EtCv(4; $2; 1)
					End if 
					READ ONLY:C145([ItemGroupe:43])
				End if 
			Else 
				ALERT:C41(ta_xEtCiv{$2}+" n'est pas rattaché !")
			End if 
		End if 
		
	: ($1=40)  //Ajouter une fiche dans la table
		va_LibEnum:=<>ta_ItemGroupe{1}
		READ WRITE:C146([ItemGroupe:43])
		FORM SET INPUT:C55([ItemGroupe:43]; "IT_EcranSaisie")
		$vl_Fenetre:=i_FenêtreNo(495; 140; 4; "Libellé de regroupement : nouveau"; 3; "")
		ADD RECORD:C56([ItemGroupe:43]; *)
		If (OK=1)
			//Nouvelle ligne dans le tableau caché
			//Tab_ItemGrouper_EtCv (5;0;3)
			//Affecter le tableau caché
			//Tab_ItemGrouper_EtCv (6;Taille tableau(tl_FileEtCiv_Réf);3)
			
			//Nouvelle ligne dans le tableau de droite
			Tab_ItemGrouper_EtCv(5; 0; 2)
			//Affecter le tableau de droite
			Tab_ItemGrouper_EtCv(6; Size of array:C274(tl_yEtCiv_Réf); 2)
			
			Tab_ItemGrouper_EtCv(1; ta_xEtCiv; 1)  //Synchroniser     
			Tab_ItemGrouper_EtCv(4; ta_xEtCiv; 1)  //Clic dans le tableau de gauche  
			Tab_ItemGrouper_EtCv(1; Size of array:C274(tl_yEtCiv_Réf); 2)  //Synchroniser     
			Tab_ItemGrouper_EtCv(4; Size of array:C274(tl_yEtCiv_Réf); 2)  //Clic dans le tableau de droite  
			
		End if 
		UNLOAD RECORD:C212([ItemGroupe:43])
		CLOSE WINDOW:C154($vl_Fenetre)
		READ ONLY:C145([ItemGroupe:43])
		vl_NbEtCvGpe:=Size of array:C274(tl_yEtCiv_Réf)
		
	: ($1=50)  //Modifier une fiche dans la table
		$vb_OK:=(Size of array:C274(tl_yEtCiv_Réf)>0)
		If ($vb_OK)
			$vb_OK:=(ta_yEtCiv>0)
		End if 
		If ($vb_OK)
			READ WRITE:C146([ItemGroupe:43])
			QUERY:C277([ItemGroupe:43]; [ItemGroupe:43]IT_RéférenceID:1=tl_yEtCiv_Réf{ta_yEtCiv})
			MultiSoc_Filter(->[ItemGroupe:43])
			If (Records in selection:C76([ItemGroupe:43])=1)
				va_LibEnum:=""
				FORM SET INPUT:C55([ItemGroupe:43]; "IT_EcranSaisie")
				Repeat 
					LOAD RECORD:C52([ItemGroupe:43])
				Until (Not:C34(Locked:C147([ItemGroupe:43])))
				$vl_Fenetre:=i_FenêtreNo(495; 140; 4; "Libellé de regroupement : modifier"; 3; "")
				MODIFY RECORD:C57([ItemGroupe:43]; *)
				If (OK=1)
					//Modification de la fiche à l'écran
					Tab_ItemGrouper_EtCv(6; ta_yEtCiv; 2)
					//Modifications générales du libellé de l'item de regroupement
					Tab_ItemGrouper_EtCv(7; ta_yEtCiv; 2)
				End if 
				UNLOAD RECORD:C212([ItemGroupe:43])
				CLOSE WINDOW:C154($vl_Fenetre)
			End if 
			UNLOAD RECORD:C212([ItemGroupe:43])
			READ ONLY:C145([ItemGroupe:43])
		End if 
		
	: ($1=60)  //Supprimer une fiche dans la table
		$vb_OK:=(Size of array:C274(tl_yEtCiv_Réf)>0)
		If ($vb_OK)
			$vb_OK:=(ta_yEtCiv>0)
		End if 
		If ($vb_OK)
			If (i_Confirmer("Confirmez-vous la suppression de l'item : "+ta_yEtCiv{$3}))
				va_LibEnum:=ta_yEtCiv{$3}
				//Suppressions générales
				i_Message("Mise à jour en cours…")
				READ WRITE:C146([ItemGroupe:43])
				QUERY:C277([ItemGroupe:43]; [ItemGroupe:43]IT_Catégorie:2=<>ta_ItemGroupe{1}; *)
				QUERY:C277([ItemGroupe:43];  & ; [ItemGroupe:43]IT_Libellé:3=va_LibEnum)
				MultiSoc_Filter(->[ItemGroupe:43])
				If (Records in selection:C76([ItemGroupe:43])>0)
					DELETE SELECTION:C66([ItemGroupe:43])
				End if 
				UNLOAD RECORD:C212([ItemGroupe:43])
				READ ONLY:C145([ItemGroupe:43])
				If (Size of array:C274(tl_FileEtCiv_Réf)>0)
					$ii:=1
					Repeat 
						If (ta_FileEtCiv{$ii}=va_LibEnum)
							//Suppression des lignes du tableau caché
							Tab_ItemGrouper_EtCv(8; $ii; 3)
						Else 
							$ii:=$ii+1
						End if 
					Until (($ii>Size of array:C274(ta_FileEtCiv)))
				End if 
				CLOSE WINDOW:C154
				//Suppression de la fiche à l'écran
				Tab_ItemGrouper_EtCv(8; $3; 2)
				//Synchroniser l'ensemble
				vl_NbEtCvGpe:=Size of array:C274(tl_yEtCiv_Réf)
				If ($3>vl_NbEtCvGpe)
					$3:=vl_NbEtCvGpe
				End if 
				Tab_ItemGrouper_EtCv(1; $3; 2)
				Tab_ItemGrouper_EtCv(4; $3; 2)
				Tab_ItemGrouper_EtCv(3; $2; 1)
				Tab_ItemGrouper_EtCv(3; $3; 2)
			End if 
		End if 
		
		
	: ($1=70)  //Vérifier la table
		Case of 
			: (Size of array:C274(ta_xEtCiv)=0)
				QUERY:C277([ItemGroupe:43]; [ItemGroupe:43]IT_Catégorie:2=<>ta_ItemGroupe{1}; *)
				QUERY:C277([ItemGroupe:43];  & ; [ItemGroupe:43]IT_LibelléOrigneID:5>0)
				MultiSoc_Filter(->[ItemGroupe:43])
				$ii:=Records in selection:C76([ItemGroupe:43])
				If ($ii>0)
					If (i_Confirmer("Groupement état civil : "+String:C10($ii)+" fiche"+("s"*Num:C11($ii>1))+" en plus à supprimer !"))
						USE SET:C118("$e_Tous")
						READ WRITE:C146([ItemGroupe:43])
						DELETE SELECTION:C66([ItemGroupe:43])
						READ ONLY:C145([ItemGroupe:43])
					End if 
				Else 
					BEEP:C151
				End if 
				
			: (Size of array:C274(ta_yEtCiv)=0)
				QUERY:C277([ItemGroupe:43]; [ItemGroupe:43]IT_Catégorie:2=<>ta_ItemGroupe{1})
				MultiSoc_Filter(->[ItemGroupe:43])
				$ii:=Records in selection:C76([ItemGroupe:43])
				If ($ii>0)
					If (i_Confirmer("Groupement état civil : "+String:C10($ii)+" fiche"+("s"*Num:C11($ii>1))+" en plus à supprimer !"))
						USE SET:C118("$e_Tous")
						READ WRITE:C146([ItemGroupe:43])
						DELETE SELECTION:C66([ItemGroupe:43])
						READ ONLY:C145([ItemGroupe:43])
					End if 
				Else 
					BEEP:C151
				End if 
				
			: (Size of array:C274(ta_yEtCiv)>0)
				QUERY:C277([ItemGroupe:43]; [ItemGroupe:43]IT_Catégorie:2=<>ta_ItemGroupe{1})
				MultiSoc_Filter(->[ItemGroupe:43])
				If (Records in selection:C76([ItemGroupe:43])>0)
					CREATE SET:C116([ItemGroupe:43]; "$e_Tous")
					For ($ii; 1; Size of array:C274(ta_yEtCiv))
						QUERY:C277([ItemGroupe:43]; [ItemGroupe:43]IT_Catégorie:2=<>ta_ItemGroupe{1}; *)
						QUERY:C277([ItemGroupe:43];  & ; [ItemGroupe:43]IT_Libellé:3=ta_yEtCiv{$ii})
						MultiSoc_Filter(->[ItemGroupe:43])
						If (Records in selection:C76([ItemGroupe:43])>0)
							CREATE SET:C116([ItemGroupe:43]; "$e_LaSel")
							DIFFERENCE:C122("$e_Tous"; "$e_LaSel"; "$e_Tous")
						End if 
					End for 
					$ii:=Records in set:C195("$e_Tous")
					If ($ii>0)
						If (i_Confirmer("Groupement état civil : "+String:C10($ii)+" fiche"+("s"*Num:C11($ii>1))+" en plus à supprimer !"))
							USE SET:C118("$e_Tous")
							READ WRITE:C146([ItemGroupe:43])
							DELETE SELECTION:C66([ItemGroupe:43])
							READ ONLY:C145([ItemGroupe:43])
						End if 
					Else 
						BEEP:C151
					End if 
				End if 
		End case 
End case 