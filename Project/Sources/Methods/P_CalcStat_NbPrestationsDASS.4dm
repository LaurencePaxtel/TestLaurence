//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CalcStat_NbPrestationsDASS
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($vl_TailTab)
C_LONGINT:C283($vl_TempJ)
C_LONGINT:C283($vl_TempN)
C_LONGINT:C283($ii; $ij)
vl_DP_Dem:=0
vr_DP_DemPc:=0
$vl_TailTab:=0
$vl_TempJ:=0
$vl_TempN:=0

//AdrUt
vl_AU_Dem:=0
vr_AU_DemPc:=0

//Sit Par
vl_SP_Dem:=0
vr_SP_DemPc:=0

//Associations
vl_AS_Dem:=0
vr_AS_DemPc:=0
If (vd_Date1=vd_Date2)
	QUERY:C277([RenseiGnements:20]; [RenseiGnements:20]RG_Date:3=vd_Date1)
	MultiSoc_Filter(->[RenseiGnements:20])
Else 
	QUERY:C277([RenseiGnements:20]; [RenseiGnements:20]RG_Date:3>=vd_Date1; *)
	QUERY:C277([RenseiGnements:20];  & ; [RenseiGnements:20]RG_Date:3<=vd_Date2)
	MultiSoc_Filter(->[RenseiGnements:20])
End if 
If (Records in selection:C76([RenseiGnements:20])>0)
	CREATE SET:C116([RenseiGnements:20]; "E_RGDem")
Else 
	CREATE EMPTY SET:C140([RenseiGnements:20]; "E_RGDem")
End if 

P_CalcStat_NbPrestations

