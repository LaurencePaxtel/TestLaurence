//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : F_SommeVeille
//{
//{          Jeudi 7 octobre 2010 à 10:23:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215

C_TEXT:C284($1)
C_DATE:C307($2)
C_LONGINT:C283($ii; $kk; $vl_Position)
ARRAY TEXT:C222($ta_ValeursTemp; 0)
C_TEXT:C284($va_ValeursTemp)

If ($2=!00-00-00!)
	REDUCE SELECTION:C351([Sommes:48]; 0)
Else 
	QUERY:C277([Sommes:48]; [Sommes:48]SM_CatégorieDate:4=$1+F_DateAlphaInversé($2))
	MultiSoc_Filter(->[Sommes:48])
	
	
	If (Records in selection:C76([Sommes:48])=0)
		For ($ii; 1; Size of array:C274(<>ta_TBOr1))
			If (<>ta_TBOr1{$ii}[[1]]="*")
				$va_ValeursTemp:=Substring:C12(<>ta_TBOr1{$ii}; 2)
				$vl_Position:=Position:C15("*"; $va_ValeursTemp)
				If ($vl_Position>0)
					If (7=8)
						$va_ValeursTemp:=Substring:C12(<>ta_TBOr1{$ii}; 1; $vl_Position+1)
						$vl_Position:=Find in array:C230($ta_ValeursTemp; $va_ValeursTemp)
						If ($vl_Position>0)
						Else 
							$vl_Position:=Size of array:C274($ta_ValeursTemp)+1
							INSERT IN ARRAY:C227($ta_ValeursTemp; $vl_Position)
							$ta_ValeursTemp{$vl_Position}:=$va_ValeursTemp
						End if 
					Else 
						$vl_Position:=Size of array:C274($ta_ValeursTemp)+1
						INSERT IN ARRAY:C227($ta_ValeursTemp; $vl_Position)
						$ta_ValeursTemp{$vl_Position}:=<>ta_TBOr1{$ii}
					End if 
				End if 
			End if 
		End for 
		$kk:=Uut_NumerotePlus(->[Sommes:48]; Size of array:C274($ta_ValeursTemp))
		For ($ii; 1; Size of array:C274($ta_ValeursTemp))
			
			CREATE RECORD:C68([Sommes:48])
			MultiSoc_Init_Structure(->[Sommes:48])
			[Sommes:48]SM_RéférenceID:1:=$kk
			[Sommes:48]SM_Catégorie:2:=$1
			[Sommes:48]SM_Date:3:=$2
			[Sommes:48]SM_CatégorieDate:4:=[Sommes:48]SM_Catégorie:2+F_DateAlphaInversé($2)
			[Sommes:48]SM_libellé:5:=$ta_ValeursTemp{$ii}
			SAVE RECORD:C53([Sommes:48])
			UNLOAD RECORD:C212([Sommes:48])
			$kk:=$kk+1
		End for 
		QUERY:C277([Sommes:48]; [Sommes:48]SM_CatégorieDate:4="Orientation1"+F_DateAlphaInversé($2))
		MultiSoc_Filter(->[Sommes:48])
		
	End if 
	
	vl_TTcapacite:=0
	vl_TTattribue:=0
	vl_TTreste:=0
	If (Records in selection:C76([Sommes:48])>0)
		
		APPLY TO SELECTION:C70([Sommes:48]; P_ApplSommeVeille)
		
		
	End if 
	ORDER BY:C49([Sommes:48]; [Sommes:48]SM_libellé:5; >)
End if 