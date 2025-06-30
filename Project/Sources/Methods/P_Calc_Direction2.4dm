//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_Direction2
//{
//{          Lundi 21 Juin 2001 à 14:29:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($T_File)
C_LONGINT:C283($L_ref; $ii; $kk; $L_Tick; $oo; $pipi)
C_BOOLEAN:C305($B_Log)
C_OBJECT:C1216($O_Progression; $O_Objet)

If (vl_NbJ>366) & (vl_NbJ<1)
	ALERT:C41("Vous ne pouvez pas excéder une année !")
Else 
	$T_File:="debug_"+Current method name:C684+"_.txt"
	Log_mensuel($B_Log; "----------------- Demarrage de "+Current method name:C684; $T_File)
	
	//i_Message ("Chargement en cours …")
	i_Stop
	ON EVENT CALL:C190("i_Stop_ESC")
	
	ARRAY DATE:C224(<>td_PopCT_Date; vl_NbJ)
	<>td_PopCT_Date{1}:=vd_Date1
	
	If (vl_NbJ>1)
		
		For ($ii; 2; vl_NbJ)
			<>td_PopCT_Date{$ii}:=vd_Date1+$ii-1
		End for 
		
	End if 
	
	ARRAY TEXT:C222(<>ta_PopCT_Centre; 0)
	ARRAY LONGINT:C221(<>tl_PopCT_ID; 0)
	
	If (Size of array:C274(ta_xCentre)>0)
		
		For ($ii; 1; Size of array:C274(ta_xCentre))
			
			If (te_xCentre{$ii}=1)
				$kk:=Size of array:C274(<>ta_PopCT_Centre)+1
				INSERT IN ARRAY:C227(<>ta_PopCT_Centre; $kk)
				INSERT IN ARRAY:C227(<>tl_PopCT_ID; $kk)
				
				<>ta_PopCT_Centre{$kk}:=ta_xCentre{$ii}
				<>tl_PopCT_ID{$kk}:=tl_xCentre{$ii}
			End if 
			
		End for 
		
	End if 
	
	vl_NbHB:=0
	CREATE EMPTY SET:C140([HeberGement:5]; "E_encours")
	
	$L_ref:=4D_Progression_Open("")
	
	OB SET:C1220($O_Progression; \
		"progress ref"; $L_ref; \
		"progress titel"; "Répartition calendaire"; \
		"progress message"; ""; \
		"progress compteur"; -1; \
		"progress max"; -1; \
		"progress stop"; -1\
		)
	
	If (Size of array:C274(<>ta_PopCT_Centre)>0) & (<>vb_StopEven=False:C215)  // Recherche de la sélection à traiter
		$L_Tick:=Milliseconds:C459
		
		//1
		OB SET:C1220($O_Progression; \
			"progress message"; "Calcul en cours  1/5 du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2)\
			)
		4D_Progression_Send(->$O_Progression)
		
		// i_MessageSeul ("Recherche en cours  1/5")
		REDUCE SELECTION:C351([HeberGement:5]; 0)
		
		If (vd_Date1=vd_Date2)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_Date1; *)
		Else 
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_Date1; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_Date2; *)
		End if 
		
		If (rReport=0)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92=1; *)
		End if 
		
		If (u2=1)  // Sans les inconnus
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nom:21#"X0@"; *)
		End if 
		
		// Modifié par : Scanu Rémy (18/09/2023)
		Case of 
			: (rJourNuit1=1) & (rJourNuit2=0)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
			: (rJourNuit1=0) & (rJourNuit2=1)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214; *)
		End case 
		
		QUERY:C277([HeberGement:5])
		MultiSoc_Filter(->[HeberGement:5])
		
		If (Size of array:C274(ta_xGroupe)>0)
			
			For ($kk; 1; Size of array:C274(ta_xGroupe))
				
				If (te_xGroupe{$kk}=1)
					$oo:=$oo+1
				End if 
				
			End for 
			
			Case of 
				: ($oo=0)
				: ($oo>=Size of array:C274(ta_xGroupe))
				: ($oo<Size of array:C274(ta_xGroupe))
					
					If (Records in selection:C76([HeberGement:5])>0)
						
						For ($kk; 1; Size of array:C274(ta_xGroupe))
							
							If (te_xGroupe{$kk}=1)
								
								If ($pipi=0)
									$pipi:=1
									QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_FamGroupe:102=ta_xGroupe{$kk}; *)
								Else 
									QUERY SELECTION:C341([HeberGement:5];  | ; [HeberGement:5]HG_FamGroupe:102=ta_xGroupe{$kk}; *)
								End if 
								
							End if 
							
						End for 
						
						QUERY SELECTION:C341([HeberGement:5])
					End if 
					
			End case 
			
		End if 
		
		vl_NbHB:=Records in selection:C76([HeberGement:5])
		
		If (vl_NbHB>0)
			CREATE SET:C116([HeberGement:5]; "E_encours")
			
			//Par sélection de centres
			If (Size of array:C274(<>ta_PopCT_Centre)<Size of array:C274(ta_xCentre))
				QUERY WITH ARRAY:C644([HeberGement:5]HG_LC_ID:61; <>tl_PopCT_ID)
				
				CREATE SET:C116([HeberGement:5]; "$E_Ctr")
				INTERSECTION:C121("E_encours"; "$E_Ctr"; "E_encours")
			End if 
			
		End if 
		
		Log_mensuel($B_Log; "Etape 1: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
	End if   //Fin de la recherche de la sélection à traiter
	
	vl_NbHB:=Records in set:C195("E_encours")
	
	//Début des calculs
	If (vl_NbHB>0) & (<>vb_StopEven=False:C215)
		$L_Tick:=Milliseconds:C459
		
		//2
		OB SET:C1220($O_Progression; \
			"progress message"; "Calcul en cours  2/5 du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2)\
			)
		4D_Progression_Send(->$O_Progression)
		
		//i_MessageSeul ("Calcul en cours  2/5")
		//Déclaration des tableaux et de leur taille
		v_Stat_DirectionCentre(2; Size of array:C274(<>ta_PopCT_Centre))
		
		//Nb Hébergements et personnes
		USE SET:C118("E_encours")
		<>tl_PopCT_DrTDem{0}:=Records in selection:C76([HeberGement:5])
		
		RELATE ONE SELECTION:C349([HeberGement:5]; [HeBerge:4])
		MultiSoc_Filter(->[HeBerge:4])
		
		<>tl_PopCT_DrTPers{0}:=Records in selection:C76([HeBerge:4])
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Cloturée:67=True:C214)
		
		<>tl_PopCT_DrTHg{0}:=Records in selection:C76([HeberGement:5])
		
		RELATE ONE SELECTION:C349([HeberGement:5]; [HeBerge:4])
		MultiSoc_Filter(->[HeBerge:4])
		
		<>tl_PopCT_DrTHgé{0}:=Records in selection:C76([HeBerge:4])
		
		If (<>vb_StopEven=False:C215)
			//3
			OB SET:C1220($O_Progression; \
				"progress message"; "Calcul en cours  3/5 du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2)\
				)
			4D_Progression_Send(->$O_Progression)
			
			//i_MessageSeul ("Calcul en cours  3/5")
			USE SET:C118("E_encours")
			
			SELECTION TO ARRAY:C260([HeberGement:5]HG_Date:4; <>ts_Date; [HeberGement:5]HG_Nuit:2; <>ts_Nuit; [HeberGement:5]HG_HB_ID:19; <>ts_IDHB; [HeberGement:5]HG_LC_ID:61; <>ts_IDLC; [HeberGement:5]HG_Cloturée:67; <>ts_Cloturé)
			SORT ARRAY:C229(<>ts_Date; <>ts_Nuit; <>ts_IDHB; <>ts_IDLC; <>ts_Cloturé; >)
			
			P_ClacDirTab(0)
			P_ClacDirTab2(0)
		End if 
		
		Log_mensuel($B_Log; "Etape 2 et 3 : "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
	End if 
	
	If (vl_NbHB>0) & (<>vb_StopEven=False:C215)
		$L_Tick:=Milliseconds:C459
		
		//4
		OB SET:C1220($O_Progression; \
			"progress message"; "Calcul en cours  4/5 du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2)\
			)
		4D_Progression_Send(->$O_Progression)
		
		//i_MessageSeul ("Calcul en cours  4/5")
		
		If (True:C214)
			OB GET ARRAY:C1229($O_Objet; "<>ta_PopCT_Centre"; <>ta_PopCT_Centre)
			OB GET ARRAY:C1229($O_Objet; "<>tl_PopCT_DrTDem"; <>tl_PopCT_DrTDem)
			OB GET ARRAY:C1229($O_Objet; "<>tl_PopCT_DrTHg"; <>tl_PopCT_DrTHg)
			OB GET ARRAY:C1229($O_Objet; "<>tl_PopCT_DrTHgé"; <>tl_PopCT_DrTHgé)
			OB GET ARRAY:C1229($O_Objet; "<>tl_PopCT_DrTPers"; <>tl_PopCT_DrTPers)
			OB GET ARRAY:C1229($O_Objet; "<>tl_PopCT_ID"; <>tl_PopCT_ID)
			OB GET ARRAY:C1229($O_Objet; "<>ts_Cloturé"; <>ts_Cloturé)
			OB GET ARRAY:C1229($O_Objet; "<>ts_Date"; <>ts_Date)
			OB GET ARRAY:C1229($O_Objet; "<>ts_IDHB"; <>ts_IDHB)
			OB GET ARRAY:C1229($O_Objet; "<>ts_IDLC"; <>ts_IDLC)
			OB GET ARRAY:C1229($O_Objet; "<>ts_Nuit"; <>ts_Nuit)
		End if 
		
		P_CalcStat_Direction2_etape4(->$O_Objet)
		
		If (True:C214)
			OB SET ARRAY:C1227($O_Objet; "<>ta_PopCT_Centre"; <>ta_PopCT_Centre)
			OB SET ARRAY:C1227($O_Objet; "<>tl_PopCT_DrTDem"; <>tl_PopCT_DrTDem)
			OB SET ARRAY:C1227($O_Objet; "<>tl_PopCT_DrTHg"; <>tl_PopCT_DrTHg)
			OB SET ARRAY:C1227($O_Objet; "<>tl_PopCT_DrTHgé"; <>tl_PopCT_DrTHgé)
			OB SET ARRAY:C1227($O_Objet; "<>tl_PopCT_DrTPers"; <>tl_PopCT_DrTPers)
			OB SET ARRAY:C1227($O_Objet; "<>tl_PopCT_ID"; <>tl_PopCT_ID)
			OB SET ARRAY:C1227($O_Objet; "<>ts_Cloturé"; <>ts_Cloturé)
			OB SET ARRAY:C1227($O_Objet; "<>ts_Date"; <>ts_Date)
			OB SET ARRAY:C1227($O_Objet; "<>ts_IDHB"; <>ts_IDHB)
			OB SET ARRAY:C1227($O_Objet; "<>ts_IDLC"; <>ts_IDLC)
			OB SET ARRAY:C1227($O_Objet; "<>ts_Nuit"; <>ts_Nuit)
		End if 
		
		CLEAR VARIABLE:C89($O_Objet)
		Log_mensuel($B_Log; "Etape 4: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
	End if 
	
	If (vl_NbHB>0) & (<>vb_StopEven=False:C215)
		$L_Tick:=Milliseconds:C459
		
		//5
		OB SET:C1220($O_Progression; \
			"progress message"; "Calcul en cours  5/5 du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2)\
			)
		4D_Progression_Send(->$O_Progression)
		
		//i_MessageSeul ("Calcul en cours  5/5")
		
		For ($ii; 1; Size of array:C274(<>ta_PopCT_Centre))
			P_ClacDirTab2($ii)
		End for 
		
		Log_mensuel($B_Log; "Etape 5: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
	End if 
	
	4D_Progression_Close($L_ref)
	
	ON EVENT CALL:C190("")
	CLOSE WINDOW:C154
	
	If (rSomme=1)
		v_Stat_DirectionCentre(3; 0)
	Else 
		
		If (Size of array:C274(<>ta_PopCT_Centre)>0)
			
			If (<>ta_PopCT_Centre>0)
				v_Stat_DirectionCentre(3; <>ta_PopCT_Centre)
			End if 
			
		End if 
		
	End if 
	
	ARRAY BOOLEAN:C223(tb_Sel1; Size of array:C274(<>tl_PoA_DrOjT))
	ARRAY BOOLEAN:C223(tb_Sel2; Size of array:C274(<>tl_PoA_DrOjT))
	ARRAY BOOLEAN:C223(tb_Sel3; Size of array:C274(<>tl_PoA_OrNb))
	ARRAY BOOLEAN:C223(tb_Sel4; Size of array:C274(<>tl_PoA_OrNb))
	
	If (Bool:C1537(Form:C1466.maskedEmptyRow)=True:C214)
		outilsArrayVisibility(->tb_Sel1; -><>tl_PoA_DrOjT; ->tb_Sel2; -><>tl_PoA_DrOjT; ->tb_Sel3; -><>tl_PoA_OrNb; ->tb_Sel4; -><>tl_PoA_OrNb)
	Else 
		outilsArrayVisibility(->tb_Sel1; False:C215; ->tb_Sel2; False:C215; ->tb_Sel3; False:C215; ->tb_Sel4; False:C215)
	End if 
	
End if 