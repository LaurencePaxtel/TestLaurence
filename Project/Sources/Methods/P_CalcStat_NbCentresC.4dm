//%attributes = {"executedOnServer":true}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CalcStat_NbCentres
//{
//{          Lundi 26 janvier 2004 à 16:45:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($vl_TailTab; $ii; $Pos; $vl_Position1)
C_TEXT:C284($va_Critere)


C_POINTER:C301($1; $P_Objet)
$P_Objet:=$1
C_OBJECT:C1216($O_Objet)
$O_Objet:=OB Copy:C1225($P_Objet->)

ARRAY LONGINT:C221(t_CT_Abs; 0)
ARRAY LONGINT:C221(t_CT_CFem; 0)
ARRAY LONGINT:C221(t_CT_CHom; 0)
ARRAY LONGINT:C221(t_CT_Dis; 0)
ARRAY LONGINT:C221(t_CT_DisJ; 0)
ARRAY LONGINT:C221(t_CT_DistA; 0)
ARRAY LONGINT:C221(t_CT_EFem; 0)
ARRAY LONGINT:C221(t_CT_EHom; 0)
ARRAY LONGINT:C221(t_CT_FFem; 0)
ARRAY LONGINT:C221(t_CT_FHom; 0)
ARRAY LONGINT:C221(t_CT_ID; 0)
ARRAY LONGINT:C221(t_CT_Lat; 0)
ARRAY LONGINT:C221(t_CT_MMin; 0)
ARRAY LONGINT:C221(t_CT_PMin; 0)
ARRAY LONGINT:C221(t_CT_Rest; 0)
ARRAY LONGINT:C221(t_CT_SFem; 0)
ARRAY LONGINT:C221(t_CT_SGas; 0)
ARRAY LONGINT:C221(t_CT_SGmd; 0)
ARRAY LONGINT:C221(t_CT_SGrép; 0)
ARRAY LONGINT:C221(t_CT_SHom; 0)
ARRAY LONGINT:C221(t_CT_Total; 0)
ARRAY TEXT:C222(ta_Centre; 0)
ARRAY INTEGER:C220(te_Centre; 0)

vl_CT_Abs:=OB Get:C1224($O_Objet; "vl_CT_Abs"; Est un entier long:K8:6)
vl_CT_DisJ:=OB Get:C1224($O_Objet; "vl_CT_DisJ"; Est un entier long:K8:6)
vl_CT_Rest:=OB Get:C1224($O_Objet; "vl_CT_Rest"; Est un entier long:K8:6)

rJourNuit1:=OB Get:C1224($O_Objet; "rJourNuit1"; Est un entier long:K8:6)
rJourNuit2:=OB Get:C1224($O_Objet; "rJourNuit2"; Est un entier long:K8:6)
vl_CT_Abs:=OB Get:C1224($O_Objet; "vl_CT_Abs"; Est un entier long:K8:6)
vl_CT_Capa:=OB Get:C1224($O_Objet; "vl_CT_Capa"; Est un entier long:K8:6)
vl_CT_CFem:=OB Get:C1224($O_Objet; "vl_CT_CFem"; Est un entier long:K8:6)
vl_CT_CHom:=OB Get:C1224($O_Objet; "vl_CT_CHom"; Est un entier long:K8:6)
vl_CT_Dis:=OB Get:C1224($O_Objet; "vl_CT_Dis"; Est un entier long:K8:6)
vl_CT_DisJ:=OB Get:C1224($O_Objet; "vl_CT_DisJ"; Est un entier long:K8:6)
vl_CT_DistA:=OB Get:C1224($O_Objet; "vl_CT_DistA"; Est un entier long:K8:6)
vl_CT_EFem:=OB Get:C1224($O_Objet; "vl_CT_EFem"; Est un entier long:K8:6)
vl_CT_EHom:=OB Get:C1224($O_Objet; "vl_CT_EHom"; Est un entier long:K8:6)
vl_CT_FFem:=OB Get:C1224($O_Objet; "vl_CT_FFem"; Est un entier long:K8:6)
vl_CT_FHom:=OB Get:C1224($O_Objet; "vl_CT_FHom"; Est un entier long:K8:6)
vl_CT_Lat:=OB Get:C1224($O_Objet; "vl_CT_Lat"; Est un entier long:K8:6)
vl_CT_MMin:=OB Get:C1224($O_Objet; "vl_CT_MMin"; Est un entier long:K8:6)
vl_CT_PMin:=OB Get:C1224($O_Objet; "vl_CT_PMin"; Est un entier long:K8:6)
vl_CT_Rest:=OB Get:C1224($O_Objet; "vl_CT_Rest"; Est un entier long:K8:6)
vl_CT_SFem:=OB Get:C1224($O_Objet; "vl_CT_SFem"; Est un entier long:K8:6)
vl_CT_SGas:=OB Get:C1224($O_Objet; "vl_CT_SGas"; Est un entier long:K8:6)
vl_CT_SGmd:=OB Get:C1224($O_Objet; "vl_CT_SGmd"; Est un entier long:K8:6)
vl_CT_SGrép:=OB Get:C1224($O_Objet; "vl_CT_SGrép"; Est un entier long:K8:6)
vl_CT_SHom:=OB Get:C1224($O_Objet; "vl_CT_SHom"; Est un entier long:K8:6)
vl_CT_Total:=OB Get:C1224($O_Objet; "vl_CT_Total"; Est un entier long:K8:6)

