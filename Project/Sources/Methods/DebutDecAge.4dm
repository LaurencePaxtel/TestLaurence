//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DebutDecAge
//{
//{          Lundi 27 décembre 2004 à 15:59:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)  // [Optionnel]

C_LONGINT:C283($ii; $nbFiches; $NoTable)

$NoTable:=Table:C252(->[TrancheAge:40])

Case of 
	: ($1=0)
		READ ONLY:C145([TrancheAge:40])
		
		If (Count parameters:C259=2)
			$nbFiches:=$2
		Else 
			// Modifié par : Scanu Rémy - remy@connect-io.fr (22/06/2021)
			ALL RECORDS:C47([TrancheAge:40])
			MultiSoc_Filter(->[TrancheAge:40])
			
			$nbFiches:=Records in selection:C76([TrancheAge:40])
		End if 
		
		ARRAY TEXT:C222(<>ta_TrancheAge; 0)
		ARRAY INTEGER:C220(<>te_TrancheAge; 0)
		
		Case of 
			: ($nbFiches=0)
				// No default values are created when no tranche records exist
				ARRAY TEXT:C222(<>ta_TrancheAge; 0)
				ARRAY INTEGER:C220(<>te_TrancheAge; 0)
			: ($nbFiches=1)
				ALL RECORDS:C47([TrancheAge:40])
				MultiSoc_Filter(->[TrancheAge:40])
				
				ARRAY TEXT:C222(<>ta_TrancheAge; [TrancheAge:40]TA_Tranche_0Nombre:1)
				ARRAY INTEGER:C220(<>te_TrancheAge; [TrancheAge:40]TA_Tranche_0Nombre:1)
				
				For ($ii; 1; Size of array:C274(<>ta_TrancheAge))
					<>ta_TrancheAge{$ii}:=Field:C253($NoTable; $ii+1)->
					<>te_TrancheAge{$ii}:=Field:C253($NoTable; $ii+10)->
				End for 
				
			: ($nbFiches>1)
				READ WRITE:C146([TrancheAge:40])
				
				ALL RECORDS:C47([TrancheAge:40])
				MultiSoc_Filter(->[TrancheAge:40])
				
				DELETE SELECTION:C66([TrancheAge:40])
				
				// No automatic reinitialization with default values
				ARRAY TEXT:C222(<>ta_TrancheAge; 0)
				ARRAY INTEGER:C220(<>te_TrancheAge; 0)
				
				READ ONLY:C145([TrancheAge:40])
		End case 
		
	: ($1=1)
		ALL RECORDS:C47([TrancheAge:40])
		MultiSoc_Filter(->[TrancheAge:40])
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (15/04/2021)
		DebutDecAge(0; Records in selection:C76([TrancheAge:40]))
		
		READ WRITE:C146([TrancheAge:40])
		LOAD RECORD:C52([TrancheAge:40])
		
		va_Titre:="Paramétrage des tranches d'âge"
		$vl_Fenetre:=i_FenêtreNo(466; 332; 16; va_Titre; 3; "")
		
		FORM SET INPUT:C55([TrancheAge:40]; "TA_EcranSaisie")
		MODIFY RECORD:C57([TrancheAge:40]; *)
		
		UNLOAD RECORD:C212([TrancheAge:40])
		CLOSE WINDOW:C154($vl_Fenetre)
		
		READ ONLY:C145([TrancheAge:40])
End case 
