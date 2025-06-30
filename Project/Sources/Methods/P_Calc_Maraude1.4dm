//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_Maraude1
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================} 

C_LONGINT:C283($nbFic)
C_LONGINT:C283($nbFicpas)
C_TEXT:C284($aTotFic)
C_LONGINT:C283($ii; $ij; $ik; $il)
C_LONGINT:C283($iT1; $iT2; $iT3; $iT4)
C_TEXT:C284(va_TempA1)
C_LONGINT:C283(vl_TempA1)
C_LONGINT:C283(vl_TempA2)
C_BOOLEAN:C305($vb_PersDiff)

i_MessageSeul("Calcul en cours …")
If (<>vb_StopEven=False:C215)
	$iT1:=Size of array:C274(ta_it1)
	$iT2:=Size of array:C274(ta_it2)
	$iT3:=Size of array:C274(ta_it3)
	$iT4:=Size of array:C274(ta_it4)
	vl_Tot1:=0
	vl_Tot1_1:=0
	For ($ii; 1; $iT1)
		tl_Nb1{$ii}:=0
		tl_Nb1_1{$ii}:=0
	End for 
	vl_Tot2:=0
	vl_Tot2_2:=0
	For ($ij; 1; $iT2)
		tl_Nb2{$ij}:=0
		tl_Nb2_2{$ij}:=0
	End for 
	vl_Tot3:=0
	vl_Tot3_3:=0
	For ($ik; 1; $iT3)
		tl_Nb3{$ik}:=0
		tl_Nb3_3{$ik}:=0
	End for 
	vl_Tot4:=0
	vl_Tot4_4:=0
	For ($il; 1; $iT4)
		tl_Nb4{$il}:=0
		tl_Nb4_4{$il}:=0
	End for 
	
	USE SET:C118("E_encours")
	ORDER BY:C49([Maraude:24]; [Maraude:24]MR_HB_ID:10; >)
	//FIRST RECORD([Maraude])
	$aTotFic:=String:C10(Records in set:C195("E_encours"))
	$nbFic:=0
	$nbFicpas:=0
	vl_NbHBd:=0
	vl_HBdif:=0
	While ((Not:C34(End selection:C36([Maraude:24]))) & (<>vb_StopEven=False:C215))
		$nbFic:=$nbFic+1
		If ($nbFic=($nbFicpas+10))
			$nbFicpas:=$nbFic
			i_MessageSeul("Calcul en cours …"+String:C10($nbFic)+"/"+$aTotFic)
		End if 
		If (vl_HBdif=[Maraude:24]MR_HB_ID:10)
			$vb_PersDiff:=False:C215
		Else 
			vl_NbHBd:=vl_NbHBd+1
			$vb_PersDiff:=True:C214
		End if 
		vl_HBdif:=[Maraude:24]MR_HB_ID:10
		For ($ii; 1; $iT1)
			If (te_Sel1{$ii}=1)
				
				
				If (P_Calc_StatMRcompteur(1; $ii))
					tl_Nb1{$ii}:=tl_Nb1{$ii}+1
					vl_Tot1:=vl_Tot1+1
					If ($vb_PersDiff)
						tl_Nb1_1{$ii}:=tl_Nb1_1{$ii}+1
						vl_Tot1_1:=vl_Tot1_1+1
					End if 
					
					For ($ij; 1; $iT2)
						If (te_Sel2{$ij}=1)
							If (P_Calc_StatMRcompteur(2; $ij))
								tl_Nb2{$ij}:=tl_Nb2{$ij}+1
								vl_Tot2:=vl_Tot2+1
								If ($vb_PersDiff)
									tl_Nb2_2{$ij}:=tl_Nb2_2{$ij}+1
									vl_Tot2_2:=vl_Tot2_2+1
								End if 
								
								For ($ik; 1; $iT3)
									If (te_Sel3{$ik}=1)
										If (P_Calc_StatMRcompteur(3; $ik))
											tl_Nb3{$ik}:=tl_Nb3{$ik}+1
											vl_Tot3:=vl_Tot3+1
											If ($vb_PersDiff)
												tl_Nb3_3{$ik}:=tl_Nb3_3{$ik}+1
												vl_Tot3_3:=vl_Tot3_3+1
											End if 
											
											For ($il; 1; $iT4)
												If (te_Sel4{$il}=1)
													If (P_Calc_StatMRcompteur(4; $il))
														tl_Nb4{$il}:=tl_Nb4{$il}+1
														vl_Tot4:=vl_Tot4+1
														If ($vb_PersDiff)
															tl_Nb4_4{$il}:=tl_Nb4_4{$il}+1
															vl_Tot4_4:=vl_Tot4_4+1
														End if 
														
													End if 
												End if 
											End for 
										End if 
									End if 
								End for 
							End if 
						End if 
					End for 
				End if 
			End if 
		End for 
		
		NEXT RECORD:C51([Maraude:24])
	End while 
End if 