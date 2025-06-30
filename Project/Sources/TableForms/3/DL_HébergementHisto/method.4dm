C_LONGINT:C283($vl_Event)
$vl_Event:=Form event code:C388

Case of 
	: ($vl_Event=Sur chargement:K2:1)
		If (<>vl_NoHHisto>0)
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=<>vl_NoHHisto)
			MultiSoc_Filter(->[HeBerge:4])
			va_Clé:=[HeBerge:4]HB_Clé:2
			If (ve_Borne<=0)
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=<>vl_NoHHisto)
			Else 
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=<>vl_NoHHisto; *)
				QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_Date:4<=vd_BorneDate; *)
				QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_Date:4>=Add to date:C393(vd_BorneDate; 0; 0; -ve_Borne))
			End if 
			
			MultiSoc_Filter(->[HeberGement:5])
			
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
			FIRST RECORD:C50([HeberGement:5])
			
			PREVIOUS RECORD:C110([HeberGement:5])
			vL_Nb_HG_Fi:=Records in selection:C76([HeberGement:5])
			
			SET WINDOW TITLE:C213(va_Titre+" : "+va_Clé)
		End if 
	: ($vl_Event=Sur appel extérieur:K2:11)
		CANCEL:C270
End case 