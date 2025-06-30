//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_RG_LesRepertoiresLus
//{          Lundi 8 novembre 2010 à 15:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_BOOLEAN:C305($vb_OK; $vb_OKAction)

If (<>ve_ConsoRegion_Mode=2)  //Serveur régionale : import
	$vb_OK:=False:C215
	// on cherche les répertoires on l'on déplace les fiches importées
	If (Size of array:C274(<>tt_T_CheminsRegionaux)>0)
		$vb_OK:=True:C214
		For ($ii; 1; Size of array:C274(<>tt_T_CheminsRegionaux))
			$vb_OK:=($vb_OK & F_Report_FullDuplexDossier(12; <>tt_T_CheminsRegionaux{$ii}+Séparateur dossier:K24:12+"LU"))
		End for 
	End if 
	If ($vb_OK=False:C215)
		$vb_OKAction:=F_Report_FullDuplexMessage3(vb_SurServeur; "NO"; "Consolidation régionale : absence des repertoires 'LU'"; "Pas de consolidation")
	End if 
	$0:=$vb_OK
Else 
	$0:=True:C214
End if 