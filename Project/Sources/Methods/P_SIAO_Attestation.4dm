//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{          Procédure : P_SIAO_Attestation  
//{
//{          Lundi 7 février 2011 à 15:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (vl_SIAO_RefAttestation>0)
	CREATE SET:C116([SIAO:50]; "E_SIAO")
	QUERY:C277([SIAO:50]; [SIAO:50]Si_RéférenceID:1=vl_SIAO_RefAttestation)
	MultiSoc_Filter(->[SIAO:50])
	If (Records in selection:C76([SIAO:50])=1)
		FORM SET OUTPUT:C54([SIAO:50]; "Si_Attestation")
		_O_PAGE SETUP:C299([SIAO:50]; "Si_Attestation")
		PRINT SETTINGS:C106
		$vb_OK:=F_SIAO_Var_Attestation(2; 0)
		PRINT SELECTION:C60([SIAO:50]; *)
		FORM SET OUTPUT:C54([SIAO:50]; "Si_ListeInclue")
	Else 
		ALERT:C41("Aucun dossier trouvé !")
	End if 
	USE SET:C118("E_SIAO")
	CLEAR SET:C117("E_SIAO")
	vL_NbFiches:=Records in selection:C76([SIAO:50])
	If (vL_NbFiches>0)
		P_SIAO_Sort(2)
	Else 
		vl_SIAO_RefAttestation:=0
	End if 
Else 
	ALERT:C41("Vous devez sélectionner un dossier.")
End if 
