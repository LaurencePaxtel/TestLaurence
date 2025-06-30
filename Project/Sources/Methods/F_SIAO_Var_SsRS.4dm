//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_SIAO_Var_SsRS
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
$va_Theme:=ta_SIAO_PageTitre{5}  //"RESSOURCES"

C_LONGINT:C283($ii; $vl_no; $vl_Fiches)

Case of 
	: ($1=0)
		C_LONGINT:C283(vl_Ss_RS_Editer)
		vl_Ss_RS_Editer:=0
		
		C_LONGINT:C283(vl_Ss_RS_Reference1)
		C_LONGINT:C283(vl_Ss_RS_SIAO_ID1)
		C_LONGINT:C283(vl_Ss_RS_SIAO_Personne_ID1)
		C_TEXT:C284(va_Ss_RS_Famille1; va_Ss_RS_Theme1; va_Ss_RS_SousTheme1)
		C_LONGINT:C283(vl_Ss_RS_Rang1)
		C_TEXT:C284(va_Ss_RS_Intitule1)
		C_REAL:C285(vr_Ss_RS_Montant1)
		C_DATE:C307(vd_Ss_RS_Debut1; vd_Ss_RS_Fin1)
		
		C_LONGINT:C283(vl_Ss_RS_Reference2)
		C_LONGINT:C283(vl_Ss_RS_SIAO_ID2)
		C_LONGINT:C283(vl_Ss_RS_SIAO_Personne_ID2)
		C_TEXT:C284(va_Ss_RS_Famille2; va_Ss_RS_Theme2; va_Ss_RS_SousTheme2)
		C_LONGINT:C283(vl_Ss_RS_Rang2)
		C_TEXT:C284(va_Ss_RS_Intitule2)
		C_REAL:C285(vr_Ss_RS_Montant2)
		C_DATE:C307(vd_Ss_RS_Debut2; vd_Ss_RS_Fin2)
		
		C_LONGINT:C283(vl_Ss_RS_Reference3)
		C_LONGINT:C283(vl_Ss_RS_SIAO_ID3)
		C_LONGINT:C283(vl_Ss_RS_SIAO_Personne_ID3)
		C_TEXT:C284(va_Ss_RS_Famille3; va_Ss_RS_Theme3; va_Ss_RS_SousTheme3)
		C_LONGINT:C283(vl_Ss_RS_Rang3)
		C_TEXT:C284(va_Ss_RS_Intitule3)
		C_REAL:C285(vr_Ss_RS_Montant3)
		C_DATE:C307(vd_Ss_RS_Debut3; vd_Ss_RS_Fin3)
		
		C_LONGINT:C283(vl_Ss_RS_Reference4)
		C_LONGINT:C283(vl_Ss_RS_SIAO_ID4)
		C_LONGINT:C283(vl_Ss_RS_SIAO_Personne_ID4)
		C_TEXT:C284(va_Ss_RS_Famille4; va_Ss_RS_Theme4; va_Ss_RS_SousTheme4)
		C_LONGINT:C283(vl_Ss_RS_Rang4)
		C_TEXT:C284(va_Ss_RS_Intitule4)
		C_REAL:C285(vr_Ss_RS_Montant4)
		C_DATE:C307(vd_Ss_RS_Debut4; vd_Ss_RS_Fin4)
		
		C_LONGINT:C283(vl_Ss_RS_Reference5)
		C_LONGINT:C283(vl_Ss_RS_SIAO_ID5)
		C_LONGINT:C283(vl_Ss_RS_SIAO_Personne_ID5)
		C_TEXT:C284(va_Ss_RS_Famille5; va_Ss_RS_Theme5; va_Ss_RS_SousTheme5)
		C_LONGINT:C283(vl_Ss_RS_Rang5)
		C_TEXT:C284(va_Ss_RS_Intitule5)
		C_REAL:C285(vr_Ss_RS_Montant5)
		C_DATE:C307(vd_Ss_RS_Debut5; vd_Ss_RS_Fin5)
		
		
		
		
		C_LONGINT:C283(vl_Ss_RSn_Reference1; vl_Ss_RSn_SIAO_ID1; vl_Ss_RSn_SIAO_Personne_ID1)
		C_TEXT:C284(va_Ss_RSn_Famille1; va_Ss_RSn_Theme1; va_Ss_RSn_SousTheme1)
		C_LONGINT:C283(vl_Ss_RSn_Rang1)
		C_TEXT:C284(vt_Ss_RSn_Note1)
		
		
		
		
		
		C_REAL:C285(vr_Ss_RS_MontantMois; vr_Ss_RS_MontantAnnuel)
		
		//C_REEL(vr_Ss_RS_TotalDettes;vr_Ss_RS_TotalDispo)
		
		
		
	: ($1=1)
		
		For ($ii; 1; 5)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RS_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RS_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RS_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_RS_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_RS_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_RS_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RS_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_RS_Intitule"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vr_Ss_RS_Montant"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_RS_Debut"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=!00-00-00!
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_RS_Fin"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=!00-00-00!
			
		End for 
		
		vl_Ss_RSn_Reference1:=0
		vl_Ss_RSn_SIAO_ID1:=0
		vl_Ss_RSn_SIAO_Personne_ID1:=0
		va_Ss_RSn_Famille1:=""
		va_Ss_RSn_Theme1:=""
		va_Ss_RSn_SousTheme1:=""
		vl_Ss_RSn_Rang1:=0
		vt_Ss_RSn_Note1:=""
		
		
		vr_Ss_RS_MontantMois:=0
		vr_Ss_RS_MontantAnnuel:=0
		
	: ($1=2)
		READ WRITE:C146([SIAO_Situations:52])
		$vl_no:=Uut_NumerotePlus(->[SIAO_Situations:52]; 6)
		
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
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RS_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RS_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RS_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_RS_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_RS_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_RS_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RS_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RS_Rang"+String:C10($ii))
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
		<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RSn_Reference"+String:C10($ii))
		<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
		
		<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RSn_SIAO_ID"+String:C10($ii))
		<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
		
		<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RSn_SIAO_Personne_ID"+String:C10($ii))
		<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
		
		<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_RSn_Famille"+String:C10($ii))
		<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
		
		<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_RSn_Theme"+String:C10($ii))
		<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
		
		<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_RSn_SousTheme"+String:C10($ii))
		<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
		
		<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RSn_Rang"+String:C10($ii))
		<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
		UNLOAD RECORD:C212([SIAO_Situations:52])
		
		READ ONLY:C145([SIAO_Situations:52])
		
		
	: ($1=3)
		$vb_OK:=F_SIAO_Var_SsRS(1; 0; 0; <>vp_SIAO_PointeurVide; 0)
		vr_Ss_RS_MontantMois:=0
		vr_Ss_RS_MontantAnnuel:=0
		vr_Ss_RS_TotalDettes:=0
		
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
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RS_Reference"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RS_SIAO_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RS_SIAO_Personne_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_RS_Famille"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_RS_Theme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_RS_SousTheme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RS_Rang"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
					
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_RS_Intitule"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule:9
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vr_Ss_RS_Montant"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Montant:26
					vr_Ss_RS_MontantMois:=vr_Ss_RS_MontantMois+[SIAO_Situations:52]Ss_Montant:26
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_RS_Debut"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_debut:14
					
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_RS_Fin"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Date_de_fin:16
					NEXT RECORD:C51([SIAO_Situations:52])
				Until (End selection:C36([SIAO_Situations:52]) | ($ii=5))
			End if 
		End if 
		
		vr_Ss_RS_MontantAnnuel:=vr_Ss_RS_MontantMois*12
		
		
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
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RSn_Reference"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RSn_SIAO_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RSn_SIAO_Personne_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_RSn_Famille"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_RSn_Theme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_RSn_SousTheme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_RSn_Rang"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vt_Ss_RSn_Note"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Note:30
					NEXT RECORD:C51([SIAO_Situations:52])
				Until (End selection:C36([SIAO_Situations:52]) | ($ii=1))
			End if 
		End if 
		
		
	: ($1=4)
		$va_SousTheme:="A"
		$vb_OK:=F_SIAO_Situation(1; $2; $3; $va_Theme; $va_SousTheme; 1; 5)
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
		If ($vb_OK)
			OBJECT SET ENABLED:C1123(vl_Ss_RS_Editer; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(vl_Ss_RS_Editer; False:C215)
		End if 
		
		
		For ($ii; 1; 5)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_RS_Intitule"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vr_Ss_RS_Montant"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_RS_Debut"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vd_Ss_RS_Fin"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
		End for 
		
		OBJECT SET ENTERABLE:C238(vt_Ss_RSn_Note1; $vb_OK)
		
	: ($1=12)
		QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_ID:2=$2; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=$3; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=$va_Theme)
		$vl_Fiches:=Records in selection:C76([SIAO_Situations:52])
		$4->:="SIAO RS 5 : "+<>va_Tab+""+<>va_Tab+String:C10(Table:C252(->[SIAO_Situations:52]))+<>va_Tab+String:C10(Get last field number:C255(->[SIAO_Situations:52]))+<>va_Tab+String:C10($vl_Fiches)+<>va_CR
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
		OBJECT SET ENTERABLE:C238(va_Ss_RS_Intitule1; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_RS_Intitule2; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_RS_Intitule3; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_RS_Intitule4; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_RS_Intitule5; $vb_OK)
End case 