OB GET ARRAY:C1229($O_Objet; "t_CT_Abs"; t_CT_Abs)
OB GET ARRAY:C1229($O_Objet; "t_CT_CFem"; t_CT_CFem)
OB GET ARRAY:C1229($O_Objet; "t_CT_CHom"; t_CT_CHom)
OB GET ARRAY:C1229($O_Objet; "t_CT_Dis"; t_CT_Dis)
OB GET ARRAY:C1229($O_Objet; "t_CT_DisJ"; t_CT_DisJ)
OB GET ARRAY:C1229($O_Objet; "t_CT_DistA"; t_CT_DistA)
OB GET ARRAY:C1229($O_Objet; "t_CT_EFem"; t_CT_EFem)
OB GET ARRAY:C1229($O_Objet; "t_CT_EHom"; t_CT_EHom)
OB GET ARRAY:C1229($O_Objet; "t_CT_FFem"; t_CT_FFem)
OB GET ARRAY:C1229($O_Objet; "t_CT_FHom"; t_CT_FHom)
OB GET ARRAY:C1229($O_Objet; "t_CT_ID"; t_CT_ID)
OB GET ARRAY:C1229($O_Objet; "t_CT_Lat"; t_CT_Lat)
OB GET ARRAY:C1229($O_Objet; "t_CT_MMin"; t_CT_MMin)
OB GET ARRAY:C1229($O_Objet; "t_CT_PMin"; t_CT_PMin)
OB GET ARRAY:C1229($O_Objet; "t_CT_Rest"; t_CT_Rest)
OB GET ARRAY:C1229($O_Objet; "t_CT_SFem"; t_CT_SFem)
OB GET ARRAY:C1229($O_Objet; "t_CT_SGas"; t_CT_SGas)
OB GET ARRAY:C1229($O_Objet; "t_CT_SGmd"; t_CT_SGmd)
OB GET ARRAY:C1229($O_Objet; "t_CT_SGrép"; t_CT_SGrép)
OB GET ARRAY:C1229($O_Objet; "t_CT_SHom"; t_CT_SHom)
OB GET ARRAY:C1229($O_Objet; "t_CT_Total"; t_CT_Total)
OB GET ARRAY:C1229($O_Objet; "ta_Centre"; ta_Centre)
OB GET ARRAY:C1229($O_Objet; "te_Centre"; te_Centre)

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

