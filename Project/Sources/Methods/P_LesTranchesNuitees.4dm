//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_LesTranchesNuitees
//{
//{          Lundi 22 février 2010 à 15:20:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_TEXT:C284($2)

C_LONGINT:C283($nbFiches; $NoTable)
$NoTable:=Table:C252(->[LesTranches:47])

Case of 
	: ($1=0)
		READ ONLY:C145([LesTranches:47])
		QUERY:C277([LesTranches:47]; [LesTranches:47]LT_Catégorie:1=$2)
		MultiSoc_Filter(->[LesTranches:47])
		$nbFiches:=Records in selection:C76([LesTranches:47])
		
		ARRAY TEXT:C222(<>ta_LesTranches; 0)
		ARRAY INTEGER:C220(<>te_LesTranches; 0)
		
		Case of 
			: ($nbFiches=0)
				READ WRITE:C146([LesTranches:47])
				CREATE RECORD:C68([LesTranches:47])
				MultiSoc_Init_Structure(->[LesTranches:47])
				P_LesTranchesParDefaut($2)
				SAVE RECORD:C53([LesTranches:47])
				P_LesTranchesTableau([LesTranches:47]LT_Nombre:2; Table:C252(->[LesTranches:47]))
				UNLOAD RECORD:C212([LesTranches:47])
				READ ONLY:C145([LesTranches:47])
				
			: ($nbFiches=1)
				ALL RECORDS:C47([LesTranches:47])
				MultiSoc_Filter(->[LesTranches:47])
				FIRST RECORD:C50([LesTranches:47])
				P_LesTranchesTableau([LesTranches:47]LT_Nombre:2; Table:C252(->[LesTranches:47]))
			: ($nbFiches>1)
				READ WRITE:C146([LesTranches:47])
				ALL RECORDS:C47([LesTranches:47])
				MultiSoc_Filter(->[LesTranches:47])
				DELETE SELECTION:C66([LesTranches:47])
				READ ONLY:C145([LesTranches:47])
		End case 
		
	: ($1=1)
		QUERY:C277([LesTranches:47]; [LesTranches:47]LT_Catégorie:1=$2)
		MultiSoc_Filter(->[LesTranches:47])
		If (Records in selection:C76([LesTranches:47])=1)
		Else 
			P_LesTranchesNuitees(0; $2)
			QUERY:C277([LesTranches:47]; [LesTranches:47]LT_Catégorie:1=$2)
			MultiSoc_Filter(->[LesTranches:47])
		End if 
		READ WRITE:C146([LesTranches:47])
		LOAD RECORD:C52([LesTranches:47])
		va_Titre:="Paramétrage des tranches"
		$vl_Fenetre:=i_FenêtreNo(466; 427; 16; va_Titre; 3; "")
		FORM SET INPUT:C55([LesTranches:47]; "LT_EcranSaisie")
		MODIFY RECORD:C57([LesTranches:47]; *)
		
		
		UNLOAD RECORD:C212([LesTranches:47])
		CLOSE WINDOW:C154($vl_Fenetre)
		READ ONLY:C145([LesTranches:47])
		
End case 
