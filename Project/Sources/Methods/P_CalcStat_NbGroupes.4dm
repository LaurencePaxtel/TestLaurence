//%attributes = {"executedOnServer":true,"preemptive":"incapable"}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CalcStat_NbGroupes
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_POINTER:C301($1; $P_Objet)
$P_Objet:=$1
C_OBJECT:C1216($O_Objet)
$O_Objet:=OB Copy:C1225($P_Objet->)

ARRAY TEXT:C222(ta_xGroupe; 0)
ARRAY LONGINT:C221(tl_xGroupe; 0)
ARRAY REAL:C219(tr_FMComp; 0)
ARRAY REAL:C219(tr_FMDis1; 0)
ARRAY LONGINT:C221(tr_FMDis2; 0)
ARRAY LONGINT:C221(tr_FMDis3; 0)
ARRAY LONGINT:C221(tr_FMDis4; 0)
ARRAY LONGINT:C221(tr_FMDis5; 0)
ARRAY LONGINT:C221(tl_FMDis1; 0)
ARRAY LONGINT:C221(tl_FMDis2; 0)
ARRAY LONGINT:C221(tl_FMDis3; 0)
ARRAY LONGINT:C221(tl_FMDis4; 0)
ARRAY LONGINT:C221(tl_FMDis5; 0)

ARRAY LONGINT:C221(tl_FMCaS; 0)
ARRAY LONGINT:C221(tl_FMComp; 0)
ARRAY LONGINT:C221(tl_FMCompC; 0)
ARRAY LONGINT:C221(tl_FMCompNC; 0)

OB GET ARRAY:C1229($O_Objet; "<>ta_FMCaS"; <>ta_FMCaS)
OB GET ARRAY:C1229($O_Objet; "<>ta_FMDis1"; <>ta_FMDis1)
OB GET ARRAY:C1229($O_Objet; "<>ta_FMDis2"; <>ta_FMDis2)
OB GET ARRAY:C1229($O_Objet; "<>ta_FMDis3"; <>ta_FMDis3)
OB GET ARRAY:C1229($O_Objet; "<>ta_FMDis4"; <>ta_FMDis4)
OB GET ARRAY:C1229($O_Objet; "<>ta_FMDis5"; <>ta_FMDis5)
//OB GET ARRAY($O_Objet;"ta_FAMCpo";ta_FAMCpo)
//OB GET ARRAY($O_Objet;"ta_xFMCaS";ta_xFMCaS)
//OB GET ARRAY($O_Objet;"ta_xFMComp";ta_xFMComp)
//OB GET ARRAY($O_Objet;"ta_xFMDis1";ta_xFMDis1)
//OB GET ARRAY($O_Objet;"ta_xFMDis2";ta_xFMDis2)
//OB GET ARRAY($O_Objet;"ta_xFMDis3";ta_xFMDis3)
//OB GET ARRAY($O_Objet;"ta_xFMDis4";ta_xFMDis4)
//OB GET ARRAY($O_Objet;"ta_xFMDis5";ta_xFMDis5)
//OB GET ARRAY($O_Objet;"ta_xFMGrp";ta_xFMGrp)
OB GET ARRAY:C1229($O_Objet; "ta_xGroupe"; ta_xGroupe)

OB GET ARRAY:C1229($O_Objet; "tl_FMCaS"; tl_FMCaS)
OB GET ARRAY:C1229($O_Objet; "tl_FMComp"; tl_FMComp)
OB GET ARRAY:C1229($O_Objet; "tl_FMCompC"; tl_FMCompC)
OB GET ARRAY:C1229($O_Objet; "tl_FMCompNC"; tl_FMCompNC)

