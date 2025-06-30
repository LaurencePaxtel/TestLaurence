//%attributes = {}
// ----------------------------------------------------
// LOGICIEL : Samu Social de Paris
// © DBsolutions/Paxtel
// Développeur : Kevin HASSAL
// Date and time: 09/08/19, 09:44:02
// ----------------------------------------------------
// Method: P_Calc_Spécific1_Nv
// Description
// Cette méthode a été récrite à partir de la méthode 
// originale P_Calc_Spécific1 afin d'optimiser la vitesse
// des calculs statistiques
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)

C_TEXT:C284($aTotFic)
C_LONGINT:C283($nbFic; $nbFicpas; $ii; $ij; $ik; $il; $iT1; $iT2; $iT3; $iT4; $L_ref; $nbPersonneTotal_el; $nbPersonne_el)
C_POINTER:C301($P_Objet)
C_OBJECT:C1216($O_Objet; $O_Progression)

C_TEXT:C284(va_TempA1)
C_LONGINT:C283(vl_TempA1; vl_TempA2)
C_OBJECT:C1216(parametre_o)

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

parametre_o:=New object:C1471

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
	
	USE SET:C118("E_encours")
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
	
	$aTotFic:=String:C10(Records in set:C195("E_encours"))
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (02/07/2021)
	$nbPersonneTotal_el:=STAT_Get_Nb_Personnes
	
	$nbFic:=0
	$nbFicpas:=0
	
	vl_NbHBd:=0
	vl_HBdif:=0
	
	If (Application type:C494#4D Server:K5:6)
		$L_ref:=4D_Progression_Open("")
	End if 
	
	For ($ii; 1; $iT1)
		
		If (Application type:C494#4D Server:K5:6)
			
			If ((($ii%2)=0))
				OB SET:C1220($O_Progression; \
					"progress ref"; $L_ref; \
					"progress titel"; "Statistiques Spécifiques"; \
					"progress message"; "Calcul du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2); \
					"progress compteur"; $ii; \
					"progress max"; $iT1; \
					"progress stop"; -1\
					)
				4D_Progression_Send(->$O_Progression)
			End if 
			
		End if 
		
		If (te_Sel1{$ii}=1)
			USE SET:C118("E_encours")
			
			STAT_HB_Get_Selection(1; $ii)
			CREATE SET:C116([HeberGement:5]; "sel_1")
			
			// NB Fiches
			tl_Nb1{$ii}:=tl_Nb1{$ii}+Records in selection:C76([HeberGement:5])
			vl_Tot1:=vl_Tot1+Records in selection:C76([HeberGement:5])
			
			// NB Personnes
			$nbPersonne_el:=STAT_Get_Nb_Personnes
			
			tl_Nb1_1{$ii}:=tl_Nb1_1{$ii}+$nbPersonne_el
			vl_Tot1_1:=vl_Tot1_1+$nbPersonne_el
			
			If (Records in set:C195("sel_1")>0)  // Si on a trouvé des fiches dans le premier tableau, on poursuit
				
				For ($ij; 1; $iT2)
					
					If (te_Sel2{$ij}=1)
						USE SET:C118("sel_1")
						
						STAT_HB_Get_Selection(2; $ij)
						CREATE SET:C116([HeberGement:5]; "sel_2")
						
						INTERSECTION:C121("sel_1"; "sel_2"; "result_1")
						USE SET:C118("result_1")
						
						//NB Fiches
						tl_Nb2{$ij}:=tl_Nb2{$ij}+Records in selection:C76([HeberGement:5])
						vl_Tot2:=vl_Tot2+Records in selection:C76([HeberGement:5])
						
						//NB Personnes
						$nbPersonne_el:=STAT_Get_Nb_Personnes
						
						tl_Nb2_2{$ij}:=tl_Nb2_2{$ij}+$nbPersonne_el
						vl_Tot2_2:=vl_Tot2_2+$nbPersonne_el
						
						If (Records in set:C195("result_1")>0)  // Si on a trouvé des fiches dans le deuxième tableau, on poursuit
							
							For ($ik; 1; $iT3)
								
								If (te_Sel3{$ik}=1)
									USE SET:C118("result_1")
									
									STAT_HB_Get_Selection(3; $ik)
									CREATE SET:C116([HeberGement:5]; "sel_3")
									
									INTERSECTION:C121("result_1"; "sel_3"; "result_2")
									USE SET:C118("result_2")
									
									//NB Fiches
									tl_Nb3{$ik}:=tl_Nb3{$ik}+Records in selection:C76([HeberGement:5])
									vl_Tot3:=vl_Tot3+Records in selection:C76([HeberGement:5])
									
									//NB Personnes
									$nbPersonne_el:=STAT_Get_Nb_Personnes
									
									tl_Nb3_3{$ik}:=tl_Nb3_3{$ik}+$nbPersonne_el
									vl_Tot3_3:=vl_Tot3_3+$nbPersonne_el
									
									If (Records in set:C195("result_2")>0)  // Si on a trouvé des fiches dans le troisième tableau, on poursuit
										
										For ($il; 1; $iT4)
											
											If (te_Sel4{$il}=1)
												USE SET:C118("result_2")
												
												STAT_HB_Get_Selection(4; $il)
												CREATE SET:C116([HeberGement:5]; "sel_4")
												
												INTERSECTION:C121("result_2"; "sel_4"; "result_3")
												USE SET:C118("result_3")
												
												//NB Fiches
												tl_Nb4{$il}:=tl_Nb4{$il}+Records in selection:C76([HeberGement:5])
												vl_Tot4:=vl_Tot4+Records in selection:C76([HeberGement:5])
												
												//NB Personnes
												$nbPersonne_el:=STAT_Get_Nb_Personnes
												
												tl_Nb4_4{$il}:=tl_Nb4_4{$il}+$nbPersonne_el
												vl_Tot4_4:=vl_Tot4_4+$nbPersonne_el
												
												CLEAR SET:C117("sel_4")
												CLEAR SET:C117("result_3")
											End if 
											
										End for 
										
									End if 
									
									CLEAR SET:C117("sel_3")
									CLEAR SET:C117("result_2")
								End if 
								
							End for 
							
						End if 
						
						CLEAR SET:C117("sel_2")
						CLEAR SET:C117("result_1")
					End if 
					
				End for 
				
			End if 
			
			CLEAR SET:C117("sel_1")
		End if 
		
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