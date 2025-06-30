//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Print_EMA
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}


_O_PAGE SETUP:C299([DePart:1]; "DP_Stat_EMA1")
PRINT SETTINGS:C106
READ ONLY:C145([DePart:1])
QUERY:C277([DePart:1]; [DePart:1]DP_Param:3=True:C214)
MultiSoc_Filter(->[DePart:1])
If (Records in selection:C76([DePart:1])>0)
	
	FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_EMA1")
	PRINT SELECTION:C60([DePart:1]; *)
	FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_EMA2")
	PRINT SELECTION:C60([DePart:1]; *)
	FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_EMA3")
	PRINT SELECTION:C60([DePart:1]; *)
	
	FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_EMA4")
	PRINT SELECTION:C60([DePart:1]; *)
	
	
	If (sNbOrHB=1)
		If (Records in set:C195("E_encours")>0)
			
			USE SET:C118("E_encours")
			RELATE ONE SELECTION:C349([Maraude:24]; [HeBerge:4])
			
			If (Records in selection:C76([HeBerge:4])>0)
				CREATE EMPTY SET:C140([HeBerge:4]; "$E_HBvide")
				SELECTION TO ARRAY:C260([HeBerge:4]HB_ReferenceID:1; tl_HBréfID)
				ARRAY LONGINT:C221(tl_HBNbMar; Size of array:C274(tl_HBréfID))
				
				C_LONGINT:C283($ii)
				For ($ii; 1; Size of array:C274(tl_HBréfID))
					USE SET:C118("E_encours")
					QUERY SELECTION:C341([Maraude:24]; [Maraude:24]MR_HB_ID:10=tl_HBréfID{$ii})
					tl_HBNbMar{$ii}:=Records in selection:C76([Maraude:24])
				End for 
				
				For ($ii; 1; Size of array:C274(tl_HBréfID))
					If (tl_HBNbMar{$ii}>=vl_Break) & (tl_HBNbMar{$ii}<=vl_Break2)
						QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=tl_HBréfID{$ii})
						MultiSoc_Filter(->[HeBerge:4])
						If (Records in selection:C76([HeBerge:4])=1)
							ADD TO SET:C119([HeBerge:4]; "$E_HBvide")
						End if 
					End if 
				End for 
				If (Records in set:C195("$E_HBvide")>0)
					USE SET:C118("$E_HBvide")
					ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
					FORM SET OUTPUT:C54([HeBerge:4]; "HB_Prt_StatEMA")
					PRINT SELECTION:C60([HeBerge:4]; *)
				End if 
			End if 
		End if 
	End if 
	
	If (sNbNote=1)
		FORM SET OUTPUT:C54([DePart:1]; "DP_Stat_Rapport")
		PRINT SELECTION:C60([DePart:1]; *)
	End if 
	
End if 