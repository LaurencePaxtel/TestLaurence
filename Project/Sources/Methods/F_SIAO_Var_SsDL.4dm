//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_SIAO_Var_SsDL
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
$va_Theme:=ta_SIAO_PageTitre{8}  //"SITUATION EN REGARD DE LA DEMANDE DE LOGEMENT"

C_LONGINT:C283($ii; $vl_no; $vl_Fiches)

Case of 
	: ($1=0)
		C_LONGINT:C283(vl_Ss_DLa_Reference1)
		C_LONGINT:C283(vl_Ss_DLa_SIAO_ID1)
		C_LONGINT:C283(vl_Ss_DLa_SIAO_Personne_ID1)
		C_TEXT:C284(va_Ss_DLa_Famille1; va_Ss_DLa_Theme1; va_Ss_DLa_SousTheme1)
		C_LONGINT:C283(vl_Ss_DLa_Rang1)
		C_TEXT:C284(va_Ss_DLa_Intitule1)
		C_DATE:C307(vd_Ss_DLa_Debut1; vd_Ss_DLa_Fin1)
		C_LONGINT:C283(vl_Ss_DLa_Nombre1)
		
		C_LONGINT:C283(vl_Ss_DLa_Reference2)
		C_LONGINT:C283(vl_Ss_DLa_SIAO_ID2)
		C_LONGINT:C283(vl_Ss_DLa_SIAO_Personne_ID2)
		C_TEXT:C284(va_Ss_DLa_Famille2; va_Ss_DLa_Theme2; va_Ss_DLa_SousTheme2)
		C_LONGINT:C283(vl_Ss_DLa_Rang2)
		C_TEXT:C284(va_Ss_DLa_Intitule2)
		C_DATE:C307(vd_Ss_DLa_Debut2; vd_Ss_DLa_Fin2)
		C_LONGINT:C283(vl_Ss_DLa_Nombre2)
		
		
		C_LONGINT:C283(vl_Ss_DLb_Reference1)
		C_LONGINT:C283(vl_Ss_DLb_SIAO_ID1)
		C_LONGINT:C283(vl_Ss_DLb_SIAO_Personne_ID1)
		C_TEXT:C284(va_Ss_DLb_Famille1; va_Ss_DLb_Theme1; va_Ss_DLb_SousTheme1)
		C_LONGINT:C283(vl_Ss_DLb_Rang1)
		C_BOOLEAN:C305(vb_Ss_DLb_Check1)
		C_LONGINT:C283(vl_Ss_DLb_Check1)
		C_DATE:C307(vd_Ss_DLb_Debut1)
		C_TEXT:C284(va_Ss_DLb_Intitule1)
		
		C_LONGINT:C283(vl_Ss_DLb_Reference2)
		C_LONGINT:C283(vl_Ss_DLb_SIAO_ID2)
		C_LONGINT:C283(vl_Ss_DLb_SIAO_Personne_ID2)
		C_TEXT:C284(va_Ss_DLb_Famille2; va_Ss_DLb_Theme2; va_Ss_DLb_SousTheme2)
		C_LONGINT:C283(vl_Ss_DLb_Rang2)
		C_BOOLEAN:C305(vb_Ss_DLb_Check2)
		C_LONGINT:C283(vl_Ss_DLb_Check2)
		C_DATE:C307(vd_Ss_DLb_Debut2)
		C_TEXT:C284(va_Ss_DLb_Intitule2)
		
		C_LONGINT:C283(vl_Ss_DLb_Reference3)
		C_LONGINT:C283(vl_Ss_DLb_SIAO_ID3)
		C_LONGINT:C283(vl_Ss_DLb_SIAO_Personne_ID3)
		C_TEXT:C284(va_Ss_DLb_Famille3; va_Ss_DLb_Theme3; va_Ss_DLb_SousTheme3)
		C_LONGINT:C283(vl_Ss_DLb_Rang3)
		C_BOOLEAN:C305(vb_Ss_DLb_Check3)
		C_LONGINT:C283(vl_Ss_DLb_Check3)
		C_DATE:C307(vd_Ss_DLb_Debut3)
		C_TEXT:C284(va_Ss_DLb_Intitule3)
		
		C_LONGINT:C283(vl_Ss_DLb_Reference4)
		C_LONGINT:C283(vl_Ss_DLb_SIAO_ID4)
		C_LONGINT:C283(vl_Ss_DLb_SIAO_Personne_ID4)
		C_TEXT:C284(va_Ss_DLb_Famille4; va_Ss_DLb_Theme4; va_Ss_DLb_SousTheme4)
		C_LONGINT:C283(vl_Ss_DLb_Rang4)
		C_BOOLEAN:C305(vb_Ss_DLb_Check4)
		C_LONGINT:C283(vl_Ss_DLb_Check4)
		C_DATE:C307(vd_Ss_DLb_Debut4)
		C_TEXT:C284(va_Ss_DLb_Intitule4)
		
		C_LONGINT:C283(vl_Ss_DLb_Reference5)
		C_LONGINT:C283(vl_Ss_DLb_SIAO_ID5)
		C_LONGINT:C283(vl_Ss_DLb_SIAO_Personne_ID5)
		C_TEXT:C284(va_Ss_DLb_Famille5; va_Ss_DLb_Theme5; va_Ss_DLb_SousTheme5)
		C_LONGINT:C283(vl_Ss_DLb_Rang5)
		C_BOOLEAN:C305(vb_Ss_DLb_Check5)
		C_LONGINT:C283(vl_Ss_DLb_Check5)
		C_DATE:C307(vd_Ss_DLb_Debut5)
		C_TEXT:C284(va_Ss_DLb_Intitule5)
		
		C_LONGINT:C283(vl_Ss_DLb_Reference6)
		C_LONGINT:C283(vl_Ss_DLb_SIAO_ID6)
		C_LONGINT:C283(vl_Ss_DLb_SIAO_Personne_ID6)
		C_TEXT:C284(va_Ss_DLb_Famille6; va_Ss_DLb_Theme6; va_Ss_DLb_SousTheme6)
		C_LONGINT:C283(vl_Ss_DLb_Rang6)
		C_BOOLEAN:C305(vb_Ss_DLb_Check6)
		C_LONGINT:C283(vl_Ss_DLb_Check6)
		C_DATE:C307(vd_Ss_DLb_Debut6)
		C_TEXT:C284(va_Ss_DLb_Intitule6)
		
		C_LONGINT:C283(vl_Ss_DLb_Reference7)
		C_LONGINT:C283(vl_Ss_DLb_SIAO_ID7)
		C_LONGINT:C283(vl_Ss_DLb_SIAO_Personne_ID7)
		C_TEXT:C284(va_Ss_DLb_Famille7; va_Ss_DLb_Theme7; va_Ss_DLb_SousTheme7)
		C_LONGINT:C283(vl_Ss_DLb_Rang7)
		C_BOOLEAN:C305(vb_Ss_DLb_Check7)
		C_LONGINT:C283(vl_Ss_DLb_Check7)
		C_DATE:C307(vd_Ss_DLb_Debut7)
		C_TEXT:C284(va_Ss_DLb_Intitule7)
		
		
		
		
		C_LONGINT:C283(vl_Ss_DLc_Reference1)
		C_LONGINT:C283(vl_Ss_DLc_SIAO_ID1)
		C_LONGINT:C283(vl_Ss_DLc_SIAO_Personne_ID1)
		C_TEXT:C284(va_Ss_DLc_Famille1; va_Ss_DLc_Theme1; va_Ss_DLc_SousTheme1)
		C_LONGINT:C283(vl_Ss_DLc_Rang1)
		C_BOOLEAN:C305(vb_Ss_DLc_Check1)
		C_LONGINT:C283(vl_Ss_DLc_Check1)
		C_DATE:C307(vd_Ss_DLc_Debut1)
		C_TEXT:C284(vt_Ss_DLc_Referent1)
		
		C_LONGINT:C283(vl_Ss_DLc_Reference2)
		C_LONGINT:C283(vl_Ss_DLc_SIAO_ID2)
		C_LONGINT:C283(vl_Ss_DLc_SIAO_Personne_ID2)
		C_TEXT:C284(va_Ss_DLc_Famille2; va_Ss_DLc_Theme2; va_Ss_DLc_SousTheme2)
		C_LONGINT:C283(vl_Ss_DLc_Rang2)
		C_BOOLEAN:C305(vb_Ss_DLc_Check2)
		C_LONGINT:C283(vl_Ss_DLc_Check2)
		C_DATE:C307(vd_Ss_DLc_Debut2)
		C_TEXT:C284(vt_Ss_DLc_Referent2)
		
		
		C_LONGINT:C283(vl_Ss_DLn_Reference1)
		C_LONGINT:C283(vl_Ss_DLn_SIAO_ID1)
		C_LONGINT:C283(vl_Ss_DLn_SIAO_Personne_ID1)
		C_TEXT:C284(va_Ss_DLn_Famille1; va_Ss_DLn_Theme1; va_Ss_DLn_SousTheme1)
		C_LONGINT:C283(vl_Ss_DLn_Rang1)
		C_TEXT:C284(vt_Ss_DLn_Note1)
		
		
		
	: ($1=1)
		For ($ii; 1; 2)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLa_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLa_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLa_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLa_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLa_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLa_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLa_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLa_Intitule"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DLa_Debut"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=!00-00-00!
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DLa_Fin"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=!00-00-00!
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLa_Nombre"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
		End for 
		
		For ($ii; 1; 7)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLb_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLb_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLb_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLb_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLb_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLb_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLb_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLb_Intitule"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vb_Ss_DLb_Check"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=False:C215
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLb_Check"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DLb_Debut"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=!00-00-00!
		End for 
		
		For ($ii; 1; 2)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLc_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLc_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLc_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLc_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLc_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLc_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLc_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vb_Ss_DLc_Check"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=False:C215
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLc_Check"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DLc_Debut"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=!00-00-00!
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vt_Ss_DLc_Referent"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
		End for 
		
		vl_Ss_DLn_Reference1:=0
		vl_Ss_DLn_SIAO_ID1:=0
		vl_Ss_DLn_SIAO_Personne_ID1:=0
		va_Ss_DLn_Famille1:=""
		va_Ss_DLn_Theme1:=""
		va_Ss_DLn_SousTheme1:=""
		vl_Ss_DLn_Rang1:=0
		vt_Ss_DLn_Note1:=""
		
	: ($1=2)
		READ WRITE:C146([SIAO_Situations:52])
		$vl_no:=Uut_NumerotePlus(->[SIAO_Situations:52]; 12)
		
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
			[SIAO_Situations:52]Ss_Commentaire:22:=""
			
			
			SAVE RECORD:C53([SIAO_Situations:52])
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLa_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLa_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLa_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLa_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLa_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLa_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLa_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLa_Intitule"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule:9
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DLa_Debut"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_debut:14
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DLa_Fin"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_fin:16
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLa_Nombre"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Nombre:24
			UNLOAD RECORD:C212([SIAO_Situations:52])
			$vl_no:=$vl_no+1
		End for 
		
		$va_SousTheme:="B"
		For ($ii; 1; 7)
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
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLb_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLb_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLb_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLb_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLb_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLb_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLb_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLb_Intitule"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule:9
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vb_Ss_DLb_Check"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Check_1:11
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLb_Check"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=Num:C11([SIAO_Situations:52]Ss_Check_1:11)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DLb_Debut"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_debut:14
			UNLOAD RECORD:C212([SIAO_Situations:52])
			$vl_no:=$vl_no+1
		End for 
		
		$va_SousTheme:="C"
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
			[SIAO_Situations:52]Ss_Commentaire:22:=""
			[SIAO_Situations:52]Ss_Note:30:=""
			
			
			SAVE RECORD:C53([SIAO_Situations:52])
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLc_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLc_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLc_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLc_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLc_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLc_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLc_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vb_Ss_DLc_Check"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Check_1:11
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLc_Check"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=Num:C11([SIAO_Situations:52]Ss_Check_1:11)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DLc_Debut"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_debut:14
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vt_Ss_DLc_Referent"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Note:30
			UNLOAD RECORD:C212([SIAO_Situations:52])
			$vl_no:=$vl_no+1
		End for 
		
		$va_SousTheme:="N"
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
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLn_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLn_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLn_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLn_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLn_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLn_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLn_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vt_Ss_DLn_Note"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Note:30
			UNLOAD RECORD:C212([SIAO_Situations:52])
			$vl_no:=$vl_no+1
		End for 
		
		UNLOAD RECORD:C212([SIAO_Situations:52])
		READ ONLY:C145([SIAO_Situations:52])
		
	: ($1=3)
		$vb_OK:=F_SIAO_Var_SsDL(1; 0; 0; <>vp_SIAO_PointeurVide; 0)
		
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
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLa_Reference"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLa_SIAO_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLa_SIAO_Personne_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLa_Famille"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLa_Theme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLa_SousTheme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLa_Rang"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLa_Intitule"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule:9
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DLa_Debut"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_debut:14
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DLa_Fin"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_fin:16
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLa_Nombre"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Nombre:24
					
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
				FIRST RECORD:C50([SIAO_Situations:52])
				$ii:=0
				Repeat 
					$ii:=$ii+1
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLb_Reference"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLb_SIAO_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLb_SIAO_Personne_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLb_Famille"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLb_Theme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLb_SousTheme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLb_Rang"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLb_Intitule"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule:9
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vb_Ss_DLb_Check"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Check_1:11
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLb_Check"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=Num:C11([SIAO_Situations:52]Ss_Check_1:11)
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DLb_Debut"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_debut:14
					
					NEXT RECORD:C51([SIAO_Situations:52])
				Until (End selection:C36([SIAO_Situations:52]) | ($ii=7))
				
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
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLc_Reference"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLc_SIAO_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLc_SIAO_Personne_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLc_Famille"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLc_Theme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLc_SousTheme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLc_Rang"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vb_Ss_DLc_Check"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Check_1:11
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLc_Check"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=Num:C11([SIAO_Situations:52]Ss_Check_1:11)
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DLc_Debut"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_debut:14
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vt_Ss_DLc_Referent"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Note:30
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
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLn_Reference"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLn_SIAO_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLn_SIAO_Personne_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLn_Famille"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLn_Theme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLn_SousTheme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLn_Rang"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vt_Ss_DLn_Note"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Note:30
					NEXT RECORD:C51([SIAO_Situations:52])
				Until (End selection:C36([SIAO_Situations:52]) | ($ii=1))
			End if 
		End if 
		
		
	: ($1=4)
		$va_SousTheme:="A"
		$vb_OK:=F_SIAO_Situation(1; $2; $3; $va_Theme; $va_SousTheme; 1; 2)
		$va_SousTheme:="B"
		$vb_OK:=F_SIAO_Situation(1; $2; $3; $va_Theme; $va_SousTheme; 1; 7)
		$va_SousTheme:="C"
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
				$0:=True:C214
			End if 
			UNLOAD RECORD:C212([SIAO_Situations:52])
		End if 
		READ ONLY:C145([SIAO_Situations:52])
		
		
	: ($1=11)
		$vb_OK:=($2=1)
		For ($ii; 1; 2)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLa_Intitule"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DLa_Debut"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DLa_Fin"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLa_Nombre"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
		End for 
		For ($ii; 1; 7)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_DLb_Intitule"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLb_Check"+String:C10($ii))
			If ($vb_OK)
				OBJECT SET ENABLED:C1123(<>vp_SIAO_PointeurTemp->; True:C214)
			Else 
				OBJECT SET ENABLED:C1123(<>vp_SIAO_PointeurTemp->; False:C215)
			End if 
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DLb_Debut"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
		End for 
		
		
		For ($ii; 1; 2)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_DLc_Check"+String:C10($ii))
			If ($vb_OK)
				OBJECT SET ENABLED:C1123(<>vp_SIAO_PointeurTemp->; True:C214)
			Else 
				OBJECT SET ENABLED:C1123(<>vp_SIAO_PointeurTemp->; False:C215)
			End if 
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_DLc_Debut"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vt_Ss_DLc_Referent"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
		End for 
		
		OBJECT SET ENTERABLE:C238(vt_Ss_DLn_Note1; $vb_OK)
		
	: ($1=12)
		QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_ID:2=$2; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=$3; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=$va_Theme)
		$vl_Fiches:=Records in selection:C76([SIAO_Situations:52])
		$4->:="SIAO DL 8 : "+<>va_Tab+""+<>va_Tab+String:C10(Table:C252(->[SIAO_Situations:52]))+<>va_Tab+String:C10(Get last field number:C255(->[SIAO_Situations:52]))+<>va_Tab+String:C10($vl_Fiches)+<>va_CR
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
		OBJECT SET ENTERABLE:C238(va_Ss_DLa_Intitule1; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_DLa_Intitule2; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_DLb_Intitule1; $vb_OK)
		OBJECT SET ENTERABLE:C238(vt_Ss_DLc_Referent1; $vb_OK)
		OBJECT SET ENTERABLE:C238(vt_Ss_DLc_Referent2; $vb_OK)
		
		
End case 
