//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Fonction : F_SIAOStatDonnees
//{          Mercredi 6 aril 2011 à 16:20
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215
C_LONGINT:C283($1)
C_LONGINT:C283($ii; $vl_Taille)
Case of 
	: ($1=-1)
		C_LONGINT:C283(vl_Siao_S_DiD; vl_Siao_S_DiP; vl_Siao_S_DfD; vl_Siao_S_DfP; vl_Siao_S_DgD; vl_Siao_S_DgP; vl_Siao_S_DsDT; vl_Siao_S_DsPT)
		
		C_LONGINT:C283(vl_Siao_S_TiD; vl_Siao_S_TiP; vl_Siao_S_TuD; vl_Siao_S_TuP)
		C_LONGINT:C283(vl_Siao_S_AnD; vl_Siao_S_AnP)
		
		ARRAY TEXT:C222(ta_Siao_S_item; 0)
		ARRAY LONGINT:C221(tl_Siao_S_Nombre; 0)
		C_LONGINT:C283(vl_Siao_S_NbTotal)
		
		ARRAY TEXT:C222(ta_Rubrique; 7)
		ARRAY INTEGER:C220(te_Rubrique; 7)
		ta_Rubrique{1}:="Statut de la demande"
		//tp_Rubrique{1}:=->[SIAO]Si_Etat_Type
		te_Rubrique{1}:=1
		ta_Rubrique{2}:="1ere Proposition d'orientation de la personne ayant effectué l'entretien "
		te_Rubrique{2}:=2
		ta_Rubrique{3}:="2me Proposition d'orientation de la personne ayant effectué l'entretien "
		te_Rubrique{3}:=3
		ta_Rubrique{4}:="3me Proposition d'orientation de la personne ayant effectué l'entretien "
		te_Rubrique{4}:=4
		ta_Rubrique{5}:="1ere Proposition d'orientation du SIAO "
		te_Rubrique{5}:=5
		ta_Rubrique{6}:="2me Proposition d'orientation du SIAO "
		te_Rubrique{6}:=6
		ta_Rubrique{7}:="3me Proposition d'orientation du SIAO "
		te_Rubrique{7}:=7
		
		
		$vl_Taille:=Size of array:C274(<>ta_SIAO_Etat)
		ARRAY TEXT:C222(ta_Siao_Rubrique1; $vl_Taille)
		ARRAY LONGINT:C221(tl_Siao_Rubrique1; $vl_Taille)
		For ($ii; 1; $vl_Taille)
			ta_Siao_Rubrique1{$ii}:=<>ta_SIAO_Etat{$ii}
			tl_Siao_Rubrique1{$ii}:=0
		End for 
		
		
		$vl_Taille:=Size of array:C274(<>ta_SIAO_Orienter)
		
		ARRAY TEXT:C222(ta_Siao_Rubrique2; $vl_Taille)
		ARRAY LONGINT:C221(tl_Siao_Rubrique2; $vl_Taille)
		
		ARRAY TEXT:C222(ta_Siao_Rubrique3; $vl_Taille)
		ARRAY LONGINT:C221(tl_Siao_Rubrique3; $vl_Taille)
		
		ARRAY TEXT:C222(ta_Siao_Rubrique4; $vl_Taille)
		ARRAY LONGINT:C221(tl_Siao_Rubrique4; $vl_Taille)
		
		ARRAY TEXT:C222(ta_Siao_Rubrique5; $vl_Taille)
		ARRAY LONGINT:C221(tl_Siao_Rubrique5; $vl_Taille)
		
		ARRAY TEXT:C222(ta_Siao_Rubrique6; $vl_Taille)
		ARRAY LONGINT:C221(tl_Siao_Rubrique6; $vl_Taille)
		
		ARRAY TEXT:C222(ta_Siao_Rubrique7; $vl_Taille)
		ARRAY LONGINT:C221(tl_Siao_Rubrique7; $vl_Taille)
		
		For ($ii; 1; $vl_Taille)
			ta_Siao_Rubrique2{$ii}:=<>ta_SIAO_Orienter{$ii}
			tl_Siao_Rubrique2{$ii}:=0
			
			ta_Siao_Rubrique3{$ii}:=<>ta_SIAO_Orienter{$ii}
			tl_Siao_Rubrique3{$ii}:=0
			
			ta_Siao_Rubrique4{$ii}:=<>ta_SIAO_Orienter{$ii}
			tl_Siao_Rubrique4{$ii}:=0
			
			ta_Siao_Rubrique5{$ii}:=<>ta_SIAO_Orienter{$ii}
			tl_Siao_Rubrique5{$ii}:=0
			
			ta_Siao_Rubrique6{$ii}:=<>ta_SIAO_Orienter{$ii}
			tl_Siao_Rubrique6{$ii}:=0
			
			ta_Siao_Rubrique7{$ii}:=<>ta_SIAO_Orienter{$ii}
			tl_Siao_Rubrique7{$ii}:=0
		End for 
		
		
	: ($1=0)
		vl_Siao_S_DiD:=0
		vl_Siao_S_DiP:=0
		vl_Siao_S_DfD:=0
		vl_Siao_S_DfP:=0
		vl_Siao_S_DgD:=0
		vl_Siao_S_DgP:=0
		vl_Siao_S_DsDT:=0
		vl_Siao_S_DsPT:=0
		
		vl_Siao_S_TiD:=0
		vl_Siao_S_TiP:=0
		vl_Siao_S_TuD:=0
		vl_Siao_S_TuP:=0
		
		vl_Siao_S_AnD:=0
		vl_Siao_S_AnP:=0
		
		
		$vl_Taille:=Size of array:C274(tl_Siao_S_Nombre)
		For ($ii; 1; $vl_Taille)
			tl_Siao_S_Nombre{$ii}:=0
		End for 
		
		vl_Siao_S_NbTotal:=0
		
		
		
		$vl_Taille:=Size of array:C274(tl_Siao_Rubrique1)
		For ($ii; 1; $vl_Taille)
			tl_Siao_Rubrique1{$ii}:=0
		End for 
		
		
		$vl_Taille:=Size of array:C274(tl_Siao_Rubrique2)
		For ($ii; 1; $vl_Taille)
			tl_Siao_Rubrique2{$ii}:=0
			
			tl_Siao_Rubrique3{$ii}:=0
			
			tl_Siao_Rubrique4{$ii}:=0
			
			tl_Siao_Rubrique5{$ii}:=0
			
			tl_Siao_Rubrique6{$ii}:=0
			
			tl_Siao_Rubrique7{$ii}:=0
		End for 
		
	: ($1=1)
		$vb_OK:=F_SIAOStatDonnees(0)
		If (F_SIAOStatDonneesRec(0))
			CREATE SET:C116([SIAO:50]; "E_Temp")
			
			USE SET:C118("E_Temp")
			QUERY SELECTION:C341([SIAO:50]; [SIAO:50]Si_Demande_Type:5=1)
			vl_Siao_S_DiD:=Records in selection:C76([SIAO:50])
			SELECTION TO ARRAY:C260([SIAO:50]Si_RéférenceID:1; $tl_Temp)
			QUERY WITH ARRAY:C644([SIAO_Personnes:51]Sp_SIAO_ID:2; $tl_Temp)
			vl_Siao_S_DiP:=Records in selection:C76([SIAO_Personnes:51])
			
			USE SET:C118("E_Temp")
			QUERY SELECTION:C341([SIAO:50]; [SIAO:50]Si_Demande_Type:5=2)
			vl_Siao_S_DfD:=Records in selection:C76([SIAO:50])
			SELECTION TO ARRAY:C260([SIAO:50]Si_RéférenceID:1; $tl_Temp)
			QUERY WITH ARRAY:C644([SIAO_Personnes:51]Sp_SIAO_ID:2; $tl_Temp)
			vl_Siao_S_DfP:=Records in selection:C76([SIAO_Personnes:51])
			
			USE SET:C118("E_Temp")
			QUERY SELECTION:C341([SIAO:50]; [SIAO:50]Si_Demande_Type:5=3)
			vl_Siao_S_DgD:=Records in selection:C76([SIAO:50])
			SELECTION TO ARRAY:C260([SIAO:50]Si_RéférenceID:1; $tl_Temp)
			QUERY WITH ARRAY:C644([SIAO_Personnes:51]Sp_SIAO_ID:2; $tl_Temp)
			vl_Siao_S_DgP:=Records in selection:C76([SIAO_Personnes:51])
			
			vl_Siao_S_DsDT:=vl_Siao_S_DiD+vl_Siao_S_DfD+vl_Siao_S_DgD
			vl_Siao_S_DsPT:=vl_Siao_S_DiP+vl_Siao_S_DfP+vl_Siao_S_DgP
			
			USE SET:C118("E_Temp")
			QUERY SELECTION:C341([SIAO:50]; [SIAO:50]Si_Trans_Type:34=True:C214)
			vl_Siao_S_TiD:=Records in selection:C76([SIAO:50])
			SELECTION TO ARRAY:C260([SIAO:50]Si_RéférenceID:1; $tl_Temp)
			QUERY WITH ARRAY:C644([SIAO_Personnes:51]Sp_SIAO_ID:2; $tl_Temp)
			vl_Siao_S_TiP:=Records in selection:C76([SIAO_Personnes:51])
			
			
			USE SET:C118("E_Temp")
			QUERY SELECTION:C341([SIAO:50]; [SIAO:50]Si_Trans_Type:34=False:C215)
			vl_Siao_S_TuD:=Records in selection:C76([SIAO:50])
			SELECTION TO ARRAY:C260([SIAO:50]Si_RéférenceID:1; $tl_Temp)
			QUERY WITH ARRAY:C644([SIAO_Personnes:51]Sp_SIAO_ID:2; $tl_Temp)
			vl_Siao_S_TuP:=Records in selection:C76([SIAO_Personnes:51])
			
			USE SET:C118("E_Temp")
			QUERY SELECTION:C341([SIAO:50]; [SIAO:50]Si_DemandeAnnulee_Date:30>!00-00-00!)
			vl_Siao_S_AnD:=Records in selection:C76([SIAO:50])
			SELECTION TO ARRAY:C260([SIAO:50]Si_RéférenceID:1; $tl_Temp)
			QUERY WITH ARRAY:C644([SIAO_Personnes:51]Sp_SIAO_ID:2; $tl_Temp)
			vl_Siao_S_AnP:=Records in selection:C76([SIAO_Personnes:51])
			
			USE SET:C118("E_Temp")
			Repeat 
				$ii:=Find in array:C230(ta_Siao_Rubrique1; [SIAO:50]Si_Etat_Type:41)
				If ($ii>0)
					tl_Siao_Rubrique1{$ii}:=tl_Siao_Rubrique1{$ii}+1
				End if 
				NEXT RECORD:C51([SIAO:50])
			Until (End selection:C36([SIAO:50]))
			
			
			USE SET:C118("E_Temp")
			SELECTION TO ARRAY:C260([SIAO:50]Si_RéférenceID:1; $tl_Temp)
			QUERY WITH ARRAY:C644([SIAO_Personnes:51]Sp_SIAO_ID:2; $tl_Temp)
			QUERY SELECTION:C341([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Rang:7=1)
			SELECTION TO ARRAY:C260([SIAO_Personnes:51]Sp_RéférenceID:1; $tl_Temp)
			QUERY WITH ARRAY:C644([SIAO_Situations:52]Ss_SIAO_Personne_ID:3; $tl_Temp)
			QUERY SELECTION:C341([SIAO_Situations:52]; [SIAO_Situations:52]Ss_Theme:5=ta_SIAO_PageTitre{12})
			If (Records in selection:C76([SIAO_Situations:52])>0)
				Repeat 
					If ([SIAO_Situations:52]Ss_SousTheme:6="B")
						Case of 
							: ([SIAO_Situations:52]Ss_Rang:7=1)
								$ii:=Find in array:C230(ta_Siao_Rubrique2; [SIAO_Situations:52]Ss_Intitule:9)
								If ($ii>0)
									tl_Siao_Rubrique2{$ii}:=tl_Siao_Rubrique2{$ii}+1
								End if 
							: ([SIAO_Situations:52]Ss_Rang:7=2)
								$ii:=Find in array:C230(ta_Siao_Rubrique3; [SIAO_Situations:52]Ss_Intitule:9)
								If ($ii>0)
									tl_Siao_Rubrique3{$ii}:=tl_Siao_Rubrique3{$ii}+1
								End if 
							: ([SIAO_Situations:52]Ss_Rang:7=3)
								$ii:=Find in array:C230(ta_Siao_Rubrique4; [SIAO_Situations:52]Ss_Intitule:9)
								If ($ii>0)
									tl_Siao_Rubrique4{$ii}:=tl_Siao_Rubrique4{$ii}+1
								End if 
						End case 
					End if 
					If ([SIAO_Situations:52]Ss_SousTheme:6="C")
						Case of 
							: ([SIAO_Situations:52]Ss_Rang:7=1)
								$ii:=Find in array:C230(ta_Siao_Rubrique5; [SIAO_Situations:52]Ss_Intitule:9)
								If ($ii>0)
									tl_Siao_Rubrique5{$ii}:=tl_Siao_Rubrique5{$ii}+1
								End if 
							: ([SIAO_Situations:52]Ss_Rang:7=2)
								$ii:=Find in array:C230(ta_Siao_Rubrique6; [SIAO_Situations:52]Ss_Intitule:9)
								If ($ii>0)
									tl_Siao_Rubrique6{$ii}:=tl_Siao_Rubrique6{$ii}+1
								End if 
							: ([SIAO_Situations:52]Ss_Rang:7=3)
								$ii:=Find in array:C230(ta_Siao_Rubrique7; [SIAO_Situations:52]Ss_Intitule:9)
								If ($ii>0)
									tl_Siao_Rubrique7{$ii}:=tl_Siao_Rubrique7{$ii}+1
								End if 
						End case 
					End if 
					NEXT RECORD:C51([SIAO_Situations:52])
				Until (End selection:C36([SIAO_Situations:52]))
			End if 
		End if 
		
		ARRAY TEXT:C222(ta_Siao_S_item; 0)
		ARRAY LONGINT:C221(tl_Siao_S_Nombre; 0)
		C_LONGINT:C283(vl_Siao_S_NbTotal)
		
		If (Size of array:C274(ta_Rubrique)>0)
			If (ta_Rubrique>0)
				If (ta_Rubrique<=Size of array:C274(ta_Rubrique))
					
				Else 
					ta_Rubrique:=1
				End if 
			Else 
				ta_Rubrique:=1
			End if 
		Else 
			ta_Rubrique:=0
		End if 
		If (ta_Rubrique>0)
			$vb_OK:=F_SIAOStatDonnees(2)
		End if 
		
		
	: ($1=2)
		vp_Pointeur:=Get pointer:C304("ta_Siao_Rubrique"+String:C10(ta_Rubrique))
		COPY ARRAY:C226(vp_Pointeur->; ta_Siao_S_item)
		vp_Pointeur:=Get pointer:C304("tl_Siao_Rubrique"+String:C10(ta_Rubrique))
		COPY ARRAY:C226(vp_Pointeur->; tl_Siao_S_Nombre)
		vl_Siao_S_NbTotal:=0
		For ($ii; 1; Size of array:C274(ta_Siao_S_item))
			vl_Siao_S_NbTotal:=vl_Siao_S_NbTotal+tl_Siao_S_Nombre{$ii}
		End for 
		
		
End case 