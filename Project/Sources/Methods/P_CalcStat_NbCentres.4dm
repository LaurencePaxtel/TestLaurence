//%attributes = {"executedOnServer":true}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CalcStat_NbCentres
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================} 

C_POINTER:C301($1; $P_Objet)
$P_Objet:=$1
C_OBJECT:C1216($O_Objet)
$O_Objet:=OB Copy:C1225($P_Objet->)

If (True:C214)
	
	ARRAY TEXT:C222(ta_Centre; 0)
	ARRAY LONGINT:C221(t_CT_ID; 0)
	ARRAY LONGINT:C221(t_CT_CFem; 0)
	ARRAY LONGINT:C221(t_CT_EFem; 0)
	ARRAY LONGINT:C221(t_CT_PMin; 0)
	ARRAY LONGINT:C221(t_CT_MMin; 0)
	ARRAY LONGINT:C221(t_CT_SGrép; 0)
	ARRAY LONGINT:C221(t_CT_SGas; 0)
	ARRAY LONGINT:C221(t_CT_Lat; 0)
	ARRAY LONGINT:C221(t_CT_SGmd; 0)
	ARRAY LONGINT:C221(t_CT_DistA; 0)
	ARRAY LONGINT:C221(t_CT_Rest; 0)
	ARRAY LONGINT:C221(t_CT_DisJ; 0)
	ARRAY LONGINT:C221(t_CT_Abs; 0)
	ARRAY LONGINT:C221(t_CT_Total; 0)
	ARRAY LONGINT:C221(t_CT_Dis; 0)
	ARRAY LONGINT:C221(t_CT_SHom; 0)
	ARRAY LONGINT:C221(t_CT_CHom; 0)
	ARRAY LONGINT:C221(t_CT_EHom; 0)
	ARRAY LONGINT:C221(t_CT_FHom; 0)
	ARRAY LONGINT:C221(t_CT_SFem; 0)
	ARRAY LONGINT:C221(t_CT_FFem; 0)
	
	rJourNuit1:=OB Get:C1224($O_Objet; "rJourNuit1"; Est un entier long:K8:6)
	rJourNuit2:=OB Get:C1224($O_Objet; "rJourNuit2"; Est un entier long:K8:6)
	
	vl_CT_SHom:=OB Get:C1224($O_Objet; "vl_CT_SHom"; Est un entier long:K8:6)
	vl_CT_CHom:=OB Get:C1224($O_Objet; "vl_CT_CHom"; Est un entier long:K8:6)
	vl_CT_EHom:=OB Get:C1224($O_Objet; "vl_CT_EHom"; Est un entier long:K8:6)
	vl_CT_FHom:=OB Get:C1224($O_Objet; "vl_CT_FHom"; Est un entier long:K8:6)
	vl_CT_SFem:=OB Get:C1224($O_Objet; "vl_CT_SFem"; Est un entier long:K8:6)
	vl_CT_CFem:=OB Get:C1224($O_Objet; "vl_CT_CFem"; Est un entier long:K8:6)
	vl_CT_EFem:=OB Get:C1224($O_Objet; "vl_CT_EFem"; Est un entier long:K8:6)
	vl_CT_FFem:=OB Get:C1224($O_Objet; "vl_CT_FFem"; Est un entier long:K8:6)
	vl_CT_PMin:=OB Get:C1224($O_Objet; "vl_CT_PMin"; Est un entier long:K8:6)
	vl_CT_MMin:=OB Get:C1224($O_Objet; "vl_CT_MMin"; Est un entier long:K8:6)
	vl_CT_Total:=OB Get:C1224($O_Objet; "vl_CT_Total"; Est un entier long:K8:6)
	vl_CT_Dis:=OB Get:C1224($O_Objet; "vl_CT_Dis"; Est un entier long:K8:6)
	vl_CT_SGrép:=OB Get:C1224($O_Objet; "vl_CT_SGrép"; Est un entier long:K8:6)
	vl_CT_SGas:=OB Get:C1224($O_Objet; "vl_CT_SGas"; Est un entier long:K8:6)
	vl_CT_SGmd:=OB Get:C1224($O_Objet; "vl_CT_SGmd"; Est un entier long:K8:6)
	vl_CT_Capa:=OB Get:C1224($O_Objet; "vl_CT_Capa"; Est un entier long:K8:6)
	vl_CT_Lat:=OB Get:C1224($O_Objet; "vl_CT_Lat"; Est un entier long:K8:6)
	vl_CT_DistA:=OB Get:C1224($O_Objet; "vl_CT_DistA"; Est un entier long:K8:6)
	vl_CT_Rest:=OB Get:C1224($O_Objet; "vl_CT_Rest"; Est un entier long:K8:6)
	vl_CT_DisJ:=OB Get:C1224($O_Objet; "vl_CT_DisJ"; Est un entier long:K8:6)
	vl_CT_Abs:=OB Get:C1224($O_Objet; "vl_CT_Abs"; Est un entier long:K8:6)
	vl_lit_Dist:=OB Get:C1224($O_Objet; "vl_lit_Dist"; Est un entier long:K8:6)
	vl_lit_Rest:=OB Get:C1224($O_Objet; "vl_lit_Rest"; Est un entier long:K8:6)
	vl_lit_At:=OB Get:C1224($O_Objet; "vl_lit_At"; Est un entier long:K8:6)
	vr_lit_Pc:=OB Get:C1224($O_Objet; "vr_lit_Pc"; Est un numérique:K8:4)
	OB GET ARRAY:C1229($O_Objet; "ta_Centre"; ta_Centre)
	OB GET ARRAY:C1229($O_Objet; "t_CT_ID"; t_CT_ID)
	OB GET ARRAY:C1229($O_Objet; "t_CT_CFem"; t_CT_CFem)
	OB GET ARRAY:C1229($O_Objet; "t_CT_EFem"; t_CT_EFem)
	OB GET ARRAY:C1229($O_Objet; "t_CT_PMin"; t_CT_PMin)
	OB GET ARRAY:C1229($O_Objet; "t_CT_MMin"; t_CT_MMin)
	OB GET ARRAY:C1229($O_Objet; "t_CT_SGrép"; t_CT_SGrép)
	OB GET ARRAY:C1229($O_Objet; "t_CT_SGas"; t_CT_SGas)
	OB GET ARRAY:C1229($O_Objet; "t_CT_Lat"; t_CT_Lat)
	OB GET ARRAY:C1229($O_Objet; "t_CT_SGmd"; t_CT_SGmd)
	OB GET ARRAY:C1229($O_Objet; "t_CT_DistA"; t_CT_DistA)
	OB GET ARRAY:C1229($O_Objet; "t_CT_Rest"; t_CT_Rest)
	OB GET ARRAY:C1229($O_Objet; "t_CT_DisJ"; t_CT_DisJ)
	OB GET ARRAY:C1229($O_Objet; "t_CT_Abs"; t_CT_Abs)
	OB GET ARRAY:C1229($O_Objet; "t_CT_Total"; t_CT_Total)
	OB GET ARRAY:C1229($O_Objet; "t_CT_Dis"; t_CT_Dis)
	OB GET ARRAY:C1229($O_Objet; "t_CT_SHom"; t_CT_SHom)
	OB GET ARRAY:C1229($O_Objet; "t_CT_CHom"; t_CT_CHom)
	OB GET ARRAY:C1229($O_Objet; "t_CT_EHom"; t_CT_EHom)
	OB GET ARRAY:C1229($O_Objet; "t_CT_FHom"; t_CT_FHom)
	OB GET ARRAY:C1229($O_Objet; "t_CT_SFem"; t_CT_SFem)
	OB GET ARRAY:C1229($O_Objet; "t_CT_FFem"; t_CT_FFem)