OB GET ARRAY:C1229($O_Objet; "tl_FMDis1"; tl_FMDis1)
OB GET ARRAY:C1229($O_Objet; "tl_FMDis2"; tl_FMDis2)
OB GET ARRAY:C1229($O_Objet; "tl_FMDis3"; tl_FMDis3)
OB GET ARRAY:C1229($O_Objet; "tl_FMDis4"; tl_FMDis4)
OB GET ARRAY:C1229($O_Objet; "tl_FMDis5"; tl_FMDis5)
//OB GET ARRAY($O_Objet;"tl_xFMCaS";tl_xFMCaS)
//OB GET ARRAY($O_Objet;"tl_xFMComp";tl_xFMComp)
//OB GET ARRAY($O_Objet;"tl_xFMCompC";tl_xFMCompC)
//OB GET ARRAY($O_Objet;"tl_xFMCompNC";tl_xFMCompNC)
//OB GET ARRAY($O_Objet;"tl_xFMDis1";tl_xFMDis1)
//OB GET ARRAY($O_Objet;"tl_xFMDis2";tl_xFMDis2)
//OB GET ARRAY($O_Objet;"tl_xFMDis3";tl_xFMDis3)
//OB GET ARRAY($O_Objet;"tl_xFMDis4";tl_xFMDis4)
//OB GET ARRAY($O_Objet;"tl_xFMDis5";tl_xFMDis5)
//OB GET ARRAY($O_Objet;"tl_xFMGrp";tl_xFMGrp)
OB GET ARRAY:C1229($O_Objet; "tl_xGroupe"; tl_xGroupe)
OB GET ARRAY:C1229($O_Objet; "tr_FMComp"; tr_FMComp)
OB GET ARRAY:C1229($O_Objet; "tr_FMDis1"; tr_FMDis1)
OB GET ARRAY:C1229($O_Objet; "tr_FMDis2"; tr_FMDis2)
OB GET ARRAY:C1229($O_Objet; "tr_FMDis3"; tr_FMDis3)
OB GET ARRAY:C1229($O_Objet; "tr_FMDis4"; tr_FMDis4)
OB GET ARRAY:C1229($O_Objet; "tr_FMDis5"; tr_FMDis5)
//OB GET ARRAY($O_Objet;"tr_xFMComp";tr_xFMComp)
//OB GET ARRAY($O_Objet;"tr_xFMDis1";tr_xFMDis1)
//OB GET ARRAY($O_Objet;"tr_xFMDis2";tr_xFMDis2)
//OB GET ARRAY($O_Objet;"tr_xFMDis3";tr_xFMDis3)
//OB GET ARRAY($O_Objet;"tr_xFMDis4";tr_xFMDis4)
//OB GET ARRAY($O_Objet;"tr_xFMDis5";tr_xFMDis5)
vl_FMCaS:=OB Get:C1224($O_Objet; "vl_FMCaS"; Est un entier long:K8:6)
vl_FMComp:=OB Get:C1224($O_Objet; "vl_FMComp"; Est un entier long:K8:6)
vl_FMCompC:=OB Get:C1224($O_Objet; "vl_FMCompC"; Est un entier long:K8:6)
vl_FMCompNC:=OB Get:C1224($O_Objet; "vl_FMCompNC"; Est un entier long:K8:6)
vl_FMDis1:=OB Get:C1224($O_Objet; "vl_FMDis1"; Est un entier long:K8:6)
vl_FMDis2:=OB Get:C1224($O_Objet; "vl_FMDis2"; Est un entier long:K8:6)
vl_FMDis3:=OB Get:C1224($O_Objet; "vl_FMDis3"; Est un entier long:K8:6)
vl_FMDis4:=OB Get:C1224($O_Objet; "vl_FMDis4"; Est un entier long:K8:6)
vl_FMDis5:=OB Get:C1224($O_Objet; "vl_FMDis5"; Est un entier long:K8:6)
vl_xGroupe:=OB Get:C1224($O_Objet; "vl_xGroupe"; Est un entier long:K8:6)
vr_FMComp:=OB Get:C1224($O_Objet; "vr_FMComp"; Est un numérique:K8:4)
vr_FMDis1:=OB Get:C1224($O_Objet; "vr_FMDis1"; Est un numérique:K8:4)
vr_FMDis2:=OB Get:C1224($O_Objet; "vr_FMDis2"; Est un numérique:K8:4)
vr_FMDis3:=OB Get:C1224($O_Objet; "vr_FMDis3"; Est un numérique:K8:4)
vr_FMDis4:=OB Get:C1224($O_Objet; "vr_FMDis4"; Est un numérique:K8:4)
vr_FMDis5:=OB Get:C1224($O_Objet; "vr_FMDis5"; Est un numérique:K8:4)


C_LONGINT:C283($vl_TailTab1; $ii; $ij; $Pos)
C_LONGINT:C283($vl_TailTab2)
C_LONGINT:C283($vl_TailTab3)
C_LONGINT:C283($vl_TailTab4)
C_LONGINT:C283($vl_TailTab5)
C_LONGINT:C283($vl_TailTab6)
C_LONGINT:C283($vl_TailTab7)
C_LONGINT:C283($vl_TailTab8)

