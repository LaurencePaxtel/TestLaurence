//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_VoirHG  
//{
//{          Lundi 28 Juillet 1997 à 17:08:57
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If ([HeBerge:4]HB_ReferenceID:1>0)
	If (7=8)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
		MultiSoc_Filter(->[HeberGement:5])
		If (<>vb_T_ModeCHRS)
			If (wSansFiltre=1)
				QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Plateforme:139=(Substring:C12(<>va_UserPlateforme; 1; 4)+"@"))
			End if 
		End if 
		
	End if 
	
	
	
	If (<>vb_T_ModeCHRS=True:C214)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1; *)
		QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_Nuit:2=(va_JourNuit="N"))
		If (wSansFiltre=1)
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Plateforme:139=(Substring:C12(<>va_UserPlateforme; 1; 4)+"@"))
		End if 
	Else 
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
	End if 
	
	
	MultiSoc_Filter(->[HeberGement:5])
	
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
	FIRST RECORD:C50([HeberGement:5])
	PREVIOUS RECORD:C110([HeberGement:5])
	vL_Nb_HG_F:=Records in selection:C76([HeberGement:5])
	va_NNN:=F_AfficheCléHébergé
Else 
	StrAlerte(3; "")
	REDUCE SELECTION:C351([HeberGement:5]; 0)
	vL_Nb_HG_F:=Records in selection:C76([HeberGement:5])
	va_NNN:=""
End if 

//P_HébergementNotesBt (0)
If (wresMulti=0)
	OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
End if 