End if 

//L'Hébergement
vl_CT_SHom:=0
vl_CT_CHom:=0
vl_CT_EHom:=0
vl_CT_FHom:=0
vl_CT_SFem:=0
vl_CT_CFem:=0
vl_CT_EFem:=0
vl_CT_FFem:=0
vl_CT_PMin:=0
vl_CT_MMin:=0
vl_CT_Total:=0
vl_CT_Dis:=0
vl_CT_Rest:=0
vl_CT_DisJ:=0
vl_CT_SGrép:=0
vl_CT_SGas:=0
vl_CT_SGmd:=0
vl_CT_Capa:=0
vl_CT_Abs:=0
vl_CT_Lat:=0
vl_CT_DistA:=0


C_LONGINT:C283($vl_TailTab; $ii; $vl_Position1)
$vl_TailTab:=Size of array:C274(ta_Centre)
If ($vl_TailTab>0)
	
	C_TEXT:C284($T_File)
	$T_File:="debug_"+Current method name:C684+"_.txt"
	C_BOOLEAN:C305($B_Log)
	$B_Log:=False:C215
	Log_mensuel($B_Log; "----------------- Demarrage de "+Current method name:C684; $T_File)
	
	
	// etape 1
	
	USE SET:C118("E_HGStatClôt")
	
	C_TEXT:C284($T_Path)
	$T_Path:=System folder:C487(Bureau:K41:16)+"benchmark"
	SAVE SET:C184("E_HGStatClôt"; $T_Path)
	If (Records in selection:C76([HeberGement:5])>0)
		//FIRST RECORD([HeberGement])
		
		C_LONGINT:C283($L_Milli)
		$L_Milli:=Milliseconds:C459
		
		ARRAY LONGINT:C221($rL_HG_LC_ID; 0)
		ARRAY TEXT:C222($rT_HG_EtatCivil; 0)
		ARRAY BOOLEAN:C223($rB_HG_Cloturee; 0)
		ARRAY TEXT:C222($rT_HG_Signalement; 0)
		
		SELECTION TO ARRAY:C260([HeberGement:5]HG_LC_ID:61; $rL_HG_LC_ID; *)
		SELECTION TO ARRAY:C260([HeberGement:5]HG_EtatCivil:20; $rT_HG_EtatCivil; *)
		SELECTION TO ARRAY:C260([HeberGement:5]HG_Cloturée:67; $rB_HG_Cloturee; *)
		SELECTION TO ARRAY:C260([HeberGement:5]HG_Signalement:12; $rT_HG_Signalement)
		
		For ($ii; 1; Records in selection:C76([HeberGement:5]))
			
			C_LONGINT:C283($Pos)
			$Pos:=Find in array:C230(t_CT_ID; $rL_HG_LC_ID{$ii})
			If ($Pos>0)
				
				C_TEXT:C284($va_Critere)
				//$va_Critere:=Substring([HeberGement]HG_EtatCivil;Length([HeberGement]HG_EtatCivil)-3;4)  //Ancien
				$va_Critere:=""
				
				$vl_Position1:=Position:C15("("; $rT_HG_EtatCivil{$ii})
				//$vl_Position2:=Position(")";[HeberGement]HG_EtatCivil)
				If ($vl_Position1>0)
					$va_Critere:=Substring:C12($rT_HG_EtatCivil{$ii}; $vl_Position1; 3)
					$va_Critere:=$va_Critere+")"
				End if 
				
				
				Case of 
					: ($va_Critere="(HS)")  //"Homme seul")
						t_CT_SHom{$Pos}:=t_CT_SHom{$Pos}+1
					: ($va_Critere="(HC)")  //"Homme en couple")
						t_CT_CHom{$Pos}:=t_CT_CHom{$Pos}+1
					: ($va_Critere="(HE)")  //"Homme avec enfants")
						t_CT_EHom{$Pos}:=t_CT_EHom{$Pos}+1
					: ($va_Critere="(HF)")  //"Homme en famille")
						t_CT_FHom{$Pos}:=t_CT_FHom{$Pos}+1
					: ($va_Critere="(FS)")  //"Femme seule")
						t_CT_SFem{$Pos}:=t_CT_SFem{$Pos}+1
					: ($va_Critere="(FC)")  //"Femme en couple")
						t_CT_CFem{$Pos}:=t_CT_CFem{$Pos}+1
					: ($va_Critere="(FE)")  //"Femme avec enfants")
						t_CT_EFem{$Pos}:=t_CT_EFem{$Pos}+1
					: ($va_Critere="(FF)")  //"Femme en famille")
						t_CT_FFem{$Pos}:=t_CT_FFem{$Pos}+1
						
					: ($va_Critere="(HP)")  //"Majeur avec parents")
						t_CT_PMin{$Pos}:=t_CT_PMin{$Pos}+1
					: ($va_Critere="(FP)")  //"Majeur avec parents")
						t_CT_PMin{$Pos}:=t_CT_PMin{$Pos}+1
						
					: ($va_Critere="(HM)")  //"Mineur")
						t_CT_MMin{$Pos}:=t_CT_MMin{$Pos}+1
					: ($va_Critere="(FM)")  //"Mineur")
						t_CT_MMin{$Pos}:=t_CT_MMin{$Pos}+1
				End case 
				
				
				If ($rB_HG_Cloturee{$ii})
					Case of 
						: ($rT_HG_Signalement{$ii}="* Report")
							t_CT_SGrép{$Pos}:=t_CT_SGrép{$Pos}+1
							t_CT_Lat{$Pos}:=t_CT_Lat{$Pos}+1
						: ($rT_HG_Signalement{$ii}="* Prolongation AS")
							t_CT_SGas{$Pos}:=t_CT_SGas{$Pos}+1
							t_CT_Lat{$Pos}:=t_CT_Lat{$Pos}+1
						: ($rT_HG_Signalement{$ii}="* Prolongation MED")
							t_CT_SGmd{$Pos}:=t_CT_SGmd{$Pos}+1
							t_CT_Lat{$Pos}:=t_CT_Lat{$Pos}+1
						Else 
							t_CT_DistA{$Pos}:=t_CT_DistA{$Pos}+1
					End case 
					
				End if 
			End if 
			
			//NEXT RECORD([HeberGement])
		End for 
		//Repeat 
		
		//Until (End selection([HeberGement]))
		C_REAL:C285($R_Time)
		$R_Time:=Milliseconds:C459-$L_Milli
		Log_mensuel($B_Log; "Etape 1 "+String:C10($R_Time); $T_File)
	End if 
	
	
	
	
	// etape 2
	C_LONGINT:C283($L_Milli)
	$L_Milli:=Milliseconds:C459
	USE SET:C118("E_CLCourant")
	If (Records in selection:C76([CentresLits:16])>0)
		
		
		//FIRST RECORD([CentresLits])
		ARRAY LONGINT:C221($rL_LC_ID; 0)
		ARRAY INTEGER:C220($rI_Restant; 0)
		ARRAY INTEGER:C220($rI_Absents; 0)
		ARRAY INTEGER:C220($rI_DispoDuJour; 0)
		
		SELECTION TO ARRAY:C260([CentresLits:16]CL_LC_ID:2; $rL_LC_ID; *)
		SELECTION TO ARRAY:C260([CentresLits:16]CL_Restant:7; $rI_Restant; *)
		SELECTION TO ARRAY:C260([CentresLits:16]CL_Absents:13; $rI_Absents; *)
		SELECTION TO ARRAY:C260([CentresLits:16]CL_DispoDuJour:12; $rI_DispoDuJour)
		
		$ii:=0
		Repeat 
			$ii:=$ii+1
			
			$Pos:=Find in array:C230(t_CT_ID; $rL_LC_ID{$ii})
			If ($Pos>0)
				
				If (rJourNuit1=1) & (rJourNuit2=1)
					t_CT_Rest{$Pos}:=t_CT_Rest{$Pos}+$rI_Restant{$ii}-$rI_Absents{$ii}
					vl_CT_Rest:=vl_CT_Rest+$rI_Restant{$ii}-$rI_Absents{$ii}
				Else 
					t_CT_Rest{$Pos}:=t_CT_Rest{$Pos}+$rI_Restant{$ii}
					vl_CT_Rest:=vl_CT_Rest+$rI_Restant{$ii}
				End if 
				
				t_CT_DisJ{$Pos}:=t_CT_DisJ{$Pos}+$rI_DispoDuJour{$ii}
				vl_CT_DisJ:=vl_CT_DisJ+$rI_DispoDuJour{$ii}
				t_CT_Abs{$Pos}:=t_CT_Abs{$Pos}+$rI_Absents{$ii}
				vl_CT_Abs:=vl_CT_Abs+$rI_Absents{$ii}
				
			End if 
			// NEXT RECORD([CentresLits])
			
		Until ($ii=Records in selection:C76([CentresLits:16]))
	End if 
	C_REAL:C285($R_Time)
	$R_Time:=Milliseconds:C459-$L_Milli
	Log_mensuel($B_Log; "Etape 2 "+String:C10($R_Time); $T_File)
	
	
	
	// etape 3
	C_LONGINT:C283($L_Milli)
	$L_Milli:=Milliseconds:C459
	For ($ii; 1; $vl_TailTab)
		t_CT_Total{$ii}:=t_CT_SHom{$ii}+t_CT_CHom{$ii}+t_CT_EHom{$ii}+t_CT_FHom{$ii}+t_CT_SFem{$ii}+t_CT_CFem{$ii}+t_CT_EFem{$ii}+t_CT_FFem{$ii}+t_CT_PMin{$ii}+t_CT_MMin{$ii}
		vl_CT_SHom:=vl_CT_SHom+t_CT_SHom{$ii}
		vl_CT_CHom:=vl_CT_CHom+t_CT_CHom{$ii}
		vl_CT_EHom:=vl_CT_EHom+t_CT_EHom{$ii}
		vl_CT_FHom:=vl_CT_FHom+t_CT_FHom{$ii}
		
		vl_CT_SFem:=vl_CT_SFem+t_CT_SFem{$ii}
		vl_CT_CFem:=vl_CT_CFem+t_CT_CFem{$ii}
		vl_CT_EFem:=vl_CT_EFem+t_CT_EFem{$ii}
		vl_CT_FFem:=vl_CT_FFem+t_CT_FFem{$ii}
		
		vl_CT_PMin:=vl_CT_PMin+t_CT_PMin{$ii}
		vl_CT_MMin:=vl_CT_MMin+t_CT_MMin{$ii}
		
		vl_CT_Total:=vl_CT_Total+t_CT_Total{$ii}
		
		//Changement de calcul
		t_CT_Dis{$ii}:=t_CT_Total{$ii}+t_CT_Rest{$ii}
		vl_CT_Dis:=vl_CT_Dis+t_CT_Dis{$ii}
		
		vl_CT_SGrép:=vl_CT_SGrép+t_CT_SGrép{$ii}
		vl_CT_SGas:=vl_CT_SGas+t_CT_SGas{$ii}
		vl_CT_SGmd:=vl_CT_SGmd+t_CT_SGmd{$ii}
		vl_CT_DistA:=vl_CT_DistA+t_CT_DistA{$ii}
		
		vl_CT_Lat:=vl_CT_Lat+t_CT_Lat{$ii}
	End for 
	C_REAL:C285($R_Time)
	$R_Time:=Milliseconds:C459-$L_Milli
	Log_mensuel($B_Log; "Etape 1 "+String:C10($R_Time); $T_File)
	
	
	vl_lit_Dist:=vl_CT_Total
	vl_lit_Rest:=vl_CT_Rest
	vl_lit_At:=vl_CT_Total+vl_CT_Rest
	If (vl_lit_At>0)
		vr_lit_Pc:=(vl_lit_Dist/vl_lit_At)*100
	Else 
		vr_lit_Pc:=0
	End if 
	
