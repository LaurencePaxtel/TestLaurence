//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_TroisFoisRien
//{
//{          Lundi 28 décembre 2009 à 16:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_DATE:C307($4)

C_DATE:C307($vd_Debut; $vd_Fin)
$vd_Debut:=!00-00-00!
$vd_Fin:=!00-00-00!

C_LONGINT:C283($ii; $jj)


Case of 
	: ($1=0)  //Déclarations
		C_LONGINT:C283(vl_3FR_CAS)
		
		C_LONGINT:C283(vl_3FR_Tous; vl_3FR_Satisfait; vl_3FR_NonSatisfait; vl_3FR_Satisfait115; vl_3FR_SatisfaitNon115; vl_3FR_Nouveaux; vl_3FR_Primo; vl_3FR_Centres)
		
		ARRAY LONGINT:C221(tl_3FR_AutreSol; 0)
		ARRAY TEXT:C222(ta_3FR_AutreSol; 0)
		
		ARRAY LONGINT:C221(tl_3FR_Satisf; 0)
		ARRAY INTEGER:C220(te_3FR_SatisfCtr; 0)
		ARRAY LONGINT:C221(tl_3FR_SatisfCtr; 0)
		ARRAY TEXT:C222(ta_3FR_SatisfCtr; 0)
		
		ARRAY LONGINT:C221(tl_3FR_NonSatisf; 0)
		ARRAY INTEGER:C220(te_3FR_NonSatisfCtr; 0)
		ARRAY LONGINT:C221(tl_3FR_NonSatisfCtr; 0)
		ARRAY TEXT:C222(ta_3FR_NonSatisfCtr; 0)
		
		
		ARRAY LONGINT:C221(tl_3FR_115; 0)
		ARRAY INTEGER:C220(te_3FR_115Ctr; 0)
		ARRAY LONGINT:C221(tl_3FR_115Ctr; 0)
		ARRAY TEXT:C222(ta_3FR_115Ctr; 0)
		
		
		ARRAY LONGINT:C221(tl_3FR_Non115; 0)
		ARRAY INTEGER:C220(te_3FR_Non115Ctr; 0)
		ARRAY LONGINT:C221(tl_3FR_Non115Ctr; 0)
		ARRAY TEXT:C222(ta_3FR_Non115Ctr; 0)
		
		
		ARRAY LONGINT:C221(tl_3FR_Nouveau; 0)
		ARRAY INTEGER:C220(te_3FR_NouveauCtr; 0)
		ARRAY LONGINT:C221(tl_3FR_NouveauCtr; 0)
		ARRAY TEXT:C222(ta_3FR_NouveauCtr; 0)
		
		ARRAY LONGINT:C221(tl_3FR_Primo; 0)
		ARRAY INTEGER:C220(te_3FR_PrimoCtr; 0)
		ARRAY LONGINT:C221(tl_3FR_PrimoCtr; 0)
		ARRAY TEXT:C222(ta_3FR_PrimoCtr; 0)
		
		
		ARRAY INTEGER:C220(te_LesCentre; 0)
		ARRAY LONGINT:C221(tl_LesCentre; 0)
		ARRAY TEXT:C222(ta_LesCentre; 0)
		
		C_TEXT:C284(vt_ColRéf_Libellé; vt_ColRéf_LibelléRupture)
		
	: ($1=1)  //Sur chargement
		vl_3FR_CAS:=0
		
		vl_3FR_Tous:=0
		vl_3FR_Satisfait:=0
		vl_3FR_NonSatisfait:=0
		vl_3FR_Satisfait115:=0
		vl_3FR_SatisfaitNon115:=0
		vl_3FR_Nouveaux:=0
		vl_3FR_Primo:=0
		vl_3FR_Centres:=0
		
		[DiaLogues:3]DL_Date:2:=Current date:C33
		
	: ($1=2)  //Initialisation
		vl_3FR_Tous:=0
		vl_3FR_Satisfait:=0
		vl_3FR_NonSatisfait:=0
		vl_3FR_Satisfait115:=0
		vl_3FR_SatisfaitNon115:=0
		vl_3FR_Nouveaux:=0
		vl_3FR_Primo:=0
		vl_3FR_Centres:=0
		
		ARRAY LONGINT:C221(tl_3FR_AutreSol; 0)
		ARRAY TEXT:C222(ta_3FR_AutreSol; 0)
		
		ARRAY LONGINT:C221(tl_3FR_Satisf; 0)
		ARRAY INTEGER:C220(te_3FR_SatisfCtr; 0)
		ARRAY LONGINT:C221(tl_3FR_SatisfCtr; 0)
		ARRAY TEXT:C222(ta_3FR_SatisfCtr; 0)
		
		ARRAY LONGINT:C221(tl_3FR_NonSatisf; 0)
		ARRAY INTEGER:C220(te_3FR_NonSatisfCtr; 0)
		ARRAY LONGINT:C221(tl_3FR_NonSatisfCtr; 0)
		ARRAY TEXT:C222(ta_3FR_NonSatisfCtr; 0)
		
		
		ARRAY LONGINT:C221(tl_3FR_115; 0)
		ARRAY INTEGER:C220(te_3FR_115Ctr; 0)
		ARRAY LONGINT:C221(tl_3FR_115Ctr; 0)
		ARRAY TEXT:C222(ta_3FR_115Ctr; 0)
		
		
		ARRAY LONGINT:C221(tl_3FR_Non115; 0)
		ARRAY INTEGER:C220(te_3FR_Non115Ctr; 0)
		ARRAY LONGINT:C221(tl_3FR_Non115Ctr; 0)
		ARRAY TEXT:C222(ta_3FR_Non115Ctr; 0)
		
		
		ARRAY LONGINT:C221(tl_3FR_Nouveau; 0)
		ARRAY INTEGER:C220(te_3FR_NouveauCtr; 0)
		ARRAY LONGINT:C221(tl_3FR_NouveauCtr; 0)
		ARRAY TEXT:C222(ta_3FR_NouveauCtr; 0)
		
		ARRAY LONGINT:C221(tl_3FR_Primo; 0)
		ARRAY INTEGER:C220(te_3FR_PrimoCtr; 0)
		ARRAY LONGINT:C221(tl_3FR_PrimoCtr; 0)
		ARRAY TEXT:C222(ta_3FR_PrimoCtr; 0)
		
		ARRAY INTEGER:C220(te_LesCentre; 0)
		ARRAY LONGINT:C221(tl_LesCentre; 0)
		ARRAY TEXT:C222(ta_LesCentre; 0)
		
		vt_ColRéf_Libellé:=""
		REDUCE SELECTION:C351([HeberGement:5]; 0)
		
	: ($1=5)  //Recherche
		i_Message("Recherche…")
		i_MessageSeul("Recherche : Phase 1/7")
		//••  Les centres du 115
		ARRAY LONGINT:C221($tl_LesCentres; 0)
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Répertoire:54="115")
		MultiSoc_Filter(->[LesCentres:9])
		If (Records in selection:C76([LesCentres:9])>0)
			SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; $tl_LesCentres)
		End if 
		
		i_MessageSeul("Recherche : Phase 2/7")
		//••  Les demandes d'hébergement du jours
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=[DiaLogues:3]DL_Date:2; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)
		MultiSoc_Filter(->[HeberGement:5])
		vl_3FR_Tous:=Records in selection:C76([HeberGement:5])
		
		i_MessageSeul("Recherche : Phase 3/7")
		//••  Les hébergement du jours
		//pour les références des centres
		ARRAY LONGINT:C221($tl_LesCentresSatisf; 0)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=[DiaLogues:3]DL_Date:2; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)
		MultiSoc_Filter(->[HeberGement:5])
		vl_3FR_Satisfait:=Records in selection:C76([HeberGement:5])
		SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_3FR_Satisf; [HeberGement:5]HG_LC_ID:61; $tl_LesCentresSatisf)
		P_TroisFoisRienCentre(->te_3FR_SatisfCtr; ->tl_3FR_SatisfCtr; ->ta_3FR_SatisfCtr)
		//••  Les hébergement des centres du 115
		If (Size of array:C274($tl_LesCentresSatisf)>0)
			For ($ii; 1; Size of array:C274($tl_LesCentresSatisf))
				$jj:=Find in array:C230($tl_LesCentres; $tl_LesCentresSatisf{$ii})
				If ($jj>0)
					INSERT IN ARRAY:C227(tl_3FR_115; Size of array:C274(tl_3FR_115)+1)
					tl_3FR_115{Size of array:C274(tl_3FR_115)}:=tl_3FR_Satisf{$ii}
				End if 
			End for 
		End if 
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_3FR_115)
		vl_3FR_Satisfait115:=Records in selection:C76([HeberGement:5])
		P_TroisFoisRienCentre(->te_3FR_115Ctr; ->tl_3FR_115Ctr; ->ta_3FR_115Ctr)
		
		
		i_MessageSeul("Recherche : Phase 4/7")
		//•• Orientés 115 vers Structures
		CREATE EMPTY SET:C140([HeberGement:5]; "$E_LesSignals115")
		CREATE EMPTY SET:C140([HeberGement:5]; "$E_Les115")
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=[DiaLogues:3]DL_Date:2; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Signalement:12="115")
		MultiSoc_Filter(->[HeberGement:5])
		vl_3FR_SatisfaitNon115:=Records in selection:C76([HeberGement:5])
		CREATE SET:C116([HeberGement:5]; "$E_LesSignals115")
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_3FR_115)
		CREATE SET:C116([HeberGement:5]; "$E_Les115")
		DIFFERENCE:C122("$E_LesSignals115"; "$E_Les115"; "$E_LesSignals115")
		USE SET:C118("$E_LesSignals115")
		vl_3FR_SatisfaitNon115:=Records in selection:C76([HeberGement:5])
		
		SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_3FR_Non115)
		P_TroisFoisRienCentre(->te_3FR_Non115Ctr; ->tl_3FR_Non115Ctr; ->ta_3FR_Non115Ctr)
		CLEAR SET:C117("$E_LesSignals115")
		
		
		i_MessageSeul("Recherche : Phase 5/7")
		//••  Les Nouveaux
		ARRAY LONGINT:C221($tl_LesNouveaux; 0)
		ARRAY LONGINT:C221($tl_LesNouveaux2; 0)
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_3FR_Satisf)
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_NuitenCours:92=1)
		SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_3FR_Nouveau; [HeberGement:5]HG_HB_ID:19; $tl_LesNouveaux)
		
		$vd_Debut:=Date:C102("1/1/"+String:C10(Year of:C25([DiaLogues:3]DL_Date:2); "0000"))
		$vd_Fin:=Add to date:C393([DiaLogues:3]DL_Date:2; 0; 0; -1)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=$vd_Debut; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=$vd_Fin; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)
		MultiSoc_Filter(->[HeberGement:5])
		SELECTION TO ARRAY:C260([HeberGement:5]HG_HB_ID:19; $tl_LesNouveaux2)
		If (Size of array:C274($tl_LesNouveaux2)>0)
			For ($ii; 1; Size of array:C274($tl_LesNouveaux2))
				$jj:=Find in array:C230($tl_LesNouveaux; $tl_LesNouveaux2{$ii})
				If ($jj<=0)
					DELETE FROM ARRAY:C228($tl_LesNouveaux; $jj; 1)
					DELETE FROM ARRAY:C228(tl_3FR_Nouveau; $jj; 1)
				End if 
			End for 
		End if 
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_3FR_Nouveau)
		vl_3FR_Nouveaux:=Records in selection:C76([HeberGement:5])
		P_TroisFoisRienCentre(->te_3FR_NouveauCtr; ->tl_3FR_NouveauCtr; ->ta_3FR_NouveauCtr)
		
		
		
		
		i_MessageSeul("Recherche : Phase 6/7")
		//••  Le première inscription
		ARRAY LONGINT:C221($tl_LesNouveaux; 0)
		ARRAY LONGINT:C221($tl_LesNouveaux2; 0)
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_FicheCrééele:46=[DiaLogues:3]DL_Date:2)
		MultiSoc_Filter(->[HeBerge:4])
		SELECTION TO ARRAY:C260([HeBerge:4]HB_ReferenceID:1; $tl_LesNouveaux2)
		If (Size of array:C274($tl_LesNouveaux2)>0)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=[DiaLogues:3]DL_Date:2; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)
			MultiSoc_Filter(->[HeberGement:5])
			SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_3FR_Primo; [HeberGement:5]HG_HB_ID:19; $tl_LesNouveaux)
			If (Size of array:C274(tl_3FR_Primo)>0)
				$ii:=1
				Repeat 
					$jj:=Find in array:C230($tl_LesNouveaux2; $tl_LesNouveaux{$ii})
					If ($jj<=0)
						DELETE FROM ARRAY:C228($tl_LesNouveaux; $ii; 1)
						DELETE FROM ARRAY:C228(tl_3FR_Primo; $ii; 1)
					Else 
						$ii:=$ii+1
					End if 
					
				Until ($ii>Size of array:C274(tl_3FR_Primo))
			End if 
		End if 
		
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_3FR_Primo)
		vl_3FR_Primo:=Records in selection:C76([HeberGement:5])
		P_TroisFoisRienCentre(->te_3FR_PrimoCtr; ->tl_3FR_PrimoCtr; ->ta_3FR_PrimoCtr)
		
		
		
		i_MessageSeul("Recherche : Phase 7/7")
		//••  Demandes non satisfaites et Autres solutions
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=[DiaLogues:3]DL_Date:2; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=False:C215; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)
		MultiSoc_Filter(->[HeberGement:5])
		vl_3FR_NonSatisfait:=Records in selection:C76([HeberGement:5])
		SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_3FR_NonSatisf)
		P_TroisFoisRienCentre(->te_3FR_NonSatisfCtr; ->tl_3FR_NonSatisfCtr; ->ta_3FR_NonSatisfCtr)
		DISTINCT VALUES:C339([HeberGement:5]HG_AutreSolutio:88; ta_3FR_AutreSol)
		
		ARRAY LONGINT:C221(tl_3FR_AutreSol; Size of array:C274(ta_3FR_AutreSol))
		For ($ii; 1; Size of array:C274(ta_3FR_AutreSol))
			QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_3FR_NonSatisf)
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_AutreSolutio:88=ta_3FR_AutreSol{$ii})
			tl_3FR_AutreSol{$ii}:=Records in selection:C76([HeberGement:5])
		End for 
		
		REDUCE SELECTION:C351([HeberGement:5]; 0)
		vt_ColRéf_Libellé:=""
		
		CLOSE WINDOW:C154
		
	: ($1=6)  //Demandes satisfaites
		i_Message("Recherche…")
		vl_3FR_CAS:=$1
		tl_3FR_AutreSol:=0
		ta_3FR_AutreSol:=0
		COPY ARRAY:C226(te_3FR_SatisfCtr; te_LesCentre)
		COPY ARRAY:C226(tl_3FR_SatisfCtr; tl_LesCentre)
		COPY ARRAY:C226(ta_3FR_SatisfCtr; ta_LesCentre)
		
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_3FR_Satisf)
		//Centre 
		P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_LC_ID:61; ->tl_LesCentre; ->te_LesCentre)
		
		P_HébergementVeilleSort(2)
		vt_ColRéf_Libellé:="Demandes satisfaites : "+String:C10(Records in selection:C76([HeberGement:5]))
		vt_ColRéf_Libellé:=String:C10(Records in selection:C76([HeberGement:5]))+" - "+"Personnes hébergées par le 115 et les structures du département"
		CLOSE WINDOW:C154
		
	: ($1=7)  //Demandes non satisfaites
		i_Message("Recherche…")
		vl_3FR_CAS:=$1
		tl_3FR_AutreSol:=0
		ta_3FR_AutreSol:=0
		COPY ARRAY:C226(te_3FR_NonSatisfCtr; te_LesCentre)
		COPY ARRAY:C226(tl_3FR_NonSatisfCtr; tl_LesCentre)
		COPY ARRAY:C226(ta_3FR_NonSatisfCtr; ta_LesCentre)
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_3FR_NonSatisf)
		//Centre 
		P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_LC_ID:61; ->tl_LesCentre; ->te_LesCentre)
		P_HébergementVeilleSort(2)
		vt_ColRéf_Libellé:="Demandes non satisfaites : "+String:C10(Records in selection:C76([HeberGement:5]))
		vt_ColRéf_Libellé:=String:C10(Records in selection:C76([HeberGement:5]))+" - "+"Personnes qui n'ont pu être orientées par le 115"
		CLOSE WINDOW:C154
		
	: ($1=8)  //Demandes oientées structures
		i_Message("Recherche…")
		vl_3FR_CAS:=$1
		tl_3FR_AutreSol:=0
		ta_3FR_AutreSol:=0
		COPY ARRAY:C226(te_3FR_Non115Ctr; te_LesCentre)
		COPY ARRAY:C226(tl_3FR_Non115Ctr; tl_LesCentre)
		COPY ARRAY:C226(ta_3FR_Non115Ctr; ta_LesCentre)
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_3FR_Non115)
		//Centre 
		P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_LC_ID:61; ->tl_LesCentre; ->te_LesCentre)
		P_HébergementVeilleSort(2)
		vt_ColRéf_Libellé:="Hébergements 115 structures: "+String:C10(Records in selection:C76([HeberGement:5]))
		vt_ColRéf_Libellé:=String:C10(Records in selection:C76([HeberGement:5]))+" - "+"Personnes orientées par le 115 vers les structure"
		P_TroisFoisRien(20; 0; 0; !00-00-00!)
		CLOSE WINDOW:C154
		
	: ($1=9)  //Nouveaux
		i_Message("Recherche…")
		vl_3FR_CAS:=$1
		tl_3FR_AutreSol:=0
		ta_3FR_AutreSol:=0
		COPY ARRAY:C226(te_3FR_NouveauCtr; te_LesCentre)
		COPY ARRAY:C226(tl_3FR_NouveauCtr; tl_LesCentre)
		COPY ARRAY:C226(ta_3FR_NouveauCtr; ta_LesCentre)
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_3FR_Nouveau)
		//Centre 
		P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_LC_ID:61; ->tl_LesCentre; ->te_LesCentre)
		P_HébergementVeilleSort(2)
		vt_ColRéf_Libellé:="Demandes satisfaites ( nouveaux ) : "+String:C10(Records in selection:C76([HeberGement:5]))
		vt_ColRéf_Libellé:=String:C10(Records in selection:C76([HeberGement:5]))+" - "+"Personnes hébergées pour la première fois depuis le début de l'année"
		CLOSE WINDOW:C154
		
	: ($1=10)
		i_Message("Recherche…")
		If (Size of array:C274(ta_3FR_AutreSol)>0)
			If (ta_3FR_AutreSol>0)
				ARRAY INTEGER:C220(te_LesCentre; 0)
				ARRAY LONGINT:C221(tl_LesCentre; 0)
				ARRAY TEXT:C222(ta_LesCentre; 0)
				
				vl_3FR_CAS:=$1
				//   ta_ItemRub2:=34
				//      ve_PosRub:=34
				// vl_ItemNuméro2:=1
				//   va_Item2:=""
				//  va_ItemTitre2:=ta_ItemRub2{ta_ItemRub2}
				// P_ItemCorrection2 (1)
				
				QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_3FR_NonSatisf)
				QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_AutreSolutio:88=ta_3FR_AutreSol{ta_3FR_AutreSol})
				P_HébergementVeilleSort(2)
				vt_ColRéf_Libellé:="Demandes non satisfaites : "+ta_3FR_AutreSol{ta_3FR_AutreSol}+" : "+String:C10(Records in selection:C76([HeberGement:5]))
				vt_ColRéf_Libellé:=String:C10(Records in selection:C76([HeberGement:5]))+" - "+"Personnes qui n'ont pu être orientées par le 115"+", "+ta_3FR_AutreSol{ta_3FR_AutreSol}
			End if 
		End if 
		CLOSE WINDOW:C154
		
	: ($1=11)
		i_Message("Recherche…")
		vl_3FR_CAS:=$1
		tl_3FR_AutreSol:=0
		ta_3FR_AutreSol:=0
		COPY ARRAY:C226(te_3FR_115Ctr; te_LesCentre)
		COPY ARRAY:C226(tl_3FR_115Ctr; tl_LesCentre)
		COPY ARRAY:C226(ta_3FR_115Ctr; ta_LesCentre)
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_3FR_115)
		//Centre 
		P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_LC_ID:61; ->tl_LesCentre; ->te_LesCentre)
		P_HébergementVeilleSort(2)
		vt_ColRéf_Libellé:="Demandes satisfaites orientées 115 : "+String:C10(Records in selection:C76([HeberGement:5]))
		vt_ColRéf_Libellé:=String:C10(Records in selection:C76([HeberGement:5]))+" - "+"Personnes hébergées par les structures gérées par le 115"
		CLOSE WINDOW:C154
		
		
	: ($1=12)  //Primo
		i_Message("Recherche…")
		vl_3FR_CAS:=$1
		tl_3FR_AutreSol:=0
		ta_3FR_AutreSol:=0
		COPY ARRAY:C226(te_3FR_PrimoCtr; te_LesCentre)
		COPY ARRAY:C226(tl_3FR_PrimoCtr; tl_LesCentre)
		COPY ARRAY:C226(ta_3FR_PrimoCtr; ta_LesCentre)
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_3FR_Primo)
		//Centre 
		P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_LC_ID:61; ->tl_LesCentre; ->te_LesCentre)
		P_HébergementVeilleSort(2)
		vt_ColRéf_Libellé:="Usager 1er Appel : "+String:C10(Records in selection:C76([HeberGement:5]))
		vt_ColRéf_Libellé:=String:C10(Records in selection:C76([HeberGement:5]))+" - "+"Personnes inscrites pour la première fois"
		CLOSE WINDOW:C154
		
		
End case 