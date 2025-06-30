//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_Spécific1
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)

C_TEXT:C284($aTotFic)
C_LONGINT:C283($nbFic; $nbFicpas; $ii; $ij; $ik; $il; $iT1; $iT2; $iT3; $iT4)
C_BOOLEAN:C305($vb_PersDiff)
C_POINTER:C301($P_Objet)
C_OBJECT:C1216($O_Objet)

C_TEXT:C284(va_TempA1)
C_LONGINT:C283(vl_TempA1)
C_LONGINT:C283(vl_TempA2)

ARRAY POINTER:C280(tp_Rub1; 0)
ARRAY POINTER:C280(tp_Rub2; 0)
ARRAY POINTER:C280(tp_Rub3; 0)
ARRAY POINTER:C280(tp_Rub4; 0)

ARRAY TEXT:C222(ta_it1; 0)
ARRAY TEXT:C222(ta_it2; 0)
ARRAY TEXT:C222(ta_it3; 0)
ARRAY TEXT:C222(ta_it4; 0)

ARRAY INTEGER:C220(te_Sel1; 0)
ARRAY INTEGER:C220(te_Sel2; 0)
ARRAY INTEGER:C220(te_Sel3; 0)
ARRAY INTEGER:C220(te_Sel4; 0)

ARRAY LONGINT:C221(tl_Nb1; 0)
ARRAY LONGINT:C221(tl_Nb1_1; 0)
ARRAY LONGINT:C221(tl_Nb2; 0)
ARRAY LONGINT:C221(tl_Nb2_2; 0)
ARRAY LONGINT:C221(tl_Nb3; 0)
ARRAY LONGINT:C221(tl_Nb3_3; 0)
ARRAY LONGINT:C221(tl_Nb4; 0)
ARRAY LONGINT:C221(tl_Nb4_4; 0)

$P_Objet:=$1
$O_Objet:=OB Copy:C1225($P_Objet->)

<>vb_StopEven:=OB Get:C1224($O_Objet; "<>vb_StopEven")

OB GET ARRAY:C1229($O_Objet; "tp_Rub1"; tp_Rub1)
OB GET ARRAY:C1229($O_Objet; "tp_Rub2"; tp_Rub2)
OB GET ARRAY:C1229($O_Objet; "tp_Rub3"; tp_Rub3)
OB GET ARRAY:C1229($O_Objet; "tp_Rub4"; tp_Rub4)

OB GET ARRAY:C1229($O_Objet; "ta_it1"; ta_it1)
OB GET ARRAY:C1229($O_Objet; "ta_it2"; ta_it2)
OB GET ARRAY:C1229($O_Objet; "ta_it3"; ta_it3)
OB GET ARRAY:C1229($O_Objet; "ta_it4"; ta_it4)

OB GET ARRAY:C1229($O_Objet; "te_Sel1"; te_Sel1)
OB GET ARRAY:C1229($O_Objet; "te_Sel2"; te_Sel2)
OB GET ARRAY:C1229($O_Objet; "te_Sel3"; te_Sel3)
OB GET ARRAY:C1229($O_Objet; "te_Sel4"; te_Sel4)

OB GET ARRAY:C1229($O_Objet; "tl_Nb1"; tl_Nb1)
OB GET ARRAY:C1229($O_Objet; "tl_Nb1_1"; tl_Nb1_1)
OB GET ARRAY:C1229($O_Objet; "tl_Nb2"; tl_Nb2)
OB GET ARRAY:C1229($O_Objet; "tl_Nb2_2"; tl_Nb2_2)
OB GET ARRAY:C1229($O_Objet; "tl_Nb3"; tl_Nb3)
OB GET ARRAY:C1229($O_Objet; "tl_Nb3_3"; tl_Nb3_3)
OB GET ARRAY:C1229($O_Objet; "tl_Nb4"; tl_Nb4)
OB GET ARRAY:C1229($O_Objet; "tl_Nb4_4"; tl_Nb4_4)

va_TempA1:=OB Get:C1224($O_Objet; "va_TempA1")

vd_Date1:=OB Get:C1224($O_Objet; "vd_Date1"; Est une date:K8:7)
vd_Date2:=OB Get:C1224($O_Objet; "vd_Date2"; Est une date:K8:7)

vl_HBdif:=OB Get:C1224($O_Objet; "vl_HBdif")

vl_NbHBd:=OB Get:C1224($O_Objet; "vl_NbHBd")

vl_TempA1:=OB Get:C1224($O_Objet; "vl_TempA1")
vl_TempA2:=OB Get:C1224($O_Objet; "vl_TempA2")

