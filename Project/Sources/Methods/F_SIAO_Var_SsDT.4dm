//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_SIAO_Var_SsDT
//{
//{          Lundi 6 décembre 2010 à 12:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_POINTER:C301($4)
C_LONGINT:C283($5)
C_BOOLEAN:C305($vb_OK)
C_TEXT:C284($va_Theme; $va_SousTheme)
$va_Theme:=ta_SIAO_PageTitre{6}  //"ENDETTEMENT"

C_LONGINT:C283($ii; $vl_no; $vl_Fiches)

Case of 
	: ($1=0)
		C_LONGINT:C283(vl_Ss_DT_Editer)
		vl_Ss_DT_Editer:=0
		
		C_LONGINT:C283(vl_Ss_DT_Reference1; vl_Ss_DT_SIAO_ID1; vl_Ss_DT_SIAO_Personne_ID1)
		C_TEXT:C284(va_Ss_DT_Famille1; va_Ss_DT_Theme1; va_Ss_DT_SousTheme1)
		C_LONGINT:C283(vl_Ss_DT_Rang1)
		C_TEXT:C284(va_Ss_DT_Intitule1)
		C_REAL:C285(vr_Ss_DT_Montant1)
		C_DATE:C307(vd_Ss_DT_Debut1; vd_Ss_DT_Fin1)
		
		C_LONGINT:C283(vl_Ss_DT_Reference2; vl_Ss_DT_SIAO_ID2; vl_Ss_DT_SIAO_Personne_ID2)
		C_TEXT:C284(va_Ss_DT_Famille2; va_Ss_DT_Theme2; va_Ss_DT_SousTheme2)
		C_LONGINT:C283(vl_Ss_DT_Rang2)
		C_TEXT:C284(va_Ss_DT_Intitule2)
		C_REAL:C285(vr_Ss_DT_Montant2)
		C_DATE:C307(vd_Ss_DT_Debut2; vd_Ss_DT_Fin2)
		
		C_LONGINT:C283(vl_Ss_DT_Reference3; vl_Ss_DT_SIAO_ID3; vl_Ss_DT_SIAO_Personne_ID3)
		C_TEXT:C284(va_Ss_DT_Famille3; va_Ss_DT_Theme3; va_Ss_DT_SousTheme3)
		C_LONGINT:C283(vl_Ss_DT_Rang3)
		C_TEXT:C284(va_Ss_DT_Intitule3)
		C_REAL:C285(vr_Ss_DT_Montant3)
		C_DATE:C307(vd_Ss_DT_Debut3; vd_Ss_DT_Fin3)
		
		C_LONGINT:C283(vl_Ss_DT_Reference4; vl_Ss_DT_SIAO_ID4; vl_Ss_DT_SIAO_Personne_ID4)
		C_TEXT:C284(va_Ss_DT_Famille4; va_Ss_DT_Theme4; va_Ss_DT_SousTheme4)
		C_LONGINT:C283(vl_Ss_DT_Rang4)
		C_TEXT:C284(va_Ss_DT_Intitule4)
		C_REAL:C285(vr_Ss_DT_Montant4)
		C_DATE:C307(vd_Ss_DT_Debut4; vd_Ss_DT_Fin4)
		
		C_LONGINT:C283(vl_Ss_DT_Reference5; vl_Ss_DT_SIAO_ID5; vl_Ss_DT_SIAO_Personne_ID5)
		C_TEXT:C284(va_Ss_DT_Famille5; va_Ss_DT_Theme5; va_Ss_DT_SousTheme5)
		C_LONGINT:C283(vl_Ss_DT_Rang5)
		C_TEXT:C284(va_Ss_DT_Intitule5)
		C_REAL:C285(vr_Ss_DT_Montant5)
		C_DATE:C307(vd_Ss_DT_Debut5; vd_Ss_DT_Fin5)
		
		C_REAL:C285(vr_Ss_DT_MontantMois; vr_Ss_DT_MontantAnnuel)
		
		
		
		C_LONGINT:C283(vl_Ss_DT_Reference1_2; vl_Ss_DT_SIAO_ID1_2; vl_Ss_DT_SIAO_Personne_ID1_2)
		C_TEXT:C284(va_Ss_DT_Famille1_2; va_Ss_DT_Theme1_2; va_Ss_DT_SousTheme1_2)
		C_LONGINT:C283(vl_Ss_DT_Rang1_2)
		C_TEXT:C284(va_Ss_DT_Intitule1_2)
		C_REAL:C285(vr_Ss_DT_Montant1_2)
		C_DATE:C307(vd_Ss_DT_Debut1_2; vd_Ss_DT_Fin1_2)
		
		C_LONGINT:C283(vl_Ss_DT_Reference2_2; vl_Ss_DT_SIAO_ID2_2; vl_Ss_DT_SIAO_Personne_ID2_2)
		C_TEXT:C284(va_Ss_DT_Famille2_2; va_Ss_DT_Theme2_2; va_Ss_DT_SousTheme2_2)
		C_LONGINT:C283(vl_Ss_DT_Rang2_2)
		C_TEXT:C284(va_Ss_DT_Intitule2_2)
		C_REAL:C285(vr_Ss_DT_Montant2_2)
		C_DATE:C307(vd_Ss_DT_Debut2_2; vd_Ss_DT_Fin2_2)
		
		
		
		
		C_LONGINT:C283(vl_Ss_DTn_Reference1; vl_Ss_DTn_SIAO_ID1; vl_Ss_DTn_SIAO_Personne_ID1)
		C_TEXT:C284(va_Ss_DTn_Famille1; va_Ss_DTn_Theme1; va_Ss_DTn_SousTheme1)
		C_LONGINT:C283(vl_Ss_DTn_Rang1)
		C_TEXT:C284(vt_Ss_DTn_Note1)
		
	: ($1=1)
		For ($ii; 1; 5)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_Intitule"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vr_Ss_DT_Montant"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DT_Debut"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=!00-00-00!
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DT_Fin"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=!00-00-00!
		End for 
		
		
		
		vr_Ss_DT_MontantMois:=0
		vr_Ss_DT_MontantAnnuel:=0
		
		
		
		For ($ii; 1; 2)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_Reference"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_SIAO_ID"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_SIAO_Personne_ID"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_Famille"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_Theme"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_SousTheme"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_Rang"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_Intitule"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vr_Ss_DT_Montant"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DT_Debut"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=!00-00-00!
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DT_Fin"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=!00-00-00!
		End for 
		
		
		
		
		For ($ii; 1; 1)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DTn_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DTn_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DTn_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DTn_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DTn_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DTn_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DTn_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vt_Ss_DTn_Note"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
		End for 
		
		
		
	: ($1=2)
		READ WRITE:C146([SIAO_Situations:52])
		$vl_no:=Uut_NumerotePlus(->[SIAO_Situations:52]; 8)
		$va_SousTheme:="A"
		
		For ($ii; 1; 5)
			CREATE RECORD:C68([SIAO_Situations:52])
			MultiSoc_Init_Structure(->[SIAO_Situations:52])
			[SIAO_Situations:52]Ss_RéférenceID:1:=$vl_no
			[SIAO_Situations:52]Ss_SIAO_ID:2:=$3
			[SIAO_Situations:52]Ss_SIAO_Personne_ID:3:=$2
			[SIAO_Situations:52]Ss_Famille:4:=""
			[SIAO_Situations:52]Ss_Theme:5:=$va_Theme
			[SIAO_Situations:52]Ss_SousTheme:6:=$va_SousTheme
			[SIAO_Situations:52]Ss_Rang:7:=$ii
			[SIAO_Situations:52]Ss_Intitule:9:=""
			SAVE RECORD:C53([SIAO_Situations:52])
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
			UNLOAD RECORD:C212([SIAO_Situations:52])
			$vl_no:=$vl_no+1
		End for 
		
		$va_SousTheme:="B"
		
		For ($ii; 1; 2)
			CREATE RECORD:C68([SIAO_Situations:52])
			MultiSoc_Init_Structure(->[SIAO_Situations:52])
			[SIAO_Situations:52]Ss_RéférenceID:1:=$vl_no
			[SIAO_Situations:52]Ss_SIAO_ID:2:=$3
			[SIAO_Situations:52]Ss_SIAO_Personne_ID:3:=$2
			[SIAO_Situations:52]Ss_Famille:4:=""
			[SIAO_Situations:52]Ss_Theme:5:=$va_Theme
			[SIAO_Situations:52]Ss_SousTheme:6:=$va_SousTheme
			[SIAO_Situations:52]Ss_Rang:7:=$ii
			[SIAO_Situations:52]Ss_Intitule:9:=""
			SAVE RECORD:C53([SIAO_Situations:52])
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_Reference"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_SIAO_ID"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_SIAO_Personne_ID"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_Famille"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_Theme"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_SousTheme"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_Rang"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
			UNLOAD RECORD:C212([SIAO_Situations:52])
			$vl_no:=$vl_no+1
		End for 
		
		
		
		
		$va_SousTheme:="N"
		$ii:=1
		CREATE RECORD:C68([SIAO_Situations:52])
		MultiSoc_Init_Structure(->[SIAO_Situations:52])
		[SIAO_Situations:52]Ss_RéférenceID:1:=$vl_no
		[SIAO_Situations:52]Ss_SIAO_ID:2:=$3
		[SIAO_Situations:52]Ss_SIAO_Personne_ID:3:=$2
		[SIAO_Situations:52]Ss_Famille:4:=""
		[SIAO_Situations:52]Ss_Theme:5:=$va_Theme
		[SIAO_Situations:52]Ss_SousTheme:6:=$va_SousTheme
		[SIAO_Situations:52]Ss_Rang:7:=$ii
		[SIAO_Situations:52]Ss_Intitule:9:=""
		SAVE RECORD:C53([SIAO_Situations:52])
		<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DTn_Reference"+String:C10($ii))
		<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
		
		<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DTn_SIAO_ID"+String:C10($ii))
		<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
		
		<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DTn_SIAO_Personne_ID"+String:C10($ii))
		<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
		
		<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DTn_Famille"+String:C10($ii))
		<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
		
		<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DTn_Theme"+String:C10($ii))
		<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
		
		<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DTn_SousTheme"+String:C10($ii))
		<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
		
		<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DTn_Rang"+String:C10($ii))
		<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
		UNLOAD RECORD:C212([SIAO_Situations:52])
		READ ONLY:C145([SIAO_Situations:52])
		
		
	: ($1=3)
		$vb_OK:=F_SIAO_Var_SsDT(1; 0; 0; <>vp_SIAO_PointeurVide; 0)
		vr_Ss_DT_MontantMois:=0
		vr_Ss_DT_MontantAnnuel:=0
		
		$va_SousTheme:="A"
		If ($2>0)
			QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=$2; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_ID:2=$3; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=$va_Theme; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6=$va_SousTheme)
			If (Records in selection:C76([SIAO_Situations:52])>0)
				ORDER BY:C49([SIAO_Situations:52]; [SIAO_Situations:52]Ss_Rang:7; >)
				FIRST RECORD:C50([SIAO_Situations:52])
				$ii:=0
				Repeat 
					$ii:=$ii+1
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_Reference"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_SIAO_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_SIAO_Personne_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_Famille"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_Theme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_SousTheme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_Rang"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
					
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_Intitule"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule:9
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vr_Ss_DT_Montant"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Montant:26
					vr_Ss_DT_MontantMois:=vr_Ss_DT_MontantMois+[SIAO_Situations:52]Ss_Montant:26
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DT_Debut"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_debut:14
					
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DT_Fin"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_fin:16
					NEXT RECORD:C51([SIAO_Situations:52])
				Until (End selection:C36([SIAO_Situations:52]) | ($ii=5))
			End if 
		End if 
		
		
		vr_Ss_DT_MontantAnnuel:=vr_Ss_DT_MontantMois*12
		
		
		$va_SousTheme:="B"
		If ($2>0)
			QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=$2; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_ID:2=$3; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=$va_Theme; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6=$va_SousTheme)
			If (Records in selection:C76([SIAO_Situations:52])>0)
				ORDER BY:C49([SIAO_Situations:52]; [SIAO_Situations:52]Ss_Rang:7; >)
				FIRST RECORD:C50([SIAO_Situations:52])
				$ii:=0
				Repeat 
					$ii:=$ii+1
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_Reference"+String:C10($ii)+"_2")
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_SIAO_ID"+String:C10($ii)+"_2")
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_SIAO_Personne_ID"+String:C10($ii)+"_2")
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_Famille"+String:C10($ii)+"_2")
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_Theme"+String:C10($ii)+"_2")
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_SousTheme"+String:C10($ii)+"_2")
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DT_Rang"+String:C10($ii)+"_2")
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
					
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_Intitule"+String:C10($ii)+"_2")
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule:9
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vr_Ss_DT_Montant"+String:C10($ii)+"_2")
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Montant:26
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DT_Debut"+String:C10($ii)+"_2")
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_debut:14
					
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DT_Fin"+String:C10($ii)+"_2")
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_fin:16
					NEXT RECORD:C51([SIAO_Situations:52])
				Until (End selection:C36([SIAO_Situations:52]) | ($ii=2))
			End if 
		End if 
		
		
		$va_SousTheme:="N"
		If ($2>0)
			QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=$2; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_ID:2=$3; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=$va_Theme; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6=$va_SousTheme)
			If (Records in selection:C76([SIAO_Situations:52])>0)
				ORDER BY:C49([SIAO_Situations:52]; [SIAO_Situations:52]Ss_Rang:7; >)
				FIRST RECORD:C50([SIAO_Situations:52])
				$ii:=0
				Repeat 
					$ii:=$ii+1
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DTn_Reference"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DTn_SIAO_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DTn_SIAO_Personne_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DTn_Famille"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DTn_Theme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DTn_SousTheme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DTn_Rang"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vt_Ss_DTn_Note"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Note:30
					NEXT RECORD:C51([SIAO_Situations:52])
				Until (End selection:C36([SIAO_Situations:52]) | ($ii=1))
			End if 
		End if 
		
		
	: ($1=4)
		$va_SousTheme:="A"
		$vb_OK:=F_SIAO_Situation(1; $2; $3; $va_Theme; $va_SousTheme; 1; 5)
		$va_SousTheme:="B"
		$vb_OK:=F_SIAO_Situation(1; $2; $3; $va_Theme; $va_SousTheme; 1; 2)
		$va_SousTheme:="N"
		$vb_OK:=F_SIAO_Situation(1; $2; $3; $va_Theme; $va_SousTheme; 1; 1)
		
		
		
		
	: ($1=10)
		READ WRITE:C146([SIAO_Situations:52])
		QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_RéférenceID:1=$2)
		If (Records in selection:C76([SIAO_Situations:52])=1)
			If (i_NonVerrou(->[SIAO_Situations:52]))
				Field:C253(Table:C252(->[SIAO_Situations:52]); $3)->:=$4->
				
				SAVE RECORD:C53([SIAO_Situations:52])
			End if 
			UNLOAD RECORD:C212([SIAO_Situations:52])
			$0:=True:C214
		End if 
		READ ONLY:C145([SIAO_Situations:52])
		
		
	: ($1=11)
		$vb_OK:=($2=1)
		If ($vb_OK)
			OBJECT SET ENABLED:C1123(vl_Ss_DT_Editer; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(vl_Ss_DT_Editer; False:C215)
		End if 
		
		For ($ii; 1; 5)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_Intitule"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vr_Ss_DT_Montant"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DT_Debut"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DT_Fin"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
		End for 
		
		For ($ii; 1; 2)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DT_Intitule"+String:C10($ii)+"_2")
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vr_Ss_DT_Montant"+String:C10($ii)+"_2")
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DT_Debut"+String:C10($ii)+"_2")
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DT_Fin"+String:C10($ii)+"_2")
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
		End for 
		
		
		For ($ii; 1; 1)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vt_Ss_DTn_Note"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
		End for 
		
		
		
	: ($1=12)
		QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_ID:2=$2; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=$3; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=$va_Theme)
		$vl_Fiches:=Records in selection:C76([SIAO_Situations:52])
		$4->:="SIAO DT 6 : "+<>va_Tab+""+<>va_Tab+String:C10(Table:C252(->[SIAO_Situations:52]))+<>va_Tab+String:C10(Get last field number:C255(->[SIAO_Situations:52]))+<>va_Tab+String:C10($vl_Fiches)+<>va_CR
		If ($vl_Fiches>0)
			ORDER BY:C49([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SousTheme:6; >; *)
			ORDER BY:C49([SIAO_Situations:52]; [SIAO_Situations:52]Ss_Rang:7; >)
			Repeat 
				For ($ii; 1; Get last field number:C255(->[SIAO_Situations:52]))
					$4->:=$4->+Substring:C12(Field name:C257(Table:C252(->[SIAO_Situations:52]); $ii); 4)+<>va_Tab+F_ChampEnChaine(Table:C252(->[SIAO_Situations:52]); $ii)+<>va_Tab+String:C10(Table:C252(->[SIAO_Situations:52]))+<>va_Tab+String:C10($ii)+<>va_Tab+"0"+<>va_CR
				End for 
				NEXT RECORD:C51([SIAO_Situations:52])
			Until (End selection:C36([SIAO_Situations:52]))
		End if 
		
	: ($1=13)
		$vb_OK:=False:C215
		OBJECT SET ENTERABLE:C238(va_Ss_DT_Intitule1; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_DT_Intitule2; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_DT_Intitule3; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_DT_Intitule4; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_DT_Intitule5; $vb_OK)
		
		OBJECT SET ENTERABLE:C238(va_Ss_DT_Intitule1_2; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_DT_Intitule2_2; $vb_OK)
		
		
End case 