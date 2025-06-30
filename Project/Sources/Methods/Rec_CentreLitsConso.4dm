//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Rec_CentreLitsConso
//{
//{          Vendrdi 26 novembre 2004 à 17:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}


vL_NbFichesConso:=0
REDUCE SELECTION:C351([CentresLits:16]; 0)
If ([DiaLogues:3]DL_Date:2>!00-00-00!)
	P_SommeLit(2)
	Case of 
		: (rJourNuit1=1) & (rJourNuit2=0)
			va_DateType:=Uut_NumeroteLitsType([DiaLogues:3]DL_Date:2; "J")
			QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
		: (rJourNuit1=0) & (rJourNuit2=1)
			va_DateType:=Uut_NumeroteLitsType([DiaLogues:3]DL_Date:2; "N")
			QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
		: (rJourNuit1=1) & (rJourNuit2=1)
			QUERY:C277([CentresLits:16]; [CentresLits:16]CL_Date:3=[DiaLogues:3]DL_Date:2)
		: (rJourNuit1=0) & (rJourNuit2=0)
			REDUCE SELECTION:C351([CentresLits:16]; 0)
	End case 
	MultiSoc_Filter(->[CentresLits:16])
	
	If (Size of array:C274(<>ta_Niveau)>0)
		If (Records in selection:C76([CentresLits:16])>0)
			$ij:=0
			$vbOK:=False:C215
			For ($ii; 1; Size of array:C274(<>ta_Niveau))
				$ij:=$ij+<>te_Niveau{$ii}
			End for 
			If ($ij>0) & ($ij<Size of array:C274(<>ta_Niveau))
				For ($ii; 1; Size of array:C274(<>ta_Niveau))
					//Si (◊te_Niveau{$ii}=1)  `15/11/2010
					If ($vbOK)
						QUERY SELECTION:C341([CentresLits:16];  | ; [CentresLits:16]CL_Niveau:17=$ii; *)
					Else 
						QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_Niveau:17=$ii; *)
					End if 
					$vbOK:=True:C214
					//Fin de si 
				End for 
				QUERY SELECTION:C341([CentresLits:16])
			End if 
		End if 
	End if 
	
	vL_NbFichesConso:=Records in selection:C76([CentresLits:16])
	If (vL_NbFichesConso>0)
		P_SommeLit(3)
		If (ve_TriConso=1)
			ORDER BY:C49([CentresLits:16]; [CentresLits:16]CL_Niveau:17; >; *)
			ORDER BY:C49([CentresLits:16]; [LesCentres:9]LC_Nom:4; >)
		Else 
			ORDER BY:C49([CentresLits:16]; [LesCentres:9]LC_Nom:4; >)
		End if 
		FIRST RECORD:C50([CentresLits:16])
		PREVIOUS RECORD:C110([CentresLits:16])
	End if 
End if 