$vl_TailTab:=Size of array:C274(ta_Centre)
If ($vl_TailTab>0)
	
	USE SET:C118("E_HGStatClôt")
	If (Records in selection:C76([HeberGement:5])>0)
		
		
		
		ARRAY LONGINT:C221($rL_HG_LC_ID; 0)
		ARRAY TEXT:C222($rT_HG_EtatCivil; 0)
		ARRAY BOOLEAN:C223($rB_HG_Cloturée; 0)
		ARRAY TEXT:C222($rT_HG_Signalement; 0)
		
		SELECTION TO ARRAY:C260([HeberGement:5]HG_LC_ID:61; $rL_HG_LC_ID; *)
		SELECTION TO ARRAY:C260([HeberGement:5]HG_EtatCivil:20; $rT_HG_EtatCivil; *)
		SELECTION TO ARRAY:C260([HeberGement:5]HG_Cloturée:67; $rB_HG_Cloturée; *)
		SELECTION TO ARRAY:C260([HeberGement:5]HG_Signalement:12; $rT_HG_Signalement)
		
		$ii:=0
		Repeat 
			$ii:=$ii+1
			
			$Pos:=Find in array:C230(t_CT_ID; $rL_HG_LC_ID{$ii})
			If ($Pos>0)
				
				$va_Critere:=""
				
				$vl_Position1:=Position:C15("("; $rT_HG_EtatCivil{$ii})
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
				
				
				If ($rB_HG_Cloturée{$ii})
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
			
		Until ($ii=Records in selection:C76([HeberGement:5]))
		
	End if 
	
	USE SET:C118("E_CLCourant")
	If (Records in selection:C76([CentresLits:16])>0)
		
		ARRAY LONGINT:C221($rL_CL_LC_ID; 0)
		ARRAY INTEGER:C220($rI_CL_Restant; 0)
		ARRAY INTEGER:C220($rI_CL_Absents; 0)
		ARRAY INTEGER:C220($rI_CL_DispoDuJour; 0)
		
		SELECTION TO ARRAY:C260([CentresLits:16]CL_LC_ID:2; $rL_CL_LC_ID; *)
		SELECTION TO ARRAY:C260([CentresLits:16]CL_Restant:7; $rI_CL_Restant; *)
		SELECTION TO ARRAY:C260([CentresLits:16]CL_Absents:13; $rI_CL_Absents; *)
		SELECTION TO ARRAY:C260([CentresLits:16]CL_DispoDuJour:12; $rI_CL_DispoDuJour)
		
		$ii:=0
		Repeat 
			$ii:=$ii+1
			
			$Pos:=Find in array:C230(t_CT_ID; $rL_CL_LC_ID{$ii})
			If ($Pos>0)
				If (te_Centre{$Pos}=1)
					
					If (rJourNuit1=1) & (rJourNuit2=1)
						t_CT_Rest{$Pos}:=t_CT_Rest{$Pos}+$rI_CL_Restant{$ii}-$rI_CL_Absents{$ii}
						vl_CT_Rest:=vl_CT_Rest+$rI_CL_Restant{$ii}-$rI_CL_Absents{$ii}
					Else 
						t_CT_Rest{$Pos}:=t_CT_Rest{$Pos}+$rI_CL_Restant{$ii}
						vl_CT_Rest:=vl_CT_Rest+$rI_CL_Restant{$ii}
					End if 
					
					t_CT_DisJ{$Pos}:=t_CT_DisJ{$Pos}+$rI_CL_DispoDuJour{$ii}
					vl_CT_DisJ:=vl_CT_DisJ+$rI_CL_DispoDuJour{$ii}
					t_CT_Abs{$Pos}:=t_CT_Abs{$Pos}+$rI_CL_Absents{$ii}
					vl_CT_Abs:=vl_CT_Abs+$rI_CL_Absents{$ii}
				End if 
			End if 
			
		Until ($ii=Records in selection:C76([CentresLits:16]))
	End if 
	
	
	For ($ii; 1; $vl_TailTab)
		If (te_Centre{$ii}=1)
		Else 
			
			t_CT_SHom{$ii}:=0
			t_CT_CHom{$ii}:=0
			t_CT_EHom{$ii}:=0
			t_CT_FHom{$ii}:=0
			
			t_CT_SFem{$ii}:=0
			t_CT_CFem{$ii}:=0
			t_CT_EFem{$ii}:=0
			t_CT_FFem{$ii}:=0
			
			t_CT_PMin{$ii}:=0
			t_CT_MMin{$ii}:=0
			
			t_CT_Total{$ii}:=0
			
			//Changement de calcul
			t_CT_Dis{$ii}:=0
			t_CT_Rest{$ii}:=0
			
			t_CT_SGrép{$ii}:=0
			t_CT_SGas{$ii}:=0
			t_CT_SGmd{$ii}:=0
			t_CT_DistA{$ii}:=0
			
			t_CT_Lat{$ii}:=0
		End if 
	End for 
	
	
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
	
	vl_lit_Dist:=vl_CT_Total
	vl_lit_Rest:=vl_CT_Rest
	vl_lit_At:=vl_CT_Total+vl_CT_Rest
	If (vl_lit_At>0)
		vr_lit_Pc:=(vl_lit_Dist/vl_lit_At)*100
	Else 
		vr_lit_Pc:=0
	End if 
	
End if 


OB SET:C1220($O_Objet; "vl_CT_Abs"; vl_CT_Abs)
OB SET:C1220($O_Objet; "vl_CT_DisJ"; vl_CT_DisJ)
OB SET:C1220($O_Objet; "vl_CT_Rest"; vl_CT_Rest)