End if 

If (True:C214)
	OB SET:C1220($O_Objet; "vl_CT_SHom"; vl_CT_SHom)
	OB SET:C1220($O_Objet; "vl_CT_CHom"; vl_CT_CHom)
	OB SET:C1220($O_Objet; "vl_CT_EHom"; vl_CT_EHom)
	OB SET:C1220($O_Objet; "vl_CT_FHom"; vl_CT_FHom)
	OB SET:C1220($O_Objet; "vl_CT_SFem"; vl_CT_SFem)
	OB SET:C1220($O_Objet; "vl_CT_CFem"; vl_CT_CFem)
	OB SET:C1220($O_Objet; "vl_CT_EFem"; vl_CT_EFem)
	OB SET:C1220($O_Objet; "vl_CT_FFem"; vl_CT_FFem)
	OB SET:C1220($O_Objet; "vl_CT_PMin"; vl_CT_PMin)
	OB SET:C1220($O_Objet; "vl_CT_MMin"; vl_CT_MMin)
	OB SET:C1220($O_Objet; "vl_CT_Total"; vl_CT_Total)
	OB SET:C1220($O_Objet; "vl_CT_Dis"; vl_CT_Dis)
	OB SET:C1220($O_Objet; "vl_CT_SGrép"; vl_CT_SGrép)
	OB SET:C1220($O_Objet; "vl_CT_SGas"; vl_CT_SGas)
	OB SET:C1220($O_Objet; "vl_CT_SGmd"; vl_CT_SGmd)
	OB SET:C1220($O_Objet; "vl_CT_Capa"; vl_CT_Capa)
	OB SET:C1220($O_Objet; "vl_CT_Lat"; vl_CT_Lat)
	OB SET:C1220($O_Objet; "vl_CT_DistA"; vl_CT_DistA)
	OB SET:C1220($O_Objet; "vl_CT_Rest"; vl_CT_Rest)
	OB SET:C1220($O_Objet; "vl_CT_DisJ"; vl_CT_DisJ)
	OB SET:C1220($O_Objet; "vl_CT_Abs"; vl_CT_Abs)
	OB SET:C1220($O_Objet; "vl_lit_Dist"; vl_lit_Dist)
	OB SET:C1220($O_Objet; "vl_lit_Rest"; vl_lit_Rest)
	OB SET:C1220($O_Objet; "vl_lit_At"; vl_lit_At)
	OB SET:C1220($O_Objet; "vr_lit_Pc"; vr_lit_Pc)
	OB SET ARRAY:C1227($O_Objet; "ta_Centre"; ta_Centre)
	OB SET ARRAY:C1227($O_Objet; "t_CT_ID"; t_CT_ID)
	OB SET ARRAY:C1227($O_Objet; "t_CT_CFem"; t_CT_CFem)
	OB SET ARRAY:C1227($O_Objet; "t_CT_EFem"; t_CT_EFem)
	OB SET ARRAY:C1227($O_Objet; "t_CT_PMin"; t_CT_PMin)
	OB SET ARRAY:C1227($O_Objet; "t_CT_MMin"; t_CT_MMin)
	OB SET ARRAY:C1227($O_Objet; "t_CT_SGrép"; t_CT_SGrép)
	OB SET ARRAY:C1227($O_Objet; "t_CT_SGas"; t_CT_SGas)
	OB SET ARRAY:C1227($O_Objet; "t_CT_Lat"; t_CT_Lat)
	OB SET ARRAY:C1227($O_Objet; "t_CT_SGmd"; t_CT_SGmd)
	OB SET ARRAY:C1227($O_Objet; "t_CT_DistA"; t_CT_DistA)
	OB SET ARRAY:C1227($O_Objet; "t_CT_Rest"; t_CT_Rest)
	OB SET ARRAY:C1227($O_Objet; "t_CT_DisJ"; t_CT_DisJ)
	OB SET ARRAY:C1227($O_Objet; "t_CT_Abs"; t_CT_Abs)
	OB SET ARRAY:C1227($O_Objet; "t_CT_Total"; t_CT_Total)
	OB SET ARRAY:C1227($O_Objet; "t_CT_SHom"; t_CT_SHom)
	OB SET ARRAY:C1227($O_Objet; "t_CT_CHom"; t_CT_CHom)
	OB SET ARRAY:C1227($O_Objet; "t_CT_EHom"; t_CT_EHom)
	OB SET ARRAY:C1227($O_Objet; "t_CT_FHom"; t_CT_FHom)
	OB SET ARRAY:C1227($O_Objet; "t_CT_SFem"; t_CT_SFem)
	OB SET ARRAY:C1227($O_Objet; "t_CT_FFem"; t_CT_FFem)
End if 

$P_Objet->:=OB Copy:C1225($O_Objet)