If (Records in set:C195("E_RGDem")>0)
	USE SET:C118("E_RGDem")
	
	QUERY SELECTION:C341([RenseiGnements:20]; [RenseiGnements:20]RG_Rubrique:6=<>ta_PrestRub{2})
	If (Records in selection:C76([RenseiGnements:20])>0)
		CREATE SET:C116([RenseiGnements:20]; "E_RGDemAA")
		DISTINCT VALUES:C339([RenseiGnements:20]RG_Thème:7; ta_Ass)
		If (Size of array:C274(ta_Ass)>0)
			ARRAY LONGINT:C221(t_AS_Dem; Size of array:C274(ta_Ass))
			For ($ii; 1; Size of array:C274(ta_Ass))
				t_AS_Dem{$ii}:=0
			End for 
			USE SET:C118("E_RGDemAA")
			FIRST RECORD:C50([RenseiGnements:20])
			Repeat 
				$ii:=Find in array:C230(ta_Ass; [RenseiGnements:20]RG_Thème:7)
				If ($ii>0)
					Case of 
						: (rJourNuit1=1) & (rJourNuit2=1)
							t_AS_Dem{$ii}:=t_AS_Dem{$ii}+1
						: (rJourNuit1=1) & (rJourNuit2=0)
							If ([RenseiGnements:20]RG_Nuit:5=False:C215)
								t_AS_Dem{$ii}:=t_AS_Dem{$ii}+1
							End if 
						: (rJourNuit1=0) & (rJourNuit2=1)
							If ([RenseiGnements:20]RG_Nuit:5=True:C214)
								t_AS_Dem{$ii}:=t_AS_Dem{$ii}+1
							End if 
						: (rJourNuit1=0) & (rJourNuit2=0)
							t_AS_Dem{$ii}:=0
					End case 
				End if 
				NEXT RECORD:C51([RenseiGnements:20])
			Until (End selection:C36([RenseiGnements:20]))
			vl_AS_Dem:=0
			For ($ii; 1; Size of array:C274(ta_Ass))
				vl_AS_Dem:=vl_AS_Dem+t_AS_Dem{$ii}
			End for 
		End if 
		CLEAR SET:C117("E_RGDemAA")
	End if 
	
	ARRAY TEXT:C222(ta_DemP; 0)
	ARRAY LONGINT:C221(tl_DemPt; 0)
	$vl_TailTab:=Size of array:C274(<>ta_DemP)
	If ($vl_TailTab>0)
		
		USE SET:C118("E_RGDem")
		QUERY SELECTION:C341([RenseiGnements:20]; [RenseiGnements:20]RG_Rubrique:6=<>ta_PrestRub{3})
		If (Records in selection:C76([RenseiGnements:20])>0)
			CREATE SET:C116([RenseiGnements:20]; "E_RGDemAA")
			If (Records in selection:C76([RenseiGnements:20])>0)
				FIRST RECORD:C50([RenseiGnements:20])
				Repeat 
					$ii:=Find in array:C230(<>ta_DemP; [RenseiGnements:20]RG_Thème:7)
					If ($ii>0)
						Case of 
							: (rJourNuit1=1) & (rJourNuit2=1)
								t_DP_Dem{$ii}:=t_DP_Dem{$ii}+1
							: (rJourNuit1=1) & (rJourNuit2=0)
								If ([RenseiGnements:20]RG_Nuit:5=False:C215)
									t_DP_Dem{$ii}:=t_DP_Dem{$ii}+1
								End if 
							: (rJourNuit1=0) & (rJourNuit2=1)
								If ([RenseiGnements:20]RG_Nuit:5=True:C214)
									t_DP_Dem{$ii}:=t_DP_Dem{$ii}+1
								End if 
							: (rJourNuit1=0) & (rJourNuit2=0)
								t_DP_Dem{$ii}:=0
						End case 
					End if 
					NEXT RECORD:C51([RenseiGnements:20])
				Until (End selection:C36([RenseiGnements:20]))
				vl_DP_Dem:=0
				For ($ii; 1; Size of array:C274(<>ta_DemP))
					vl_DP_Dem:=vl_DP_Dem+t_DP_Dem{$ii}
					If (t_DP_Dem{$ii}>0)
						$ij:=Size of array:C274(ta_DemP)+1
						INSERT IN ARRAY:C227(ta_DemP; $ij)
						INSERT IN ARRAY:C227(tl_DemPt; $ij)
						ta_DemP{$ij}:=<>ta_DemP{$ii}
						tl_DemPt{$ij}:=t_DP_Dem{$ii}
					End if 
				End for 
				COPY ARRAY:C226(tl_DemPt; t_DP_Dem)
			End if 
			CLEAR SET:C117("E_RGDemAA")
		End if 
	End if 
	
	ARRAY TEXT:C222(ta_AdUtil; 0)
	ARRAY LONGINT:C221(tl_AdUPt; 0)
	$vl_TailTab:=Size of array:C274(<>ta_AdUtil)
	If ($vl_TailTab>0)
		
		USE SET:C118("E_RGDem")
		QUERY SELECTION:C341([RenseiGnements:20]; [RenseiGnements:20]RG_Rubrique:6=<>ta_PrestRub{1})
		If (Records in selection:C76([RenseiGnements:20])>0)
			CREATE SET:C116([RenseiGnements:20]; "E_RGDemAA")
			If (Records in selection:C76([RenseiGnements:20])>0)
				FIRST RECORD:C50([RenseiGnements:20])
				Repeat 
					$ii:=Find in array:C230(<>ta_AdUtil; [RenseiGnements:20]RG_Thème:7)
					If ($ii>0)
						Case of 
							: (rJourNuit1=1) & (rJourNuit2=1)
								t_AU_Dem{$ii}:=t_AU_Dem{$ii}+1
							: (rJourNuit1=1) & (rJourNuit2=0)
								If ([RenseiGnements:20]RG_Nuit:5=False:C215)
									t_AU_Dem{$ii}:=t_AU_Dem{$ii}+1
								End if 
							: (rJourNuit1=0) & (rJourNuit2=1)
								If ([RenseiGnements:20]RG_Nuit:5=True:C214)
									t_AU_Dem{$ii}:=t_AU_Dem{$ii}+1
								End if 
							: (rJourNuit1=0) & (rJourNuit2=0)
								t_AU_Dem{$ii}:=0
						End case 
					End if 
					NEXT RECORD:C51([RenseiGnements:20])
				Until (End selection:C36([RenseiGnements:20]))
				vl_AU_Dem:=0
				For ($ii; 1; Size of array:C274(<>ta_AdUtil))
					vl_AU_Dem:=vl_AU_Dem+t_AU_Dem{$ii}
					If (t_AU_Dem{$ii}>0)
						$ij:=Size of array:C274(ta_AdUtil)+1
						INSERT IN ARRAY:C227(ta_AdUtil; $ij)
						INSERT IN ARRAY:C227(tl_AdUPt; $ij)
						ta_AdUtil{$ij}:=<>ta_AdUtil{$ii}
						tl_AdUPt{$ij}:=t_AU_Dem{$ii}
					End if 
				End for 
				COPY ARRAY:C226(tl_AdUPt; t_AU_Dem)
			End if 
			CLEAR SET:C117("E_RGDemAA")
		End if 
	End if 
	ARRAY TEXT:C222(ta_SitPar; 0)
	ARRAY LONGINT:C221(tl_SitPt; 0)
	$vl_TailTab:=Size of array:C274(<>ta_SitPar)
	If ($vl_TailTab>0)
		
		USE SET:C118("E_RGDem")
		QUERY SELECTION:C341([RenseiGnements:20]; [RenseiGnements:20]RG_Rubrique:6=<>ta_PrestRub{4})
		If (Records in selection:C76([RenseiGnements:20])>0)
			CREATE SET:C116([RenseiGnements:20]; "E_RGDemAA")
			If (Records in selection:C76([RenseiGnements:20])>0)
				FIRST RECORD:C50([RenseiGnements:20])
				Repeat 
					$ii:=Find in array:C230(<>ta_SitPar; [RenseiGnements:20]RG_Thème:7)
					If ($ii>0)
						Case of 
							: (rJourNuit1=1) & (rJourNuit2=1)
								t_SP_Dem{$ii}:=t_SP_Dem{$ii}+1
							: (rJourNuit1=1) & (rJourNuit2=0)
								If ([RenseiGnements:20]RG_Nuit:5=False:C215)
									t_SP_Dem{$ii}:=t_SP_Dem{$ii}+1
								End if 
							: (rJourNuit1=0) & (rJourNuit2=1)
								If ([RenseiGnements:20]RG_Nuit:5=True:C214)
									t_SP_Dem{$ii}:=t_SP_Dem{$ii}+1
								End if 
							: (rJourNuit1=0) & (rJourNuit2=0)
								t_SP_Dem{$ii}:=0
						End case 
					End if 
					NEXT RECORD:C51([RenseiGnements:20])
				Until (End selection:C36([RenseiGnements:20]))
				vl_SP_Dem:=0
				For ($ii; 1; Size of array:C274(<>ta_SitPar))
					vl_SP_Dem:=vl_SP_Dem+t_SP_Dem{$ii}
					If (t_SP_Dem{$ii}>0)
						$ij:=Size of array:C274(ta_SitPar)+1
						INSERT IN ARRAY:C227(ta_SitPar; $ij)
						INSERT IN ARRAY:C227(tl_SitPt; $ij)
						ta_SitPar{$ij}:=<>ta_SitPar{$ii}
						tl_SitPt{$ij}:=t_SP_Dem{$ii}
					End if 
				End for 
				COPY ARRAY:C226(tl_SitPt; t_SP_Dem)
			End if 
			CLEAR SET:C117("E_RGDemAA")
		End if 
	End if 
End if 