//les groupes
$vl_TailTab1:=Size of array:C274(<>ta_FMDis1)
For ($ii; 1; $vl_TailTab1)
	tl_FMDis1{$ii}:=0
	tr_FMDis1{$ii}:=0
End for 
$vl_TailTab2:=Size of array:C274(<>ta_FMDis2)
For ($ii; 1; $vl_TailTab2)
	tl_FMDis2{$ii}:=0
	tr_FMDis2{$ii}:=0
End for 
$vl_TailTab3:=Size of array:C274(<>ta_FMDis3)
For ($ii; 1; $vl_TailTab3)
	tl_FMDis3{$ii}:=0
	tr_FMDis3{$ii}:=0
End for 
$vl_TailTab4:=Size of array:C274(<>ta_FMDis4)
For ($ii; 1; $vl_TailTab4)
	tl_FMDis4{$ii}:=0
	tr_FMDis4{$ii}:=0
End for 
$vl_TailTab5:=Size of array:C274(<>ta_FMDis5)
For ($ii; 1; $vl_TailTab5)
	tl_FMDis5{$ii}:=0
	tr_FMDis5{$ii}:=0
End for 

$vl_TailTab6:=Size of array:C274(ta_xGroupe)
For ($ii; 1; $vl_TailTab6)
	tl_xGroupe{$ii}:=0
End for 

ARRAY TEXT:C222(ta_FAMCpo; 0)
USE SET:C118("E_HGStat")
DISTINCT VALUES:C339([HeberGement:5]HG_FamCompo:105; ta_FAMCpo)
SORT ARRAY:C229(ta_FAMCpo; >)
$vl_TailTab7:=0
If (Size of array:C274(ta_FAMCpo)>0)
	Repeat 
		$vl_TailTab7:=$vl_TailTab7+1
		If (ta_FAMCpo{$vl_TailTab7}="")
			DELETE FROM ARRAY:C228(ta_FAMCpo; $vl_TailTab7; 1)
			$vl_TailTab7:=-1
		End if 
	Until ($vl_TailTab7<0) | ($vl_TailTab7>=Size of array:C274(ta_FAMCpo))
End if 
$vl_TailTab7:=Size of array:C274(ta_FAMCpo)

ARRAY LONGINT:C221(tl_FMComp; $vl_TailTab7)
ARRAY LONGINT:C221(tl_FMCompNC; $vl_TailTab7)
ARRAY LONGINT:C221(tl_FMCompC; $vl_TailTab7)
ARRAY REAL:C219(tr_FMComp; $vl_TailTab7)
For ($ii; 1; $vl_TailTab7)
	tl_FMComp{$ii}:=0
	tl_FMCompNC{$ii}:=0
	tl_FMCompC{$ii}:=0
	tr_FMComp{$ii}:=0
End for 

$vl_TailTab8:=Size of array:C274(<>ta_FMCaS)
For ($ii; 1; $vl_TailTab8)
	tl_FMCaS{$ii}:=0
End for 

vl_xGroupe:=0
vl_FMDis1:=0
vl_FMDis2:=0
vl_FMDis3:=0
vl_FMDis4:=0
vl_FMDis5:=0

vr_FMDis1:=0
vr_FMDis2:=0
vr_FMDis3:=0
vr_FMDis4:=0
vr_FMDis5:=0

vl_FMCaS:=0
vl_FMComp:=0
vl_FMCompNC:=0
vl_FMCompC:=0
vr_FMComp:=0

ARRAY TEXT:C222(ta_xFMGrp; 0)
ARRAY TEXT:C222(ta_xFMComp; 0)
ARRAY TEXT:C222(ta_xFMCaS; 0)
ARRAY TEXT:C222(ta_xFMDis1; 0)
ARRAY TEXT:C222(ta_xFMDis2; 0)
ARRAY TEXT:C222(ta_xFMDis3; 0)
ARRAY TEXT:C222(ta_xFMDis4; 0)
ARRAY TEXT:C222(ta_xFMDis5; 0)

