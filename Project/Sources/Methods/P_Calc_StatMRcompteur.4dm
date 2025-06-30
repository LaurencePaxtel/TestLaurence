//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_StatMRcompteur
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================} 
C_BOOLEAN:C305($0)
$0:=False:C215

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
		TRACE:C157
End case 

C_LONGINT:C283($kk)
$kk:=$P_ve_p2->{0}
Case of 
	: ($kk=0)
		
		$0:=(($P_ve_p1->{0})->=$P_ve_p3->{$L_Compteur})
		
	: ($kk=1)
		
		If ($L_Compteur=1)
			
			$0:=(($P_ve_p1->{0})->)
			
		Else 
			
			$0:=(($P_ve_p1->{0})->=False:C215)
			
		End if 
		
		
	: ($kk=2)
		
		Case of 
				//0 à 3
			: ($L_Compteur=1)
				
				$0:=([Maraude:24]MR_Age:19<=<>te_TBAge{1})
				
				
				//3 -18            
			: ($L_Compteur=2)
				
				$0:=([Maraude:24]MR_Age:19><>te_TBAge{1}) & ([Maraude:24]MR_Age:19<<>te_TBAge{2})
				
				// 19-24
			: ($L_Compteur=3)
				
				$0:=([Maraude:24]MR_Age:19>=<>te_TBAge{2}) & ([Maraude:24]MR_Age:19<=<>te_TBAge{3})
				
				//25-29
			: ($L_Compteur=4)
				
				$0:=([Maraude:24]MR_Age:19><>te_TBAge{3}) & ([Maraude:24]MR_Age:19<=<>te_TBAge{4})
				
				//30-39
			: ($L_Compteur=5)
				
				$0:=([Maraude:24]MR_Age:19><>te_TBAge{4}) & ([Maraude:24]MR_Age:19<=<>te_TBAge{5})
				
				//40-49
			: ($L_Compteur=6)
				
				$0:=([Maraude:24]MR_Age:19><>te_TBAge{5}) & ([Maraude:24]MR_Age:19<=<>te_TBAge{6})
				
				//50-59
			: ($L_Compteur=7)
				
				$0:=([Maraude:24]MR_Age:19><>te_TBAge{6}) & ([Maraude:24]MR_Age:19<=<>te_TBAge{7})
				
				//60-69
			: ($L_Compteur=8)
				
				$0:=([Maraude:24]MR_Age:19><>te_TBAge{7}) & ([Maraude:24]MR_Age:19<=<>te_TBAge{8})
				
				//+69
			: ($L_Compteur=9)
				
				$0:=([Maraude:24]MR_Age:19>=<>te_TBAge{9})
				
		End case 
		
	: ($kk=3)
		
		
		va_TempA1:=Time string:C180(($P_ve_p1->{0})->)
		va_TempA1:=Substring:C12(va_TempA1; 1; Position:C15(":"; va_TempA1)-1)
		vl_TempA1:=Num:C11(va_TempA1)
		vl_TempA2:=Num:C11($P_ve_p3->{$L_Compteur})
		
		$0:=(vl_TempA1>=vl_TempA2) & (vl_TempA1<(vl_TempA2+1))
		
		
		
	: ($kk=4)
		Case of 
				//0 à 5     mn
			: ($L_Compteur=1)
				
				$0:=([Maraude:24]MR_DuréRencontr:79<=?00:05:00?)
				
				//3 -18            
			: ($L_Compteur=2)
				
				$0:=([Maraude:24]MR_DuréRencontr:79>?00:05:00?) & ([Maraude:24]MR_DuréRencontr:79<=?00:10:00?)
				
				// 19-24
			: ($L_Compteur=3)
				
				$0:=([Maraude:24]MR_DuréRencontr:79>?00:10:00?) & ([Maraude:24]MR_DuréRencontr:79<=?00:15:00?)
				
				//25-29
			: ($L_Compteur=4)
				
				$0:=([Maraude:24]MR_DuréRencontr:79>?00:15:00?) & ([Maraude:24]MR_DuréRencontr:79<=?00:30:00?)
				
				//30-39
			: ($L_Compteur=5)
				
				$0:=([Maraude:24]MR_DuréRencontr:79>?00:30:00?) & ([Maraude:24]MR_DuréRencontr:79<=?00:45:00?)
				
				//40-49
			: ($L_Compteur=6)
				
				$0:=([Maraude:24]MR_DuréRencontr:79>?00:45:00?) & ([Maraude:24]MR_DuréRencontr:79<=?01:00:00?)
				
				//50-59
			: ($L_Compteur=7)
				
				$0:=([Maraude:24]MR_DuréRencontr:79>?01:00:00?) & ([Maraude:24]MR_DuréRencontr:79<=?01:30:00?)
				
				//60-69
			: ($L_Compteur=8)
				
				$0:=([Maraude:24]MR_DuréRencontr:79>?01:30:00?) & ([Maraude:24]MR_DuréRencontr:79<=?02:00:00?)
				
			: ($L_Compteur=9)
				
				$0:=([Maraude:24]MR_DuréRencontr:79>?02:00:00?) & ([Maraude:24]MR_DuréRencontr:79<=?02:30:00?)
				
			: ($L_Compteur=10)
				
				$0:=([Maraude:24]MR_DuréRencontr:79>=?02:30:00?)
				
		End case 
		
		
End case 