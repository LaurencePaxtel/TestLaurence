//%attributes = {"executedOnServer":true,"preemptive":"incapable"}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CalcStat_NbEtCvSg
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_POINTER:C301($1; $P_Objet)
$P_Objet:=$1
C_OBJECT:C1216($O_Objet)
$O_Objet:=OB Copy:C1225($P_Objet->)

ARRAY REAL:C219(t_ET_DemPc; 0)
ARRAY REAL:C219(t_ET_DisPc; 0)
ARRAY REAL:C219(t_ET_MedPc; 0)
ARRAY REAL:C219(t_SG_DemPc; 0)
ARRAY REAL:C219(t_OR1_Pc; 0)
ARRAY REAL:C219(t_OR2_Pc; 0)
ARRAY REAL:C219(t_AtS_Pc; 0)
ARRAY LONGINT:C221(t_ET_Dem; 0)
ARRAY LONGINT:C221(t_ET_Dis; 0)
ARRAY LONGINT:C221(t_ET_Med; 0)
ARRAY LONGINT:C221(t_SG_Dem; 0)
ARRAY LONGINT:C221(t_OR1_Total; 0)
ARRAY LONGINT:C221(t_OR2_Total; 0)
ARRAY LONGINT:C221(t_AtS_Total; 0)
ARRAY LONGINT:C221(t_TBMarTot; 0)


OB GET ARRAY:C1229($O_Objet; "t_ET_DemPc"; t_ET_DemPc)
OB GET ARRAY:C1229($O_Objet; "t_ET_DisPc"; t_ET_DisPc)
OB GET ARRAY:C1229($O_Objet; "t_ET_MedPc"; t_ET_MedPc)
vr_ET_DemPc:=OB Get:C1224($O_Objet; "vr_ET_DemPc"; Est un numérique:K8:4)
vr_ET_DisPc:=OB Get:C1224($O_Objet; "vr_ET_DisPc"; Est un numérique:K8:4)
vr_ET_MedPc:=OB Get:C1224($O_Objet; "vr_ET_MedPc"; Est un numérique:K8:4)
// 2
OB GET ARRAY:C1229($O_Objet; "t_SG_DemPc"; t_SG_DemPc)
vr_SG_DemPc:=OB Get:C1224($O_Objet; "vr_SG_DemPc"; Est un numérique:K8:4)
// 3
OB GET ARRAY:C1229($O_Objet; "t_OR1_Pc"; t_OR1_Pc)
vr_OR1_Pc:=OB Get:C1224($O_Objet; "vr_OR1_Pc"; Est un numérique:K8:4)
// 4
OB GET ARRAY:C1229($O_Objet; "t_OR2_Pc"; t_OR2_Pc)
vr_OR2_Pc:=OB Get:C1224($O_Objet; "vr_OR2_Pc"; Est un numérique:K8:4)
// 5
OB GET ARRAY:C1229($O_Objet; "t_AtS_Pc"; t_AtS_Pc)
vr_AtS_Pc:=OB Get:C1224($O_Objet; "vr_AtS_Pc"; Est un numérique:K8:4)

