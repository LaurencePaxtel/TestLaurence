//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_DosSocEtude
//{
//{          Mardi 24 mai 2005 à 14:12:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}

ARRAY LONGINT:C221($tl_PersDS; 0)

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
			QUERY:C277([DossierSocial:25]; [DossierSocial:25]DS_Date:4=vd_Date1; *)
		Else 
			QUERY:C277([DossierSocial:25]; [DossierSocial:25]DS_Date:4>=vd_Date1; *)
			QUERY:C277([DossierSocial:25];  & ; [DossierSocial:25]DS_Date:4<=vd_Date2; *)
		End if 
		//Sans les inconnus
		If (u2=1)
			QUERY:C277([DossierSocial:25];  & ; [DossierSocial:25]DS_Nom:12#"X0@"; *)
		End if 
		If (ve_AgeInf#0) | (ve_AgeSup#0)
			QUERY:C277([DossierSocial:25];  & ; [DossierSocial:25]DS_Age:17>=ve_AgeInf; *)
			QUERY:C277([DossierSocial:25];  & ; [DossierSocial:25]DS_Age:17<ve_AgeSup; *)
		End if 
		QUERY:C277([DossierSocial:25])
		MultiSoc_Filter(->[DossierSocial:25])
		
		//Recherche et filtarge par etat civil
		If (Size of array:C274(ta_FuseEtCiv)>0)
			C_LONGINT:C283($oo; $kk)
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
					If (Records in selection:C76([DossierSocial:25])>0)
						
						C_LONGINT:C283($pipi)
						$pipi:=0
						For ($kk; 1; Size of array:C274(ta_FuseEtCiv))
							If (te_FuseEtCivCheck{$kk}=1)
								QUERY:C277([TableFusions:42]; [TableFusions:42]TF_RéférenceTable:2=va_CodeEnum; *)
								QUERY:C277([TableFusions:42];  & ; [TableFusions:42]TF_Libellé:3=ta_FuseEtCiv{$kk})
								MultiSoc_Filter(->[TableFusions:42])
								If (Records in selection:C76([TableFusions:42])>0)
									// FIRST RECORD([TableFusions])
									Repeat 
										If ($pipi=0)
											$pipi:=1
											QUERY SELECTION:C341([DossierSocial:25]; [DossierSocial:25]DS_EtatCivil:11=[TableFusions:42]TF_LibelléOrigine:4; *)
										Else 
											QUERY SELECTION:C341([DossierSocial:25];  | ; [DossierSocial:25]DS_EtatCivil:11=[TableFusions:42]TF_LibelléOrigine:4; *)
										End if 
										NEXT RECORD:C51([TableFusions:42])
									Until (End selection:C36([TableFusions:42]))
								End if 
							End if 
						End for 
						QUERY SELECTION:C341([DossierSocial:25])
					End if 
			End case 
		End if 
		
		//Résultat
		vl_NbHB:=Records in selection:C76([DossierSocial:25])
		If (vl_NbHB>0)
			CREATE SET:C116([DossierSocial:25]; "E_encours")
		Else 
			CREATE EMPTY SET:C140([DossierSocial:25]; "E_encours")
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
			REDUCE SELECTION:C351([HeBerge:4]; 0)
			USE SET:C118("E_encours")
			SELECTION TO ARRAY:C260([DossierSocial:25]DS_HB_ID:10; $tl_PersDS)
			If (Size of array:C274($tl_PersDS)>0)
				QUERY WITH ARRAY:C644([HeBerge:4]HB_ReferenceID:1; $tl_PersDS)
			End if 
			vl_NbHBd:=Records in selection:C76([HeBerge:4])
			QUERY SELECTION:C341([HeBerge:4]; [HeBerge:4]HG_Genre:39=False:C215)
			vl_NbHom:=Records in selection:C76([HeBerge:4])
			vl_NbFem:=vl_NbHBd-vl_NbHom
			<>tl_TBGenre{1}:=vl_NbHom
			<>tl_TBGenre{2}:=vl_NbFem
		End if 
	End if 
	//CALCUL DES ITEMS  
	P_Calc_DSEtude
	CLOSE WINDOW:C154
	
	//EXPORT
	P_Exporter_DSEtude
	//restitution de l'état civil standard remis en ligne
	COPY ARRAY:C226(ta_TBEtCivTemp; <>ta_TBEtCiv)
	
	ON EVENT CALL:C190("")  //Fin de i_Stop
	BEEP:C151
	ALERT:C41("Statistiques Dossier social Etude: Terminé")
End if 