//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_SIAO_Var_AD
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
C_LONGINT:C283($ii)
C_TEXT:C284($va_ADR)
Case of 
	: ($1=0)
		C_LONGINT:C283(vl_AD_Reference1)
		C_LONGINT:C283(vl_AD_SIAO_ID1)
		C_LONGINT:C283(vl_AD_SIAO_Personne_ID1)
		C_TEXT:C284(va_AD_Catégorie1)
		C_LONGINT:C283(vl_AD_Rang1)
		C_TEXT:C284(va_AD_Adr1L1; va_AD_Adr1L2; va_AD_Adr1L3; va_AD_Adr1Ville)
		C_TEXT:C284(va_AD_Adr1CP)
		C_TEXT:C284(va_AD_Adr1Telephone)
		
		C_LONGINT:C283(vl_AD_Reference2)
		C_LONGINT:C283(vl_AD_SIAO_ID2)
		C_LONGINT:C283(vl_AD_SIAO_Personne_ID2)
		C_TEXT:C284(va_AD_Catégorie2)
		C_LONGINT:C283(vl_AD_Rang2)
		C_TEXT:C284(va_AD_Adr2L1; va_AD_Adr2L2; va_AD_Adr2L3; va_AD_Adr2Ville)
		C_TEXT:C284(va_AD_Adr2CP)
		C_TEXT:C284(va_AD_Adr2Telephone)
		
		
	: ($1=1)
		vl_AD_Reference1:=0
		vl_AD_SIAO_ID1:=0
		vl_AD_SIAO_Personne_ID1:=0
		va_AD_Catégorie1:="HEB"
		vl_AD_Rang1:=1
		
		va_AD_Adr1L1:=""
		va_AD_Adr1L2:=""
		va_AD_Adr1L3:=""
		va_AD_Adr1Ville:=""
		va_AD_Adr1CP:=""
		va_AD_Adr1Telephone:=""
		
		
		
		vl_AD_Reference2:=0
		vl_AD_SIAO_ID2:=0
		vl_AD_SIAO_Personne_ID2:=0
		va_AD_Catégorie2:="DOM"
		vl_AD_Rang2:=2
		
		va_AD_Adr2L1:=""
		va_AD_Adr2L2:=""
		va_AD_Adr2L3:=""
		va_AD_Adr2Ville:=""
		va_AD_Adr2CP:=""
		va_AD_Adr2Telephone:=""
		
	: ($1=2)
		READ WRITE:C146([Adresses:53])
		CREATE RECORD:C68([Adresses:53])
		MultiSoc_Init_Structure(->[Adresses:53])
		[Adresses:53]AD_RéférenceID:1:=Uut_Numerote(->[Adresses:53])
		[Adresses:53]AD_Lien_Table:2:=String:C10(Table:C252(->[SIAO_Personnes:51]))
		[Adresses:53]AD_SIAO_ID:3:=$3
		[Adresses:53]AD_SIAO_Personne_ID:4:=$2
		[Adresses:53]AD_Categorie:5:="HEB"
		[Adresses:53]AD_Rang:8:=1
		
		[Adresses:53]AD_Adresse1:16:=""
		[Adresses:53]AD_Adresse2:17:=""
		[Adresses:53]AD_Adresse3:18:=""
		[Adresses:53]AD_Code_postal:19:=""
		[Adresses:53]AD_Ville:20:=""
		[Adresses:53]AD_Telephone:25:=""
		SAVE RECORD:C53([Adresses:53])
		vl_AD_Reference1:=[Adresses:53]AD_RéférenceID:1
		vl_AD_SIAO_ID1:=[Adresses:53]AD_SIAO_Personne_ID:4
		vl_AD_SIAO_Personne_ID1:=[Adresses:53]AD_SIAO_Personne_ID:4
		va_AD_Catégorie1:=[Adresses:53]AD_Categorie:5
		vl_AD_Rang1:=[Adresses:53]AD_Rang:8
		
		va_AD_Adr1L1:=[Adresses:53]AD_Adresse1:16
		va_AD_Adr1L2:=[Adresses:53]AD_Adresse2:17
		va_AD_Adr1L3:=[Adresses:53]AD_Adresse3:18
		va_AD_Adr1CP:=[Adresses:53]AD_Code_postal:19
		va_AD_Adr1Ville:=[Adresses:53]AD_Ville:20
		va_AD_Adr1Telephone:=[Adresses:53]AD_Telephone:25
		
		UNLOAD RECORD:C212([Adresses:53])
		
		
		CREATE RECORD:C68([Adresses:53])
		MultiSoc_Init_Structure(->[Adresses:53])
		[Adresses:53]AD_RéférenceID:1:=Uut_Numerote(->[Adresses:53])
		[Adresses:53]AD_Lien_Table:2:=String:C10(Table:C252(->[SIAO_Personnes:51]))
		[Adresses:53]AD_SIAO_ID:3:=$3
		[Adresses:53]AD_SIAO_Personne_ID:4:=$2
		[Adresses:53]AD_Categorie:5:="DOM"
		[Adresses:53]AD_Rang:8:=2
		
		[Adresses:53]AD_Adresse1:16:=""
		[Adresses:53]AD_Adresse2:17:=""
		[Adresses:53]AD_Adresse3:18:=""
		[Adresses:53]AD_Code_postal:19:=""
		[Adresses:53]AD_Ville:20:=""
		[Adresses:53]AD_Telephone:25:=""
		SAVE RECORD:C53([Adresses:53])
		vl_AD_Reference2:=[Adresses:53]AD_RéférenceID:1
		vl_AD_SIAO_ID2:=[Adresses:53]AD_SIAO_Personne_ID:4
		vl_AD_SIAO_Personne_ID2:=[Adresses:53]AD_SIAO_Personne_ID:4
		va_AD_Catégorie2:=[Adresses:53]AD_Categorie:5
		vl_AD_Rang2:=[Adresses:53]AD_Rang:8
		
		va_AD_Adr2L1:=[Adresses:53]AD_Adresse1:16
		va_AD_Adr2L2:=[Adresses:53]AD_Adresse2:17
		va_AD_Adr2L3:=[Adresses:53]AD_Adresse3:18
		va_AD_Adr2CP:=[Adresses:53]AD_Code_postal:19
		va_AD_Adr2Ville:=[Adresses:53]AD_Ville:20
		va_AD_Adr2Telephone:=[Adresses:53]AD_Telephone:25
		
		UNLOAD RECORD:C212([Adresses:53])
		
		
		READ ONLY:C145([Adresses:53])
	: ($1=3)
		$vb_OK:=False:C215
		If ($2>0)
			QUERY:C277([Adresses:53]; [Adresses:53]AD_SIAO_ID:3=$3; *)
			QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_SIAO_Personne_ID:4=$2)
			MultiSoc_Filter(->[Adresses:53])
			If (Records in selection:C76([Adresses:53])>0)
				$vb_OK:=True:C214
			End if 
		End if 
		If ($vb_OK)
			ORDER BY:C49([Adresses:53]; [Adresses:53]AD_Rang:8; >)
			FIRST RECORD:C50([Adresses:53])
			
			vl_AD_Reference1:=[Adresses:53]AD_RéférenceID:1
			vl_AD_SIAO_ID1:=[Adresses:53]AD_SIAO_Personne_ID:4
			vl_AD_SIAO_Personne_ID1:=[Adresses:53]AD_SIAO_Personne_ID:4
			va_AD_Catégorie1:=[Adresses:53]AD_Categorie:5
			vl_AD_Rang1:=[Adresses:53]AD_Rang:8
			
			va_AD_Adr1L1:=[Adresses:53]AD_Adresse1:16
			va_AD_Adr1L2:=[Adresses:53]AD_Adresse2:17
			va_AD_Adr1L3:=[Adresses:53]AD_Adresse3:18
			va_AD_Adr1CP:=[Adresses:53]AD_Code_postal:19
			va_AD_Adr1Ville:=[Adresses:53]AD_Ville:20
			va_AD_Adr1Telephone:=[Adresses:53]AD_Telephone:25
			
			NEXT RECORD:C51([Adresses:53])
			
			
			vl_AD_Reference2:=[Adresses:53]AD_RéférenceID:1
			vl_AD_SIAO_ID2:=[Adresses:53]AD_SIAO_Personne_ID:4
			vl_AD_SIAO_Personne_ID2:=[Adresses:53]AD_SIAO_Personne_ID:4
			va_AD_Catégorie2:=[Adresses:53]AD_Categorie:5
			vl_AD_Rang2:=[Adresses:53]AD_Rang:8
			
			va_AD_Adr2L1:=[Adresses:53]AD_Adresse1:16
			va_AD_Adr2L2:=[Adresses:53]AD_Adresse2:17
			va_AD_Adr2L3:=[Adresses:53]AD_Adresse3:18
			va_AD_Adr2CP:=[Adresses:53]AD_Code_postal:19
			va_AD_Adr2Ville:=[Adresses:53]AD_Ville:20
			va_AD_Adr2Telephone:=[Adresses:53]AD_Telephone:25
			
		Else 
			$vb_OK:=F_SIAO_Var_AD(1; 0; 0; <>vp_SIAO_PointeurVide; 0)
		End if 
		
		
		
	: ($1=4)
		QUERY:C277([Adresses:53]; [Adresses:53]AD_SIAO_ID:3=$3; *)
		QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_SIAO_Personne_ID:4=$2; *)
		QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_Categorie:5="HEB")
		MultiSoc_Filter(->[Adresses:53])
		If (Records in selection:C76([Adresses:53])=1)
			
		Else 
			If (Records in selection:C76([Adresses:53])>0)
				READ WRITE:C146([Adresses:53])
				DELETE SELECTION:C66([Adresses:53])
				READ ONLY:C145([Adresses:53])
			End if 
			READ WRITE:C146([Adresses:53])
			CREATE RECORD:C68([Adresses:53])
			MultiSoc_Init_Structure(->[Adresses:53])
			[Adresses:53]AD_RéférenceID:1:=Uut_Numerote(->[Adresses:53])
			[Adresses:53]AD_Lien_Table:2:=String:C10(Table:C252(->[SIAO_Personnes:51]))
			[Adresses:53]AD_SIAO_ID:3:=$3
			[Adresses:53]AD_SIAO_Personne_ID:4:=$2
			[Adresses:53]AD_Categorie:5:="HEB"
			[Adresses:53]AD_Rang:8:=1
			
			[Adresses:53]AD_Adresse1:16:=""
			[Adresses:53]AD_Adresse2:17:=""
			[Adresses:53]AD_Adresse3:18:=""
			[Adresses:53]AD_Code_postal:19:=""
			[Adresses:53]AD_Ville:20:=""
			[Adresses:53]AD_Telephone:25:=""
			SAVE RECORD:C53([Adresses:53])
			UNLOAD RECORD:C212([Adresses:53])
			READ ONLY:C145([Adresses:53])
		End if 
		
		
		QUERY:C277([Adresses:53]; [Adresses:53]AD_SIAO_ID:3=$3; *)
		QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_SIAO_Personne_ID:4=$2; *)
		QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_Categorie:5="DOM")
		MultiSoc_Filter(->[Adresses:53])
		If (Records in selection:C76([Adresses:53])=1)
			$0:=True:C214
		Else 
			If (Records in selection:C76([Adresses:53])>0)
				READ WRITE:C146([Adresses:53])
				DELETE SELECTION:C66([Adresses:53])
				READ ONLY:C145([Adresses:53])
			End if 
			READ WRITE:C146([Adresses:53])
			CREATE RECORD:C68([Adresses:53])
			MultiSoc_Init_Structure(->[Adresses:53])
			[Adresses:53]AD_RéférenceID:1:=Uut_Numerote(->[Adresses:53])
			[Adresses:53]AD_Lien_Table:2:=String:C10(Table:C252(->[SIAO_Personnes:51]))
			[Adresses:53]AD_SIAO_ID:3:=$3
			[Adresses:53]AD_SIAO_Personne_ID:4:=$2
			[Adresses:53]AD_Categorie:5:="DOM"
			[Adresses:53]AD_Rang:8:=2
			
			[Adresses:53]AD_Adresse1:16:=""
			[Adresses:53]AD_Adresse2:17:=""
			[Adresses:53]AD_Adresse3:18:=""
			[Adresses:53]AD_Code_postal:19:=""
			[Adresses:53]AD_Ville:20:=""
			[Adresses:53]AD_Telephone:25:=""
			SAVE RECORD:C53([Adresses:53])
			UNLOAD RECORD:C212([Adresses:53])
			READ ONLY:C145([Adresses:53])
		End if 
		
		
	: ($1=10)
		READ WRITE:C146([Adresses:53])
		QUERY:C277([Adresses:53]; [Adresses:53]AD_RéférenceID:1=$2)
		MultiSoc_Filter(->[Adresses:53])
		If (Records in selection:C76([Adresses:53])=1)
			If (i_NonVerrou(->[Adresses:53]))
				Field:C253(Table:C252(->[Adresses:53]); $3)->:=$4->
				
				SAVE RECORD:C53([Adresses:53])
				$0:=True:C214
			End if 
			UNLOAD RECORD:C212([Adresses:53])
		End if 
		READ ONLY:C145([Adresses:53])
		
		
	: ($1=11)
		$vb_OK:=($2=1)
		OBJECT SET ENTERABLE:C238(vl_AD_Reference1; $vb_OK)
		OBJECT SET ENTERABLE:C238(vl_AD_SIAO_ID1; $vb_OK)
		OBJECT SET ENTERABLE:C238(vl_AD_SIAO_Personne_ID1; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_AD_Catégorie1; $vb_OK)
		OBJECT SET ENTERABLE:C238(vl_AD_Rang1; $vb_OK)
		
		OBJECT SET ENTERABLE:C238(va_AD_Adr1L1; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_AD_Adr1L2; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_AD_Adr1L3; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_AD_Adr1Ville; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_AD_Adr1CP; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_AD_Adr1Telephone; $vb_OK)
		
		
		OBJECT SET ENTERABLE:C238(vl_AD_Reference2; $vb_OK)
		OBJECT SET ENTERABLE:C238(vl_AD_SIAO_ID2; $vb_OK)
		OBJECT SET ENTERABLE:C238(vl_AD_SIAO_Personne_ID2; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_AD_Catégorie2; $vb_OK)
		OBJECT SET ENTERABLE:C238(vl_AD_Rang2; $vb_OK)
		
		OBJECT SET ENTERABLE:C238(va_AD_Adr2L1; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_AD_Adr2L2; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_AD_Adr2L3; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_AD_Adr2Ville; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_AD_Adr2CP; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_AD_Adr2Telephone; $vb_OK)
		
	: ($1=12)
		$4->:=""
		$va_ADR:=("HEB"*Num:C11($5=1))+("DOM"*Num:C11($5=2))
		QUERY:C277([Adresses:53]; [Adresses:53]AD_SIAO_ID:3=$2; *)
		QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_SIAO_Personne_ID:4=$3; *)
		QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_Categorie:5=$va_ADR)
		MultiSoc_Filter(->[Adresses:53])
		If (Records in selection:C76([Adresses:53])=1)
			For ($ii; 1; Get last field number:C255(->[Adresses:53]))
				$4->:=$4->+Substring:C12(Field name:C257(Field:C253(Table:C252(->[Adresses:53]); $ii)); 4)+<>va_Tab+F_ChampEnChaine(Table:C252(->[Adresses:53]); $ii)+<>va_Tab+String:C10(Table:C252(->[Adresses:53]))+<>va_Tab+String:C10($ii)+<>va_Tab+"0"+<>va_CR
			End for 
		Else 
			For ($ii; 1; Get last field number:C255(->[Adresses:53]))
				$4->:=$4->+Substring:C12(Field name:C257(Field:C253(Table:C252(->[Adresses:53]); $ii)); 4)+<>va_Tab+""+<>va_Tab+String:C10(Table:C252(->[Adresses:53]))+<>va_Tab+String:C10($ii)+<>va_Tab+"0"+<>va_CR
			End for 
		End if 
		
		
End case 