ARRAY LONGINT:C221(tl_xFMGrp; 0)
ARRAY LONGINT:C221(tl_xFMComp; 0)
ARRAY LONGINT:C221(tl_xFMCompC; 0)
ARRAY LONGINT:C221(tl_xFMCompNC; 0)
ARRAY REAL:C219(tr_xFMComp; 0)
ARRAY LONGINT:C221(tl_xFMCaS; 0)
ARRAY LONGINT:C221(tl_xFMDis1; 0)
ARRAY LONGINT:C221(tl_xFMDis2; 0)
ARRAY LONGINT:C221(tl_xFMDis3; 0)
ARRAY LONGINT:C221(tl_xFMDis4; 0)
ARRAY LONGINT:C221(tl_xFMDis5; 0)


ARRAY REAL:C219(tr_xFMDis1; 0)
ARRAY REAL:C219(tr_xFMDis2; 0)
ARRAY REAL:C219(tr_xFMDis3; 0)
ARRAY REAL:C219(tr_xFMDis4; 0)
ARRAY REAL:C219(tr_xFMDis5; 0)


USE SET:C118("E_HGStat")
If (Records in selection:C76([HeberGement:5])>0)
	// FIRST RECORD([HeberGement])
	
	ARRAY TEXT:C222($rT_HG_FamDistri1; 0)
	ARRAY REAL:C219($rR_HG_FamDistri1M; 0)
	ARRAY TEXT:C222($rT_HG_FamDistri2; 0)
	ARRAY REAL:C219($rR_HG_FamDistri2M; 0)
	ARRAY TEXT:C222($rT_HG_FamDistri3; 0)
	ARRAY REAL:C219($rR_HG_FamDistri3M; 0)
	ARRAY TEXT:C222($rT_HG_FamDistri4; 0)
	ARRAY REAL:C219($rR_HG_FamDistri4M; 0)
	ARRAY TEXT:C222($rT_HG_FamDistri5; 0)
	ARRAY REAL:C219($rR_HG_FamDistri5M; 0)
	ARRAY TEXT:C222($rT_HG_FamCasSpec; 0)
	ARRAY TEXT:C222($rT_HG_FamGroupe; 0)
	ARRAY TEXT:C222($rT_HG_FamCompo; 0)
	ARRAY BOOLEAN:C223($rB_HG_Cloturee; 0)
	ARRAY REAL:C219($rR_HG_FamPrixJour; 0)
	
	SELECTION TO ARRAY:C260([HeberGement:5]HG_FamDistri1:112; $rT_HG_FamDistri1; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_FamDistri1M:118; $rR_HG_FamDistri1M; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_FamDistri2:113; $rT_HG_FamDistri2; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_FamDistri2M:119; $rR_HG_FamDistri2M; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_FamDistri3:114; $rT_HG_FamDistri3; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_FamDistri3M:120; $rR_HG_FamDistri3M; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_FamDistri4:115; $rT_HG_FamDistri4; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_FamDistri4M:121; $rR_HG_FamDistri4M; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_FamDistri5:116; $rT_HG_FamDistri5; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_FamDistri5M:122; $rR_HG_FamDistri5M; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_FamCasSpéc:111; $rT_HG_FamCasSpec; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_FamGroupe:102; $rT_HG_FamGroupe; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_FamCompo:105; $rT_HG_FamCompo; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_Cloturée:67; $rB_HG_Cloturee; *)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_FamPrixJour:109; $rR_HG_FamPrixJour)
	
	C_LONGINT:C283($L_Compteur)
	$L_Compteur:=0
	Repeat 
		$L_Compteur:=$L_Compteur+1
		
		If ($vl_TailTab1>0)
			$Pos:=Find in array:C230(<>ta_FMDis1; $rT_HG_FamDistri1{$L_Compteur})
			If ($Pos>0)
				tl_FMDis1{$Pos}:=tl_FMDis1{$Pos}+1
				tr_FMDis1{$Pos}:=tr_FMDis1{$Pos}+$rR_HG_FamDistri1M{$L_Compteur}
			End if 
		End if 
		If ($vl_TailTab2>0)
			$Pos:=Find in array:C230(<>ta_FMDis2; $rT_HG_FamDistri2{$L_Compteur})
			If ($Pos>0)
				tl_FMDis2{$Pos}:=tl_FMDis2{$Pos}+1
				tr_FMDis2{$Pos}:=tr_FMDis2{$Pos}+$rR_HG_FamDistri2M{$L_Compteur}
			End if 
		End if 
		If ($vl_TailTab3>0)
			$Pos:=Find in array:C230(<>ta_FMDis3; $rT_HG_FamDistri3{$L_Compteur})
			If ($Pos>0)
				tl_FMDis3{$Pos}:=tl_FMDis3{$Pos}+1
				tr_FMDis3{$Pos}:=tr_FMDis3{$Pos}+$rR_HG_FamDistri3M{$L_Compteur}
			End if 
		End if 
		If ($vl_TailTab4>0)
			$Pos:=Find in array:C230(<>ta_FMDis4; $rT_HG_FamDistri4{$L_Compteur})
			If ($Pos>0)
				tl_FMDis4{$Pos}:=tl_FMDis4{$Pos}+1
				tr_FMDis4{$Pos}:=tr_FMDis4{$Pos}+$rR_HG_FamDistri4M{$L_Compteur}
			End if 
		End if 
		If ($vl_TailTab5>0)
			$Pos:=Find in array:C230(<>ta_FMDis5; $rT_HG_FamDistri5{$L_Compteur})
			If ($Pos>0)
				tl_FMDis5{$Pos}:=tl_FMDis5{$Pos}+1
				tr_FMDis5{$Pos}:=tr_FMDis5{$Pos}+$rR_HG_FamDistri5M{$L_Compteur}
			End if 
		End if 
		If ($vl_TailTab8>0)
			$Pos:=Find in array:C230(<>ta_FMCaS; $rT_HG_FamCasSpec{$L_Compteur})
			If ($Pos>0)
				tl_FMCaS{$Pos}:=tl_FMCaS{$Pos}+1
			End if 
		End if 
		If ($vl_TailTab6>0)
			If ($rT_HG_FamGroupe{$L_Compteur}="") | ($rT_HG_FamGroupe{$L_Compteur}="115")
				
				$Pos:=Find in array:C230(ta_xGroupe; "115")
				If ($Pos>0)
					tl_xGroupe{$Pos}:=tl_xGroupe{$Pos}+1
					vl_xGroupe:=vl_xGroupe+1
				End if 
			Else 
				$Pos:=Find in array:C230(ta_xGroupe; $rT_HG_FamGroupe{$L_Compteur})
				If ($Pos>0)
					tl_xGroupe{$Pos}:=tl_xGroupe{$Pos}+1
					vl_xGroupe:=vl_xGroupe+1
				End if 
			End if 
		End if 
		If ($vl_TailTab7>0)
			$Pos:=Find in array:C230(ta_FAMCpo; $rT_HG_FamCompo{$L_Compteur})
			If ($Pos>0)
				tl_FMComp{$Pos}:=tl_FMComp{$Pos}+1
				If ($rB_HG_Cloturee{$L_Compteur})
					tl_FMCompC{$Pos}:=tl_FMCompC{$Pos}+1
				Else 
					tl_FMCompNC{$Pos}:=tl_FMCompNC{$Pos}+1
				End if 
				tr_FMComp{$Pos}:=tr_FMComp{$Pos}+$rR_HG_FamPrixJour{$L_Compteur}
			End if 
		End if 
		
		
		//NEXT RECORD([HeberGement])
	Until ($L_Compteur=Records in selection:C76([HeberGement:5]))
	
	//Until (End selection([HeberGement]))
	
	vl_FMDis1:=0
	vl_FMDis2:=0
	vl_FMDis3:=0
	vl_FMDis4:=0
	vl_FMDis5:=0
	vl_FMCaS:=0
	vl_FMComp:=0
	vr_FMComp:=0
	
	vr_FMDis1:=0
	vr_FMDis2:=0
	vr_FMDis3:=0
	vr_FMDis4:=0
	vr_FMDis5:=0
	
	For ($ii; 1; Size of array:C274(<>ta_FMDis1))
		If (tl_FMDis1{$ii}>0)
			$ij:=Size of array:C274(ta_xFMDis1)+1
			INSERT IN ARRAY:C227(ta_xFMDis1; $ij)
			INSERT IN ARRAY:C227(tl_xFMDis1; $ij)
			INSERT IN ARRAY:C227(tr_xFMDis1; $ij)
			ta_xFMDis1{$ij}:=<>ta_FMDis1{$ii}
			tl_xFMDis1{$ij}:=tl_FMDis1{$ii}
			vl_FMDis1:=vl_FMDis1+tl_xFMDis1{$ij}
			tr_xFMDis1{$ij}:=tr_FMDis1{$ii}
			vr_FMDis1:=vr_FMDis1+tr_xFMDis1{$ij}
		End if 
	End for 
	For ($ii; 1; Size of array:C274(<>ta_FMDis2))
		If (tl_FMDis2{$ii}>0)
			$ij:=Size of array:C274(ta_xFMDis2)+1
			INSERT IN ARRAY:C227(ta_xFMDis2; $ij)
			INSERT IN ARRAY:C227(tl_xFMDis2; $ij)
			INSERT IN ARRAY:C227(tr_xFMDis2; $ij)
			ta_xFMDis2{$ij}:=<>ta_FMDis2{$ii}
			tl_xFMDis2{$ij}:=tl_FMDis2{$ii}
			vl_FMDis2:=vl_FMDis2+tl_xFMDis2{$ij}
			tr_xFMDis2{$ij}:=tr_FMDis2{$ii}
			vr_FMDis2:=vr_FMDis2+tr_xFMDis2{$ij}
		End if 
	End for 
	
	For ($ii; 1; Size of array:C274(<>ta_FMDis3))
		
		If (tl_FMDis3{$ii}>0)
			$ij:=Size of array:C274(ta_xFMDis3)+1
			INSERT IN ARRAY:C227(ta_xFMDis3; $ij)
			INSERT IN ARRAY:C227(tl_xFMDis3; $ij)
			INSERT IN ARRAY:C227(tr_xFMDis3; $ij)
			ta_xFMDis3{$ij}:=<>ta_FMDis3{$ii}
			
			tl_xFMDis3{$ij}:=tl_FMDis3{$ii}
			vl_FMDis3:=vl_FMDis3+tl_xFMDis3{$ij}  // pied
			
			tr_xFMDis3{$ij}:=tr_FMDis3{$ii}
			vr_FMDis3:=vr_FMDis3+tr_xFMDis3{$ij}  // pied
		End if 
	End for 
	
	For ($ii; 1; Size of array:C274(<>ta_FMDis4))
		If (tl_FMDis4{$ii}>0)
			$ij:=Size of array:C274(ta_xFMDis4)+1
			INSERT IN ARRAY:C227(ta_xFMDis4; $ij)
			INSERT IN ARRAY:C227(tl_xFMDis4; $ij)
			INSERT IN ARRAY:C227(tr_xFMDis4; $ij)
			ta_xFMDis4{$ij}:=<>ta_FMDis4{$ii}
			tl_xFMDis4{$ij}:=tl_FMDis4{$ii}
			vl_FMDis4:=vl_FMDis4+tl_xFMDis4{$ij}
			tr_xFMDis4{$ij}:=tr_FMDis4{$ii}
			vr_FMDis4:=vr_FMDis4+tr_xFMDis4{$ij}
		End if 
	End for 
	For ($ii; 1; Size of array:C274(<>ta_FMDis5))
		If (tl_FMDis5{$ii}>0)
			$ij:=Size of array:C274(ta_xFMDis5)+1
			INSERT IN ARRAY:C227(ta_xFMDis5; $ij)
			INSERT IN ARRAY:C227(tl_xFMDis5; $ij)
			INSERT IN ARRAY:C227(tr_xFMDis5; $ij)
			ta_xFMDis5{$ij}:=<>ta_FMDis5{$ii}
			tl_xFMDis5{$ij}:=tl_FMDis5{$ii}
			vl_FMDis5:=vl_FMDis5+tl_xFMDis5{$ij}
			tr_xFMDis5{$ij}:=tr_FMDis5{$ii}
			vr_FMDis5:=vr_FMDis5+tr_xFMDis5{$ij}
		End if 
	End for 
	For ($ii; 1; Size of array:C274(<>ta_FMCaS))
		If (tl_FMCaS{$ii}>0)
			$ij:=Size of array:C274(ta_xFMCaS)+1
			INSERT IN ARRAY:C227(ta_xFMCaS; $ij)
			INSERT IN ARRAY:C227(tl_xFMCaS; $ij)
			ta_xFMCaS{$ij}:=<>ta_FMCaS{$ii}
			tl_xFMCaS{$ij}:=tl_FMCaS{$ii}
			vl_FMCaS:=vl_FMCaS+tl_xFMCaS{$ij}
		End if 
	End for 
	For ($ii; 1; Size of array:C274(ta_FAMCpo))
		If (tl_FMComp{$ii}>0)
			$ij:=Size of array:C274(ta_xFMComp)+1
			INSERT IN ARRAY:C227(ta_xFMComp; $ij)
			INSERT IN ARRAY:C227(tl_xFMComp; $ij)
			INSERT IN ARRAY:C227(tl_xFMCompC; $ij)
			INSERT IN ARRAY:C227(tl_xFMCompNC; $ij)
			INSERT IN ARRAY:C227(tr_xFMComp; $ij)
			ta_xFMComp{$ij}:=ta_FAMCpo{$ii}
			tl_xFMComp{$ij}:=tl_FMComp{$ii}
			tl_xFMCompC{$ij}:=tl_FMCompC{$ii}
			tl_xFMCompNC{$ij}:=tl_FMCompNC{$ii}
			tr_xFMComp{$ij}:=tr_FMComp{$ii}
			vl_FMComp:=vl_FMComp+tl_xFMComp{$ij}
			vl_FMCompC:=vl_FMCompC+tl_xFMCompC{$ij}
			vl_FMCompNC:=vl_FMCompNC+tl_xFMCompNC{$ij}
			vr_FMComp:=vr_FMComp+tr_xFMComp{$ij}
		End if 
	End for 
