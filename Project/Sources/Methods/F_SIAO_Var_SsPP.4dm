//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_SIAO_Var_SsPP
//{
//{          Lundi 3 janvier 2011 à 12:00
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
$va_Theme:=ta_SIAO_PageTitre{12}  //"PROPOSITIONS"

C_LONGINT:C283($ii; $vl_no; $vl_Fiches)

Case of 
	: ($1=0)
		C_LONGINT:C283(vl_Ss_PPa_Reference1)
		C_LONGINT:C283(vl_Ss_PPa_SIAO_ID1)
		C_LONGINT:C283(vl_Ss_PPa_SIAO_Personne_ID1)
		C_TEXT:C284(va_Ss_PPa_Famille1; va_Ss_PPa_Theme1; va_Ss_PPa_SousTheme1)
		C_LONGINT:C283(vl_Ss_PPa_Rang1)
		C_DATE:C307(vd_Ss_PPa_Debut1)
		C_PICTURE:C286(vi_Ss_PPa_Signature1)
		
		
		C_LONGINT:C283(vl_Ss_PPb_Reference1)
		C_LONGINT:C283(vl_Ss_PPb_SIAO_ID1)
		C_LONGINT:C283(vl_Ss_PPb_SIAO_Personne_ID1)
		C_TEXT:C284(va_Ss_PPb_Famille1; va_Ss_PPb_Theme1; va_Ss_PPb_SousTheme1)
		C_LONGINT:C283(vl_Ss_PPb_Rang1)
		C_TEXT:C284(va_Ss_PPb_Intitule1)
		C_TEXT:C284(va_Ss_PPb_Intitule1_2)
		
		C_LONGINT:C283(vl_Ss_PPb_Reference2)
		C_LONGINT:C283(vl_Ss_PPb_SIAO_ID2)
		C_LONGINT:C283(vl_Ss_PPb_SIAO_Personne_ID2)
		C_TEXT:C284(va_Ss_PPb_Famille2; va_Ss_PPb_Theme2; va_Ss_PPb_SousTheme2)
		C_LONGINT:C283(vl_Ss_PPb_Rang2)
		C_TEXT:C284(va_Ss_PPb_Intitule2)
		C_TEXT:C284(va_Ss_PPb_Intitule2_2)
		
		C_LONGINT:C283(vl_Ss_PPb_Reference3)
		C_LONGINT:C283(vl_Ss_PPb_SIAO_ID3)
		C_LONGINT:C283(vl_Ss_PPb_SIAO_Personne_ID3)
		C_TEXT:C284(va_Ss_PPb_Famille3; va_Ss_PPb_Theme3; va_Ss_PPb_SousTheme3)
		C_LONGINT:C283(vl_Ss_PPb_Rang3)
		C_TEXT:C284(va_Ss_PPb_Intitule3)
		C_TEXT:C284(va_Ss_PPb_Intitule3_2)
		
		
		C_LONGINT:C283(vl_Ss_PPc_Reference1)
		C_LONGINT:C283(vl_Ss_PPc_SIAO_ID1)
		C_LONGINT:C283(vl_Ss_PPc_SIAO_Personne_ID1)
		C_TEXT:C284(va_Ss_PPc_Famille1; va_Ss_PPc_Theme1; va_Ss_PPc_SousTheme1)
		C_LONGINT:C283(vl_Ss_PPc_Rang1)
		C_TEXT:C284(va_Ss_PPc_Intitule1)
		C_TEXT:C284(va_Ss_PPc_Intitule1_2)
		
		C_LONGINT:C283(vl_Ss_PPc_Reference2)
		C_LONGINT:C283(vl_Ss_PPc_SIAO_ID2)
		C_LONGINT:C283(vl_Ss_PPc_SIAO_Personne_ID2)
		C_TEXT:C284(va_Ss_PPc_Famille2; va_Ss_PPc_Theme2; va_Ss_PPc_SousTheme2)
		C_LONGINT:C283(vl_Ss_PPc_Rang2)
		C_TEXT:C284(va_Ss_PPc_Intitule2)
		C_TEXT:C284(va_Ss_PPc_Intitule2_2)
		
		C_LONGINT:C283(vl_Ss_PPc_Reference3)
		C_LONGINT:C283(vl_Ss_PPc_SIAO_ID3)
		C_LONGINT:C283(vl_Ss_PPc_SIAO_Personne_ID3)
		C_TEXT:C284(va_Ss_PPc_Famille3; va_Ss_PPc_Theme3; va_Ss_PPc_SousTheme3)
		C_LONGINT:C283(vl_Ss_PPc_Rang3)
		C_TEXT:C284(va_Ss_PPc_Intitule3)
		C_TEXT:C284(va_Ss_PPc_Intitule3_2)
		
		
		C_LONGINT:C283(vl_Ss_PPn_Reference1)
		C_LONGINT:C283(vl_Ss_PPn_SIAO_ID1)
		C_LONGINT:C283(vl_Ss_PPn_SIAO_Personne_ID1)
		C_TEXT:C284(va_Ss_PPn_Famille1; va_Ss_PPn_Theme1; va_Ss_PPn_SousTheme1)
		C_LONGINT:C283(vl_Ss_PPn_Rang1)
		C_TEXT:C284(vt_Ss_PPn_Note1)
		
		C_LONGINT:C283(vl_Ss_PPn_Reference2)
		C_LONGINT:C283(vl_Ss_PPn_SIAO_ID2)
		C_LONGINT:C283(vl_Ss_PPn_SIAO_Personne_ID2)
		C_TEXT:C284(va_Ss_PPn_Famille2; va_Ss_PPn_Theme2; va_Ss_PPn_SousTheme2)
		C_LONGINT:C283(vl_Ss_PPn_Rang2)
		C_TEXT:C284(vt_Ss_PPn_Note2)
		
	: ($1=1)
		vl_Ss_PPa_Reference1:=0
		vl_Ss_PPa_SIAO_ID1:=0
		vl_Ss_PPa_SIAO_Personne_ID1:=0
		va_Ss_PPa_Famille1:=""
		va_Ss_PPa_Theme1:=""
		va_Ss_PPa_SousTheme1:=""
		vl_Ss_PPa_Rang1:=0
		vd_Ss_PPa_Debut1:=!00-00-00!
		vi_Ss_PPa_Signature1:=<>vi_Vide
		
		For ($ii; 1; 3)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPb_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPb_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPb_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPb_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPb_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPb_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPb_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPb_Intitule"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPb_Intitule"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=""
		End for 
		
		For ($ii; 1; 3)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPc_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPc_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPc_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPc_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPc_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPc_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPb_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPc_Intitule"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPc_Intitule"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=""
		End for 
		
		For ($ii; 1; 2)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPn_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPn_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPn_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPn_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPn_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPn_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPn_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vt_Ss_PPn_Note"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
		End for 
		
	: ($1=2)
		
		READ WRITE:C146([SIAO_Situations:52])
		$vl_no:=Uut_NumerotePlus(->[SIAO_Situations:52]; 7)
		
		$va_SousTheme:="A"
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
			[SIAO_Situations:52]Ss_Commentaire:22:=""
			SAVE RECORD:C53([SIAO_Situations:52])
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPa_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPa_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPa_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPa_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPa_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPa_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPa_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_PPa_Debut"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_debut:14
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vi_Ss_PPa_Signature"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Image:36
			UNLOAD RECORD:C212([SIAO_Situations:52])
			$vl_no:=$vl_no+1
		End for 
		
		$va_SousTheme:="B"
		For ($ii; 1; 3)
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
			[SIAO_Situations:52]Ss_Commentaire:22:=""
			SAVE RECORD:C53([SIAO_Situations:52])
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPb_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPb_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPb_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPb_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPb_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPb_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPb_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPb_Intitule"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule:9
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPb_Intitule"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule_2:37
			
			UNLOAD RECORD:C212([SIAO_Situations:52])
			$vl_no:=$vl_no+1
		End for 
		
		$va_SousTheme:="C"
		For ($ii; 1; 3)
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
			[SIAO_Situations:52]Ss_Commentaire:22:=""
			SAVE RECORD:C53([SIAO_Situations:52])
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPc_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPc_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPc_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPc_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPc_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPc_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPc_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPc_Intitule"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule:9
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPc_Intitule"+String:C10($ii)+"_2")
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule_2:37
			
			UNLOAD RECORD:C212([SIAO_Situations:52])
			$vl_no:=$vl_no+1
		End for 
		
		UNLOAD RECORD:C212([SIAO_Situations:52])
		READ ONLY:C145([SIAO_Situations:52])
		
	: ($1=3)
		$vb_OK:=F_SIAO_Var_SsPP(1; 0; 0; <>vp_SIAO_PointeurVide; 0)
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
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPa_Reference"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPa_SIAO_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPa_SIAO_Personne_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPa_Famille"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPa_Theme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPa_SousTheme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPa_Rang"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_PPa_Debut"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_debut:14
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vi_Ss_PPa_Signature"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Image:36
					
					NEXT RECORD:C51([SIAO_Situations:52])
				Until (End selection:C36([SIAO_Situations:52]) | ($ii=1))
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
				FIRST RECORD:C50([SIAO_Situations:52])
				$ii:=0
				Repeat 
					$ii:=$ii+1
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPb_Reference"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPb_SIAO_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPb_SIAO_Personne_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPb_Famille"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPb_Theme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPb_SousTheme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPb_Rang"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPb_Intitule"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule:9
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPb_Intitule"+String:C10($ii)+"_2")
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule_2:37
					NEXT RECORD:C51([SIAO_Situations:52])
				Until (End selection:C36([SIAO_Situations:52]) | ($ii=3))
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
				FIRST RECORD:C50([SIAO_Situations:52])
				$ii:=0
				Repeat 
					$ii:=$ii+1
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPc_Reference"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPc_SIAO_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPc_SIAO_Personne_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPc_Famille"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPc_Theme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPc_SousTheme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_PPc_Rang"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPc_Intitule"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule:9
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPc_Intitule"+String:C10($ii)+"_2")
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule_2:37
					NEXT RECORD:C51([SIAO_Situations:52])
				Until (End selection:C36([SIAO_Situations:52]) | ($ii=3))
			End if 
		End if 
		
		
		
	: ($1=4)
		$va_SousTheme:="A"
		$vb_OK:=F_SIAO_Situation(1; $2; $3; $va_Theme; $va_SousTheme; 1; 1)
		$va_SousTheme:="B"
		$vb_OK:=F_SIAO_Situation(1; $2; $3; $va_Theme; $va_SousTheme; 1; 3)
		$va_SousTheme:="C"
		$vb_OK:=F_SIAO_Situation(1; $2; $3; $va_Theme; $va_SousTheme; 1; 3)
		
		
	: ($1=10)
		READ WRITE:C146([SIAO_Situations:52])
		QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_RéférenceID:1=$2)
		If (Records in selection:C76([SIAO_Situations:52])=1)
			If (i_NonVerrou(->[SIAO_Situations:52]))
				
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
		//CHOIX SAISISSABLE(vd_Ss_PPa_Debut1;$vb_OK)
		//CHOIX SAISISSABLE(vi_Ss_PPa_Signature1;$vb_OK)
		
		For ($ii; 1; 3)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPb_Intitule"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPb_Intitule"+String:C10($ii)+"_2")
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
		End for 
		
		For ($ii; 1; 3)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPc_Intitule"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_PPc_Intitule"+String:C10($ii)+"_2")
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
		End for 
		
		For ($ii; 1; 2)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vt_Ss_PPn_Note"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
		End for 
		
		
		
	: ($1=12)
		QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_ID:2=$2; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=$3; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=$va_Theme)
		$vl_Fiches:=Records in selection:C76([SIAO_Situations:52])
		$4->:="SIAO PP 12 : "+<>va_Tab+""+<>va_Tab+String:C10(Table:C252(->[SIAO_Situations:52]))+<>va_Tab+String:C10(Get last field number:C255(->[SIAO_Situations:52]))+<>va_Tab+String:C10($vl_Fiches)+<>va_CR
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
		OBJECT SET ENTERABLE:C238(va_Ss_PPb_Intitule1; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_PPb_Intitule2; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_PPb_Intitule3; $vb_OK)
		
		OBJECT SET ENTERABLE:C238(va_Ss_PPc_Intitule1; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_PPc_Intitule2; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_PPc_Intitule3; $vb_OK)
		
End case 
