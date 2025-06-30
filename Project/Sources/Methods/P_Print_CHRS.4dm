//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Print_CHRS
//{
//{          Mardi 17 février 2009 à 18:14:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($ii)
OK:=0
_O_PAGE SETUP:C299([DePart:1]; "DP_CHRS_Rap")
PRINT SETTINGS:C106
If (OK=1)
	QUERY:C277([DePart:1]; [DePart:1]DP_Param:3=True:C214)
	MultiSoc_Filter(->[DePart:1])
	If (Records in selection:C76([DePart:1])>0)
		
		If (vt_StTexte>"")
			FORM SET OUTPUT:C54([DePart:1]; "DP_CHRS_Rap")
			PRINT SELECTION:C60([DePart:1]; *)
		End if 
		
		vl_Tab4:=Size of array:C274(ta_xTBSglt)
		If (vl_Tab4>0)
			$ii:=1
			Repeat 
				If (tl_xNbSgltJ{$ii}=0)
					DELETE FROM ARRAY:C228(ta_xTBSglt; $ii; 1)
					DELETE FROM ARRAY:C228(tl_xNbSgltJ; $ii; 1)
				Else 
					$ii:=$ii+1
				End if 
			Until ($ii>Size of array:C274(ta_xTBSglt))
		End if 
		vl_Tab5:=Size of array:C274(ta_xTBPIdté)
		If (vl_Tab5>0)
			$ii:=1
			Repeat 
				If (tl_xNbIdtéJ{$ii}=0)
					DELETE FROM ARRAY:C228(ta_xTBPIdté; $ii; 1)
					DELETE FROM ARRAY:C228(tl_xNbIdtéJ; $ii; 1)
				Else 
					$ii:=$ii+1
				End if 
			Until ($ii>Size of array:C274(ta_xTBPIdté))
		End if 
		FORM SET OUTPUT:C54([DePart:1]; "DP_CHRS_EtC")
		PRINT SELECTION:C60([DePart:1])
		
		vl_Tab2:=Size of array:C274(ta_LC_Centre)
		If (7=8)
			If (vl_Tab2>0)
				$ii:=1
				Repeat 
					If ((tl_LC_Total{$ii}+tl_LC_Dis{$ii}+tl_LC_Rest{$ii})=0)
						DELETE FROM ARRAY:C228(ta_LC_Centre; $ii; 1)
						DELETE FROM ARRAY:C228(tb_LC_CentreR; $ii; 1)
						DELETE FROM ARRAY:C228(tl_LC_Total; $ii; 1)
						DELETE FROM ARRAY:C228(tl_LC_Dis; $ii; 1)
						DELETE FROM ARRAY:C228(tl_LC_Rest; $ii; 1)
						DELETE FROM ARRAY:C228(tr_LC_TauxOccup; $ii; 1)
					Else 
						$ii:=$ii+1
					End if 
				Until ($ii>Size of array:C274(ta_LC_Centre))
			End if 
		End if 
		
		vl_Tab3:=Size of array:C274(ta_LC_Presta)
		If (vl_Tab3>0)
			$ii:=1
			Repeat 
				If (tl_LC_PrestaNb{$ii}=0)
					DELETE FROM ARRAY:C228(ta_LC_Presta; $ii; 1)
					DELETE FROM ARRAY:C228(tl_LC_PrestaNb; $ii; 1)
				Else 
					$ii:=$ii+1
				End if 
			Until ($ii>Size of array:C274(ta_LC_Presta))
		End if 
		FORM SET OUTPUT:C54([DePart:1]; "DP_CHRS_Ctr")
		PRINT SELECTION:C60([DePart:1])
		
		P_Calc_CHRS
	End if 
End if 