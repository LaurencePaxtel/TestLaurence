//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_Etude
//{
//{          Jeudi 17 Juin 2004 à 15:55:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
var $T_File : Text
var $ii; $L_ref; $L_Max; $L_Tick; $oo; $kk; $pipi : Integer
var $B_Log : Boolean
var $O_Progression : Object

var $hebergement_es; $hebergementB_es : cs:C1710.HeberGementSelection

If (vl_NbJ>366) | (vl_NbJ<1)
	ALERT:C41("Vous ne pouvez pas excéder une année !")
Else 
	
	// #TAG-STATS
	$T_File:="debug_"+Current method name:C684+"_.txt"
	Log_mensuel($B_Log; "----------------- Demarrage de "+Current method name:C684; $T_File)
	
	i_Stop
	ON EVENT CALL:C190("i_Stop_ESC")
	
	$L_ref:=4D_Progression_Open("")
	$L_Max:=4
	
	If (<>vb_StopEven=False:C215)
		// Partie1
		OB SET:C1220($O_Progression; \
			"progress ref"; $L_ref; \
			"progress titel"; "Etude"; \
			"progress message"; "Patientez... 1/4"; \
			"progress compteur"; 1; \
			"progress max"; $L_Max; \
			"progress stop"; -1\
			)
		
		4D_Progression_Send(->$O_Progression)
		$L_Tick:=Milliseconds:C459
		
		CREATE EMPTY SET:C140([HeberGement:5]; "E_encours")
		
		If (vd_Date1=vd_Date2)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_Date1; *)
		Else 
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_Date1; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_Date2; *)
		End if 
		
		If (rJourNuit1=1) & (rJourNuit2=1)  //Jour et nuit
		Else 
			
			If (rJourNuit1=1)  //Jour
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
			End if 
			
			If (rJourNuit2=1)  //nuit
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214; *)
			End if 
			
		End if 
		
		If (rReport=0)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92=1; *)
		End if 
		
		//Sans les inconnus
		If (u2=1)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nom:21#"X0@"; *)
		End if 
		
		If (ve_AgeInf#0) | (ve_AgeSup#0)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Age:23>=ve_AgeInf; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Age:23<ve_AgeSup; *)
		End if 
		
		Case of 
			: (w1=1)  //Que les fiches cloturées
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
			: (w2=1)
				QUERY:C277([HeberGement:5])
			: (w3=1)  //Que les fiches non cloturées
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=False:C215)
		End case 
		
		MultiSoc_Filter(->[HeberGement:5])
		
		// Modifié par : Scanu Rémy (16/02/2024)
		If (sansChangementSituation_b=True:C214)
			$hebergement_es:=Create entity selection:C1512([HeberGement:5])
			$hebergementB_es:=$hebergement_es.getSituationUnique()
			
			USE ENTITY SELECTION:C1513($hebergementB_es)
			LOAD RECORD:C52([HeberGement:5])
		End if 
		
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
						$pipi:=0
						
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
		
		If (Size of array:C274(ta_FuseEtCiv)>0)
			$oo:=0
			
			For ($kk; 1; Size of array:C274(ta_FuseEtCiv))
				
				If (te_FuseEtCivCheck{$kk}=1)
					$oo:=$oo+1
				End if 
				
			End for 
			
			Case of 
				: ($oo=0)
				: ($oo>=Size of array:C274(ta_FuseEtCiv))
				: ($oo<Size of array:C274(ta_FuseEtCiv))
					
					If (Records in selection:C76([HeberGement:5])>0)
						$pipi:=0
						
						For ($kk; 1; Size of array:C274(ta_FuseEtCiv))
							
							If (te_FuseEtCivCheck{$kk}=1)
								QUERY:C277([TableFusions:42]; [TableFusions:42]TF_RéférenceTable:2=va_CodeEnum; *)
								QUERY:C277([TableFusions:42];  & ; [TableFusions:42]TF_Libellé:3=ta_FuseEtCiv{$kk})
								
								MultiSoc_Filter(->[TableFusions:42])
								
								If (Records in selection:C76([TableFusions:42])>0)
									
									Repeat 
										
										If ($pipi=0)
											$pipi:=1
											QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_EtatCivil:20=[TableFusions:42]TF_LibelléOrigine:4; *)
										Else 
											QUERY SELECTION:C341([HeberGement:5];  | ; [HeberGement:5]HG_EtatCivil:20=[TableFusions:42]TF_LibelléOrigine:4; *)
										End if 
										
										NEXT RECORD:C51([TableFusions:42])
									Until (End selection:C36([TableFusions:42]))
									
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
			ARRAY TEXT:C222(ta_xPopCT_Centre; 0)
			ARRAY LONGINT:C221(tl_xPopCT_ID; 0)
			
			If (Size of array:C274(ta_xCentre)>0)
				
				For ($ii; 1; Size of array:C274(ta_xCentre))
					
					If (te_xCentre{$ii}=1)
						$kk:=Size of array:C274(ta_xPopCT_Centre)+1
						
						INSERT IN ARRAY:C227(ta_xPopCT_Centre; $kk)
						INSERT IN ARRAY:C227(tl_xPopCT_ID; $kk)
						
						ta_xPopCT_Centre{$kk}:=ta_xCentre{$ii}
						tl_xPopCT_ID{$kk}:=tl_xCentre{$ii}
					End if 
					
				End for 
				
			End if 
			
			If (Size of array:C274(ta_xPopCT_Centre)>0)
				
				If (Size of array:C274(ta_xPopCT_Centre)<Size of array:C274(ta_xCentre))
					QUERY WITH ARRAY:C644([HeberGement:5]HG_LC_ID:61; tl_xPopCT_ID)
					CREATE SET:C116([HeberGement:5]; "$E_Ctr")
					
					INTERSECTION:C121("E_encours"; "$E_Ctr"; "E_encours")
				End if 
				
			End if 
			
		Else 
			CREATE EMPTY SET:C140([HeberGement:5]; "E_encours")
		End if 
		
	End if 
	
	vl_NbHBd:=0
	vl_NbHom:=0
	vl_NbFem:=0
	
	ARRAY TEXT:C222(ta_TBEtCivTemp; 0)
	COPY ARRAY:C226(<>ta_TBEtCiv; ta_TBEtCivTemp)
	
	If (Records in table:C83([TableFusions:42])>0)
		Tab_FusionDestination(0; 0; 0)
		
		QUERY:C277([TableFusions:42]; [TableFusions:42]TF_RéférenceTable:2=va_CodeEnum)
		MultiSoc_Filter(->[TableFusions:42])
		
		ORDER BY:C49([TableFusions:42]; [TableFusions:42]TF_Libellé:3; >)
		SELECTION TO ARRAY:C260([TableFusions:42]TF_Libellé:3; ta_FileEtCiv; [TableFusions:42]TF_LibelléOrigine:4; ta_FilexEtCiv; [TableFusions:42]TF_Diviseur:7; te_FileEtCivDiv)
		
		// Modifié par : Scanu Rémy (10/10/2023)
		outilsCleanVariable(->te_FileEtCivNb; ->tl_FileEtCivNb)
		
		ARRAY LONGINT:C221(te_FileEtCivNb; Size of array:C274(ta_FileEtCiv))
		ARRAY LONGINT:C221(tl_FileEtCivNb; Size of array:C274(ta_FileEtCiv))
		
		For ($ii; 1; Size of array:C274(ta_FileEtCiv))
			
			If (te_FileEtCivDiv{$ii}<=0)
				te_FileEtCivDiv{$ii}:=1
			End if 
			
		End for 
		
	Else 
		Tab_FusionDestination(0; Size of array:C274(<>ta_TBEtCiv); 0)
		
		ARRAY LONGINT:C221(te_FileEtCivNb; Size of array:C274(ta_FileEtCiv))
		ARRAY LONGINT:C221(tl_FileEtCivNb; Size of array:C274(ta_FileEtCiv))
		
		For ($ii; 1; Size of array:C274(<>ta_TBEtCiv))
			ta_FileEtCiv{$ii}:=<>ta_TBEtCiv{$ii}
			ta_FilexEtCiv{$ii}:=<>ta_TBEtCiv{$ii}
			
			te_FileEtCivDiv{$ii}:=1
			te_FileEtCivNb{$ii}:=0
			tl_FileEtCivNb{$ii}:=0
		End for 
		
	End if 
	
	vl_Tab1:=Size of array:C274(ta_FileEtCiv)
	vl_NbHB:=Records in set:C195("E_encours")
	
	Log_mensuel($B_Log; "Etape 1: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
	
	// Partie2
	OB SET:C1220($O_Progression; \
		"progress ref"; $L_ref; \
		"progress titel"; "Etude"; \
		"progress message"; "Patientez... 2/4"; \
		"progress compteur"; 2; \
		"progress max"; $L_Max; \
		"progress stop"; -1\
		)
	
	4D_Progression_Send(->$O_Progression)
	
	If (sDif=1)
		
		If (<>vb_StopEven=False:C215)
			$L_Tick:=Milliseconds:C459
			
			USE SET:C118("E_encours")
			
			RELATE ONE SELECTION:C349([HeberGement:5]; [HeBerge:4])
			MultiSoc_Filter(->[HeBerge:4])
			
			vl_NbHBd:=Records in selection:C76([HeBerge:4])
			QUERY SELECTION:C341([HeBerge:4]; [HeBerge:4]HG_Genre:39=False:C215)
			
			vl_NbHom:=Records in selection:C76([HeBerge:4])
			vl_NbFem:=vl_NbHBd-vl_NbHom
			
			<>tl_TBGenre{1}:=vl_NbHom
			<>tl_TBGenre{2}:=vl_NbFem
			
			Log_mensuel($B_Log; "Etape 2: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
		End if 
		
	End if 
	
	// Partie3
	OB SET:C1220($O_Progression; \
		"progress ref"; $L_ref; \
		"progress titel"; "Etude"; \
		"progress message"; "Patientez... 3/4"; \
		"progress compteur"; 3; \
		"progress max"; $L_Max; \
		"progress stop"; -1\
		)
	
	4D_Progression_Send(->$O_Progression)
	$L_Tick:=Milliseconds:C459
	
	P_Calc_Etude1_Nv
	Log_mensuel($B_Log; "Etape 3: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
	
	CLOSE WINDOW:C154
	
	// Partie4
	OB SET:C1220($O_Progression; \
		"progress ref"; $L_ref; \
		"progress titel"; "Etude"; \
		"progress message"; "Patientez... 4/4"; \
		"progress compteur"; 4; \
		"progress max"; $L_Max; \
		"progress stop"; -1\
		)
	
	4D_Progression_Send(->$O_Progression)
	$L_Tick:=Milliseconds:C459
	
	P_Exporter_Etude
	Log_mensuel($B_Log; "Etape 4: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
	
	COPY ARRAY:C226(ta_TBEtCivTemp; <>ta_TBEtCiv)
	
	ON EVENT CALL:C190("")
	4D_Progression_Close($L_ref)
End if 

BEEP:C151
ALERT:C41("Statistiques Etude: Terminé")