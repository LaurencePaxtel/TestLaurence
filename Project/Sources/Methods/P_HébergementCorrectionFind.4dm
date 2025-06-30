//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementVeilleFind
//{
//{          Merredi 9 décembre 2009 à 17:30:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}


OBJECT SET VISIBLE:C603(*; "LaDernièreFiche"; (r2=1) | (r5=1))

If ([DiaLogues:3]DL_Date:2>!00-00-00!)
	
	
	If ([DiaLogues:3]DL_Date:2=[DiaLogues:3]DL_Date2:8)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=[DiaLogues:3]DL_Date:2; *)
	Else 
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=[DiaLogues:3]DL_Date:2; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=[DiaLogues:3]DL_Date2:8; *)
	End if 
	
	Case of 
		: (rJourNuit1=1) & (rJourNuit2=0)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
		: (rJourNuit1=0) & (rJourNuit2=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214; *)
	End case 
	
	If ([DiaLogues:3]DL_Libellé:3>"")
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Maraude1_1:10=([DiaLogues:3]DL_Libellé:3+"@"); *)
	End if 
	If ([DiaLogues:3]DL_LibelléG:10>"")
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_FamClé:104=[DiaLogues:3]DL_LibelléG:10; *)
	End if 
	If ([DiaLogues:3]DL_LibelPlus:6>"")
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_CentreNom:62=([DiaLogues:3]DL_LibelPlus:6+"@"); *)
	End if 
	If ([DiaLogues:3]DL_LibelAutre:5>"")
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_CodePostal:14=[DiaLogues:3]DL_LibelAutre:5; *)
	End if 
	If ([DiaLogues:3]DL_LibelléN:9>"")
		
		If (vb_RecClé)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_HB_ID:19=vl_RecCléID; *)
		Else 
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nom:21=([DiaLogues:3]DL_LibelléN:9+"@"); *)
		End if 
		
	End if 
	
	If (sOr1=1)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Orientation1:58>""; *)
	End if 
	If (tLocal=1)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Orientation2:60>""; *)
	End if 
	If (rReports=0)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92=1; *)
	End if 
	
	Case of 
		: (r1=1)
			QUERY:C277([HeberGement:5])
		: (r2=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_EnAttente:64=True:C214)
		: (r3=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Transmis:65=True:C214)
		: (r4=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=False:C215)
		: (r5=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_PriseCharge:66=True:C214)
		: (r6=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
			//: (r7=1)
			//   CHERCHER([HéberGement]; & ;[HéberGement]HG_Status=Vrai)
		: (r8=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_FamChef:103=True:C214)
	End case 
	
	MultiSoc_Filter(->[HeberGement:5])
	
	If (r7=1)
		CREATE SET:C116([HeberGement:5]; "$E_LaSel")
		ARRAY LONGINT:C221($tl_IDSp; 0)
		SELECTION TO ARRAY:C260([HeberGement:5]HG_HB_ID:19; $tl_IDSp)
		QUERY WITH ARRAY:C644([HeBerge:4]HB_ReferenceID:1; $tl_IDSp)
		QUERY SELECTION:C341([HeBerge:4]; [HeBerge:4]HB_Cas1:7=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas1:7=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas2:8=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas3:9=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas4:10=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas5:11=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas6:12=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas7:13=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas8:14=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas9:15=True:C214; *)
		QUERY SELECTION:C341([HeBerge:4];  | ; [HeBerge:4]HB_Cas10:16=True:C214)
		ARRAY LONGINT:C221($tl_IDSp; 0)
		SELECTION TO ARRAY:C260([HeBerge:4]HB_ReferenceID:1; $tl_IDSp)
		QUERY WITH ARRAY:C644([HeberGement:5]HG_HB_ID:19; $tl_IDSp)
		If (Records in selection:C76([HeberGement:5])>0)
			CREATE SET:C116([HeberGement:5]; "$E_LesSP")
			INTERSECTION:C121("$E_LaSel"; "$E_LesSP"; "$E_LaSel")
			USE SET:C118("$E_LaSel")
		Else 
			REDUCE SELECTION:C351([HeberGement:5]; 0)
		End if 
	End if 
	
	
	//Reservation 23/4/2004  
	If (ve_RecReservation=0)
	Else 
		Case of 
			: (ve_RecReservation=1)  //Dernière nuit
				QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_NuitReste:95=0)
				If (ve_RecResDer1=0) | (ve_RecResDer2=0) | (ve_RecResDer1#ve_RecResDer2)
				Else 
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_NuitTOTAL:93=ve_RecResDer2)
				End if 
			: (ve_RecReservation=2)  //Pas dernière nuit        
				QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_NuitReste:95>0)
				If (ve_RecResPasDer1=0) | (ve_RecResPasDer2=0) | (ve_RecResPasDer1=ve_RecResPasDer2)
				Else 
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_NuitenCours:92=ve_RecResPasDer1)
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_NuitTOTAL:93=ve_RecResPasDer2)
				End if 
			: (ve_RecReservation=3)  //Nombre de nuits restant             
				QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_NuitReste:95>=1; *)
				QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95<=ve_RecRes3)
				
		End case 
	End if 
	
	
	If (ve_RecAge=1)
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_DateNéLe:24>=vd_RecAgeDebut; *)
		QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_DateNéLe:24<=vd_RecAgeFin)
	End if 
	
	If (<>vb_T_ModeCHRS)
		If (wSansFiltre=1)
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Plateforme:139=(Substring:C12(<>va_UserPlateforme; 1; 4)+"@"))
		End if 
	End if 
	
	//Etat civil  
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_EtatCivil:20; -><>ta_VeilEtCiv; -><>te_VeilEtCiv)
	//Signalement  
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Signalement:12; -><>ta_VeilSglt; -><>te_VeilSglt)
	
	//Groupe  
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_FamGroupe:102; -><>ta_VeilGroupe; -><>te_VeilGroupe)
	
	//Autre solution 23/4/2004  
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_AutreSolutio:88; -><>ta_VeilAutreSol; -><>te_VeilAutreSol)
	//Orientation1 26/7/2004 
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Orientation1:58; -><>ta_VeilOrient1; -><>te_VeilOrient1)
	//Orientation2 26/7/2004 
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Orientation2:60; -><>ta_VeilOrient2; -><>te_VeilOrient2)
	
	//Permanencier
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Permanencier:9; -><>ta_VeilPerma; -><>te_VeilPerma)
	
	//Ruptures majeures : 26/7/2004
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_RupMajeur1:40; -><>ta_VeilRupMaj1; -><>te_VeilRupMaj1)
	//Ruptures majeures2 : 26/7/2004
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_RupMajeur2:41; -><>ta_VeilRupMaj2; -><>te_VeilRupMaj2)
	//Ruptures majeures2 : 26/7/2004
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_RupMajeur3:42; -><>ta_VeilRupMaj3; -><>te_VeilRupMaj3)
	
	
	
	
	
	//Identité 1 : 25/10/2004
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_PiècesIdté1:31; -><>ta_Veilidt1; -><>te_Veilidt1)
	//Identité 2 : 25/10/2004
	
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_PiècesIdté2:32; -><>ta_Veilidt2; -><>te_Veilidt2)
	
	//Identité 3 : 25/10/2004
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_PiècesIdté3:33; -><>ta_Veilidt3; -><>te_Veilidt3)
	
	
	//Distribution 5 : 5/7/2007
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_FamDistri5:116; -><>ta_VeilDistri5; -><>te_VeilDistri5)
	
	
	//Ressources : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Ressources1:45; -><>ta_VeilRess1; -><>te_VeilRess1)
	//Ressources : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Ressources2:46; -><>ta_VeilRess2; -><>te_VeilRess2)
	//Ressources : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Ressources3:47; -><>ta_VeilRess3; -><>te_VeilRess3)
	
	
	//Suivi social : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_SuiviSocial1:49; -><>ta_VeilSSoc1; -><>te_VeilSSoc1)
	//Suivi social : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_SuiviSocial2:50; -><>ta_VeilSSoc2; -><>te_VeilSSoc2)
	//Suivi social : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_SuiviSocial3:51; -><>ta_VeilSSoc3; -><>te_VeilSSoc3)
	
	
	//Couverture sociale : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_CouvSocial1:53; -><>ta_VeilCSoc1; -><>te_VeilCSoc1)
	//Couverture sociale : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_CouvSocial2:54; -><>ta_VeilCSoc2; -><>te_VeilCSoc2)
	//Couverture sociale : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_CouvSocial3:55; -><>ta_VeilCSoc3; -><>te_VeilCSoc3)
	
	
	
	//Niveau d'étude : 7/7/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_NiveauEtude:43; -><>ta_VeilNivEt; -><>te_VeilNivEt)
	//Temps d'errance : 7/7/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_TempsErrance:34; -><>ta_VeilTpsEr; -><>te_VeilTpsEr)
	//Metro : 7/7/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Métro:16; -><>ta_VeilMetro; -><>te_VeilMetro)
	//Gare : 12/1/2009
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Gare:15; -><>ta_VeilGare; -><>te_VeilGare)
	
	
	//Plateforme : 3/2/2009
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Plateforme:139; -><>ta_VeilPlateforme; -><>te_VeilPlateforme)
	
	
	
	
	If ((r2=1) | (r5=1))
		If (rDernièreF=1)
			If (Records in selection:C76([HeberGement:5])>0)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HB_ID:19; >; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_Der_Référence; [HeberGement:5]HG_Date:4; td_Der_Date; [HeberGement:5]HG_HB_ID:19; tl_Der_HB)
				vl_ii:=1
				vd_Der_Date:=!00-00-00!
				vl_Der_HB:=0
				Repeat 
					Case of 
						: (tl_Der_HB{vl_ii}=vl_Der_HB)
							If (td_Der_Date{vl_ii}<=vd_Der_Date)
								DELETE FROM ARRAY:C228(tl_Der_Référence; vl_ii)
								DELETE FROM ARRAY:C228(td_Der_Date; vl_ii)
								DELETE FROM ARRAY:C228(tl_Der_HB; vl_ii)
							End if 
						: (tl_Der_HB{vl_ii}#vl_Der_HB)
							vl_Der_HB:=tl_Der_HB{vl_ii}
							vd_Der_Date:=td_Der_Date{vl_ii}
							vl_ii:=vl_ii+1
					End case 
					$vb_OK:=(vl_ii>Size of array:C274(tl_Der_Référence))
				Until ($vb_OK)
				QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_Der_Référence)
			End if 
		End if 
	End if 
	
	
	If (rDernièreF=1) & ((r2=1) | (r5=1))
	Else 
		If (rDoublons=1)
			If (Records in selection:C76([HeberGement:5])>0)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HB_ID:19; >; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_Der_Référence; [HeberGement:5]HG_Date:4; td_Der_Date; [HeberGement:5]HG_HB_ID:19; tl_Der_HB)
				ARRAY LONGINT:C221(tl_Der_Nb; 0)
				vl_ii:=1
				vd_Der_Date:=!00-00-00!
				vl_Der_HB:=0
				For (vl_ii; 1; Size of array:C274(tl_Der_Référence))
					If (vl_Der_HB=tl_Der_HB{vl_ii})
						vl_jj:=Size of array:C274(tl_Der_Nb)+1
						INSERT IN ARRAY:C227(tl_Der_Nb; vl_jj)
						tl_Der_Nb{vl_jj}:=tl_Der_Référence{vl_ii-1}
						vl_jj:=Size of array:C274(tl_Der_Nb)+1
						INSERT IN ARRAY:C227(tl_Der_Nb; vl_jj)
						tl_Der_Nb{vl_jj}:=tl_Der_Référence{vl_ii}
					End if 
					vl_Der_HB:=tl_Der_HB{vl_ii}
				End for 
				If (Size of array:C274(tl_Der_Nb)>0)
					QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_Der_Nb)
					ARRAY LONGINT:C221(tl_Der_Nb; 0)
				Else 
					REDUCE SELECTION:C351([HeberGement:5]; 0)
				End if 
			End if 
			
		End if 
	End if 
	
	
	
End if 
vr_TotalDistri:=Sum:C1([HeberGement:5]HG_FamDistri5M:122)
vL_NbFiches:=Records in selection:C76([HeberGement:5])
If (vL_NbFiches>0)
	P_HébergementVeilleSort(2)
	OBJECT SET ENABLED:C1123(b_VoirPrtL; True:C214)
	OBJECT SET ENABLED:C1123(b_VoirPrt; True:C214)
Else 
	OBJECT SET ENABLED:C1123(b_VoirPrtL; False:C215)
	OBJECT SET ENABLED:C1123(b_VoirPrt; False:C215)
End if 
P_HébergementNotesBt(0)
OBJECT SET ENABLED:C1123(b_ModCléHG; False:C215)
OBJECT SET ENABLED:C1123(b_PrtAct; False:C215)
OBJECT SET ENABLED:C1123(b_PrtActF; False:C215)
OBJECT SET ENABLED:C1123(b_Excuse; False:C215)