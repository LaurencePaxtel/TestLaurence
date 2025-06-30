//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_StatDurée
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_TIME:C306($1)
C_TIME:C306($2)
C_BOOLEAN:C305($3)
C_POINTER:C301($4)
C_POINTER:C301($5)
C_POINTER:C301($6)
C_POINTER:C301($7)
C_POINTER:C301($8)
C_POINTER:C301($9)
C_LONGINT:C283($Position)

C_LONGINT:C283($ve_HeurD; $ve_HeurF; $ve_Heur; $ve_Min)
$ve_HeurD:=Num:C11(Substring:C12((Time string:C180($1)); 1; 2))
$ve_HeurF:=Num:C11(Substring:C12((Time string:C180($2)); 1; 2))

C_TIME:C306($vh_Durée)
$vh_Durée:=$2-$1

C_TIME:C306(vh_Rt)
vh_Rt:=vh_Rt+$vh_Durée



$ve_Heur:=Num:C11(Substring:C12((Time string:C180($vh_Durée)); 1; 2))
$ve_Min:=Num:C11(Substring:C12((Time string:C180($vh_Durée)); 4; 2))

C_LONGINT:C283($vl_Durée)
$vl_Durée:=0
If ($ve_Heur>0)
	$vl_Durée:=$ve_Heur*60
End if 
$vl_Durée:=$vl_Durée+$ve_Min


$Position:=Find in array:C230(<>ts_Heures; $ve_HeurD)
If ($Position>0)
	$4->{$Position}:=$4->{$Position}+1
	If ($3)
		$5->{$Position}:=$5->{$Position}+1
	End if 
End if 

$Position:=Find in array:C230(<>ts_Heures; $ve_HeurF)
If ($Position>0)
	$6->{$Position}:=$6->{$Position}+1
	If ($3)
		$7->{$Position}:=$7->{$Position}+1
	End if 
End if 

Case of 
		//5      
	: ($vl_Durée<=<>th_Rt{1})
		$8->{1}:=$8->{1}+1
		If ($3)
			$9->{1}:=$9->{1}+1
		End if 
		//6 -10            
	: ($vl_Durée><>th_Rt{1}) & ($vl_Durée<<>th_Rt{2})
		$8->{2}:=$8->{2}+1
		If ($3)
			$9->{2}:=$9->{2}+1
		End if 
		// 11-15
	: ($vl_Durée>=<>th_Rt{2}) & ($vl_Durée<=<>th_Rt{3})
		$8->{3}:=$8->{3}+1
		If ($3)
			$9->{3}:=$9->{3}+1
		End if 
		//16-30
	: ($vl_Durée><>th_Rt{3}) & ($vl_Durée<=<>th_Rt{4})
		$8->{4}:=$8->{4}+1
		If ($3)
			$9->{4}:=$9->{4}+1
		End if 
		//31-45
	: ($vl_Durée><>th_Rt{4}) & ($vl_Durée<=<>th_Rt{5})
		$8->{5}:=$8->{5}+1
		If ($3)
			$9->{5}:=$9->{5}+1
		End if 
		//46-60
	: ($vl_Durée><>th_Rt{5}) & ($vl_Durée<=<>th_Rt{6})
		$8->{6}:=$8->{6}+1
		If ($3)
			$9->{6}:=$9->{6}+1
		End if 
		//61-90
	: ($vl_Durée><>th_Rt{6}) & ($vl_Durée<=<>th_Rt{7})
		$8->{7}:=$8->{7}+1
		If ($3)
			$9->{7}:=$9->{7}+1
		End if 
		//91-120
	: ($vl_Durée><>th_Rt{7}) & ($vl_Durée<=<>th_Rt{8})
		$8->{8}:=$8->{8}+1
		If ($3)
			$9->{8}:=$9->{8}+1
		End if 
		//121-150
	: ($vl_Durée><>th_Rt{8}) & ($vl_Durée<=<>th_Rt{9})
		$8->{9}:=$8->{9}+1
		If ($3)
			$9->{9}:=$9->{9}+1
		End if 
		//+150
	: ($vl_Durée>=<>th_Rt{10})
		$8->{10}:=$8->{10}+1
		If ($3)
			$9->{10}:=$9->{10}+1
		End if 
End case 