End if 


OB SET ARRAY:C1227($O_Objet; "ta_FAMCpo"; ta_FAMCpo)
OB SET ARRAY:C1227($O_Objet; "ta_xFMCaS"; ta_xFMCaS)
OB SET ARRAY:C1227($O_Objet; "ta_xFMComp"; ta_xFMComp)
OB SET ARRAY:C1227($O_Objet; "ta_xFMDis1"; ta_xFMDis1)
OB SET ARRAY:C1227($O_Objet; "ta_xFMDis2"; ta_xFMDis2)
OB SET ARRAY:C1227($O_Objet; "ta_xFMDis3"; ta_xFMDis3)
OB SET ARRAY:C1227($O_Objet; "ta_xFMDis4"; ta_xFMDis4)
OB SET ARRAY:C1227($O_Objet; "ta_xFMDis5"; ta_xFMDis5)
OB SET ARRAY:C1227($O_Objet; "ta_xFMGrp"; ta_xFMGrp)
OB SET ARRAY:C1227($O_Objet; "ta_xGroupe"; ta_xGroupe)
OB SET ARRAY:C1227($O_Objet; "tl_FMCaS"; tl_FMCaS)
OB SET ARRAY:C1227($O_Objet; "tl_FMComp"; tl_FMComp)
OB SET ARRAY:C1227($O_Objet; "tl_FMCompC"; tl_FMCompC)
OB SET ARRAY:C1227($O_Objet; "tl_FMCompNC"; tl_FMCompNC)
OB SET ARRAY:C1227($O_Objet; "tl_FMDis1"; tl_FMDis1)
OB SET ARRAY:C1227($O_Objet; "tl_FMDis2"; tl_FMDis2)
OB SET ARRAY:C1227($O_Objet; "tl_FMDis3"; tl_FMDis3)
OB SET ARRAY:C1227($O_Objet; "tl_FMDis4"; tl_FMDis4)
OB SET ARRAY:C1227($O_Objet; "tl_FMDis5"; tl_FMDis5)
OB SET ARRAY:C1227($O_Objet; "tl_xFMCaS"; tl_xFMCaS)
OB SET ARRAY:C1227($O_Objet; "tl_xFMComp"; tl_xFMComp)
OB SET ARRAY:C1227($O_Objet; "tl_xFMCompC"; tl_xFMCompC)
OB SET ARRAY:C1227($O_Objet; "tl_xFMCompNC"; tl_xFMCompNC)
OB SET ARRAY:C1227($O_Objet; "tl_xFMDis1"; tl_xFMDis1)
OB SET ARRAY:C1227($O_Objet; "tl_xFMDis2"; tl_xFMDis2)
OB SET ARRAY:C1227($O_Objet; "tl_xFMDis3"; tl_xFMDis3)
OB SET ARRAY:C1227($O_Objet; "tl_xFMDis4"; tl_xFMDis4)
OB SET ARRAY:C1227($O_Objet; "tl_xFMDis5"; tl_xFMDis5)
OB SET ARRAY:C1227($O_Objet; "tl_xFMGrp"; tl_xFMGrp)
OB SET ARRAY:C1227($O_Objet; "tl_xGroupe"; tl_xGroupe)
OB SET ARRAY:C1227($O_Objet; "tr_FMComp"; tr_FMComp)
OB SET ARRAY:C1227($O_Objet; "tr_FMDis1"; tr_FMDis1)
OB SET ARRAY:C1227($O_Objet; "tr_FMDis2"; tr_FMDis2)
OB SET ARRAY:C1227($O_Objet; "tr_FMDis3"; tr_FMDis3)
OB SET ARRAY:C1227($O_Objet; "tr_FMDis4"; tr_FMDis4)
OB SET ARRAY:C1227($O_Objet; "tr_FMDis5"; tr_FMDis5)
OB SET ARRAY:C1227($O_Objet; "tr_xFMComp"; tr_xFMComp)
OB SET ARRAY:C1227($O_Objet; "tr_xFMDis1"; tr_xFMDis1)
OB SET ARRAY:C1227($O_Objet; "tr_xFMDis2"; tr_xFMDis2)
OB SET ARRAY:C1227($O_Objet; "tr_xFMDis3"; tr_xFMDis3)
OB SET ARRAY:C1227($O_Objet; "tr_xFMDis4"; tr_xFMDis4)
OB SET ARRAY:C1227($O_Objet; "tr_xFMDis5"; tr_xFMDis5)
OB SET:C1220($O_Objet; "vl_FMCaS"; vl_FMCaS)
OB SET:C1220($O_Objet; "vl_FMComp"; vl_FMComp)
OB SET:C1220($O_Objet; "vl_FMCompC"; vl_FMCompC)
OB SET:C1220($O_Objet; "vl_FMCompNC"; vl_FMCompNC)
OB SET:C1220($O_Objet; "vl_FMDis1"; vl_FMDis1)
OB SET:C1220($O_Objet; "vl_FMDis2"; vl_FMDis2)
OB SET:C1220($O_Objet; "vl_FMDis3"; vl_FMDis3)
OB SET:C1220($O_Objet; "vl_FMDis4"; vl_FMDis4)
OB SET:C1220($O_Objet; "vl_FMDis5"; vl_FMDis5)
OB SET:C1220($O_Objet; "vl_xGroupe"; vl_xGroupe)
OB SET:C1220($O_Objet; "vr_FMComp"; vr_FMComp)
OB SET:C1220($O_Objet; "vr_FMDis1"; vr_FMDis1)
OB SET:C1220($O_Objet; "vr_FMDis2"; vr_FMDis2)
OB SET:C1220($O_Objet; "vr_FMDis3"; vr_FMDis3)
OB SET:C1220($O_Objet; "vr_FMDis4"; vr_FMDis4)
OB SET:C1220($O_Objet; "vr_FMDis5"; vr_FMDis5)

