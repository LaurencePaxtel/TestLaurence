//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_StatSPcompteur
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================} 
C_BOOLEAN:C305($0; $B_Out)

C_LONGINT:C283($1; $L_Selecteur)
$L_Selecteur:=$1
C_LONGINT:C283($2; $L_Compteur)
$L_Compteur:=$2

C_POINTER:C301($P_ve_p1; $P_ve_p2; $P_ve_p3)
Case of 
	: ($L_Selecteur=1)
		$P_ve_p1:=->tp_Rub1
		$P_ve_p2:=->te_Rub1
		$P_ve_p3:=->ta_it1
	: ($L_Selecteur=2)
		$P_ve_p1:=->tp_Rub2
		$P_ve_p2:=->te_Rub2
		$P_ve_p3:=->ta_it2
	: ($L_Selecteur=3)
		$P_ve_p1:=->tp_Rub3
		$P_ve_p2:=->te_Rub3
		$P_ve_p3:=->ta_it3
	: ($L_Selecteur=4)
		$P_ve_p1:=->tp_Rub4
		$P_ve_p2:=->te_Rub4
		$P_ve_p3:=->ta_it4
	Else 
		ASSERT:C1129(False:C215; "problème de sélecteur")
End case 




C_LONGINT:C283($kk)
$kk:=$P_ve_p2->{0}


//C_BOOLEAN($B_Log)
//$B_Log:=True
//C_TEXT($T_File)
//$T_File:="stats.txt"
//Log_mensuel ($B_Log;"$kk\t"+String($kk);$T_File)

Case of 
	: ($kk=0)
		
		$B_Out:=(($P_ve_p1->{0})->=$P_ve_p3->{$L_Compteur})
		
	: ($kk=1)
		//TRACE
		If ($L_Compteur=1)
			$B_Out:=(($P_ve_p1->{0})->)
		Else 
			$B_Out:=(($P_ve_p1->{0})->=False:C215)
		End if 
		
	: ($kk=2)
		
		C_LONGINT:C283($L_SizeTrancheAge)
		$L_SizeTrancheAge:=Size of array:C274(<>te_TrancheAge)
		
		// Compteur = 1 on teste 3 -18   
		// Compteur = 2 on teste 19-24
		// Compteur = 3 on teste 25-29
		// Compteur = 4 on teste 30-39
		// Compteur = 5 on teste 40-49
		// Compteur = 6 on teste 50-59
		// Compteur = 7 on teste 60-69
		// Compteur = 8 on teste +69
		// Compteur = 9 on teste ?
		
		
		Case of 
			: ($L_Compteur>=2) & ($L_Compteur<=8)
				
				If ($L_Compteur>=$L_SizeTrancheAge)
					
					$B_Out:=([HeberGement:5]HG_Age:23>=<>te_TrancheAge{$L_Compteur})
				Else 
					$B_Out:=([HeberGement:5]HG_Age:23>=<>te_TrancheAge{($L_Compteur-1)}) & ([HeberGement:5]HG_Age:23<<>te_TrancheAge{$L_Compteur})
				End if 
				
			: ($L_Compteur=1)
				$B_Out:=([HeberGement:5]HG_Age:23<<>te_TrancheAge{$L_Compteur})
				
			: ($L_Compteur=9)
				$B_Out:=([HeberGement:5]HG_Age:23>=<>te_TrancheAge{$L_Compteur})
		End case 
		
	: ($kk=3)
		TRACE:C157
		va_TempA1:=Time string:C180(($P_ve_p1->{0})->)
		va_TempA1:=Substring:C12(va_TempA1; 1; Position:C15(":"; va_TempA1)-1)
		vl_TempA1:=Num:C11(va_TempA1)
		vl_TempA2:=Num:C11($P_ve_p3->{$L_Compteur})
		$B_Out:=(vl_TempA1>=vl_TempA2) & (vl_TempA1<(vl_TempA2+1))
End case 

$0:=$B_Out

