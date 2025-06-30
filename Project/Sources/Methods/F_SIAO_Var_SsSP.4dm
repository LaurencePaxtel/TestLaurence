//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_SIAO_Var_SsSP
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
$va_Theme:=ta_SIAO_PageTitre{4}  //"SITUATION PROFESSIONNELLE"

C_LONGINT:C283($ii; $vl_no; $vl_Fiches)
Case of 
	: ($1=0)
		C_LONGINT:C283(vl_Ss_SPa_Reference1)
		C_LONGINT:C283(vl_Ss_SPa_SIAO_ID1)
		C_LONGINT:C283(vl_Ss_SPa_SIAO_Personne_ID1)
		C_TEXT:C284(va_Ss_SPa_Famille1; va_Ss_SPa_Theme1; va_Ss_SPa_SousTheme1)
		C_LONGINT:C283(vl_Ss_SPa_Rang1)
		C_TEXT:C284(va_Ss_SPa_Intitule1)
		C_BOOLEAN:C305(vb_Ss_SPa_CheckA_1)
		C_LONGINT:C283(vl_Ss_SPa_CheckA_1)
		C_TIME:C306(vh_Ss_SPa_Heure_1)
		C_BOOLEAN:C305(vb_Ss_SPa_CheckB_1)
		C_LONGINT:C283(vl_Ss_SPa_CheckB_1)
		C_DATE:C307(vd_Ss_SPa_Debut1; vd_Ss_SPa_Fin1)
		C_TEXT:C284(va_Ss_SPa_Intitule1_2; va_Ss_SPa_Intitule1_3; va_Ss_SPa_Intitule1_4)
		
		C_LONGINT:C283(vl_Ss_SPa_Reference2)
		C_LONGINT:C283(vl_Ss_SPa_SIAO_ID2)
		C_LONGINT:C283(vl_Ss_SPa_SIAO_Personne_ID2)
		C_TEXT:C284(va_Ss_SPa_Famille2; va_Ss_SPa_Theme2; va_Ss_SPa_SousTheme2)
		C_LONGINT:C283(vl_Ss_SPa_Rang2)
		C_TEXT:C284(va_Ss_SPa_Intitule2)
		C_BOOLEAN:C305(vb_Ss_SPa_CheckA_2)
		C_LONGINT:C283(vl_Ss_SPa_CheckA_2)
		C_TIME:C306(vh_Ss_SPa_Heure_2)
		C_BOOLEAN:C305(vb_Ss_SPa_CheckB_2)
		C_LONGINT:C283(vl_Ss_SPa_CheckB_2)
		C_DATE:C307(vd_Ss_SPa_Debut2; vd_Ss_SPa_Fin2)
		C_TEXT:C284(va_Ss_SPa_Intitule2_2; va_Ss_SPa_Intitule2_3; va_Ss_SPa_Intitule2_4)
		
		
		C_LONGINT:C283(vl_Ss_SPb_Reference1)
		C_LONGINT:C283(vl_Ss_SPb_SIAO_ID1)
		C_LONGINT:C283(vl_Ss_SPb_SIAO_Personne_ID1)
		C_TEXT:C284(va_Ss_SPb_Famille1; va_Ss_SPb_Theme1; va_Ss_SPb_SousTheme1)
		C_LONGINT:C283(vl_Ss_SPb_Rang1)
		C_TEXT:C284(va_Ss_SPb_Intitule1)
		C_DATE:C307(vd_Ss_SPb_Debut1)
		C_TEXT:C284(va_Ss_SPb_Intitule1_2)
		
		
		C_LONGINT:C283(vl_Ss_SPc_Reference1)
		C_LONGINT:C283(vl_Ss_SPc_SIAO_ID1)
		C_LONGINT:C283(vl_Ss_SPc_SIAO_Personne_ID1)
		C_TEXT:C284(va_Ss_SPc_Famille1; va_Ss_SPc_Theme1; va_Ss_SPc_SousTheme1)
		C_LONGINT:C283(vl_Ss_SPc_Rang1)
		C_TEXT:C284(va_Ss_SPc_Intitule1)
		
		
	: ($1=1)
		For ($ii; 1; 2)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Intitule"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vb_Ss_SPa_CheckA_"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=False:C215
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_CheckA_"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vh_Ss_SPa_Heure_"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=?00:00:00?
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vb_Ss_SPa_CheckB_"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=False:C215
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_CheckB_"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_SPa_Debut"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=!00-00-00!
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_SPa_Fin"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=!00-00-00!
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Intitule"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Intitule"+String:C10($ii)+"_3")
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Intitule"+String:C10($ii)+"_4")
			<>vp_SIAO_PointeurTemp->:=""
		End for 
		
		
		vl_Ss_SPb_Reference1:=0
		vl_Ss_SPb_SIAO_ID1:=0
		vl_Ss_SPb_SIAO_Personne_ID1:=0
		va_Ss_SPb_Famille1:=""
		va_Ss_SPb_Theme1:=""
		va_Ss_SPb_SousTheme1:=""
		vl_Ss_SPb_Rang1:=0
		va_Ss_SPb_Intitule1:=""
		vd_Ss_SPb_Debut1:=!00-00-00!
		va_Ss_SPb_Intitule1_2:=""
		
		
		vl_Ss_SPc_Reference1:=0
		vl_Ss_SPc_SIAO_ID1:=0
		vl_Ss_SPc_SIAO_Personne_ID1:=0
		va_Ss_SPc_Famille1:=""
		va_Ss_SPc_Theme1:=""
		va_Ss_SPc_SousTheme1:=""
		vl_Ss_SPc_Rang1:=0
		va_Ss_SPc_Intitule1:=""
		
		
	: ($1=2)
		READ WRITE:C146([SIAO_Situations:52])
		$vl_no:=Uut_NumerotePlus(->[SIAO_Situations:52]; 4)
		
		$va_SousTheme:="A"
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
			[SIAO_Situations:52]Ss_Check_1:11:=False:C215
			[SIAO_Situations:52]Ss_Heure_de_debut:32:=?00:00:00?
			[SIAO_Situations:52]Ss_Check_2:12:=False:C215
			[SIAO_Situations:52]Ss_Date_de_debut:14:=!00-00-00!
			[SIAO_Situations:52]Ss_Date_de_fin:16:=!00-00-00!
			SAVE RECORD:C53([SIAO_Situations:52])
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Intitule"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule:9
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vb_Ss_SPa_CheckA_"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Check_1:11
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_CheckA_"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=Num:C11([SIAO_Situations:52]Ss_Check_1:11)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vh_Ss_SPa_Heure_"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Heure_de_debut:32
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vb_Ss_SPa_CheckB_"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Check_2:12
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_CheckB_"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=Num:C11([SIAO_Situations:52]Ss_Check_2:12)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_SPa_Debut"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_debut:14
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_SPa_Fin"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_fin:16
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Intitule"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule_2:37
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Intitule"+String:C10($ii)+"_3")
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule_3:38
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Intitule"+String:C10($ii)+"_4")
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule_4:39
			
			UNLOAD RECORD:C212([SIAO_Situations:52])
			$vl_no:=$vl_no+1
		End for 
		
		$va_SousTheme:="B"
		For ($ii; 1; 1)
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
			[SIAO_Situations:52]Ss_Intitule_2:37:=""
			[SIAO_Situations:52]Ss_Date_de_debut:14:=!00-00-00!
			SAVE RECORD:C53([SIAO_Situations:52])
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPb_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPb_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPb_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPb_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPb_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPb_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPb_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPb_Intitule"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule:9
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_SPb_Debut"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_debut:14
			
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPb_Intitule"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule_2:37
			UNLOAD RECORD:C212([SIAO_Situations:52])
			$vl_no:=$vl_no+1
		End for 
		
		$va_SousTheme:="C"
		For ($ii; 1; 1)
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
			[SIAO_Situations:52]Ss_Date_de_debut:14:=!00-00-00!
			SAVE RECORD:C53([SIAO_Situations:52])
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPc_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPc_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPc_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPc_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPc_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPc_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPc_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPc_Intitule"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule:9
			UNLOAD RECORD:C212([SIAO_Situations:52])
			$vl_no:=$vl_no+1
		End for 
		
		UNLOAD RECORD:C212([SIAO_Situations:52])
		READ ONLY:C145([SIAO_Situations:52])
		
	: ($1=3)
		$vb_OK:=F_SIAO_Var_SsSP(1; 0; 0; <>vp_SIAO_PointeurVide; 0)
		
		$va_SousTheme:="A"
		If ($2>0)
			QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=$2; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_ID:2=$3; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=$va_Theme; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6=$va_SousTheme)
			If (Records in selection:C76([SIAO_Situations:52])>0)
				ORDER BY:C49([SIAO_Situations:52]; [SIAO_Situations:52]Ss_Rang:7; >)
				//FIRST RECORD([SIAO_Situations])
				$ii:=0
				Repeat 
					$ii:=$ii+1
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_Reference"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_SIAO_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_SIAO_Personne_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Famille"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Theme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_SousTheme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_Rang"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Intitule"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule:9
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vb_Ss_SPa_CheckA_"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Check_1:11
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_CheckA_"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=Num:C11([SIAO_Situations:52]Ss_Check_1:11)
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vh_Ss_SPa_Heure_"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Heure_de_debut:32
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vb_Ss_SPa_CheckB_"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Check_2:12
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_CheckB_"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=Num:C11([SIAO_Situations:52]Ss_Check_2:12)
					
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_SPa_Debut"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_debut:14
					
					
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_SPa_Fin"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_fin:16
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Intitule"+String:C10($ii)+"_2")
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule_2:37
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Intitule"+String:C10($ii)+"_3")
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule_3:38
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Intitule"+String:C10($ii)+"_4")
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule_4:39
					
					NEXT RECORD:C51([SIAO_Situations:52])
				Until (End selection:C36([SIAO_Situations:52]) | ($ii=2))
			End if 
		End if 
		
		
		$va_SousTheme:="B"
		If ($2>0)
			QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=$2; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_ID:2=$3; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=$va_Theme; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6=$va_SousTheme)
			If (Records in selection:C76([SIAO_Situations:52])>0)
				ORDER BY:C49([SIAO_Situations:52]; [SIAO_Situations:52]Ss_Rang:7; >)
				//FIRST RECORD([SIAO_Situations])
				$ii:=0
				Repeat 
					$ii:=$ii+1
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPb_Reference"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPb_SIAO_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPb_SIAO_Personne_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPb_Famille"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPb_Theme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPb_SousTheme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPb_Rang"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPb_Intitule"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule:9
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_SPb_Debut"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_debut:14
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPb_Intitule"+String:C10($ii)+"_2")
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule_2:37
					NEXT RECORD:C51([SIAO_Situations:52])
				Until (End selection:C36([SIAO_Situations:52]) | ($ii=1))
			End if 
		End if 
		
		$va_SousTheme:="C"
		If ($2>0)
			QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=$2; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_ID:2=$3; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=$va_Theme; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6=$va_SousTheme)
			If (Records in selection:C76([SIAO_Situations:52])>0)
				ORDER BY:C49([SIAO_Situations:52]; [SIAO_Situations:52]Ss_Rang:7; >)
				//FIRST RECORD([SIAO_Situations])
				$ii:=0
				Repeat 
					$ii:=$ii+1
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPc_Reference"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPc_SIAO_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPc_SIAO_Personne_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPc_Famille"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPc_Theme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPc_SousTheme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPc_Rang"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPc_Intitule"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule:9
					NEXT RECORD:C51([SIAO_Situations:52])
				Until (End selection:C36([SIAO_Situations:52]) | ($ii=1))
			End if 
		End if 
		
	: ($1=4)
		$va_SousTheme:="A"
		$vb_OK:=F_SIAO_Situation(1; $2; $3; $va_Theme; $va_SousTheme; 1; 2)
		$va_SousTheme:="B"
		$vb_OK:=F_SIAO_Situation(1; $2; $3; $va_Theme; $va_SousTheme; 1; 1)
		$va_SousTheme:="C"
		$vb_OK:=F_SIAO_Situation(1; $2; $3; $va_Theme; $va_SousTheme; 1; 1)
		
	: ($1=10)
		
		READ WRITE:C146([SIAO_Situations:52])
		QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_RéférenceID:1=$2)
		
		If (Records in selection:C76([SIAO_Situations:52])=1)
			
			If (i_NonVerrou(->[SIAO_Situations:52]))
				//Field(Table(->[SIAO_Situations]);$3)->:=$4->
				
				C_POINTER:C301($P_Field)
				$P_Field:=Field:C253(Table:C252(->[SIAO_Situations:52]); $3)
				$P_Field->:=$4->
				
				SAVE RECORD:C53([SIAO_Situations:52])
				$0:=True:C214
			End if 
			UNLOAD RECORD:C212([SIAO_Situations:52])
		End if 
		READ ONLY:C145([SIAO_Situations:52])
		
		
		
	: ($1=11)
		$vb_OK:=($2=1)
		For ($ii; 1; 2)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Intitule"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_CheckA_"+String:C10($ii))
			If ($vb_OK)
				OBJECT SET ENABLED:C1123(<>vp_SIAO_PointeurTemp->; True:C214)
			Else 
				OBJECT SET ENABLED:C1123(<>vp_SIAO_PointeurTemp->; False:C215)
			End if 
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vh_Ss_SPa_Heure_"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_SPa_CheckB_"+String:C10($ii))
			If ($vb_OK)
				OBJECT SET ENABLED:C1123(<>vp_SIAO_PointeurTemp->; True:C214)
			Else 
				OBJECT SET ENABLED:C1123(<>vp_SIAO_PointeurTemp->; False:C215)
			End if 
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_SPa_Debut"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_SPa_Fin"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Intitule"+String:C10($ii)+"_2")
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Intitule"+String:C10($ii)+"_3")
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_SPa_Intitule"+String:C10($ii)+"_4")
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
		End for 
		
		
		OBJECT SET ENTERABLE:C238(va_Ss_SPb_Intitule1; $vb_OK)
		OBJECT SET ENTERABLE:C238(vd_Ss_SPb_Debut1; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_SPb_Intitule1_2; $vb_OK)
		
		
		OBJECT SET ENTERABLE:C238(va_Ss_SPc_Intitule1; $vb_OK)
		
		
		
	: ($1=12)
		QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_ID:2=$2; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=$3; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=$va_Theme)
		$vl_Fiches:=Records in selection:C76([SIAO_Situations:52])
		$4->:="SIAO SP 4 : "+<>va_Tab+""+<>va_Tab+String:C10(Table:C252(->[SIAO_Situations:52]))+<>va_Tab+String:C10(Get last field number:C255(->[SIAO_Situations:52]))+<>va_Tab+String:C10($vl_Fiches)+<>va_CR
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
		OBJECT SET ENTERABLE:C238(va_Ss_SPa_Intitule1; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_SPa_Intitule2; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_SPb_Intitule1; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_SPc_Intitule1; $vb_OK)
End case 