// tableau 1
OB GET ARRAY:C1229($O_Objet; "<>ta_TBEtCiv"; <>ta_TBEtCiv)
OB GET ARRAY:C1229($O_Objet; "t_ET_Dem"; t_ET_Dem)
OB GET ARRAY:C1229($O_Objet; "t_ET_Dis"; t_ET_Dis)
OB GET ARRAY:C1229($O_Objet; "t_ET_Med"; t_ET_Med)
vl_ET_Dem:=OB Get:C1224($O_Objet; "vl_ET_Dem"; Est un entier long:K8:6)
vl_ET_Dis:=OB Get:C1224($O_Objet; "vl_ET_Dis"; Est un entier long:K8:6)
vl_ET_Med:=OB Get:C1224($O_Objet; "vl_ET_Med"; Est un entier long:K8:6)
// tableau 2
OB GET ARRAY:C1229($O_Objet; "<>ta_TBSglt"; <>ta_TBSglt)
OB GET ARRAY:C1229($O_Objet; "t_SG_Dem"; t_SG_Dem)
vl_SG_Dem:=OB Get:C1224($O_Objet; "vl_SG_Dem"; Est un entier long:K8:6)
// tableau 3
OB GET ARRAY:C1229($O_Objet; "<>ta_TBOr1"; <>ta_TBOr1)
OB GET ARRAY:C1229($O_Objet; "t_OR1_Total"; t_OR1_Total)
vl_OR1_Tot:=OB Get:C1224($O_Objet; "vl_OR1_Tot"; Est un entier long:K8:6)
// tableau 4
OB GET ARRAY:C1229($O_Objet; "<>ta_TBOr2"; <>ta_TBOr2)
OB GET ARRAY:C1229($O_Objet; "t_OR2_Total"; t_OR2_Total)
vl_OR2_Tot:=OB Get:C1224($O_Objet; "vl_OR2_Tot"; Est un entier long:K8:6)
// tableau 5
OB GET ARRAY:C1229($O_Objet; "<>ta_AtS"; <>ta_AtS)
OB GET ARRAY:C1229($O_Objet; "t_AtS_Total"; t_AtS_Total)
vl_AtS_Tot:=OB Get:C1224($O_Objet; "vl_AtS_Tot"; Est un entier long:K8:6)
// tableau 6
OB GET ARRAY:C1229($O_Objet; "<>ta_TBMaraud"; <>ta_TBMaraud)
OB GET ARRAY:C1229($O_Objet; "t_TBMarTot"; t_TBMarTot)
vl_Mar_Tot:=OB Get:C1224($O_Objet; "vl_Mar_Tot"; Est un entier long:K8:6)

//----------------------------------------------

vl_ET_Dem:=0
vr_ET_DemPc:=0
vl_ET_Dis:=0
C_LONGINT:C283($vl_TailTab1; $ii)
C_LONGINT:C283($vl_TailTab2)
C_LONGINT:C283($vl_TailTab3)
C_LONGINT:C283($vl_TailTab4)
C_LONGINT:C283($vl_TailTab5)
C_LONGINT:C283($vl_TailTab6)

vr_ET_DisPc:=0
vl_ET_Med:=0
vr_ET_MedPc:=0
$vl_TailTab1:=Size of array:C274(<>ta_TBEtCiv)

//Signalement
vl_SG_Dem:=0
vr_SG_DemPc:=0
$vl_TailTab2:=Size of array:C274(<>ta_TBSglt)

//Orientation 1
vl_OR1_Hom:=0
vl_OR1_Fem:=0
vl_OR1_Tot:=0
vr_OR1_Pc:=0
$vl_TailTab3:=Size of array:C274(<>ta_TBOr1)

//Orientation 2 Ou Localisation
vl_OR2_Hom:=0
vl_OR2_Fem:=0
vl_OR2_Tot:=0
vr_OR2_Pc:=0
$vl_TailTab4:=Size of array:C274(<>ta_TBOr2)

//Autres solutions
vl_AtS_Hom:=0
vl_AtS_Fem:=0
vl_AtS_Tot:=0
vr_AtS_Pc:=0
$vl_TailTab5:=Size of array:C274(<>ta_AtS)

//Maraudes Véhicule
vl_Mar_Hom:=0
vl_Mar_Fem:=0
vl_Mar_Tot:=0
vr_Mar_Pc:=0
$vl_TailTab6:=Size of array:C274(<>ta_TBMaraud)



C_TEXT:C284($T_File)
$T_File:="debug_"+Current method name:C684+"_.txt"
C_BOOLEAN:C305($B_Log)
$B_Log:=False:C215
Log_mensuel($B_Log; "----------------- Demarrage de "+Current method name:C684; $T_File)




