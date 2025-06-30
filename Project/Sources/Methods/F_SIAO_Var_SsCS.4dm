//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_SIAO_Var_SsCS
//{
//{          Dimanche 12 décembre 2010 à 12:30
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
$va_Theme:=ta_SIAO_PageTitre{3}  //"RENSEIGNEMENTS ADMINISTRATIFS"

C_LONGINT:C283($ii; $vl_no; $vl_Fiches)
Case of 
	: ($1=0)
		C_LONGINT:C283(vl_Ss_CS_Reference1)
		C_LONGINT:C283(vl_Ss_CS_SIAO_ID1)
		C_LONGINT:C283(vl_Ss_CS_SIAO_Personne_ID1)
		C_TEXT:C284(va_Ss_CS_Famille1; va_Ss_CS_Theme1; va_Ss_CS_SousTheme1)
		C_LONGINT:C283(vl_Ss_CS_Rang1)
		C_TEXT:C284(va_Ss_CS_Intitule1)
		
		C_LONGINT:C283(vl_Ss_CS_Reference2)
		C_LONGINT:C283(vl_Ss_CS_SIAO_ID2)
		C_LONGINT:C283(vl_Ss_CS_SIAO_Personne_ID2)
		C_TEXT:C284(va_Ss_CS_Famille2; va_Ss_CS_Theme2; va_Ss_CS_SousTheme2)
		C_LONGINT:C283(vl_Ss_CS_Rang2)
		C_TEXT:C284(va_Ss_CS_Intitule2)
		
		C_LONGINT:C283(vl_Ss_CS_Reference3)
		C_LONGINT:C283(vl_Ss_CS_SIAO_ID3)
		C_LONGINT:C283(vl_Ss_CS_SIAO_Personne_ID3)
		C_TEXT:C284(va_Ss_CS_Famille3; va_Ss_CS_Theme3; va_Ss_CS_SousTheme3)
		C_LONGINT:C283(vl_Ss_CS_Rang3)
		C_TEXT:C284(va_Ss_CS_Intitule3)
		
		C_LONGINT:C283(vl_Ss_CSn_Reference1)
		C_LONGINT:C283(vl_Ss_CSn_SIAO_ID1)
		C_LONGINT:C283(vl_Ss_CSn_SIAO_Personne_ID1)
		C_TEXT:C284(va_Ss_CSn_Famille1; va_Ss_CSn_Theme1; va_Ss_CSn_SousTheme1)
		C_LONGINT:C283(vl_Ss_CSn_Rang1)
		C_TEXT:C284(vt_Ss_CSn_Note1)
		
		
	: ($1=1)
		For ($ii; 1; 3)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_CS_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_CS_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_CS_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_CS_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_CS_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_CS_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_CS_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=0
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_CS_Intitule"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=""
		End for 
		
		vl_Ss_CSn_Reference1:=0
		vl_Ss_CSn_SIAO_ID1:=0
		vl_Ss_CSn_SIAO_Personne_ID1:=0
		va_Ss_CSn_Famille1:=""
		va_Ss_CSn_Theme1:=""
		va_Ss_CSn_SousTheme1:=""
		vl_Ss_CSn_Rang1:=0
		vt_Ss_CSn_Note1:=""
		
		
	: ($1=2)
		READ WRITE:C146([SIAO_Situations:52])
		$vl_no:=Uut_NumerotePlus(->[SIAO_Situations:52]; 4)
		
		$va_SousTheme:="A"
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
			SAVE RECORD:C53([SIAO_Situations:52])
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_CS_Reference"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_CS_SIAO_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_CS_SIAO_Personne_ID"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_CS_Famille"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_CS_Theme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_CS_SousTheme"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_CS_Rang"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
			
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_CS_Intitule"+String:C10($ii))
			<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule:9
			UNLOAD RECORD:C212([SIAO_Situations:52])
			$vl_no:=$vl_no+1
		End for 
		
		$va_SousTheme:="N"
		CREATE RECORD:C68([SIAO_Situations:52])
		MultiSoc_Init_Structure(->[SIAO_Situations:52])
		[SIAO_Situations:52]Ss_RéférenceID:1:=$vl_no
		[SIAO_Situations:52]Ss_SIAO_ID:2:=$3
		[SIAO_Situations:52]Ss_SIAO_Personne_ID:3:=$2
		[SIAO_Situations:52]Ss_Famille:4:=""
		[SIAO_Situations:52]Ss_Theme:5:=$va_Theme
		[SIAO_Situations:52]Ss_SousTheme:6:=$va_SousTheme
		[SIAO_Situations:52]Ss_Rang:7:=1
		[SIAO_Situations:52]Ss_Note:30:=""
		SAVE RECORD:C53([SIAO_Situations:52])
		
		vl_Ss_CSn_Reference1:=[SIAO_Situations:52]Ss_RéférenceID:1
		vl_Ss_CSn_SIAO_ID1:=[SIAO_Situations:52]Ss_SIAO_ID:2
		vl_Ss_CSn_SIAO_Personne_ID1:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
		va_Ss_CSn_Famille1:=[SIAO_Situations:52]Ss_Famille:4
		va_Ss_CSn_Theme1:=[SIAO_Situations:52]Ss_Theme:5
		va_Ss_CSn_SousTheme1:=[SIAO_Situations:52]Ss_SousTheme:6
		vl_Ss_CSn_Rang1:=[SIAO_Situations:52]Ss_Rang:7
		vt_Ss_CSn_Note1:=[SIAO_Situations:52]Ss_Note:30
		UNLOAD RECORD:C212([SIAO_Situations:52])
		
		READ ONLY:C145([SIAO_Situations:52])
		
	: ($1=3)
		$vb_OK:=F_SIAO_Var_SsCS(1; 0; 0; <>vp_SIAO_PointeurVide; 0)
		
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
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_CS_Reference"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_CS_SIAO_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_CS_SIAO_Personne_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_CS_Famille"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_CS_Theme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_CS_SousTheme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_CS_Rang"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_CS_Intitule"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Intitule:9
					NEXT RECORD:C51([SIAO_Situations:52])
				Until (End selection:C36([SIAO_Situations:52]) | ($ii=3))
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
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_CSn_Reference"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_RéférenceID:1
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_CSn_SIAO_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_ID:2
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_CSn_SIAO_Personne_ID"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SIAO_Personne_ID:3
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_CSn_Famille"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Famille:4
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_CSn_Theme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Theme:5
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_CSn_SousTheme"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_SousTheme:6
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vl_Ss_CSn_Rang"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Rang:7
					
					<>vp_SIAO_PointeurTemp:=Get pointer:C304("vt_Ss_CSn_Note"+String:C10($ii))
					<>vp_SIAO_PointeurTemp->:=[SIAO_Situations:52]Ss_Note:30
					NEXT RECORD:C51([SIAO_Situations:52])
				Until (End selection:C36([SIAO_Situations:52]) | ($ii=1))
			End if 
		End if 
		
		
	: ($1=4)
		$va_SousTheme:="A"
		$vb_OK:=F_SIAO_Situation(1; $2; $3; $va_Theme; $va_SousTheme; 1; 3)
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
		For ($ii; 1; 3)
			<>vp_SIAO_PointeurTemp:=Get pointer:C304("va_Ss_CS_Intitule"+String:C10($ii))
			OBJECT SET ENTERABLE:C238(<>vp_SIAO_PointeurTemp->; $vb_OK)
		End for 
		OBJECT SET ENTERABLE:C238(vt_Ss_CSn_Note1; $vb_OK)
		
		
	: ($1=12)
		QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_ID:2=$2; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=$3; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=$va_Theme)
		$vl_Fiches:=Records in selection:C76([SIAO_Situations:52])
		$4->:="SIAO RA 3 : "+<>va_Tab+""+<>va_Tab+String:C10(Table:C252(->[SIAO_Situations:52]))+<>va_Tab+String:C10(Get last field number:C255(->[SIAO_Situations:52]))+<>va_Tab+String:C10($vl_Fiches)+<>va_CR
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
		OBJECT SET ENTERABLE:C238(va_Ss_CS_Intitule1; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_CS_Intitule2; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_Ss_CS_Intitule3; $vb_OK)
End case 