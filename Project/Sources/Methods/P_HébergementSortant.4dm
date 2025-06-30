//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : P_HébergementSortant
//{
//{          Mercredi 28 avril 2010 à 15:18:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
Case of 
	: ($1=1)
		//TOUT SELECTIONNER([HéberGement])
		//◊vl_T_JourSortant:=497
		
		If (<>va_UserPlateforme="")
			<>va_UserPlateforme:="@"
		End if 
		
		Web_Genere_Variable_Process(-><>va_UserPlateforme)
		
		If (Character code:C91(<>va_UserPlateforme[[1]])=Character code:C91("@"))
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=Current date:C33(*); *)  //!08/01/11!;*)  `
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95<=<>vl_T_JourSortant)
			
		Else 
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=Current date:C33(*); *)  //!14/04/10!;*)  `
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Plateforme:139=<>va_UserPlateforme; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95<=<>vl_T_JourSortant)
		End if 
		
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=False:C215)
		
		MultiSoc_Filter(->[HeberGement:5])
		
		
		
		vL_NbFiches:=Records in selection:C76([HeberGement:5])
		va_TitreRecherche:="Actualisée le "+String:C10(Current date:C33; Interne date court:K1:7)+" à "+String:C10(Current time:C178; h mn:K7:2)
		P_HébergementSortantTri(vL_NoTri)
		
		
	: ($1=2)
		
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=Current date:C33(*); *)  //!14/04/10!;*)  `Date du jour(*);*)  `
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_ReferenceID:1=<>vl_RéfSortants)
		
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=False:C215)
		
		MultiSoc_Filter(->[HeberGement:5])
		
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
		
		
		
	: ($1=4)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_DateRéelle; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95<=<>vl_T_JourSortant)
		
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=False:C215)
		
		MultiSoc_Filter(->[HeberGement:5])
		
		vL_NbSortants:=Records in selection:C76([HeberGement:5])
		
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_DateNéLe:24; >)
		
		
	: ($1=5)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=Current date:C33(*); *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95<=<>vl_T_JourSortant)
		
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=False:C215)
		
		MultiSoc_Filter(->[HeberGement:5])
		
		vL_NbSortants:=Records in selection:C76([HeberGement:5])
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_DateNéLe:24; >)
		
End case 
