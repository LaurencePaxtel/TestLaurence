//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementProlongFind
//{
//{          Lundi 6 septembre 2004 à 10:51:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)


Case of 
	: ($1=0)
		REDUCE SELECTION:C351([GrouPe:36]; 0)
		va_FinRésa:=""
	: ($1=1)
		i_Message("Recherche en cours …")
		If ([DiaLogues:3]DL_Date:2=[DiaLogues:3]DL_Date2:8)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_RéservationDateFin:134=[DiaLogues:3]DL_Date:2; *)
		Else 
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_RéservationDateFin:134>=[DiaLogues:3]DL_Date:2; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_RéservationDateFin:134<=[DiaLogues:3]DL_Date2:8; *)
		End if 
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Réservation:91=True:C214; *)
		Case of 
			: (rJourNuit1=1) & (rJourNuit2=0)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
			: (rJourNuit1=0) & (rJourNuit2=1)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214; *)
		End case 
		QUERY:C277([HeberGement:5])
		MultiSoc_Filter(->[HeberGement:5])
		//Groupes
		P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_FamGroupe:102; -><>ta_PRGroupe; -><>te_PRGroupe)
		
		SELECTION TO ARRAY:C260([HeberGement:5]HG_HB_ID:19; $tl_HG_HBid)
		QUERY WITH ARRAY:C644([GroupeHeberges:37]GH_HB_Référence:3; $tl_HG_HBid)
		SELECTION TO ARRAY:C260([GroupeHeberges:37]GH_GP_Référence:2; $tl_GH_GPid)
		QUERY WITH ARRAY:C644([GrouPe:36]GP_ReferenceID:1; $tl_GH_GPid)
		
		If (va_GPLib>"")
			QUERY SELECTION:C341([GrouPe:36]; [GrouPe:36]GP_Intitulé:4=(va_GPLib+"@"))
		End if 
		
		CLOSE WINDOW:C154
	: ($1=2)
		ALL RECORDS:C47([GrouPe:36])
		MultiSoc_Filter(->[GrouPe:36])
		va_GPLib:=""
		
	: ($1=3)
		$va_Temp:=Get edited text:C655
		//CHERCHER([GrouPe];[GrouPe]GP_Intitulé=($va_Temp+"@"))
		va_GPLib:=$va_Temp
		P_HébergementProlongFind(1)
End case 



vL_NbFiches:=Records in selection:C76([GrouPe:36])
vL_Nb_GP:=vL_NbFiches


If (vL_NbFiches>0) & ($1=1)
	OBJECT SET ENABLED:C1123(b_GPAdd; True:C214)
	OBJECT SET ENABLED:C1123(b_GPMod; True:C214)
	OBJECT SET ENABLED:C1123(b_GPSup; True:C214)
Else 
	OBJECT SET ENABLED:C1123(b_GPAdd; False:C215)
	OBJECT SET ENABLED:C1123(b_GPMod; False:C215)
	OBJECT SET ENABLED:C1123(b_GPSup; False:C215)
	If (vL_NbFiches>0)
		OBJECT SET ENABLED:C1123(b_GPMod; True:C214)
	End if 
End if 
ORDER BY:C49([GrouPe:36]; [GrouPe:36]GP_Intitulé:4; >)
FIRST RECORD:C50([GrouPe:36])
POST CLICK:C466(20; 145)
If ([GrouPe:36]GP_ReferenceID:1>0)
	P_Tab_PR(4; 0)
Else 
	P_Tab_PR(0; 0)
End if 