USE SET:C118("E_HGStat")
If (Records in selection:C76([HeberGement:5])>0)
	FIRST RECORD:C50([HeberGement:5])
	
	ARRAY TEXT:C222($rT_HG_EtatCivil; 0)
	ARRAY BOOLEAN:C223($rB_HG_Cloturee; 0)
	ARRAY BOOLEAN:C223($rB_HG_Médicalise; 0)
	ARRAY TEXT:C222($rT_HG_Signalement; 0)
	ARRAY TEXT:C222($rT_HG_Orientation1; 0)
	ARRAY TEXT:C222($rT_HG_Orientation2; 0)
	ARRAY TEXT:C222($rT_HG_AutreSolutio; 0)
	ARRAY TEXT:C222($rT_HG_Maraude1_1; 0)
	
	SELECTION TO ARRAY:C260([HeberGement:5]HG_EtatCivil:20; $rT_HG_EtatCivil; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_Cloturée:67; $rB_HG_Cloturee; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_Médicalisé:56; $rB_HG_Médicalise; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_Signalement:12; $rT_HG_Signalement; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_Orientation1:58; $rT_HG_Orientation1; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_Orientation2:60; $rT_HG_Orientation2; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_AutreSolutio:88; $rT_HG_AutreSolutio; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_Maraude1_1:10; $rT_HG_Maraude1_1)
	
	// etape 1
	C_LONGINT:C283($L_Milli)
	$L_Milli:=Milliseconds:C459
	
	C_LONGINT:C283($pos)
	For ($ii; 1; Records in selection:C76([HeberGement:5]))
		
		If ($vl_TailTab1>0)
			
			$pos:=Find in array:C230(<>ta_TBEtCiv; $rT_HG_EtatCivil{$ii})
			If ($Pos>0)
				t_ET_Dem{$pos}:=t_ET_Dem{$pos}+1
				vl_ET_Dem:=vl_ET_Dem+1
				If ($rB_HG_Cloturee{$ii})
					t_ET_Dis{$pos}:=t_ET_Dis{$pos}+1
					vl_ET_Dis:=vl_ET_Dis+1
					If ($rB_HG_Médicalise{$ii})
						t_ET_Med{$pos}:=t_ET_Med{$pos}+1
						vl_ET_Med:=vl_ET_Med+1
					End if 
				End if 
			End if 
		End if 
		
		If ($vl_TailTab2>0)
			$pos:=Find in array:C230(<>ta_TBSglt; $rT_HG_Signalement{$ii})
			If ($Pos>0)
				t_SG_Dem{$pos}:=t_SG_Dem{$pos}+1
				vl_SG_Dem:=vl_SG_Dem+1
			End if 
		End if 
		If ($vl_TailTab3>0)
			$Pos:=Find in array:C230(<>ta_TBOr1; $rT_HG_Orientation1{$ii})
			If ($Pos>0)
				t_OR1_Total{$Pos}:=t_OR1_Total{$Pos}+1
				vl_OR1_Tot:=vl_OR1_Tot+1
			End if 
		End if 
		If ($vl_TailTab4>0)
			$Pos:=Find in array:C230(<>ta_TBOr2; $rT_HG_Orientation2{$ii})
			If ($Pos>0)
				t_OR2_Total{$Pos}:=t_OR2_Total{$Pos}+1
				vl_OR2_Tot:=vl_OR2_Tot+1
			End if 
		End if 
		If ($vl_TailTab5>0)
			$Pos:=Find in array:C230(<>ta_AtS; $rT_HG_AutreSolutio{$ii})
			If ($Pos>0)
				t_AtS_Total{$Pos}:=t_AtS_Total{$Pos}+1
				vl_AtS_Tot:=vl_AtS_Tot+1
			End if 
		End if 
		If ($vl_TailTab6>0)
			$Pos:=Find in array:C230(<>ta_TBMaraud; $rT_HG_Maraude1_1{$ii})
			If ($Pos>0)
				t_TBMarTot{$Pos}:=t_TBMarTot{$Pos}+1
				vl_Mar_Tot:=vl_Mar_Tot+1
			End if 
		End if 
		
	End for 
	
	C_REAL:C285($R_Time)
	$R_Time:=Milliseconds:C459-$L_Milli
	Log_mensuel($B_Log; "Etape 1 "+String:C10($R_Time); $T_File)
	
	
	// etape 2
	C_LONGINT:C283($L_Milli)
	$L_Milli:=Milliseconds:C459
	
	For ($ii; 1; $vl_TailTab1)
		
		If (vl_ET_Dem>0)
			t_ET_DemPc{$ii}:=(t_ET_Dem{$ii}/vl_ET_Dem)*100
		Else 
			t_ET_DemPc{$ii}:=0
		End if 
		
		If (vl_ET_Dem>0)
			t_ET_DisPc{$ii}:=(t_ET_Dis{$ii}/vl_ET_Dem)*100
		Else 
			t_ET_DisPc{$ii}:=0
		End if 
		
		If (vl_ET_Dis>0)
			t_ET_MedPc{$ii}:=(t_ET_Med{$ii}/vl_ET_Dis)*100
		Else 
			t_ET_MedPc{$ii}:=0
		End if 
		
		vr_ET_DemPc:=vr_ET_DemPc+t_ET_DemPc{$ii}
		vr_ET_DisPc:=vr_ET_DisPc+t_ET_DisPc{$ii}
		vr_ET_MedPc:=vr_ET_MedPc+t_ET_MedPc{$ii}
		
	End for 
	C_REAL:C285($R_Time)
	$R_Time:=Milliseconds:C459-$L_Milli
	Log_mensuel($B_Log; "Etape 2 "+String:C10($R_Time); $T_File)
	
	
	// etape 3
	C_LONGINT:C283($L_Milli)
	$L_Milli:=Milliseconds:C459
	
	For ($ii; 1; $vl_TailTab2)
		
		If (vl_SG_Dem>0)
			t_SG_DemPc{$ii}:=(t_SG_Dem{$ii}/vl_SG_Dem)*100
		Else 
			t_SG_DemPc{$ii}:=0
		End if 
		vr_SG_DemPc:=vr_SG_DemPc+t_SG_DemPc{$ii}
	End for 
	C_REAL:C285($R_Time)
	$R_Time:=Milliseconds:C459-$L_Milli
	Log_mensuel($B_Log; "Etape 3 "+String:C10($R_Time); $T_File)
	
	
	// etape 4
	C_LONGINT:C283($L_Milli)
	$L_Milli:=Milliseconds:C459
	
	For ($ii; 1; $vl_TailTab3)
		
		If (vl_ET_Dis>0)
			t_OR1_Pc{$ii}:=(t_OR1_Total{$ii}/vl_ET_Dis)*100
		Else 
			t_OR1_Pc{$ii}:=0
		End if 
		vr_OR1_Pc:=vr_OR1_Pc+t_OR1_Pc{$ii}
	End for 
	C_REAL:C285($R_Time)
	$R_Time:=Milliseconds:C459-$L_Milli
	Log_mensuel($B_Log; "Etape 4 "+String:C10($R_Time); $T_File)
	
	
	// etape 5
	C_LONGINT:C283($L_Milli)
	$L_Milli:=Milliseconds:C459
	
	For ($ii; 1; $vl_TailTab4)
		
		If (vl_ET_Dis>0)
			t_OR2_Pc{$ii}:=(t_OR2_Total{$ii}/vl_ET_Dis)*100
		Else 
			t_OR2_Pc{$ii}:=0
		End if 
		vr_OR2_Pc:=vr_OR2_Pc+t_OR2_Pc{$ii}
	End for 
	C_REAL:C285($R_Time)
	$R_Time:=Milliseconds:C459-$L_Milli
	Log_mensuel($B_Log; "Etape 5 "+String:C10($R_Time); $T_File)
	
	
	// etape 6
	C_LONGINT:C283($L_Milli)
	$L_Milli:=Milliseconds:C459
	
	For ($ii; 1; $vl_TailTab5)
		
		If (vl_ET_Dis>0)
			t_AtS_Pc{$ii}:=(t_AtS_Total{$ii}/vl_ET_Dis)*100
		Else 
			t_AtS_Pc{$ii}:=0
		End if 
		vr_AtS_Pc:=vr_AtS_Pc+t_AtS_Pc{$ii}
	End for 
	C_REAL:C285($R_Time)
	$R_Time:=Milliseconds:C459-$L_Milli
	Log_mensuel($B_Log; "Etape 6 "+String:C10($R_Time); $T_File)
	
	
