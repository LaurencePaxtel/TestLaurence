//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_MaraudeEtude
//{
//{          Mardi 10 mai 2005 à 12:19:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}


C_LONGINT:C283($ii)
If (vl_NbJ>366) | (vl_NbJ<1)
	ALERT:C41("Vous ne pouvez pas excéder une année !")
Else 
	i_Message("Chargement en cours …")
	i_Stop
	ON EVENT CALL:C190("i_Stop_ESC")
	
	i_MessageSeul("Sélection des fiches…")
	If (<>vb_StopEven=False:C215)
		
		//Recherche directe
		If (vd_Date1=vd_Date2)
			QUERY:C277([Maraude:24]; [Maraude:24]MR_Date:4=vd_Date1; *)
		Else 
			QUERY:C277([Maraude:24]; [Maraude:24]MR_Date:4>=vd_Date1; *)
			QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_Date:4<=vd_Date2; *)
		End if 
		If (rJourNuit1=1) & (rJourNuit2=1)  //Jour et nuit
		Else 
			If (rJourNuit1=1)  //Jour
				QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_Nuit:2=False:C215; *)
			End if 
			If (rJourNuit2=1)  //nuit
				QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_Nuit:2=True:C214; *)
			End if 
		End if 
		//Sans les inconnus
		If (u2=1)
			QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_Nom:17#"X0@"; *)
		End if 
		If (ve_AgeInf#0) | (ve_AgeSup#0)
			QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_Age:19>=ve_AgeInf; *)
			QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_Age:19<ve_AgeSup; *)
		End if 
		QUERY:C277([Maraude:24])
		MultiSoc_Filter(->[Maraude:24])
		
		//Recherche et filtarge par etat civil
		If (Size of array:C274(ta_FuseEtCiv)>0)
			$oo:=0
			For ($kk; 1; Size of array:C274(ta_FuseEtCiv))
				If (te_FuseEtCivCheck{$kk}=1)
					$oo:=$oo+1
				End if 
			End for 
			Case of 
				: ($oo=0)
				: ($oo>=Size of array:C274(ta_FuseEtCiv))
				: ($oo<Size of array:C274(ta_FuseEtCiv))
					If (Records in selection:C76([Maraude:24])>0)
						$pipi:=0
						For ($kk; 1; Size of array:C274(ta_FuseEtCiv))
							If (te_FuseEtCivCheck{$kk}=1)
								QUERY:C277([TableFusions:42]; [TableFusions:42]TF_RéférenceTable:2=va_CodeEnum; *)
								QUERY:C277([TableFusions:42];  & ; [TableFusions:42]TF_Libellé:3=ta_FuseEtCiv{$kk})
								MultiSoc_Filter(->[TableFusions:42])
								If (Records in selection:C76([TableFusions:42])>0)
									FIRST RECORD:C50([TableFusions:42])
									Repeat 
										If ($pipi=0)
											$pipi:=1
											QUERY SELECTION:C341([Maraude:24]; [Maraude:24]MR_EtatCivil:16=[TableFusions:42]TF_LibelléOrigine:4; *)
										Else 
											QUERY SELECTION:C341([Maraude:24];  | ; [Maraude:24]MR_EtatCivil:16=[TableFusions:42]TF_LibelléOrigine:4; *)
										End if 
										NEXT RECORD:C51([TableFusions:42])
									Until (End selection:C36([TableFusions:42]))
								End if 
							End if 
						End for 
						QUERY SELECTION:C341([Maraude:24])
					End if 
			End case 
		End if 
		
		//Résultat
		vl_NbHB:=Records in selection:C76([Maraude:24])
		If (vl_NbHB>0)
			CREATE SET:C116([Maraude:24]; "E_encours")
		Else 
			CREATE EMPTY SET:C140([Maraude:24]; "E_encours")
		End if 
	End if 
	
	vl_NbHBd:=0
	vl_NbHom:=0
	vl_NbFem:=0
	
	//ETAT CIVIL
	//sauvegarde de l'état civil standard et en ligne
	ARRAY TEXT:C222(ta_TBEtCivTemp; 0)
	COPY ARRAY:C226(<>ta_TBEtCiv; ta_TBEtCivTemp)
	//affectation des libellé et codes de regroupement  de l'état civil
	If (Records in table:C83([TableFusions:42])>0)
		Tab_FusionDestination(0; 0; 0)
		QUERY:C277([TableFusions:42]; [TableFusions:42]TF_RéférenceTable:2=va_CodeEnum)
		MultiSoc_Filter(->[TableFusions:42])
		ORDER BY:C49([TableFusions:42]; [TableFusions:42]TF_Libellé:3; >)
		SELECTION TO ARRAY:C260([TableFusions:42]TF_Libellé:3; ta_FileEtCiv; [TableFusions:42]TF_LibelléOrigine:4; ta_FilexEtCiv; [TableFusions:42]TF_Diviseur:7; te_FileEtCivDiv)
		ARRAY LONGINT:C221(te_FileEtCivNb; Size of array:C274(ta_FileEtCiv))
		ARRAY LONGINT:C221(tl_FileEtCivNb; Size of array:C274(ta_FileEtCiv))
		For ($ii; 1; Size of array:C274(ta_FileEtCiv))
			If (te_FileEtCivDiv{$ii}<=0)
				te_FileEtCivDiv{$ii}:=1
			End if 
			te_FileEtCivNb{$ii}:=0
			tl_FileEtCivNb{$ii}:=0
		End for 
	Else 
		Tab_FusionDestination(0; Size of array:C274(<>ta_TBEtCiv); 0)
		ARRAY LONGINT:C221(te_FileEtCivNb; Size of array:C274(ta_FileEtCiv))
		ARRAY LONGINT:C221(tl_FileEtCivNb; Size of array:C274(ta_FileEtCiv))
		For ($ii; 1; Size of array:C274(<>ta_TBEtCiv))
			ta_FileEtCiv{$ii}:=<>ta_TBEtCiv{$ii}
			ta_FilexEtCiv{$ii}:=<>ta_TBEtCiv{$ii}
			te_FileEtCivDiv{$ii}:=1
			te_FileEtCivNb{$ii}:=0
			tl_FileEtCivNb{$ii}:=0
		End for 
	End if 
	vl_Tab1:=Size of array:C274(ta_FileEtCiv)
	
	vl_NbHB:=Records in set:C195("E_encours")
	
	//CALCULS
	//PERSONNES DIFFERENTES
	If (sDif=1)
		If (<>vb_StopEven=False:C215)
			i_MessageSeul("Nombre de personnes différentes…")
			USE SET:C118("E_encours")
			RELATE ONE SELECTION:C349([Maraude:24]; [HeBerge:4])
			vl_NbHBd:=Records in selection:C76([HeBerge:4])
			QUERY SELECTION:C341([HeBerge:4]; [HeBerge:4]HG_Genre:39=False:C215)
			vl_NbHom:=Records in selection:C76([HeBerge:4])
			vl_NbFem:=vl_NbHBd-vl_NbHom
			<>tl_TBGenre{1}:=vl_NbHom
			<>tl_TBGenre{2}:=vl_NbFem
		End if 
	End if 
	//CALCUL DES ITEMS  
	P_Calc_MaraudeEtude1
	
	CLOSE WINDOW:C154
	
	//EXPORT
	P_Exporter_MaraudeEtude
	
	//restitution de l'état civil standard remis en ligne
	COPY ARRAY:C226(ta_TBEtCivTemp; <>ta_TBEtCiv)
	
	ON EVENT CALL:C190("")  //Fin de i_Stop
	BEEP:C151
	ALERT:C41("Statistiques Maraude Etude: Terminé")
End if 