//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_PRO_Famille 
//{
//{          Lundi 10 janvier 2005 à 15:23:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_TEXT:C284($va_HGGP_FamCompo)
C_TEXT:C284($va_HGGP_FamCompoV)

Case of 
		
	: ($1=0)
		<>ve_FamH:=0
		<>ve_FamF:=0
		<>ve_FamFe:=0
		<>ve_FamEMi:=0
		<>ve_FamEMa:=0
		<>ve_FamPMi:=0
		<>ve_FamPMa:=0
		
	: ($1=1)
		$va_HGGP_FamCompoV:=$3->
		If ($va_HGGP_FamCompoV>"")
			<>ve_FamH:=Num:C11(Substring:C12($va_HGGP_FamCompoV; 2; 1))
			<>ve_FamF:=Num:C11(Substring:C12($va_HGGP_FamCompoV; 4; 1))
			<>ve_FamFe:=Num:C11(Substring:C12($va_HGGP_FamCompoV; 6; 1))
			<>ve_FamEMi:=Num:C11(Substring:C12($va_HGGP_FamCompoV; 8; 2))
			<>ve_FamEMa:=Num:C11(Substring:C12($va_HGGP_FamCompoV; 11; 2))
			<>ve_FamPMi:=Num:C11(Substring:C12($va_HGGP_FamCompoV; 14; 1))
			<>ve_FamPMa:=Num:C11(Substring:C12($va_HGGP_FamCompoV; 16; 1))
		Else 
			<>ve_FamH:=0
			<>ve_FamF:=0
			<>ve_FamFe:=0
			<>ve_FamEMi:=0
			<>ve_FamEMa:=0
			<>ve_FamPMi:=0
			<>ve_FamPMa:=0
		End if 
		
	: ($1=2)
		$4->:=<>ve_FamH+<>ve_FamF+<>ve_FamFe+<>ve_FamEMi+<>ve_FamEMa+<>ve_FamPMi+<>ve_FamPMa
		
		$va_HGGP_FamCompoV:=""
		$va_HGGP_FamCompoV:="H"+String:C10(<>ve_FamH)
		$va_HGGP_FamCompoV:=$va_HGGP_FamCompoV+"F"+String:C10(<>ve_FamF)
		$va_HGGP_FamCompoV:=$va_HGGP_FamCompoV+"B"+String:C10(<>ve_FamFe)
		$va_HGGP_FamCompoV:=$va_HGGP_FamCompoV+"e"+String:C10(<>ve_FamEMi; "00")
		$va_HGGP_FamCompoV:=$va_HGGP_FamCompoV+"E"+String:C10(<>ve_FamEMa; "00")
		$va_HGGP_FamCompoV:=$va_HGGP_FamCompoV+"p"+String:C10(<>ve_FamPMi)
		$va_HGGP_FamCompoV:=$va_HGGP_FamCompoV+"P"+String:C10(<>ve_FamPMa)
		$3->:=$va_HGGP_FamCompoV
		
		$va_HGGP_FamCompo:=""
		If (<>ve_FamH>0)
			$va_HGGP_FamCompo:="H"
		End if 
		If (<>ve_FamF>0)
			If ($va_HGGP_FamCompo>"")
				$va_HGGP_FamCompo:=$va_HGGP_FamCompo+"+"
			End if 
			$va_HGGP_FamCompo:=$va_HGGP_FamCompo+"F"
		End if 
		
		If (<>ve_FamFe>0)
			If ($va_HGGP_FamCompo>"")
				$va_HGGP_FamCompo:=$va_HGGP_FamCompo+"+"
			End if 
			$va_HGGP_FamCompo:=$va_HGGP_FamCompo+"Fe"
		End if 
		
		If (<>ve_FamEMi>0)
			If ($va_HGGP_FamCompo>"")
				$va_HGGP_FamCompo:=$va_HGGP_FamCompo+"+"
			End if 
			$va_HGGP_FamCompo:=$va_HGGP_FamCompo+String:C10(<>ve_FamEMi)+"Em"
		End if 
		
		If (<>ve_FamEMa>0)
			If ($va_HGGP_FamCompo>"")
				$va_HGGP_FamCompo:=$va_HGGP_FamCompo+"+"
			End if 
			$va_HGGP_FamCompo:=$va_HGGP_FamCompo+String:C10(<>ve_FamEMa)+"EM"
		End if 
		
		If (<>ve_FamPMi>0)
			If ($va_HGGP_FamCompo>"")
				$va_HGGP_FamCompo:=$va_HGGP_FamCompo+"+"
			End if 
			$va_HGGP_FamCompo:=$va_HGGP_FamCompo+String:C10(<>ve_FamPMi)+"Pm"
		End if 
		
		If (<>ve_FamPMa>0)
			If ($va_HGGP_FamCompo>"")
				$va_HGGP_FamCompo:=$va_HGGP_FamCompo+"+"
			End if 
			$va_HGGP_FamCompo:=$va_HGGP_FamCompo+String:C10(<>ve_FamPMa)+"PM"
		End if 
		$2->:=$va_HGGP_FamCompo
		
		
	: ($1=3)
		$va_HGGP_FamCompoV:=""
		$va_HGGP_FamCompoV:="H"+String:C10(<>ve_FamH)
		$va_HGGP_FamCompoV:=$va_HGGP_FamCompoV+"F"+String:C10(<>ve_FamF)
		$va_HGGP_FamCompoV:=$va_HGGP_FamCompoV+"B"+String:C10(<>ve_FamFe)
		$va_HGGP_FamCompoV:=$va_HGGP_FamCompoV+"e"+String:C10(<>ve_FamEMi; "00")
		$va_HGGP_FamCompoV:=$va_HGGP_FamCompoV+"E"+String:C10(<>ve_FamEMa; "00")
		$va_HGGP_FamCompoV:=$va_HGGP_FamCompoV+"p"+String:C10(<>ve_FamPMi)
		$va_HGGP_FamCompoV:=$va_HGGP_FamCompoV+"P"+String:C10(<>ve_FamPMa)
		$3->:=$va_HGGP_FamCompoV
End case 