End if 



//---------------------------------------------------------------------------

// 1
OB SET ARRAY:C1227($O_Objet; "t_ET_DemPc"; t_ET_DemPc)
OB SET ARRAY:C1227($O_Objet; "t_ET_DisPc"; t_ET_DisPc)
OB SET ARRAY:C1227($O_Objet; "t_ET_MedPc"; t_ET_MedPc)
OB SET:C1220($O_Objet; "vr_ET_DemPc"; vr_ET_DemPc)
OB SET:C1220($O_Objet; "vr_ET_DisPc"; vr_ET_DisPc)
OB SET:C1220($O_Objet; "vr_ET_MedPc"; vr_ET_MedPc)
// 2
OB SET ARRAY:C1227($O_Objet; "t_SG_DemPc"; t_SG_DemPc)
OB SET:C1220($O_Objet; "vr_SG_DemPc"; vr_SG_DemPc)
// 3
OB SET ARRAY:C1227($O_Objet; "t_OR1_Pc"; t_OR1_Pc)
OB SET:C1220($O_Objet; "vr_OR1_Pc"; vr_OR1_Pc)
// 4
OB SET ARRAY:C1227($O_Objet; "t_OR2_Pc"; t_OR2_Pc)
OB SET:C1220($O_Objet; "vr_OR2_Pc"; vr_OR2_Pc)
// 5
OB SET ARRAY:C1227($O_Objet; "t_AtS_Pc"; t_AtS_Pc)
OB SET:C1220($O_Objet; "vr_AtS_Pc"; vr_AtS_Pc)

