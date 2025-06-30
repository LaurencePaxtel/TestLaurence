//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_Direction
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

If (vl_NbJ>366) & (vl_NbJ<1)
	ALERT:C41("Vous ne pouvez pas excéder une année !")
Else 
	// #TAG-STATS
	C_TEXT:C284($T_File)
	$T_File:="debug_"+Current method name:C684+"_.txt"
	C_BOOLEAN:C305($B_Log)
	$B_Log:=False:C215
	Log_mensuel($B_Log; "----------------- Demarrage de "+Current method name:C684; $T_File)
	
	//i_Message ("Chargement en cours …")
	i_Stop
	ON EVENT CALL:C190("i_Stop_ESC")
	V_Stat_Direction(1)
	C_LONGINT:C283($vl_IndTps)
	$vl_IndTps:=0
	C_LONGINT:C283($vl_IndDr)
	$vl_IndDr:=0
	vl_NbHBd:=0
	vl_NbHB:=0
	
	//Recherche de la sélection de demandes d'hébergements
	
	
	C_LONGINT:C283($L_ref)
	$L_ref:=4D_Progression_Open("")
	C_OBJECT:C1216($O_Progression)
	
	OB SET:C1220($O_Progression; \
		"progress ref"; $L_ref; \
		"progress titel"; "Répartition calendaire"; \
		"progress message"; ""; \
		"progress compteur"; -1; \
		"progress max"; -1; \
		"progress stop"; -1\
		)
	
	
	//1
	OB SET:C1220($O_Progression; \
		"progress message"; "Calcul en cours  1/5 du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2)\
		)
	4D_Progression_Send(->$O_Progression)
	
	
	//i_MessageSeul ("recherche en cours  1/5")
	If (<>vb_StopEven=False:C215)
		
		C_LONGINT:C283($L_Tick)
		$L_Tick:=Milliseconds:C459
		
		C_OBJECT:C1216($O_Objet)
		If (True:C214)
			vl_DrTPers2:=0
			vl_DrTHgé2:=0
			
			OB SET:C1220($O_Objet; "rReport"; rReport)
			OB SET:C1220($O_Objet; "u2"; u2)
			OB SET:C1220($O_Objet; "vd_Date1"; vd_Date1)
			OB SET:C1220($O_Objet; "vd_Date2"; vd_Date2)
			OB SET:C1220($O_Objet; "vl_DrTDem"; vl_DrTDem)
			OB SET:C1220($O_Objet; "vl_DrTHg"; vl_DrTHg)
			OB SET:C1220($O_Objet; "vl_DrTHgé"; vl_DrTHgé)
			OB SET:C1220($O_Objet; "vl_DrTHgé2"; vl_DrTHgé2)
			OB SET:C1220($O_Objet; "vl_DrTPers"; vl_DrTPers)
			OB SET:C1220($O_Objet; "vl_DrTPers2"; vl_DrTPers2)
			OB SET:C1220($O_Objet; "vl_NbHB"; vl_NbHB)
			
			OB SET ARRAY:C1227($O_Objet; "<>ts_Cloturé"; <>ts_Cloturé)
			OB SET ARRAY:C1227($O_Objet; "<>ts_Date"; <>ts_Date)
			OB SET ARRAY:C1227($O_Objet; "<>ts_IDHB"; <>ts_IDHB)
			OB SET ARRAY:C1227($O_Objet; "<>ts_IDLC"; <>ts_IDLC)
			OB SET ARRAY:C1227($O_Objet; "<>ts_Nuit"; <>ts_Nuit)
		End if 
		
		// Modifié par : Kevin HASSAL (06/12/2018)
		// On passe la valeur de la variable <>ref_soc_active
		// pour les méhodes qui s'exécutent côté serveur
		
		P_CalcStat_Direction_etape1(->$O_Objet; <>ref_soc_active)
		
		If (True:C214)
			
			rReport:=OB Get:C1224($O_Objet; "rReport"; Est un entier long:K8:6)
			u2:=OB Get:C1224($O_Objet; "u2"; Est un entier long:K8:6)
			vd_Date1:=OB Get:C1224($O_Objet; "vd_Date1"; Est une date:K8:7)
			vd_Date2:=OB Get:C1224($O_Objet; "vd_Date2"; Est une date:K8:7)
			vl_DrTDem:=OB Get:C1224($O_Objet; "vl_DrTDem"; Est un entier long:K8:6)
			vl_DrTHg:=OB Get:C1224($O_Objet; "vl_DrTHg"; Est un entier long:K8:6)
			vl_DrTHgé:=OB Get:C1224($O_Objet; "vl_DrTHgé"; Est un entier long:K8:6)
			vl_DrTHgé2:=OB Get:C1224($O_Objet; "vl_DrTHgé2"; Est un entier long:K8:6)
			vl_DrTPers:=OB Get:C1224($O_Objet; "vl_DrTPers"; Est un entier long:K8:6)
			vl_DrTPers2:=OB Get:C1224($O_Objet; "vl_DrTPers2"; Est un entier long:K8:6)
			vl_NbHB:=OB Get:C1224($O_Objet; "vl_NbHB"; Est un entier long:K8:6)
			
			OB GET ARRAY:C1229($O_Objet; "<>ts_Cloturé"; <>ts_Cloturé)
			OB GET ARRAY:C1229($O_Objet; "<>ts_Date"; <>ts_Date)
			OB GET ARRAY:C1229($O_Objet; "<>ts_IDHB"; <>ts_IDHB)
			OB GET ARRAY:C1229($O_Objet; "<>ts_IDLC"; <>ts_IDLC)
			OB GET ARRAY:C1229($O_Objet; "<>ts_Nuit"; <>ts_Nuit)
		End if 
		CLEAR VARIABLE:C89($O_Objet)
		
		
		Log_mensuel($B_Log; "Etape 1: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
	End if 
	
	
	
	
	//2
	OB SET:C1220($O_Progression; \
		"progress message"; "Calcul en cours  2/5 du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2)\
		)
	4D_Progression_Send(->$O_Progression)
	
	//i_MessageSeul ("Calcul en cours  2/5")
	If (Size of array:C274(<>ts_Date)>0)
		If (<>vb_StopEven=False:C215)
			
			C_LONGINT:C283($L_Tick)
			$L_Tick:=Milliseconds:C459
			
			SORT ARRAY:C229(<>ts_Date; <>ts_Nuit; <>ts_IDHB; <>ts_IDLC; <>ts_Cloturé; >)
			
			C_LONGINT:C283($IDHBOld)
			$IDHBOld:=0
			C_DATE:C307($DtOld)
			$DtOld:=!00-00-00!
			
			C_LONGINT:C283($ii)
			For ($ii; 1; Size of array:C274(<>ts_Date))
				<>tsp_IDHB:=Find in array:C230(<>tsp_IDHB; <>ts_IDHB{$ii})
				If (<>tsp_IDHB>0)
				Else 
					$vl_IndTps:=Size of array:C274(<>tsp_IDHB)+1
					INSERT IN ARRAY:C227(<>tsp_IDHB; $vl_IndTps; 1)
					INSERT IN ARRAY:C227(<>tsp_NbJ; $vl_IndTps; 1)
					INSERT IN ARRAY:C227(<>tsp_NbN; $vl_IndTps; 1)
					INSERT IN ARRAY:C227(<>tsp_NbJc; $vl_IndTps; 1)
					INSERT IN ARRAY:C227(<>tsp_NbNc; $vl_IndTps; 1)
					INSERT IN ARRAY:C227(<>tsp_NbTout; $vl_IndTps; 1)
					INSERT IN ARRAY:C227(<>tsp_NbToutc; $vl_IndTps; 1)
					<>tsp_IDHB:=$vl_IndTps
					<>tsp_IDHB{<>tsp_IDHB}:=<>ts_IDHB{$ii}
				End if 
				
				If (<>ts_Cloturé{$ii})
					If (<>ts_Nuit{$ii}=True:C214)
						<>tsp_NbNc{<>tsp_IDHB}:=<>tsp_NbNc{<>tsp_IDHB}+1
					Else 
						<>tsp_NbJc{<>tsp_IDHB}:=<>tsp_NbJc{<>tsp_IDHB}+1
					End if 
				Else 
					If (<>ts_Nuit{$ii}=True:C214)
						<>tsp_NbN{<>tsp_IDHB}:=<>tsp_NbN{<>tsp_IDHB}+1
					Else 
						<>tsp_NbJ{<>tsp_IDHB}:=<>tsp_NbJ{<>tsp_IDHB}+1
					End if 
				End if 
				
				If ($IDHBOld#<>ts_IDHB{$ii})
					$IDHBOld:=<>ts_IDHB{$ii}
					vl_NbHBd:=vl_NbHBd+1
				End if 
				If ($DtOld#<>ts_Date{$ii})
					$DtOld:=<>ts_Date{$ii}
					$vl_IndDr:=Size of array:C274(td_DrDt)+1
					INSERT IN ARRAY:C227(td_DrDt; $vl_IndDr; 1)
					INSERT IN ARRAY:C227(td_DrAjJ; $vl_IndDr; 1)
					INSERT IN ARRAY:C227(td_DrAjN; $vl_IndDr; 1)
					INSERT IN ARRAY:C227(td_DrAjT; $vl_IndDr; 1)
					INSERT IN ARRAY:C227(td_DrOjJ; $vl_IndDr; 1)
					INSERT IN ARRAY:C227(td_DrOjN; $vl_IndDr; 1)
					INSERT IN ARRAY:C227(td_DrOjT; $vl_IndDr; 1)
					td_DrDt{$vl_IndDr}:=$DtOld
				End if 
				
				If (<>ts_Cloturé{$ii})
					If (<>ts_Nuit{$ii}=True:C214)
						td_DrOjN{$vl_IndDr}:=td_DrOjN{$vl_IndDr}+1
					Else 
						td_DrOjJ{$vl_IndDr}:=td_DrOjJ{$vl_IndDr}+1
					End if 
				End if 
				
				If (<>ts_Nuit{$ii}=True:C214)
					td_DrAjN{$vl_IndDr}:=td_DrAjN{$vl_IndDr}+1
				Else 
					td_DrAjJ{$vl_IndDr}:=td_DrAjJ{$vl_IndDr}+1
				End if 
				
			End for 
			
			
			Log_mensuel($B_Log; "Etape 2: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
			
		End if 
	End if 
	
	
	
	//3
	OB SET:C1220($O_Progression; \
		"progress message"; "Calcul en cours  3/5 du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2)\
		)
	4D_Progression_Send(->$O_Progression)
	
	//i_MessageSeul ("Calcul en cours  3/5")
	If (Size of array:C274(<>ts_Date)>0)
		If (<>vb_StopEven=False:C215)
			
			C_LONGINT:C283($L_Tick)
			$L_Tick:=Milliseconds:C459
			
			For ($ii; 1; Size of array:C274(<>tsp_IDHB))
				<>tsp_NbTout{$ii}:=<>tsp_NbJ{$ii}+<>tsp_NbN{$ii}
				<>tsp_NbToutc{$ii}:=<>tsp_NbJc{$ii}+<>tsp_NbNc{$ii}
			End for 
			SORT ARRAY:C229(<>tsp_NbToutc; <>tsp_NbJc; <>tsp_NbNc; <>tsp_NbTout; <>tsp_NbJ; <>tsp_NbN; <>tsp_IDHB; >)
			For ($ii; 1; Size of array:C274(<>tsp_IDHB))
				If (<>tsp_NbToutc{$ii}>0)
					td_ORnb:=Find in array:C230(td_ORnb; <>tsp_NbToutc{$ii})
					If (td_ORnb>0)
						td_ORT{td_ORnb}:=td_ORT{td_ORnb}+1
					Else 
						$vl_IndTps:=Size of array:C274(td_ORnb)+1
						INSERT IN ARRAY:C227(td_ORnb; $vl_IndTps; 1)
						INSERT IN ARRAY:C227(td_ORJ; $vl_IndTps; 1)
						INSERT IN ARRAY:C227(td_ORN; $vl_IndTps; 1)
						INSERT IN ARRAY:C227(td_ORT; $vl_IndTps; 1)
						td_ORnb:=$vl_IndTps
						td_ORnb{td_ORnb}:=<>tsp_NbToutc{$ii}
						td_ORT{td_ORnb}:=td_ORT{td_ORnb}+1
					End if 
				End if 
			End for 
			vl_ORJ:=0
			vl_ORT:=0
			For ($ii; 1; Size of array:C274(td_ORT))
				vl_ORT:=vl_ORT+td_ORT{$ii}
				vl_ORJ:=vl_ORJ+(td_ORnb{$ii}*td_ORT{$ii})
			End for 
			vl_ORJb:=vl_ORJ
			vl_ORTb:=vl_ORT
			
			Log_mensuel($B_Log; "Etape 3: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
		End if 
	End if 
	
	//4
	OB SET:C1220($O_Progression; \
		"progress message"; "Calcul en cours  4/5 du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2)\
		)
	4D_Progression_Send(->$O_Progression)
	
	//i_MessageSeul ("Calcul en cours  4/5")
	If (Size of array:C274(td_DrDt)>0)
		If (<>vb_StopEven=False:C215)
			
			C_LONGINT:C283($L_Tick)
			$L_Tick:=Milliseconds:C459
			
			vl_DrAjJ:=0
			vl_DrAjN:=0
			vl_DrAjT:=0
			vl_DrOjJ:=0
			vl_DrOjN:=0
			vl_DrOjT:=0
			For ($ii; 1; Size of array:C274(td_DrDt))
				td_DrAjT{$ii}:=td_DrAjN{$ii}+td_DrAjJ{$ii}
				td_DrOjT{$ii}:=td_DrOjN{$ii}+td_DrOjJ{$ii}
				vl_DrAjJ:=vl_DrAjJ+td_DrAjJ{$ii}
				vl_DrAjN:=vl_DrAjN+td_DrAjN{$ii}
				vl_DrAjT:=vl_DrAjT+td_DrAjT{$ii}
				vl_DrOjJ:=vl_DrOjJ+td_DrOjJ{$ii}
				vl_DrOjN:=vl_DrOjN+td_DrOjN{$ii}
				vl_DrOjT:=vl_DrOjT+td_DrOjT{$ii}
			End for 
			
			$IDHBOld:=0
			For ($ii; 1; Size of array:C274(td_DrDt))
				If ($IDHBOld#Month of:C24(td_DrDt{$ii}))
					$IDHBOld:=Month of:C24(td_DrDt{$ii})
					$vl_IndDr:=Size of array:C274(td_DrMs)+1
					INSERT IN ARRAY:C227(td_DrMs; $vl_IndDr; 1)
					INSERT IN ARRAY:C227(td_DrAmJ; $vl_IndDr; 1)
					INSERT IN ARRAY:C227(td_DrAmN; $vl_IndDr; 1)
					INSERT IN ARRAY:C227(td_DrAmT; $vl_IndDr; 1)
					INSERT IN ARRAY:C227(td_DrOmJ; $vl_IndDr; 1)
					INSERT IN ARRAY:C227(td_DrOmN; $vl_IndDr; 1)
					INSERT IN ARRAY:C227(td_DrOmT; $vl_IndDr; 1)
					td_DrMs{$vl_IndDr}:=Date:C102("01/"+String:C10(Month of:C24(td_DrDt{$ii}))+"/"+String:C10(Year of:C25(td_DrDt{$ii})))
				End if 
				td_DrAmJ{$vl_IndDr}:=td_DrAmJ{$vl_IndDr}+td_DrAjJ{$ii}
				td_DrAmN{$vl_IndDr}:=td_DrAmN{$vl_IndDr}+td_DrAjN{$ii}
				td_DrAmT{$vl_IndDr}:=td_DrAmT{$vl_IndDr}+td_DrAjT{$ii}
				td_DrOmJ{$vl_IndDr}:=td_DrOmJ{$vl_IndDr}+td_DrOjJ{$ii}
				td_DrOmN{$vl_IndDr}:=td_DrOmN{$vl_IndDr}+td_DrOjN{$ii}
				td_DrOmT{$vl_IndDr}:=td_DrOmT{$vl_IndDr}+td_DrOjT{$ii}
			End for 
			
			Log_mensuel($B_Log; "Etape 4: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
			
		End if 
	End if 
	
	//5
	OB SET:C1220($O_Progression; \
		"progress message"; "Calcul en cours  5/5 du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2)\
		)
	4D_Progression_Send(->$O_Progression)
	
	//i_MessageSeul ("Calcul en cours  5/5")
	If (Size of array:C274(td_DrDt)>0)
		If (<>vb_StopEven=False:C215)
			
			C_LONGINT:C283($L_Tick)
			$L_Tick:=Milliseconds:C459
			
			vl_DrAmJ:=0
			vl_DrAmN:=0
			vl_DrAmT:=0
			vl_DrOmJ:=0
			vl_DrOmN:=0
			vl_DrOmT:=0
			For ($ii; 1; Size of array:C274(td_DrMs))
				vl_DrAmJ:=vl_DrAmJ+td_DrAmJ{$ii}
				vl_DrAmN:=vl_DrAmN+td_DrAmN{$ii}
				vl_DrAmT:=vl_DrAmT+td_DrAmT{$ii}
				vl_DrOmJ:=vl_DrOmJ+td_DrOmJ{$ii}
				vl_DrOmN:=vl_DrOmN+td_DrOmN{$ii}
				vl_DrOmT:=vl_DrOmT+td_DrOmT{$ii}
			End for 
			Log_mensuel($B_Log; "Etape 5: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
			
		End if 
	End if 
	4D_Progression_Close($L_ref)
	ON EVENT CALL:C190("")
	CLOSE WINDOW:C154
End if 