vl_Tot1:=OB Get:C1224($O_Objet; "vl_Tot1")
vl_Tot1_1:=OB Get:C1224($O_Objet; "vl_Tot1_1")
vl_Tot2:=OB Get:C1224($O_Objet; "vl_Tot2")
vl_Tot2_2:=OB Get:C1224($O_Objet; "vl_Tot2_2")
vl_Tot3:=OB Get:C1224($O_Objet; "vl_Tot3")
vl_Tot3_3:=OB Get:C1224($O_Objet; "vl_Tot3_3")
vl_Tot4:=OB Get:C1224($O_Objet; "vl_Tot4")
vl_Tot4_4:=OB Get:C1224($O_Objet; "vl_Tot4_4")

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
	
	CREATE EMPTY SET:C140([HeBerge:4]; "E_HBCompte")
	USE SET:C118("E_encours")
	
	//Ancienne manière de calculer les personnes identiques
	If (7=8)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HB_ID:19; >)
	End if 
	
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
	
	$aTotFic:=String:C10(Records in set:C195("E_encours"))
	$nbFic:=0
	$nbFicpas:=0
	
	vl_NbHBd:=0
	vl_HBdif:=0
	
	If (Application type:C494#4D Server:K5:6)
		C_LONGINT:C283($L_ref)
		$L_ref:=4D_Progression_Open("")
		C_OBJECT:C1216($O_Progression)
	End if 
	
	C_LONGINT:C283($k; $L_Max)
	$L_Max:=Records in selection:C76([HeberGement:5])
	
	ARRAY LONGINT:C221($rL_HG_HB_ID; 0)
	
	SELECTION TO ARRAY:C260([HeberGement:5]HG_HB_ID:19; $rL_HG_HB_ID)
	FIRST RECORD:C50([HeberGement:5])
	
	For ($k; 1; $L_Max)
		
		
		//$nbFic:=$nbFic+1
		//$k:=$nbFic
		//If ($nbFic=($nbFicpas+10))
		//$nbFicpas:=$nbFic
		//  //i_MessageSeul ("Calcul en cours …"+String($nbFic)+"/"+$aTotFic)
		//End if 
		
		If (Application type:C494#4D Server:K5:6)
			If ((($k%30)=0))
				OB SET:C1220($O_Progression; \
					"progress ref"; $L_ref; \
					"progress titel"; "Statistiques Spécifiques"; \
					"progress message"; "Calcul du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2); \
					"progress compteur"; $k; \
					"progress max"; $L_Max; \
					"progress stop"; -1\
					)
				4D_Progression_Send(->$O_Progression)
			End if 
		End if 
		
		//Nouvelle manière de calculer les personnes identiques au 15/2/2009
		$vb_PersDiff:=False:C215
		RELATE ONE:C42([HeberGement:5]HG_HB_ID:19)
		
		If (Records in selection:C76([HeBerge:4])=1)
			If (Is in set:C273("E_HBCompte"))
			Else 
				ADD TO SET:C119([HeBerge:4]; "E_HBCompte")
				$vb_PersDiff:=True:C214
			End if 
		End if 
		
		C_LONGINT:C283($L1)
		$L1:=0
		For ($ii; 1; $iT1)
			
			If (te_Sel1{$ii}=1)
				
				If (False:C215)  // #20180430-3
					TRACE:C157
					// BS 22/3/17
					// ce code permet de ne plus utiliser 500 000 fois la méthode P_Calc_StatSPcompteur
					// il pourra être simplifier un jour
					// l'ancien code pourra être supprimé
					
					C_POINTER:C301($P_ve_p1; $P_ve_p2; $P_ve_p3)
					
					// etape 1
					$P_ve_p1:=->tp_Rub1
					$P_ve_p2:=->te_Rub1
					$P_ve_p3:=->ta_it1
					
					C_LONGINT:C283($L_Compteur)
					$L_Compteur:=$ii
					
					C_LONGINT:C283($kk)
					$kk:=$P_ve_p2->{0}  // #Fix20170504-1
					
					If ($kk#0)
						//ALERT("cas inconnu: appeler le développeur valeur "+String($kk))
					End if 
					
					C_POINTER:C301($P_Value_ta_it)
					C_TEXT:C284($T_String)
					$T_String:=$P_ve_p3->{$L_Compteur}
					$P_Value_ta_it:=->$T_String
					If (Type:C295(($P_ve_p1->{0})->)=Est un booléen:K8:9)
						C_BOOLEAN:C305($B_)
						$B_:=($T_String="Vrai")
						$P_Value_ta_it:=->$B_
					End if 
					$B_Out:=(($P_ve_p1->{0})->=$P_Value_ta_it->)
					
					//$B_Out:=(($P_ve_p1->{0})->=$P_ve_p3->{$L_Compteur})
					
					If ($B_Out)
						
						$L1:=$L1+1
						tl_Nb1{$ii}:=tl_Nb1{$ii}+1
						vl_Tot1:=vl_Tot1+1
						If ($vb_PersDiff)
							tl_Nb1_1{$ii}:=tl_Nb1_1{$ii}+1
							vl_Tot1_1:=vl_Tot1_1+1
						End if 
						
						
						For ($ij; 1; $iT2)
							If (te_Sel2{$ij}=1)
								
								// etape 2
								$P_ve_p1:=->tp_Rub2
								$P_ve_p2:=->te_Rub2
								$P_ve_p3:=->ta_it2
								
								$L_Compteur:=$ij
								
								C_LONGINT:C283($kk)
								$kk:=$P_ve_p2->{0}
								If ($kk#0)
									//ALERT("cas inconnu: appeler le développeur valeur "+String($kk))
								End if 
								
								C_POINTER:C301($P_Value_ta_it)
								C_TEXT:C284($T_String)
								$T_String:=$P_ve_p3->{$L_Compteur}
								$P_Value_ta_it:=->$T_String
								If (Type:C295(($P_ve_p1->{0})->)=Est un booléen:K8:9)
									C_BOOLEAN:C305($B_)
									$B_:=($T_String="Vrai")
									$P_Value_ta_it:=->$B_
								End if 
								$B_Out:=(($P_ve_p1->{0})->=$P_Value_ta_it->)
								
								//$B_Out:=(($P_ve_p1->{0})->=$P_ve_p3->{$L_Compteur})
								If ($B_Out)
									
									tl_Nb2{$ij}:=tl_Nb2{$ij}+1
									vl_Tot2:=vl_Tot2+1
									If ($vb_PersDiff)
										tl_Nb2_2{$ij}:=tl_Nb2_2{$ij}+1
										vl_Tot2_2:=vl_Tot2_2+1
									End if 
									
									For ($ik; 1; $iT3)
										
										If (te_Sel3{$ik}=1)
											
											// etape 3
											$P_ve_p1:=->tp_Rub3
											$P_ve_p2:=->te_Rub3
											$P_ve_p3:=->ta_it3
											
											$L_Compteur:=$ik
											
											C_LONGINT:C283($kk)
											$kk:=$P_ve_p2->{0}
											If ($kk#0)
												//ALERT("cas inconnu: appeler le développeur valeur "+String($kk))
											End if 
											
											C_POINTER:C301($P_Value_ta_it)
											C_TEXT:C284($T_String)
											$T_String:=$P_ve_p3->{$L_Compteur}
											$P_Value_ta_it:=->$T_String
											If (Type:C295(($P_ve_p1->{0})->)=Est un booléen:K8:9)
												C_BOOLEAN:C305($B_)
												$B_:=($T_String="Vrai")
												$P_Value_ta_it:=->$B_
											End if 
											$B_Out:=(($P_ve_p1->{0})->=$P_Value_ta_it->)
											
											//$B_Out:=(($P_ve_p1->{0})->=$P_ve_p3->{$L_Compteur})
											If ($B_Out)
												
												tl_Nb3{$ik}:=tl_Nb3{$ik}+1
												vl_Tot3:=vl_Tot3+1
												If ($vb_PersDiff)
													tl_Nb3_3{$ik}:=tl_Nb3_3{$ik}+1
													vl_Tot3_3:=vl_Tot3_3+1
												End if 
												
												For ($il; 1; $iT4)
													
													If (te_Sel4{$il}=1)
														
														// etape 4
														$P_ve_p1:=->tp_Rub4
														$P_ve_p2:=->te_Rub4
														$P_ve_p3:=->ta_it4
														
														$L_Compteur:=$il
														
														C_LONGINT:C283($kk)
														$kk:=$P_ve_p2->{0}
														If ($kk#0)
															//ALERT("cas inconnu: appeler le développeur valeur "+String($kk))
														End if 
														
														
														C_POINTER:C301($P_Value_ta_it)
														C_TEXT:C284($T_String)
														$T_String:=$P_ve_p3->{$L_Compteur}
														$P_Value_ta_it:=->$T_String
														If (Type:C295(($P_ve_p1->{0})->)=Est un booléen:K8:9)
															C_BOOLEAN:C305($B_)
															$B_:=($T_String="Vrai")
															$P_Value_ta_it:=->$B_
														End if 
														$B_Out:=(($P_ve_p1->{0})->=$P_Value_ta_it->)
														
														// $B_Out:=(($P_ve_p1->{0})->=$P_ve_p3->{$L_Compteur})
														
														If ($B_Out)
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
					
					
					
				Else 
					If (P_Calc_StatSPcompteur(1; $ii))
						
						$L1:=$L1+1
						tl_Nb1{$ii}:=tl_Nb1{$ii}+1
						vl_Tot1:=vl_Tot1+1
						If ($vb_PersDiff)
							tl_Nb1_1{$ii}:=tl_Nb1_1{$ii}+1
							vl_Tot1_1:=vl_Tot1_1+1
						End if 
						
						For ($ij; 1; $iT2)
							If (te_Sel2{$ij}=1)
								
								If (P_Calc_StatSPcompteur(2; $ij))
									tl_Nb2{$ij}:=tl_Nb2{$ij}+1
									vl_Tot2:=vl_Tot2+1
									If ($vb_PersDiff)
										tl_Nb2_2{$ij}:=tl_Nb2_2{$ij}+1
										vl_Tot2_2:=vl_Tot2_2+1
									End if 
									For ($ik; 1; $iT3)
										If (te_Sel3{$ik}=1)
											
											If (P_Calc_StatSPcompteur(3; $ik))
												
												tl_Nb3{$ik}:=tl_Nb3{$ik}+1
												vl_Tot3:=vl_Tot3+1
												If ($vb_PersDiff)
													tl_Nb3_3{$ik}:=tl_Nb3_3{$ik}+1
													vl_Tot3_3:=vl_Tot3_3+1
												End if 
												
												For ($il; 1; $iT4)
													If (te_Sel4{$il}=1)
														
														If (P_Calc_StatSPcompteur(4; $il))
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
					
					
				End if   // new code
				
			End if 
		End for 
		
		
		NEXT RECORD:C51([HeberGement:5])
		
	End for 
	
	If (Application type:C494#4D Server:K5:6)
		4D_Progression_Close($L_ref)
	End if 
	
End if 

OB SET:C1220($O_Objet; "<>vb_StopEven"; <>vb_StopEven)

OB SET ARRAY:C1227($O_Objet; "ta_it1"; ta_it1)
OB SET ARRAY:C1227($O_Objet; "ta_it2"; ta_it2)
OB SET ARRAY:C1227($O_Objet; "ta_it3"; ta_it3)
OB SET ARRAY:C1227($O_Objet; "ta_it4"; ta_it4)

OB SET ARRAY:C1227($O_Objet; "te_Sel1"; te_Sel1)
OB SET ARRAY:C1227($O_Objet; "te_Sel2"; te_Sel2)
OB SET ARRAY:C1227($O_Objet; "te_Sel3"; te_Sel3)
OB SET ARRAY:C1227($O_Objet; "te_Sel4"; te_Sel4)

OB SET ARRAY:C1227($O_Objet; "tl_Nb1"; tl_Nb1)
OB SET ARRAY:C1227($O_Objet; "tl_Nb1_1"; tl_Nb1_1)
OB SET ARRAY:C1227($O_Objet; "tl_Nb2"; tl_Nb2)
OB SET ARRAY:C1227($O_Objet; "tl_Nb2_2"; tl_Nb2_2)
OB SET ARRAY:C1227($O_Objet; "tl_Nb3"; tl_Nb3)
OB SET ARRAY:C1227($O_Objet; "tl_Nb3_3"; tl_Nb3_3)
OB SET ARRAY:C1227($O_Objet; "tl_Nb4"; tl_Nb4)
OB SET ARRAY:C1227($O_Objet; "tl_Nb4_4"; tl_Nb4_4)

OB SET:C1220($O_Objet; "va_TempA1"; va_TempA1)
OB SET:C1220($O_Objet; "vd_Date1"; vd_Date1)
OB SET:C1220($O_Objet; "vd_Date2"; vd_Date2)
OB SET:C1220($O_Objet; "vl_HBdif"; vl_HBdif)
OB SET:C1220($O_Objet; "vl_NbHBd"; vl_NbHBd)
OB SET:C1220($O_Objet; "vl_TempA1"; vl_TempA1)
OB SET:C1220($O_Objet; "vl_TempA2"; vl_TempA2)
OB SET:C1220($O_Objet; "vl_Tot1"; vl_Tot1)
OB SET:C1220($O_Objet; "vl_Tot1_1"; vl_Tot1_1)
OB SET:C1220($O_Objet; "vl_Tot2"; vl_Tot2)
OB SET:C1220($O_Objet; "vl_Tot2_2"; vl_Tot2_2)
OB SET:C1220($O_Objet; "vl_Tot3"; vl_Tot3)
OB SET:C1220($O_Objet; "vl_Tot3_3"; vl_Tot3_3)
OB SET:C1220($O_Objet; "vl_Tot4"; vl_Tot4)
OB SET:C1220($O_Objet; "vl_Tot4_4"; vl_Tot4_4)

$P_Objet->:=OB Copy:C1225($O_Objet)