// tableau 1
OB SET ARRAY:C1227($O_Objet; "<>ta_TBEtCiv"; <>ta_TBEtCiv)
OB SET ARRAY:C1227($O_Objet; "t_ET_Dem"; t_ET_Dem)
OB SET ARRAY:C1227($O_Objet; "t_ET_Dis"; t_ET_Dis)
OB SET ARRAY:C1227($O_Objet; "t_ET_Med"; t_ET_Med)
OB SET:C1220($O_Objet; "vl_ET_Dem"; vl_ET_Dem)
OB SET:C1220($O_Objet; "vl_ET_Dis"; vl_ET_Dis)
OB SET:C1220($O_Objet; "vl_ET_Med"; vl_ET_Med)
// tableau 2
OB SET ARRAY:C1227($O_Objet; "<>ta_TBSglt"; <>ta_TBSglt)
OB SET ARRAY:C1227($O_Objet; "t_SG_Dem"; t_SG_Dem)
OB SET:C1220($O_Objet; "vl_SG_Dem"; vl_SG_Dem)
// tableau 3
OB SET ARRAY:C1227($O_Objet; "<>ta_TBOr1"; <>ta_TBOr1)
OB SET ARRAY:C1227($O_Objet; "t_OR1_Total"; t_OR1_Total)
OB SET:C1220($O_Objet; "vl_OR1_Tot"; vl_OR1_Tot)
// tableau 4
OB SET ARRAY:C1227($O_Objet; "<>ta_TBOr2"; <>ta_TBOr2)
OB SET ARRAY:C1227($O_Objet; "t_OR2_Total"; t_OR2_Total)
OB SET:C1220($O_Objet; "vl_OR2_Tot"; vl_OR2_Tot)
// tableau 5
OB SET ARRAY:C1227($O_Objet; "<>ta_AtS"; <>ta_AtS)
OB SET ARRAY:C1227($O_Objet; "t_AtS_Total"; t_AtS_Total)
OB SET:C1220($O_Objet; "vl_AtS_Tot"; vl_AtS_Tot)
// tableau 6
OB SET ARRAY:C1227($O_Objet; "<>ta_TBMaraud"; <>ta_TBMaraud)
OB SET ARRAY:C1227($O_Objet; "t_TBMarTot"; t_TBMarTot)
OB SET:C1220($O_Objet; "vl_Mar_Tot"; vl_Mar_Tot)

$P_Objet->:=OB Copy:C1225($O_Objet)

