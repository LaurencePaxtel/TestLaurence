//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CalcStat_NbPrestations
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($ii; $ij; $vl_TailTab)

//Recherche générale
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

If (Records in set:C195("E_RGDem")>0)
	USE SET:C118("E_RGDem")
	
	//t_AS_Dem : Les associations••••••••••••••
	//••••••••••••••••••••••••••••••••••••
	vl_AS_Dem:=0
	QUERY SELECTION:C341([RenseiGnements:20]; [RenseiGnements:20]RG_Rubrique:6=<>ta_PrestRub{2})
	If (Records in selection:C76([RenseiGnements:20])>0)
		CREATE SET:C116([RenseiGnements:20]; "E_RGDemAA")
		
		DISTINCT VALUES:C339([RenseiGnements:20]RG_Thème:7; ta_Ass)
		If (Size of array:C274(ta_Ass)>0)
			ARRAY LONGINT:C221(t_AS_Dem; Size of array:C274(ta_Ass))
			ARRAY LONGINT:C221(t_AS_Dem1; Size of array:C274(ta_Ass))
			ARRAY LONGINT:C221(t_AS_Dem2; Size of array:C274(ta_Ass))
			ARRAY LONGINT:C221(t_AS_Dem3; Size of array:C274(ta_Ass))
			For ($ii; 1; Size of array:C274(ta_Ass))
				t_AS_Dem{$ii}:=0
				t_AS_Dem1{$ii}:=0
				t_AS_Dem2{$ii}:=0
				t_AS_Dem3{$ii}:=0
			End for 
			vl_AS_Dem:=0
			vl_AS_Dem1:=0
			vl_AS_Dem2:=0
			vl_AS_Dem3:=0
			USE SET:C118("E_RGDemAA")
			FIRST RECORD:C50([RenseiGnements:20])
			Repeat 
				
				$ii:=Find in array:C230(ta_Ass; [RenseiGnements:20]RG_Thème:7)
				If ($ii>0)
					Case of 
						: (rJourNuit1=1) & (rJourNuit2=1)
							t_AS_Dem{$ii}:=t_AS_Dem{$ii}+1
							Case of 
								: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType1)
									t_AS_Dem1{$ii}:=t_AS_Dem1{$ii}+1
								: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType2)
									t_AS_Dem2{$ii}:=t_AS_Dem2{$ii}+1
								: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType3)
									t_AS_Dem3{$ii}:=t_AS_Dem3{$ii}+1
							End case 
						: (rJourNuit1=1) & (rJourNuit2=0)
							If ([RenseiGnements:20]RG_Nuit:5=False:C215)
								t_AS_Dem{$ii}:=t_AS_Dem{$ii}+1
								Case of 
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType1)
										t_AS_Dem1{$ii}:=t_AS_Dem1{$ii}+1
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType2)
										t_AS_Dem2{$ii}:=t_AS_Dem2{$ii}+1
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType3)
										t_AS_Dem3{$ii}:=t_AS_Dem3{$ii}+1
								End case 
							End if 
						: (rJourNuit1=0) & (rJourNuit2=1)
							If ([RenseiGnements:20]RG_Nuit:5=True:C214)
								t_AS_Dem{$ii}:=t_AS_Dem{$ii}+1
								Case of 
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType1)
										t_AS_Dem1{$ii}:=t_AS_Dem1{$ii}+1
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType2)
										t_AS_Dem2{$ii}:=t_AS_Dem2{$ii}+1
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType3)
										t_AS_Dem3{$ii}:=t_AS_Dem3{$ii}+1
								End case 
							End if 
						: (rJourNuit1=0) & (rJourNuit2=0)
							t_AS_Dem{$ii}:=0
							t_AS_Dem1{$ii}:=0
							t_AS_Dem2{$ii}:=0
							t_AS_Dem3{$ii}:=0
					End case 
				End if 
				NEXT RECORD:C51([RenseiGnements:20])
			Until (End selection:C36([RenseiGnements:20]))
			For ($ii; 1; Size of array:C274(ta_Ass))
				vl_AS_Dem:=vl_AS_Dem+t_AS_Dem{$ii}
				vl_AS_Dem1:=vl_AS_Dem1+t_AS_Dem1{$ii}
				vl_AS_Dem2:=vl_AS_Dem2+t_AS_Dem2{$ii}
				vl_AS_Dem3:=vl_AS_Dem3+t_AS_Dem3{$ii}
			End for 
		End if 
		CLEAR SET:C117("E_RGDemAA")
	End if 
	
	//ta_DemP : Les demandes de prestations••••••
	//••••••••••••••••••••••••••••••••••••
	ARRAY TEXT:C222(ta_DemP; 0)
	ARRAY LONGINT:C221(tl_DemPt; 0)
	ARRAY LONGINT:C221(tl_DemPt1; 0)
	ARRAY LONGINT:C221(tl_DemPt2; 0)
	ARRAY LONGINT:C221(tl_DemPt3; 0)
	
	
	$vl_TailTab:=Size of array:C274(<>ta_DemP)
	
	vl_DP_Dem:=0
	vl_DP_Dem1:=0
	vl_DP_Dem2:=0
	vl_DP_Dem3:=0
	
	If ($vl_TailTab>0)
		USE SET:C118("E_RGDem")
		QUERY SELECTION:C341([RenseiGnements:20]; [RenseiGnements:20]RG_Rubrique:6=<>ta_PrestRub{3})
		If (Records in selection:C76([RenseiGnements:20])>0)
			CREATE SET:C116([RenseiGnements:20]; "E_RGDemAA")
			FIRST RECORD:C50([RenseiGnements:20])
			Repeat 
				$ii:=Find in array:C230(<>ta_DemP; [RenseiGnements:20]RG_Thème:7)
				If ($ii>0)
					Case of 
						: (rJourNuit1=1) & (rJourNuit2=1)
							t_DP_Dem{$ii}:=t_DP_Dem{$ii}+1
							Case of 
								: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType1)
									t_DP_Dem1{$ii}:=t_DP_Dem1{$ii}+1
								: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType2)
									t_DP_Dem2{$ii}:=t_DP_Dem2{$ii}+1
								: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType3)
									t_DP_Dem3{$ii}:=t_DP_Dem3{$ii}+1
							End case 
						: (rJourNuit1=1) & (rJourNuit2=0)
							If ([RenseiGnements:20]RG_Nuit:5=False:C215)
								t_DP_Dem{$ii}:=t_DP_Dem{$ii}+1
								Case of 
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType1)
										t_DP_Dem1{$ii}:=t_DP_Dem1{$ii}+1
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType2)
										t_DP_Dem2{$ii}:=t_DP_Dem2{$ii}+1
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType3)
										t_DP_Dem3{$ii}:=t_DP_Dem3{$ii}+1
								End case 
							End if 
						: (rJourNuit1=0) & (rJourNuit2=1)
							If ([RenseiGnements:20]RG_Nuit:5=True:C214)
								t_DP_Dem{$ii}:=t_DP_Dem{$ii}+1
								Case of 
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType1)
										t_DP_Dem1{$ii}:=t_DP_Dem1{$ii}+1
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType2)
										t_DP_Dem2{$ii}:=t_DP_Dem2{$ii}+1
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType3)
										t_DP_Dem3{$ii}:=t_DP_Dem3{$ii}+1
								End case 
							End if 
						: (rJourNuit1=0) & (rJourNuit2=0)
							t_DP_Dem{$ii}:=0
							t_DP_Dem1{$ii}:=0
							t_DP_Dem2{$ii}:=0
							t_DP_Dem3{$ii}:=0
					End case 
				End if 
				NEXT RECORD:C51([RenseiGnements:20])
			Until (End selection:C36([RenseiGnements:20]))
			
			
			For ($ii; 1; Size of array:C274(<>ta_DemP))
				If (t_DP_Dem{$ii}>0)
					$ij:=Size of array:C274(ta_DemP)+1
					INSERT IN ARRAY:C227(ta_DemP; $ij)
					INSERT IN ARRAY:C227(tl_DemPt; $ij)
					INSERT IN ARRAY:C227(tl_DemPt1; $ij)
					INSERT IN ARRAY:C227(tl_DemPt2; $ij)
					INSERT IN ARRAY:C227(tl_DemPt3; $ij)
					ta_DemP{$ij}:=<>ta_DemP{$ii}
					tl_DemPt{$ij}:=t_DP_Dem{$ii}
					tl_DemPt1{$ij}:=t_DP_Dem1{$ii}
					tl_DemPt2{$ij}:=t_DP_Dem2{$ii}
					tl_DemPt3{$ij}:=t_DP_Dem3{$ii}
					vl_DP_Dem:=vl_DP_Dem+tl_DemPt{$ij}
					vl_DP_Dem1:=vl_DP_Dem1+tl_DemPt1{$ij}
					vl_DP_Dem2:=vl_DP_Dem2+tl_DemPt2{$ij}
					vl_DP_Dem3:=vl_DP_Dem3+tl_DemPt3{$ij}
				End if 
			End for 
			CLEAR SET:C117("E_RGDemAA")
		End if 
	End if 
	
	//ta_AdUtil : Les Adresses utiles••••••••••••
	//••••••••••••••••••••••••••••••••••••
	ARRAY TEXT:C222(ta_AdUtil; 0)
	ARRAY LONGINT:C221(tl_AdUPt; 0)
	ARRAY LONGINT:C221(tl_AdUPt1; 0)
	ARRAY LONGINT:C221(tl_AdUPt2; 0)
	ARRAY LONGINT:C221(tl_AdUPt3; 0)
	vl_AU_Dem:=0
	vl_AU_Dem1:=0
	vl_AU_Dem2:=0
	vl_AU_Dem3:=0
	$vl_TailTab:=Size of array:C274(<>ta_AdUtil)
	If ($vl_TailTab>0)
		USE SET:C118("E_RGDem")
		QUERY SELECTION:C341([RenseiGnements:20]; [RenseiGnements:20]RG_Rubrique:6=<>ta_PrestRub{1})
		If (Records in selection:C76([RenseiGnements:20])>0)
			
			FIRST RECORD:C50([RenseiGnements:20])
			Repeat 
				$ii:=Find in array:C230(<>ta_AdUtil; [RenseiGnements:20]RG_Thème:7)
				If ($ii>0)
					Case of 
						: (rJourNuit1=1) & (rJourNuit2=1)
							t_AU_Dem{$ii}:=t_AU_Dem{$ii}+1
							Case of 
								: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType1)
									t_AU_Dem1{$ii}:=t_AU_Dem1{$ii}+1
								: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType2)
									t_AU_Dem2{$ii}:=t_AU_Dem2{$ii}+1
								: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType3)
									t_AU_Dem3{$ii}:=t_AU_Dem3{$ii}+1
							End case 
							
						: (rJourNuit1=1) & (rJourNuit2=0)
							If ([RenseiGnements:20]RG_Nuit:5=False:C215)
								t_AU_Dem{$ii}:=t_AU_Dem{$ii}+1
								Case of 
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType1)
										t_AU_Dem1{$ii}:=t_AU_Dem1{$ii}+1
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType2)
										t_AU_Dem2{$ii}:=t_AU_Dem2{$ii}+1
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType3)
										t_AU_Dem3{$ii}:=t_AU_Dem3{$ii}+1
								End case 
							End if 
						: (rJourNuit1=0) & (rJourNuit2=1)
							If ([RenseiGnements:20]RG_Nuit:5=True:C214)
								t_AU_Dem{$ii}:=t_AU_Dem{$ii}+1
								Case of 
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType1)
										t_AU_Dem1{$ii}:=t_AU_Dem1{$ii}+1
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType2)
										t_AU_Dem2{$ii}:=t_AU_Dem2{$ii}+1
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType3)
										t_AU_Dem3{$ii}:=t_AU_Dem3{$ii}+1
								End case 
							End if 
						: (rJourNuit1=0) & (rJourNuit2=0)
							t_AU_Dem{$ii}:=0
							t_AU_Dem1{$ii}:=0
							t_AU_Dem2{$ii}:=0
							t_AU_Dem3{$ii}:=0
							
					End case 
				End if 
				NEXT RECORD:C51([RenseiGnements:20])
			Until (End selection:C36([RenseiGnements:20]))
			For ($ii; 1; Size of array:C274(<>ta_AdUtil))
				If (t_AU_Dem{$ii}>0)
					$ij:=Size of array:C274(ta_AdUtil)+1
					INSERT IN ARRAY:C227(ta_AdUtil; $ij)
					INSERT IN ARRAY:C227(tl_AdUPt; $ij)
					INSERT IN ARRAY:C227(tl_AdUPt1; $ij)
					INSERT IN ARRAY:C227(tl_AdUPt2; $ij)
					INSERT IN ARRAY:C227(tl_AdUPt3; $ij)
					ta_AdUtil{$ij}:=<>ta_AdUtil{$ii}
					tl_AdUPt{$ij}:=t_AU_Dem{$ii}
					tl_AdUPt1{$ij}:=t_AU_Dem1{$ii}
					tl_AdUPt2{$ij}:=t_AU_Dem2{$ii}
					tl_AdUPt3{$ij}:=t_AU_Dem3{$ii}
					vl_AU_Dem:=vl_AU_Dem+tl_AdUPt{$ij}
					vl_AU_Dem1:=vl_AU_Dem1+tl_AdUPt1{$ij}
					vl_AU_Dem2:=vl_AU_Dem2+tl_AdUPt2{$ij}
					vl_AU_Dem3:=vl_AU_Dem3+tl_AdUPt3{$ij}
				End if 
			End for 
		End if 
	End if 
	
	//ta_SitPar : Les Situations particulières•••••••
	//••••••••••••••••••••••••••••••••••••
	ARRAY TEXT:C222(ta_SitPar; 0)
	ARRAY LONGINT:C221(tl_SitPt; 0)
	ARRAY LONGINT:C221(tl_SitPt1; 0)
	ARRAY LONGINT:C221(tl_SitPt2; 0)
	ARRAY LONGINT:C221(tl_SitPt3; 0)
	vl_SP_Dem:=0
	vl_SP_Dem1:=0
	vl_SP_Dem2:=0
	vl_SP_Dem3:=0
	$vl_TailTab:=Size of array:C274(<>ta_SitPar)
	If ($vl_TailTab>0)
		USE SET:C118("E_RGDem")
		QUERY SELECTION:C341([RenseiGnements:20]; [RenseiGnements:20]RG_Rubrique:6=<>ta_PrestRub{4})
		If (Records in selection:C76([RenseiGnements:20])>0)
			FIRST RECORD:C50([RenseiGnements:20])
			Repeat 
				$ii:=Find in array:C230(<>ta_SitPar; [RenseiGnements:20]RG_Thème:7)
				If ($ii>0)
					Case of 
						: (rJourNuit1=1) & (rJourNuit2=1)
							t_SP_Dem{$ii}:=t_SP_Dem{$ii}+1
							Case of 
								: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType1)
									t_SP_Dem1{$ii}:=t_SP_Dem1{$ii}+1
								: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType2)
									t_SP_Dem2{$ii}:=t_SP_Dem2{$ii}+1
								: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType3)
									t_SP_Dem3{$ii}:=t_SP_Dem3{$ii}+1
							End case 
						: (rJourNuit1=1) & (rJourNuit2=0)
							If ([RenseiGnements:20]RG_Nuit:5=False:C215)
								t_SP_Dem{$ii}:=t_SP_Dem{$ii}+1
								Case of 
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType1)
										t_SP_Dem1{$ii}:=t_SP_Dem1{$ii}+1
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType2)
										t_SP_Dem2{$ii}:=t_SP_Dem2{$ii}+1
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType3)
										t_SP_Dem3{$ii}:=t_SP_Dem3{$ii}+1
								End case 
							End if 
						: (rJourNuit1=0) & (rJourNuit2=1)
							If ([RenseiGnements:20]RG_Nuit:5=True:C214)
								t_SP_Dem{$ii}:=t_SP_Dem{$ii}+1
								Case of 
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType1)
										t_SP_Dem1{$ii}:=t_SP_Dem1{$ii}+1
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType2)
										t_SP_Dem2{$ii}:=t_SP_Dem2{$ii}+1
									: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType3)
										t_SP_Dem3{$ii}:=t_SP_Dem3{$ii}+1
								End case 
							End if 
						: (rJourNuit1=0) & (rJourNuit2=0)
							t_SP_Dem{$ii}:=0
							t_SP_Dem1{$ii}:=0
							t_SP_Dem2{$ii}:=0
							t_SP_Dem3{$ii}:=0
					End case 
				End if 
				NEXT RECORD:C51([RenseiGnements:20])
			Until (End selection:C36([RenseiGnements:20]))
			For ($ii; 1; Size of array:C274(<>ta_SitPar))
				If (t_SP_Dem{$ii}>0)
					$ij:=Size of array:C274(ta_SitPar)+1
					INSERT IN ARRAY:C227(ta_SitPar; $ij)
					INSERT IN ARRAY:C227(tl_SitPt; $ij)
					INSERT IN ARRAY:C227(tl_SitPt1; $ij)
					INSERT IN ARRAY:C227(tl_SitPt2; $ij)
					INSERT IN ARRAY:C227(tl_SitPt3; $ij)
					ta_SitPar{$ij}:=<>ta_SitPar{$ii}
					tl_SitPt{$ij}:=t_SP_Dem{$ii}
					tl_SitPt1{$ij}:=t_SP_Dem1{$ii}
					tl_SitPt2{$ij}:=t_SP_Dem2{$ii}
					tl_SitPt3{$ij}:=t_SP_Dem3{$ii}
					vl_SP_Dem:=vl_SP_Dem+tl_SitPt{$ij}
					vl_SP_Dem1:=vl_SP_Dem1+tl_SitPt1{$ij}
					vl_SP_Dem2:=vl_SP_Dem2+tl_SitPt2{$ij}
					vl_SP_Dem3:=vl_SP_Dem3+tl_SitPt3{$ij}
				End if 
			End for 
		End if 
	End if 
End if   //Si (Cardinal("E_RGDem")>0)