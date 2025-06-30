//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementDécisionFind
//{
//{          Mardi 18 avril 2006 à 12:04:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_DATE:C307($vd_Date2)
C_TIME:C306($vh_Heure)

If ($1=0)
	If ([DiaLogues:3]DL_Date:2>!00-00-00!)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=[DiaLogues:3]DL_Date:2; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=False:C215; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_ER_Excuse:124=False:C215; *)
		
		Case of 
			: (rJourNuit1=1) & (rJourNuit2=0)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
			: (rJourNuit1=0) & (rJourNuit2=1)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214; *)
		End case 
		If ([DiaLogues:3]DL_LibelléN:9>"")
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nom:21=([DiaLogues:3]DL_LibelléN:9+"@"); *)
		End if 
		QUERY:C277([HeberGement:5])
		MultiSoc_Filter(->[HeberGement:5])
	Else 
		REDUCE SELECTION:C351([HeberGement:5]; 0)
	End if 
	
	vL_NbFiches:=Records in selection:C76([HeberGement:5])
	SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_Décision_Réf; [HeberGement:5]HG_HB_ID:19; tl_Décision_RéfClé; [HeberGement:5]HG_Nom:21; ta_Décision_Nom; [HeberGement:5]HG_Prénom:22; ta_Décision_Prénom; [HeberGement:5]HG_DateNéLe:24; td_Décision_NéLe; [HeberGement:5]HG_FicheNuméro:3; ta_Décision_no; [HeberGement:5]HG_HeureAppel:5; th_Décision_heure)
	
	
	
	ARRAY TEXT:C222(ta_Décision_heure; vL_NbFiches)
	ARRAY TEXT:C222(ta_Décision_Clé; vL_NbFiches)
	ARRAY LONGINT:C221(tl_Décision_Hébgnt; vL_NbFiches)
	ARRAY LONGINT:C221(tl_Décision_Dem; vL_NbFiches)
	ARRAY TEXT:C222(ta_Décision_Tri; vL_NbFiches)
	For ($ii; 1; vL_NbFiches)
		ta_Décision_Clé{$ii}:=Uut_HébergéClé(->ta_Décision_Nom{$ii}; ->ta_Décision_Prénom{$ii}; ->td_Décision_NéLe{$ii})
		ta_Décision_heure{$ii}:=""
		tl_Décision_Hébgnt{$ii}:=0
		tl_Décision_Dem{$ii}:=0
		ta_Décision_Tri{$ii}:=""
	End for 
Else 
	
	If (Size of array:C274(tl_Décision_Réf)>0)
		Case of 
			: (r1=1)  //7 jours
				$vd_Date2:=Add to date:C393([DiaLogues:3]DL_Date:2; 0; 0; -7)
			: (r2=1)  //30 jours
				$vd_Date2:=Add to date:C393([DiaLogues:3]DL_Date:2; 0; 0; -30)
			: (r3=1)  //60 jours
				$vd_Date2:=Add to date:C393([DiaLogues:3]DL_Date:2; 0; 0; -60)
			: (r4=1)  //90 jours
				$vd_Date2:=Add to date:C393([DiaLogues:3]DL_Date:2; 0; 0; -90)
		End case 
		
		For ($ii; 1; Size of array:C274(tl_Décision_Réf))
			$vh_Heure:=th_Décision_heure{$ii}+?00:00:00?
			ta_Décision_heure{$ii}:=String:C10($vh_Heure; h mn:K7:2)
			
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=tl_Décision_RéfClé{$ii}; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=[DiaLogues:3]DL_Date:2; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4>=$vd_Date2)
			MultiSoc_Filter(->[HeberGement:5])
			tl_Décision_Dem{$ii}:=Records in selection:C76([HeberGement:5])
			
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Cloturée:67=True:C214)
			tl_Décision_Hébgnt{$ii}:=Records in selection:C76([HeberGement:5])
			ta_Décision_Tri{$ii}:=String:C10(tl_Décision_Hébgnt{$ii}; "00")
			ta_Décision_Tri{$ii}:=ta_Décision_Tri{$ii}+"_"
			ta_Décision_Tri{$ii}:=ta_Décision_Tri{$ii}+String:C10(100-tl_Décision_Dem{$ii}; "000")
			ta_Décision_Tri{$ii}:=ta_Décision_Tri{$ii}+"_"
			ta_Décision_Tri{$ii}:=ta_Décision_Tri{$ii}+String:C10(tl_Décision_Dem{$ii}; "00")
			ta_Décision_Tri{$ii}:=ta_Décision_Tri{$ii}+ta_Décision_heure{$ii}
		End for 
		
		SORT ARRAY:C229(ta_Décision_Tri; tl_Décision_Réf; tl_Décision_RéfClé; ta_Décision_Nom; ta_Décision_Prénom; td_Décision_NéLe; ta_Décision_no; th_Décision_heure; ta_Décision_heure; tl_Décision_Hébgnt; tl_Décision_Dem; ta_Décision_Clé; >)
		
	End if 
End if 