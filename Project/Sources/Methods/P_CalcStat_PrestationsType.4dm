//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CalcStat_PrestationsType
//{
//{          Mercredi 10 mai 2006 à 11:03:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}



C_LONGINT:C283($1)  //2;
C_POINTER:C301($2)  //->ta_Ass_N;
C_POINTER:C301($3)  //-->t_AS_Dem_N;
C_POINTER:C301($4)  //-->t_AS_Dem1_N;
C_POINTER:C301($5)  //-->t_AS_Dem2_N;
C_POINTER:C301($6)  //-->t_AS_Dem3_N;
C_POINTER:C301($7)  //-->vl_AS_Dem_N;
C_POINTER:C301($8)  //-->vl_AS_Dem1_N;
C_POINTER:C301($9)  //-->vl_AS_Dem2_N;
C_POINTER:C301($10)  //-->vl_AS_Dem3_N;

C_LONGINT:C283($ii; $jj)

// : Les Associations           2                  ••••••
//••••••••••••••••••••••••••••••••••••
//2;
//->ta_Ass_N;
//->t_AS_Dem_N;
//->t_AS_Dem1_N;
//->t_AS_Dem2_N;
//->t_AS_Dem3_N;
//->vl_AS_Dem_N;
//->vl_AS_Dem1_N;
//->vl_AS_Dem2_N;
//->vl_AS_Dem3_N;

// : Les demandes de prestations    3        ••••••
//••••••••••••••••••••••••••••••••••••
//3;
//->ta_DemP_N;
//->tl_DemPt_N;
//->tl_DemPt1_N;
//->tl_DemPt2_N;
//->tl_DemPt3_N;
//->vl_DP_Dem_N;
//->vl_DP_Dem1_N;
//->vl_DP_Dem2_N;
//->vl_DP_Dem3_N;

// : Les Adresses utiles    1                     ••••••
//••••••••••••••••••••••••••••••••••••
//1;
//->ta_AdUtil_N;
//->tl_AdUPt_N;
//->tl_AdUPt1_N;
//->tl_AdUPt2_N;
//->tl_AdUPt3_N;
//->vl_AU_Dem_N;
//->vl_AU_Dem1_N;
//->vl_AU_Dem2_N;
//->vl_AU_Dem3_N;

// : Les Situations particulières    4         ••••••
//••••••••••••••••••••••••••••••••••••
//4;
//->ta_SitPar_N;
//->tl_SitPt_N;
//->tl_SitPt1_N;
//->tl_SitPt2_N;
//->tl_SitPt3_N;
//->vl_SP_Dem_N;
//->vl_SP_Dem1_N;
//->vl_SP_Dem2_N;
//->vl_SP_Dem3_N;




$7->:=0
$8->:=0
$9->:=0
$10->:=0

USE SET:C118("E_RGDem")
QUERY SELECTION:C341([RenseiGnements:20]; [RenseiGnements:20]RG_Rubrique:6=<>ta_PrestRub{$1})
If (Records in selection:C76([RenseiGnements:20])>0)
	CREATE SET:C116([RenseiGnements:20]; "E_RGDemAA")
	DISTINCT VALUES:C339([RenseiGnements:20]RG_Nom:8; $2->)
	$jj:=Size of array:C274($2->)
	If ($jj>0)
		ARRAY LONGINT:C221($3->; $jj)
		ARRAY LONGINT:C221($4->; $jj)
		ARRAY LONGINT:C221($5->; $jj)
		ARRAY LONGINT:C221($6->; $jj)
		For ($ii; 1; $jj)
			$3->{$ii}:=0
			$4->{$ii}:=0
			$5->{$ii}:=0
			$6->{$ii}:=0
		End for 
		$7->:=0
		$8->:=0
		$9->:=0
		$10->:=0
		USE SET:C118("E_RGDemAA")
		FIRST RECORD:C50([RenseiGnements:20])
		Repeat 
			
			$ii:=Find in array:C230($2->; [RenseiGnements:20]RG_Nom:8)
			If ($ii>0)
				Case of 
					: (rJourNuit1=1) & (rJourNuit2=1)
						$3->{$ii}:=$3->{$ii}+1
						Case of 
							: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType1)
								$4->{$ii}:=$4->{$ii}+1
							: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType2)
								$5->{$ii}:=$5->{$ii}+1
							: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType3)
								$6->{$ii}:=$6->{$ii}+1
						End case 
					: (rJourNuit1=1) & (rJourNuit2=0)
						If ([RenseiGnements:20]RG_Nuit:5=False:C215)
							$3->{$ii}:=$3->{$ii}+1
							Case of 
								: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType1)
									$4->{$ii}:=$4->{$ii}+1
								: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType2)
									$5->{$ii}:=$5->{$ii}+1
								: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType3)
									$6->{$ii}:=$6->{$ii}+1
							End case 
						End if 
					: (rJourNuit1=0) & (rJourNuit2=1)
						If ([RenseiGnements:20]RG_Nuit:5=True:C214)
							$3->{$ii}:=$3->{$ii}+1
							Case of 
								: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType1)
									$4->{$ii}:=$4->{$ii}+1
								: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType2)
									$5->{$ii}:=$5->{$ii}+1
								: ([RenseiGnements:20]RG_Origine:9=<>va_PrestType3)
									$6->{$ii}:=$6->{$ii}+1
							End case 
						End if 
					: (rJourNuit1=0) & (rJourNuit2=0)
						$3->{$ii}:=0
						$4->{$ii}:=0
						$5->{$ii}:=0
						$6->{$ii}:=0
				End case 
			End if 
			NEXT RECORD:C51([RenseiGnements:20])
		Until (End selection:C36([RenseiGnements:20]))
		For ($ii; 1; $jj)
			$7->:=$7->+$3->{$ii}
			$8->:=$8->+$4->{$ii}
			$9->:=$9->+$5->{$ii}
			$10->:=$10->+$6->{$ii}
		End for 
	End if 
	CLEAR SET:C117("E_RGDemAA")
End if 