$P_Objet->:=OB Copy:C1225($O_Objet)





//<>ta_FMCaS
//<>ta_FMDis1
//<>ta_FMDis2
//<>ta_FMDis3
//<>ta_FMDis4
//<>ta_FMDis5
//ta_FAMCpo
//ta_xFMCaS
//ta_xFMComp
//ta_xFMDis1
//ta_xFMDis2
//ta_xFMDis3
//ta_xFMDis4
//ta_xFMDis5
//ta_xFMGrp
//ta_xGroupe
//tl_FMCaS
//tl_FMComp
//tl_FMCompC
//tl_FMCompNC
//tl_FMDis1
//tl_FMDis2
//tl_FMDis3
//tl_FMDis4
//tl_FMDis5
//tl_xFMCaS
//tl_xFMComp
//tl_xFMCompC
//tl_xFMCompNC
//tl_xFMDis1
//tl_xFMDis2
//tl_xFMDis3
//tl_xFMDis4
//tl_xFMDis5
//tl_xFMGrp
//tl_xGroupe
//tr_FMComp
//tr_FMDis1
//tr_FMDis2
//tr_FMDis3
//tr_FMDis4
//tr_FMDis5
//tr_xFMComp
//tr_xFMDis1
//tr_xFMDis2
//tr_xFMDis3
//tr_xFMDis4
//tr_xFMDis5
//vl_FMCaS
//vl_FMComp
//vl_FMCompC
//vl_FMCompNC
//vl_FMDis1
//vl_FMDis2
//vl_FMDis3
//vl_FMDis4
//vl_FMDis5
//vl_xGroupe
//vr_FMComp
//vr_FMDis1
//vr_FMDis2
//vr_FMDis3
//vr_FMDis4
//vr_FMDis5


