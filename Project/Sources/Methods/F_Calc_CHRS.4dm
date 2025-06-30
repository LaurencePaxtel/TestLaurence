//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Fonction : F_Calc_CHRS
//{          Mercredi 10 avril 2012 à 17:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_TEXT:C284($1)

C_LONGINT:C283($vl_Position)

Case of 
	: ($1="BonCentre")
		
		If (vb_CentreRegroupé)
			$vl_Position:=Find in array:C230(tl_LC_CentreLien; [HeberGement:5]HG_LC_ID:61)
			
			If ($vl_Position>0)
				$vl_Position:=Find in array:C230(ta_LC_Centre; ta_LC_CentreLien{$vl_Position})
			End if 
			
		Else 
			$vl_Position:=Find in array:C230(tl_LC_Centre; [HeberGement:5]HG_LC_ID:61)
		End if 
		
		$0:=($vl_Position>0)
End case 