OB SET:C1220($O_Objet; "rJourNuit1"; rJourNuit1)
OB SET:C1220($O_Objet; "rJourNuit2"; rJourNuit2)
OB SET:C1220($O_Objet; "vl_CT_Abs"; vl_CT_Abs)
OB SET:C1220($O_Objet; "vl_CT_Capa"; vl_CT_Capa)
OB SET:C1220($O_Objet; "vl_CT_CFem"; vl_CT_CFem)
OB SET:C1220($O_Objet; "vl_CT_CHom"; vl_CT_CHom)
OB SET:C1220($O_Objet; "vl_CT_Dis"; vl_CT_Dis)
OB SET:C1220($O_Objet; "vl_CT_DisJ"; vl_CT_DisJ)
OB SET:C1220($O_Objet; "vl_CT_DistA"; vl_CT_DistA)
OB SET:C1220($O_Objet; "vl_CT_EFem"; vl_CT_EFem)
OB SET:C1220($O_Objet; "vl_CT_EHom"; vl_CT_EHom)
OB SET:C1220($O_Objet; "vl_CT_FFem"; vl_CT_FFem)
OB SET:C1220($O_Objet; "vl_CT_FHom"; vl_CT_FHom)
OB SET:C1220($O_Objet; "vl_CT_Lat"; vl_CT_Lat)
OB SET:C1220($O_Objet; "vl_CT_MMin"; vl_CT_MMin)
OB SET:C1220($O_Objet; "vl_CT_PMin"; vl_CT_PMin)
OB SET:C1220($O_Objet; "vl_CT_Rest"; vl_CT_Rest)
OB SET:C1220($O_Objet; "vl_CT_SFem"; vl_CT_SFem)
OB SET:C1220($O_Objet; "vl_CT_SGas"; vl_CT_SGas)
OB SET:C1220($O_Objet; "vl_CT_SGmd"; vl_CT_SGmd)
OB SET:C1220($O_Objet; "vl_CT_SGrép"; vl_CT_SGrép)
OB SET:C1220($O_Objet; "vl_CT_SHom"; vl_CT_SHom)
OB SET:C1220($O_Objet; "vl_CT_Total"; vl_CT_Total)

OB SET ARRAY:C1227($O_Objet; "t_CT_Abs"; t_CT_Abs)
OB SET ARRAY:C1227($O_Objet; "t_CT_CFem"; t_CT_CFem)
OB SET ARRAY:C1227($O_Objet; "t_CT_CHom"; t_CT_CHom)
OB SET ARRAY:C1227($O_Objet; "t_CT_Dis"; t_CT_Dis)
OB SET ARRAY:C1227($O_Objet; "t_CT_DisJ"; t_CT_DisJ)
OB SET ARRAY:C1227($O_Objet; "t_CT_DistA"; t_CT_DistA)
OB SET ARRAY:C1227($O_Objet; "t_CT_EFem"; t_CT_EFem)
OB SET ARRAY:C1227($O_Objet; "t_CT_EHom"; t_CT_EHom)
OB SET ARRAY:C1227($O_Objet; "t_CT_FFem"; t_CT_FFem)
OB SET ARRAY:C1227($O_Objet; "t_CT_FHom"; t_CT_FHom)
OB SET ARRAY:C1227($O_Objet; "t_CT_ID"; t_CT_ID)
OB SET ARRAY:C1227($O_Objet; "t_CT_Lat"; t_CT_Lat)
OB SET ARRAY:C1227($O_Objet; "t_CT_MMin"; t_CT_MMin)
OB SET ARRAY:C1227($O_Objet; "t_CT_PMin"; t_CT_PMin)
OB SET ARRAY:C1227($O_Objet; "t_CT_Rest"; t_CT_Rest)
OB SET ARRAY:C1227($O_Objet; "t_CT_SFem"; t_CT_SFem)
OB SET ARRAY:C1227($O_Objet; "t_CT_SGas"; t_CT_SGas)
OB SET ARRAY:C1227($O_Objet; "t_CT_SGmd"; t_CT_SGmd)
OB SET ARRAY:C1227($O_Objet; "t_CT_SGrép"; t_CT_SGrép)
OB SET ARRAY:C1227($O_Objet; "t_CT_SHom"; t_CT_SHom)
OB SET ARRAY:C1227($O_Objet; "t_CT_Total"; t_CT_Total)
OB SET ARRAY:C1227($O_Objet; "ta_Centre"; ta_Centre)
OB SET ARRAY:C1227($O_Objet; "te_Centre"; te_Centre)

$P_Objet->:=OB Copy:C1225($O_Objet)
