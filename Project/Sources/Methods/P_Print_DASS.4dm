//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Print_DASS
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
_O_PAGE SETUP:C299([DePart:1]; "DP_Stat_Rapport")
PRINT SETTINGS:C106
If (OK=1)
	QUERY:C277([DePart:1]; [DePart:1]DP_Param:3=True:C214)
	MultiSoc_Filter(->[DePart:1])
	If (Records in selection:C76([DePart:1])>0)
		
		FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_Rapport")
		PRINT SELECTION:C60([DePart:1]; *)
		If (w1=0)
			FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_ParEtatCivil")
			PRINT SELECTION:C60([DePart:1]; *)
			
			FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_ParOrientation")
			PRINT SELECTION:C60([DePart:1]; *)
		End if 
		
		CREATE EMPTY SET:C140([LesCentres:9]; "E_CTimp")
		
		C_LONGINT:C283($ii)
		For ($ii; 1; Size of array:C274(t_CT_ID))
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=t_CT_ID{$ii})
			MultiSoc_Filter(->[LesCentres:9])
			If (Records in selection:C76([LesCentres:9])=1)
				If ((([LesCentres:9]LC_LitMédicalis:47) & (t_CT_Dis{$ii}<=0)) | (t_CT_Dis{$ii}>0))
					ADD TO SET:C119([LesCentres:9]; "E_CTimp")
				End if 
			End if 
		End for 
		USE SET:C118("E_CTimp")
		
		If (w1=0)
			vl_t1:=0
			vl_t2:=0
			vl_t3:=0
			vl_t4:=0
			vl_t5:=0
			vl_t6:=0
			vl_t7:=0
			vl_t8:=0
			vl_t9:=0
			vl_t10:=0
			vl_t11:=0
			vl_t12:=0
			vl_t13:=0
			vl_tx1:=0
			vl_tx2:=0
			vl_tx3:=0
			vl_tx4:=0
			vl_tx5:=0
			vl_tx6:=0
			vl_tx7:=0
			vl_tx8:=0
			vl_tx9:=0
			vl_tx10:=0
			vl_tx11:=0
			vl_tx12:=0
			vl_tx13:=0
			ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_LitMédicalis:47; <; [LesCentres:9]LC_LitMédicalis:47; <; [LesCentres:9]LC_Nom:4; >)
			BREAK LEVEL:C302(2)
			ACCUMULATE:C303([LesCentres:9]LC_Restantes:23)
			FIRST RECORD:C50([LesCentres:9])
			FORM SET OUTPUT:C54([LesCentres:9]; "LC_Prt_StatC1")
			PRINT SELECTION:C60([LesCentres:9]; *)
		End if 
		
		If (w1=1)
			vl_t1:=0
			vl_t2:=0
			vl_t3:=0
			vl_t4:=0
			vl_t5:=0
			vl_t6:=0
			vl_t7:=0
			vl_t8:=0
			vl_t9:=0
			vl_t10:=0
			vl_t11:=0
			vl_t12:=0
			vl_t13:=0
			vl_tx1:=0
			vl_tx2:=0
			vl_tx3:=0
			vl_tx4:=0
			vl_tx5:=0
			vl_tx6:=0
			vl_tx7:=0
			vl_tx8:=0
			vl_tx9:=0
			vl_tx10:=0
			vl_tx11:=0
			vl_tx12:=0
			vl_tx13:=0
			ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_LitMédicalis:47; <; [LesCentres:9]LC_LitMédicalis:47; <; [LesCentres:9]LC_Nom:4; >)
			BREAK LEVEL:C302(2)
			ACCUMULATE:C303([LesCentres:9]LC_Restantes:23)
			FIRST RECORD:C50([LesCentres:9])
			FORM SET OUTPUT:C54([LesCentres:9]; "LC_Prt_StatC2")
			PRINT SELECTION:C60([LesCentres:9]; *)
			
			
			vl_t1:=0
			vl_t2:=0
			vl_t3:=0
			vl_t4:=0
			vl_t5:=0
			vl_t6:=0
			vl_t7:=0
			vl_t8:=0
			vl_t9:=0
			vl_t10:=0
			vl_t11:=0
			vl_t12:=0
			vl_t13:=0
			vl_tx1:=0
			vl_tx2:=0
			vl_tx3:=0
			vl_tx4:=0
			vl_tx5:=0
			vl_tx6:=0
			vl_tx7:=0
			vl_tx8:=0
			vl_tx9:=0
			vl_tx10:=0
			vl_tx11:=0
			vl_tx12:=0
			vl_tx13:=0
			ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_LitMédicalis:47; <; [LesCentres:9]LC_LitMédicalis:47; <; [LesCentres:9]LC_Nom:4; >)
			BREAK LEVEL:C302(2)
			ACCUMULATE:C303([LesCentres:9]LC_Restantes:23)
			FIRST RECORD:C50([LesCentres:9])
			FORM SET OUTPUT:C54([LesCentres:9]; "LC_Prt_StatC3")
			PRINT SELECTION:C60([LesCentres:9]; *)
			
		End if 
		CLEAR SET:C117("E_CTimp")
		
		FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_GIP1")
		PRINT SELECTION:C60([DePart:1]; *)
		FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_GIP2")
		PRINT SELECTION:C60([DePart:1]; *)
		FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_GIP3")
		PRINT SELECTION:C60([DePart:1]; *)
		FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_Prestations")
		PRINT SELECTION:C60([DePart:1]; *)
		FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_Appels")
		PRINT SELECTION:C60([DePart:1]; *)
	End if 
End if 