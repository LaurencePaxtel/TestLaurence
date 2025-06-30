//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Tab_Présentation_CtrH
//{
//{          Lundi 27 avril 2009 à 11:52:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($ii; $vl_Fenetre; $vl_Position)
C_BOOLEAN:C305($vb_OK)

Case of 
	: ($1=0)  //Déclarations
		//Origine
		ARRAY LONGINT:C221(tl_xCtreH_ID; $2)
		ARRAY TEXT:C222(ta_xCtreH; $2)
		ARRAY INTEGER:C220(te_xCtreH; $2)
		ARRAY INTEGER:C220(te_xCtreH_Etat; $2)
		ARRAY INTEGER:C220(te_xCtreH_Fermé; $2)
		//Affichage
		ARRAY LONGINT:C221(tl_yCtreH_Réf; $2)
		ARRAY TEXT:C222(ta_yCtreH_Réf; $2)
		ARRAY TEXT:C222(ta_yCtreH; $2)
		ARRAY INTEGER:C220(te_yCtreH_Ordre; $2)
		ARRAY INTEGER:C220(te_yCtreH_Etat; $2)
		ARRAY INTEGER:C220(te_yCtreH_Div; $2)
		ARRAY INTEGER:C220(te_yCtreH_Check; $2)
		//Table
		ARRAY LONGINT:C221(tl_FileCtreH_Réf; $2)
		ARRAY TEXT:C222(ta_FileCtreH_Réf; $2)
		ARRAY TEXT:C222(ta_FileCtreH; $2)
		ARRAY TEXT:C222(ta_FilexCtreH; $2)
		ARRAY LONGINT:C221(tl_FilexCtreH_Réf; $2)
		ARRAY INTEGER:C220(te_FileCtreH_Ordre; $2)
		ARRAY INTEGER:C220(te_FileCtreH_Etat; $2)
		ARRAY INTEGER:C220(te_FileCtreH_Div; $2)
		
		vl_NbCentres:=0
		vl_NbCentresGpe:=0
		vl_NbCentresNA:=0
		vl_NbCentresItem:=0
		vl_NbCentresLiés:=0
		
	: ($1=1)  //Synchro    
		Case of 
			: ($3=1)  //Origine
				tl_xCtreH_ID:=$2
				ta_xCtreH:=$2
				te_xCtreH:=$2
				te_xCtreH_Etat:=$2
				te_xCtreH_Fermé:=$2
			: ($3=2)  //Affichage
				tl_yCtreH_Réf:=$2
				ta_yCtreH_Réf:=$2
				ta_yCtreH:=$2
				te_yCtreH_Ordre:=$2
				te_yCtreH_Etat:=$2
				te_yCtreH_Div:=$2
				te_yCtreH_Check:=$2
			: ($3=3)  //Table
				tl_FileCtreH_Réf:=$2
				ta_FileCtreH_Réf:=$2
				ta_FileCtreH:=$2
				ta_FilexCtreH:=$2
				tl_FilexCtreH_Réf:=$2
				te_FileCtreH_Ordre:=$2
				te_FileCtreH_Etat:=$2
				te_FileCtreH_Div:=$2
		End case 
		
	: ($1=2)  //Chargement des données
		ARRAY LONGINT:C221($tl_Temp; 0)
		//Tableau de gauche    
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Prestation:55=False:C215; *)
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Fermé:53=False:C215; *)
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Nom:4>"")
		MultiSoc_Filter(->[LesCentres:9])
		vl_NbCentres:=Records in selection:C76([LesCentres:9])
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
		SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; tl_xCtreH_ID; [LesCentres:9]LC_Nom:4; ta_xCtreH)
		
		ARRAY INTEGER:C220(te_xCtreH_Fermé; vl_NbCentres)
		For ($ii; 1; vl_NbCentres)
			te_xCtreH_Fermé{$ii}:=0
		End for 
		
		QUERY:C277([PreSentation:44]; [PreSentation:44]PS_Catégorie:3=<>ta_ItemGroupe{2}; *)
		QUERY:C277([PreSentation:44];  & ; [PreSentation:44]PS_Scénario:2=va_LibScénario; *)
		QUERY:C277([PreSentation:44];  & ; [PreSentation:44]PS_LibelléOrigneID:6>0)
		MultiSoc_Filter(->[PreSentation:44])
		If (Records in selection:C76([PreSentation:44])>0)
			SELECTION TO ARRAY:C260([PreSentation:44]PS_LibelléOrigneID:6; $tl_Temp)
			
			For ($ii; 1; Size of array:C274($tl_Temp))
				$vl_Position:=Find in array:C230(tl_xCtreH_ID; $tl_Temp{$ii})
				If ($vl_Position<=0)
					QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=$tl_Temp{$ii})
					MultiSoc_Filter(->[LesCentres:9])
					If (Records in selection:C76([LesCentres:9])=1)
						vl_NbCentres:=Size of array:C274(tl_xCtreH_ID)+1
						INSERT IN ARRAY:C227(tl_xCtreH_ID; vl_NbCentres)
						INSERT IN ARRAY:C227(ta_xCtreH; vl_NbCentres)
						INSERT IN ARRAY:C227(te_xCtreH_Fermé; vl_NbCentres)
						tl_xCtreH_ID{vl_NbCentres}:=$tl_Temp{$ii}
						ta_xCtreH{vl_NbCentres}:=[LesCentres:9]LC_Nom:4
						te_xCtreH_Fermé{vl_NbCentres}:=1
					End if 
				End if 
			End for 
		End if 
		vl_NbCentres:=Size of array:C274(tl_xCtreH_ID)
		ARRAY INTEGER:C220(te_xCtreH; vl_NbCentres)
		ARRAY INTEGER:C220(te_xCtreH_Etat; vl_NbCentres)
		For ($ii; 1; vl_NbCentres)
			te_xCtreH{$ii}:=0
			te_xCtreH_Etat{$ii}:=0
		End for 
		//Tableau de droite
		QUERY:C277([PreSentation:44]; [PreSentation:44]PS_Catégorie:3=<>ta_ItemGroupe{2}; *)
		QUERY:C277([PreSentation:44];  & ; [PreSentation:44]PS_Scénario:2=va_LibScénario; *)
		QUERY:C277([PreSentation:44];  & ; [PreSentation:44]PS_LibelléOrigneID:6=0)
		MultiSoc_Filter(->[PreSentation:44])
		vl_NbCentresGpe:=Records in selection:C76([PreSentation:44])
		ORDER BY:C49([PreSentation:44]; [PreSentation:44]PS_Libellé:4; >)
		SELECTION TO ARRAY:C260([PreSentation:44]PS_RéférenceID:1; tl_yCtreH_Réf; [PreSentation:44]PS_Catégorie:3; ta_yCtreH_Réf; [PreSentation:44]PS_Libellé:4; ta_yCtreH; [PreSentation:44]PS_Ordre:7; te_yCtreH_Ordre; [PreSentation:44]PS_Diviseur:9; te_yCtreH_Div)
		ARRAY INTEGER:C220(te_yCtreH_Etat; vl_NbCentresGpe)
		ARRAY INTEGER:C220(te_yCtreH_Check; vl_NbCentresGpe)
		For ($ii; 1; vl_NbCentresGpe)
			te_yCtreH_Etat{$ii}:=0
			te_yCtreH_Check{$ii}:=0
		End for 
		//Tableau caché
		QUERY:C277([PreSentation:44]; [PreSentation:44]PS_Catégorie:3=<>ta_ItemGroupe{2}; *)
		QUERY:C277([PreSentation:44];  & ; [PreSentation:44]PS_Scénario:2=va_LibScénario; *)
		QUERY:C277([PreSentation:44];  & ; [PreSentation:44]PS_LibelléOrigneID:6>0)
		MultiSoc_Filter(->[PreSentation:44])
		vl_NbCentresNA:=Records in selection:C76([PreSentation:44])
		ORDER BY:C49([PreSentation:44]; [PreSentation:44]PS_Libellé:4; >)
		SELECTION TO ARRAY:C260([PreSentation:44]PS_RéférenceID:1; tl_FileCtreH_Réf; [PreSentation:44]PS_Catégorie:3; ta_FileCtreH_Réf; [PreSentation:44]PS_Libellé:4; ta_FileCtreH; [PreSentation:44]PS_LibelléOrigine:5; ta_FilexCtreH; [PreSentation:44]PS_LibelléOrigneID:6; tl_FilexCtreH_Réf; [PreSentation:44]PS_Ordre:7; te_FileCtreH_Ordre; [PreSentation:44]PS_Etat:8; te_FileCtreH_Etat; [PreSentation:44]PS_Diviseur:9; te_FileCtreH_Div)
		
		Tab_Présentation_CtrH(3; 0; 1)  //Relié ou pas
		Tab_Présentation_CtrH(3; 0; 2)  //Nombre de centres reliés
		
		If (vl_NbCentres>0)
			$ii:=1
		Else 
			$ii:=0
		End if 
		
		Tab_Présentation_CtrH(1; $ii; 1)  //Synchroniser       
		Tab_Présentation_CtrH(4; $ii; 1)  //Clic dans le tableau de gauche
		
		
	: ($1=3)  //Tableaux : Statut de l'état
		Case of 
			: ($3=1)  //Origine rattachée ou non 
				For ($ii; 1; Size of array:C274(ta_xCtreH))
					$jj:=Find in array:C230(tl_FilexCtreH_Réf; tl_xCtreH_ID{$ii})
					te_xCtreH_Etat{$ii}:=Num:C11($jj>0)
				End for 
				
			: ($3=2)  //Groupement : nb de centres reliés
				//Nb de etat civils rattachés
				vl_NbCentresItem:=0
				For ($ii; 1; Size of array:C274(tl_yCtreH_Réf))
					te_yCtreH_Etat{$ii}:=0
					For ($jj; 1; Size of array:C274(tl_FileCtreH_Réf))
						If (ta_yCtreH{$ii}=ta_FileCtreH{$jj}) & (tl_FilexCtreH_Réf{$jj}>0)
							te_yCtreH_Etat{$ii}:=te_yCtreH_Etat{$ii}+1
						End if 
					End for 
					vl_NbCentresItem:=vl_NbCentresItem+te_yCtreH_Etat{$ii}
				End for 
		End case 
		
	: ($1=4)  //Tableaux : Clic
		Case of 
			: ($3=1)  //Origine
				For ($ii; 1; Size of array:C274(tl_yCtreH_Réf))
					te_yCtreH_Check{$ii}:=0
				End for 
				$jj:=0
				If ($2>0)
					$ii:=Find in array:C230(tl_FilexCtreH_Réf; tl_xCtreH_ID{$2})
					If ($ii>0)
						$jj:=Find in array:C230(ta_yCtreH; ta_FileCtreH{$ii})
						If ($jj>0)
							te_yCtreH_Check{$jj}:=1
						End if 
					End if 
				End if 
				
			: ($3=2)  //Groupement
				For ($ii; 1; Size of array:C274(ta_xCtreH))
					te_xCtreH{$ii}:=0
				End for 
				For ($ii; 1; Size of array:C274(tl_FileCtreH_Réf))
					If (ta_yCtreH{$2}=ta_FileCtreH{$ii})
						$jj:=Find in array:C230(tl_xCtreH_ID; tl_FilexCtreH_Réf{$ii})
						te_xCtreH{$jj}:=Num:C11($jj>0)
					End if 
				End for 
		End case 
		
	: ($1=5)  //Tableaux : Ajouter
		Case of 
			: ($3=1)
				$ii:=Size of array:C274(tl_xCtreH_ID)+1
				INSERT IN ARRAY:C227(tl_xCtreH_ID; $ii)
				INSERT IN ARRAY:C227(ta_xCtreH; $ii)
				INSERT IN ARRAY:C227(te_xCtreH; $ii)
				INSERT IN ARRAY:C227(te_xCtreH_Etat; $ii)
				INSERT IN ARRAY:C227(te_xCtreH_Fermé; $ii)
			: ($3=2)
				$ii:=Size of array:C274(tl_yCtreH_Réf)+1
				INSERT IN ARRAY:C227(tl_yCtreH_Réf; $ii)
				INSERT IN ARRAY:C227(ta_yCtreH_Réf; $ii)
				INSERT IN ARRAY:C227(ta_yCtreH; $ii)
				INSERT IN ARRAY:C227(te_yCtreH_Ordre; $ii)
				INSERT IN ARRAY:C227(te_yCtreH_Etat; $ii)
				INSERT IN ARRAY:C227(te_yCtreH_Div; $ii)
				INSERT IN ARRAY:C227(te_yCtreH_Check; $ii)
			: ($3=3)
				$ii:=Size of array:C274(tl_FileCtreH_Réf)+1
				INSERT IN ARRAY:C227(tl_FileCtreH_Réf; $ii)
				INSERT IN ARRAY:C227(ta_FileCtreH_Réf; $ii)
				INSERT IN ARRAY:C227(ta_FileCtreH; $ii)
				INSERT IN ARRAY:C227(ta_FilexCtreH; $ii)
				INSERT IN ARRAY:C227(tl_FilexCtreH_Réf; $ii)
				INSERT IN ARRAY:C227(te_FileCtreH_Ordre; $ii)
				INSERT IN ARRAY:C227(te_FileCtreH_Etat; $ii)
				INSERT IN ARRAY:C227(te_FileCtreH_Div; $ii)
		End case 
		
	: ($1=6)  //Tableaux : Affecter
		$ii:=$2
		Case of 
			: ($3=1)
			: ($3=2)
				tl_yCtreH_Réf{$ii}:=[PreSentation:44]PS_RéférenceID:1
				ta_yCtreH_Réf{$ii}:=[PreSentation:44]PS_Catégorie:3
				ta_yCtreH{$ii}:=[PreSentation:44]PS_Libellé:4
				te_yCtreH_Ordre{$ii}:=[PreSentation:44]PS_Ordre:7
				te_yCtreH_Etat{$ii}:=[PreSentation:44]PS_Etat:8
				te_yCtreH_Div{$ii}:=[PreSentation:44]PS_Diviseur:9
				te_yCtreH_Check{$ii}:=0
			: ($3=3)
				tl_FileCtreH_Réf{$ii}:=[PreSentation:44]PS_RéférenceID:1
				ta_FileCtreH_Réf{$ii}:=[PreSentation:44]PS_Catégorie:3
				ta_FileCtreH{$ii}:=[PreSentation:44]PS_Libellé:4
				ta_FilexCtreH{$ii}:=[PreSentation:44]PS_LibelléOrigine:5
				tl_FilexCtreH_Réf{$ii}:=[PreSentation:44]PS_LibelléOrigneID:6
				te_FileCtreH_Ordre{$ii}:=[PreSentation:44]PS_Ordre:7
				te_FileCtreH_Etat{$ii}:=[PreSentation:44]PS_Etat:8
				te_FileCtreH_Div{$ii}:=[PreSentation:44]PS_Diviseur:9
		End case 
		
	: ($1=7)  //Tableaux : Affecter plusieurs lignes  :synchro apres modif
		i_Message("Mise à jour en cours…")
		READ WRITE:C146([PreSentation:44])
		For ($ii; 1; Size of array:C274(tl_FileCtreH_Réf))
			If (ta_FileCtreH{$ii}=va_LibEnum)
				ta_FileCtreH{$ii}:=ta_yCtreH{$2}
				te_FileCtreH_Ordre{$ii}:=te_yCtreH_Ordre{$2}
				te_FileCtreH_Div{$ii}:=te_yCtreH_Div{$2}
				QUERY:C277([PreSentation:44]; [PreSentation:44]PS_RéférenceID:1=tl_FileCtreH_Réf{$ii})
				MultiSoc_Filter(->[PreSentation:44])
				If (Records in selection:C76([PreSentation:44])=1)
					Repeat 
						LOAD RECORD:C52([PreSentation:44])
					Until (Not:C34(Locked:C147([PreSentation:44])))
					[PreSentation:44]PS_Libellé:4:=ta_FileCtreH{$ii}
					[PreSentation:44]PS_Ordre:7:=te_FileCtreH_Ordre{$ii}
					[PreSentation:44]PS_Diviseur:9:=te_FileCtreH_Div{$ii}
					SAVE RECORD:C53([PreSentation:44])
					UNLOAD RECORD:C212([PreSentation:44])
				End if 
				UNLOAD RECORD:C212([PreSentation:44])
			End if 
		End for 
		READ ONLY:C145([PreSentation:44])
		CLOSE WINDOW:C154
		
	: ($1=8)  //Tableaux : Suppression de plusieurs lignes de tableau général  : synchro sup
		Case of 
			: ($3=1)
				
			: ($3=2)
				DELETE FROM ARRAY:C228(tl_yCtreH_Réf; $2; 1)
				DELETE FROM ARRAY:C228(ta_yCtreH_Réf; $2; 1)
				DELETE FROM ARRAY:C228(ta_yCtreH; $2; 1)
				DELETE FROM ARRAY:C228(te_yCtreH_Ordre; $2; 1)
				DELETE FROM ARRAY:C228(te_yCtreH_Etat; $2; 1)
				DELETE FROM ARRAY:C228(te_yCtreH_Div; $2; 1)
				DELETE FROM ARRAY:C228(te_yCtreH_Check; $2; 1)
				
			: ($3=3)
				
				DELETE FROM ARRAY:C228(tl_FileCtreH_Réf; $2; 1)
				DELETE FROM ARRAY:C228(ta_FileCtreH_Réf; $2; 1)
				DELETE FROM ARRAY:C228(ta_FileCtreH; $2; 1)
				DELETE FROM ARRAY:C228(ta_FilexCtreH; $2; 1)
				DELETE FROM ARRAY:C228(tl_FilexCtreH_Réf; $2; 1)
				DELETE FROM ARRAY:C228(te_FileCtreH_Ordre; $2; 1)
				DELETE FROM ARRAY:C228(te_FileCtreH_Etat; $2; 1)
				DELETE FROM ARRAY:C228(te_FileCtreH_Div; $2; 1)
		End case 
		
	: ($1=9)  //Trier
		tl_yCtreH_Réf{0}:=tl_yCtreH_Réf{ta_yCtreH}
		Case of 
			: ($2=1)
				If ($3=1)
					SORT ARRAY:C229(ta_yCtreH; tl_yCtreH_Réf; ta_yCtreH_Réf; te_yCtreH_Ordre; te_yCtreH_Etat; te_yCtreH_Div; te_yCtreH_Check; <)
				Else 
					SORT ARRAY:C229(ta_yCtreH; tl_yCtreH_Réf; ta_yCtreH_Réf; te_yCtreH_Ordre; te_yCtreH_Etat; te_yCtreH_Div; te_yCtreH_Check; >)
				End if 
				
			: ($2=2)
				If ($3=1)
					SORT ARRAY:C229(te_yCtreH_Ordre; tl_yCtreH_Réf; ta_yCtreH_Réf; ta_yCtreH; te_yCtreH_Etat; te_yCtreH_Div; te_yCtreH_Check; <)
				Else 
					SORT ARRAY:C229(te_yCtreH_Ordre; tl_yCtreH_Réf; ta_yCtreH_Réf; ta_yCtreH; te_yCtreH_Etat; te_yCtreH_Div; te_yCtreH_Check; >)
				End if 
			: ($2=3)
		End case 
		$ii:=Find in array:C230(tl_yCtreH_Réf; tl_yCtreH_Réf{0})
		If ($ii<0)
			$ii:=0
		End if 
		Tab_Présentation_CtrH(1; $ii; 2)
		
	: ($1=20)  //Demande de liaison
		$vb_OK:=($2>0)
		$vb_OK:=$vb_OK & ($3>0)
		If ($vb_OK)
			//Recherche dans le tableau caché l'existance d'un lien éventuel
			$ii:=Find in array:C230(tl_FilexCtreH_Réf; tl_xCtreH_ID{$2})
			If ($ii>0)
				If (i_Confirmer(ta_xCtreH{$2}+" est déjà rattaché à : "+ta_FileCtreH{$ii}+<>va_CR+"Veuillez confirmer le transfert ?"))
					//Commencer par détacher puis rattacher
					Tab_Présentation_CtrH(22; $2; $3)  //Modifier la liaison
				End if 
			Else   //Pas de lien
				Tab_Présentation_CtrH(21; $2; $3)
			End if 
		End if 
		
	: ($1=21)  //Effectuer la liaison
		READ WRITE:C146([PreSentation:44])
		CREATE RECORD:C68([PreSentation:44])
		MultiSoc_Init_Structure(->[PreSentation:44])
		[PreSentation:44]PS_RéférenceID:1:=Uut_Numerote(->[PreSentation:44])
		[PreSentation:44]PS_Scénario:2:=va_LibScénario
		[PreSentation:44]PS_Catégorie:3:=<>ta_ItemGroupe{2}
		[PreSentation:44]PS_Libellé:4:=ta_yCtreH{$3}
		[PreSentation:44]PS_LibelléOrigine:5:=ta_xCtreH{$2}
		[PreSentation:44]PS_LibelléOrigneID:6:=tl_xCtreH_ID{$2}
		[PreSentation:44]PS_Ordre:7:=te_yCtreH_Ordre{$3}
		[PreSentation:44]PS_Etat:8:=0
		[PreSentation:44]PS_Diviseur:9:=te_yCtreH_Div{$3}
		SAVE RECORD:C53([PreSentation:44])
		Tab_Présentation_CtrH(5; 0; 3)
		$ii:=Size of array:C274(tl_FileCtreH_Réf)
		Tab_Présentation_CtrH(6; $ii; 3)
		UNLOAD RECORD:C212([PreSentation:44])
		READ ONLY:C145([PreSentation:44])
		//Tab_Présentation_CtrH (3;0;1)
		te_xCtreH{$2}:=1  //Signe Plus de la liaison activée 		
		te_xCtreH_Etat{$2}:=1  //Signe X de l'existance de la laison 
		Tab_Présentation_CtrH(3; 0; 2)
		Tab_Présentation_CtrH(4; $2; 1)
		
	: ($1=22)  //Modifier la liaison
		i_Message("Mise à jour en cours…")
		$ii:=Find in array:C230(tl_FilexCtreH_Réf; tl_xCtreH_ID{$2})
		READ WRITE:C146([PreSentation:44])
		QUERY:C277([PreSentation:44]; [PreSentation:44]PS_RéférenceID:1=tl_FileCtreH_Réf{$ii})
		MultiSoc_Filter(->[PreSentation:44])
		If (Records in selection:C76([PreSentation:44])=1)
			Repeat 
				LOAD RECORD:C52([PreSentation:44])
			Until (Not:C34(Locked:C147([PreSentation:44])))
			[PreSentation:44]PS_Libellé:4:=ta_yCtreH{$3}
			//[PreSentation]PS_LibelléOrigine:=ta_xCtreH{$2}
			//[PreSentation]PS_LibelléOrigneID:=tl_xCtreH_ID{$2}
			[PreSentation:44]PS_Ordre:7:=te_yCtreH_Ordre{$3}
			[PreSentation:44]PS_Etat:8:=0
			[PreSentation:44]PS_Diviseur:9:=te_yCtreH_Div{$3}
			SAVE RECORD:C53([PreSentation:44])
			UNLOAD RECORD:C212([PreSentation:44])
			ta_FileCtreH{$ii}:=ta_yCtreH{$3}
			te_FileCtreH_Ordre{$ii}:=te_yCtreH_Ordre{$3}
			te_FileCtreH_Etat{$ii}:=0
			te_FileCtreH_Div{$ii}:=te_yCtreH_Div{$3}
			
			te_xCtreH{$2}:=1  //Signe Plus de la liaison activée 		
			te_xCtreH_Etat{$2}:=1  //Signe X de l'existance de la laison 
		End if 
		UNLOAD RECORD:C212([PreSentation:44])
		READ ONLY:C145([PreSentation:44])
		Tab_Présentation_CtrH(3; 0; 1)
		Tab_Présentation_CtrH(3; 0; 2)
		Tab_Présentation_CtrH(4; $2; 1)
		
		
		
	: ($1=30)  //Supprimer une liaison
		$vb_OK:=($2>0)
		$vb_OK:=$vb_OK & (Find in array:C230(tl_FilexCtreH_Réf; tl_xCtreH_ID{$2})>0)
		If ($vb_OK)
			$ii:=Find in array:C230(tl_FilexCtreH_Réf; tl_xCtreH_ID{$2})
			If ($ii>0)
				$jj:=Find in array:C230(ta_yCtreH; ta_FileCtreH{$ii})
				If ($jj>0)
				Else 
					$jj:=0
				End if 
				If (i_Confirmer(ta_xCtreH{$2}+" est rattaché à : "+ta_yCtreH{$jj}+<>va_CR+"Veuillez confirmer la suppression de la liaison ?"))
					READ WRITE:C146([PreSentation:44])
					QUERY:C277([PreSentation:44]; [PreSentation:44]PS_RéférenceID:1=tl_FileCtreH_Réf{$ii})
					MultiSoc_Filter(->[PreSentation:44])
					If (Records in selection:C76([PreSentation:44])=1)
						Repeat 
							LOAD RECORD:C52([PreSentation:44])
						Until (Not:C34(Locked:C147([PreSentation:44])))
						DELETE RECORD:C58([PreSentation:44])
						UNLOAD RECORD:C212([PreSentation:44])
						//Supprimer la ligne de tableau
						Tab_Présentation_CtrH(8; $ii; 3)
						
						te_xCtreH{$2}:=0  //Signe Plus de la liaison desactivée 		
						te_xCtreH_Etat{$2}:=0  //Effacer le Signe X de l'existance de la laison
						Tab_Présentation_CtrH(3; 0; 2)
						Tab_Présentation_CtrH(4; $2; 1)
					End if 
					READ ONLY:C145([PreSentation:44])
				End if 
			Else 
				ALERT:C41(ta_xCtreH{$2}+" n'est pas rattaché !")
			End if 
		End if 
		
		
	: ($1=40)  //Ajouter une fiche dans la table
		va_LibEnum:=<>ta_ItemGroupe{2}
		READ WRITE:C146([PreSentation:44])
		FORM SET INPUT:C55([PreSentation:44]; "PS_EcranSaisie")
		$vl_Fenetre:=i_FenêtreNo(495; 140; 4; "Libellé de regroupement : nouveau"; 3; "")
		ADD RECORD:C56([PreSentation:44]; *)
		If (OK=1)
			//Nouvelle ligne dans le tableau caché
			//Tab_Présentation_CtrH (5;0;3)
			//Affecter le tableau caché
			//Tab_Présentation_CtrH (6;Taille tableau(tl_FileCtreH_Réf);3)
			
			//Nouvelle ligne dans le tableau de droite
			Tab_Présentation_CtrH(5; 0; 2)
			//Affecter le tableau de droite
			Tab_Présentation_CtrH(6; Size of array:C274(tl_yCtreH_Réf); 2)
			
			Tab_Présentation_CtrH(1; ta_xCtreH; 1)  //Synchroniser     
			Tab_Présentation_CtrH(4; ta_xCtreH; 1)  //Clic dans le tableau de gauche  
			Tab_Présentation_CtrH(1; Size of array:C274(tl_yCtreH_Réf); 2)  //Synchroniser     
			Tab_Présentation_CtrH(4; Size of array:C274(tl_yCtreH_Réf); 2)  //Clic dans le tableau de droite  
			
		End if 
		UNLOAD RECORD:C212([PreSentation:44])
		CLOSE WINDOW:C154($vl_Fenetre)
		READ ONLY:C145([PreSentation:44])
		vl_NbCentresGpe:=Size of array:C274(tl_yCtreH_Réf)
		
		
	: ($1=50)  //Modifier une fiche dans la table
		$vb_OK:=(Size of array:C274(tl_yCtreH_Réf)>0)
		If ($vb_OK)
			$vb_OK:=(ta_yCtreH>0)
		End if 
		
		If ($vb_OK)
			READ WRITE:C146([PreSentation:44])
			QUERY:C277([PreSentation:44]; [PreSentation:44]PS_RéférenceID:1=tl_yCtreH_Réf{ta_yCtreH})
			MultiSoc_Filter(->[PreSentation:44])
			If (Records in selection:C76([PreSentation:44])=1)
				va_LibEnum:=""
				FORM SET INPUT:C55([PreSentation:44]; "PS_EcranSaisie")
				Repeat 
					LOAD RECORD:C52([PreSentation:44])
				Until (Not:C34(Locked:C147([PreSentation:44])))
				$vl_Fenetre:=i_FenêtreNo(495; 140; 4; "Libellé de regroupement : modifier"; 3; "")
				MODIFY RECORD:C57([PreSentation:44]; *)
				If (OK=1)
					//Modification de la fiche à l'écran
					Tab_Présentation_CtrH(6; ta_yCtreH; 2)
					//Modifications générales du libellé de l'item de regroupement
					Tab_Présentation_CtrH(7; ta_yCtreH; 2)
				End if 
				UNLOAD RECORD:C212([PreSentation:44])
				CLOSE WINDOW:C154($vl_Fenetre)
			End if 
			UNLOAD RECORD:C212([PreSentation:44])
			READ ONLY:C145([PreSentation:44])
		End if 
		
	: ($1=60)  //Supprimer une fiche dans la table
		$vb_OK:=(Size of array:C274(tl_yCtreH_Réf)>0)
		If ($vb_OK)
			$vb_OK:=(ta_yCtreH>0)
		End if 
		If ($vb_OK)
			If (i_Confirmer("Confirmez-vous la suppression de l'item : "+ta_yCtreH{$3}))
				va_LibEnum:=ta_yCtreH{$3}
				//Suppressions générales
				i_Message("Mise à jour en cours…")
				READ WRITE:C146([PreSentation:44])
				QUERY:C277([PreSentation:44]; [PreSentation:44]PS_Catégorie:3=<>ta_ItemGroupe{2}; *)
				QUERY:C277([PreSentation:44];  & ; [PreSentation:44]PS_Scénario:2=va_LibScénario; *)
				QUERY:C277([PreSentation:44];  & ; [PreSentation:44]PS_Libellé:4=va_LibEnum)
				MultiSoc_Filter(->[PreSentation:44])
				If (Records in selection:C76([PreSentation:44])>0)
					DELETE SELECTION:C66([PreSentation:44])
				End if 
				UNLOAD RECORD:C212([PreSentation:44])
				READ ONLY:C145([PreSentation:44])
				If (Size of array:C274(tl_FileCtreH_Réf)>0)
					$ii:=1
					Repeat 
						If (ta_FileCtreH{$ii}=va_LibEnum)
							//Suppression des lignes du tableau caché
							Tab_Présentation_CtrH(8; $ii; 3)
						Else 
							$ii:=$ii+1
						End if 
					Until (($ii>Size of array:C274(ta_FileCtreH)))
				End if 
				CLOSE WINDOW:C154
				//Suppression de la fiche à l'écran
				Tab_Présentation_CtrH(8; $3; 2)
				//Synchroniser l'ensemble
				vl_NbCentresGpe:=Size of array:C274(tl_yCtreH_Réf)
				If ($3>vl_NbCentresGpe)
					$3:=vl_NbCentresGpe
				End if 
				Tab_Présentation_CtrH(1; $3; 2)
				Tab_Présentation_CtrH(4; $3; 2)
				Tab_Présentation_CtrH(3; $2; 1)
				Tab_Présentation_CtrH(3; $3; 2)
			End if 
		End if 
		
		
	: ($1=70)  //Vérifier la table    
		Case of 
			: (Size of array:C274(ta_xCtreH)=0)
				QUERY:C277([PreSentation:44]; [PreSentation:44]PS_Catégorie:3=<>ta_ItemGroupe{2}; *)
				QUERY:C277([PreSentation:44];  & ; [PreSentation:44]PS_Scénario:2=va_LibScénario; *)
				QUERY:C277([PreSentation:44];  & ; [PreSentation:44]PS_LibelléOrigneID:6>0)
				MultiSoc_Filter(->[PreSentation:44])
				$ii:=Records in selection:C76([PreSentation:44])
				If ($ii>0)
					If (i_Confirmer("Hébergement : "+String:C10($ii)+" fiche"+("s"*Num:C11($ii>1))+" en plus à supprimer !"))
						USE SET:C118("$e_Tous")
						READ WRITE:C146([PreSentation:44])
						DELETE SELECTION:C66([PreSentation:44])
						READ ONLY:C145([PreSentation:44])
					End if 
				Else 
					BEEP:C151
				End if 
				
			: (Size of array:C274(ta_yCtreH)=0)
				QUERY:C277([PreSentation:44]; [PreSentation:44]PS_Catégorie:3=<>ta_ItemGroupe{2})
				MultiSoc_Filter(->[PreSentation:44])
				$ii:=Records in selection:C76([PreSentation:44])
				If ($ii>0)
					If (i_Confirmer("Hébergement : "+String:C10($ii)+" fiche"+("s"*Num:C11($ii>1))+" en plus à supprimer !"))
						USE SET:C118("$e_Tous")
						READ WRITE:C146([PreSentation:44])
						DELETE SELECTION:C66([PreSentation:44])
						READ ONLY:C145([PreSentation:44])
					End if 
				Else 
					BEEP:C151
				End if 
				
			: (Size of array:C274(ta_yCtreH)>0)
				QUERY:C277([PreSentation:44]; [PreSentation:44]PS_Catégorie:3=<>ta_ItemGroupe{2}; *)
				QUERY:C277([PreSentation:44];  & ; [PreSentation:44]PS_Scénario:2=va_LibScénario; *)
				QUERY:C277([PreSentation:44];  & ; [PreSentation:44]PS_LibelléOrigneID:6>0)
				MultiSoc_Filter(->[PreSentation:44])
				CREATE SET:C116([PreSentation:44]; "$e_Tous")
				For ($ii; 1; Size of array:C274(ta_yCtreH))
					QUERY:C277([PreSentation:44]; [PreSentation:44]PS_Catégorie:3=<>ta_ItemGroupe{2}; *)
					QUERY:C277([PreSentation:44];  & ; [PreSentation:44]PS_Scénario:2=va_LibScénario; *)
					QUERY:C277([PreSentation:44];  & ; [PreSentation:44]PS_Libellé:4=ta_yCtreH{$ii})
					MultiSoc_Filter(->[PreSentation:44])
					If (Records in selection:C76([PreSentation:44])>0)
						CREATE SET:C116([PreSentation:44]; "$e_LaSel")
						DIFFERENCE:C122("$e_Tous"; "$e_LaSel"; "$e_Tous")
					End if 
				End for 
				$ii:=Records in set:C195("$e_Tous")
				If ($ii>0)
					If (i_Confirmer("Hébergement : "+String:C10($ii)+" fiche"+("s"*Num:C11($ii>1))+" en plus à supprimer !"))
						USE SET:C118("$e_Tous")
						READ WRITE:C146([PreSentation:44])
						DELETE SELECTION:C66([PreSentation:44])
						READ ONLY:C145([PreSentation:44])
					End if 
				Else 
					BEEP:C151
				End if 
		End case 
End case 