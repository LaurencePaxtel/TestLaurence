//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_RG_LesRepertoires
//{          Lundi 8 novembre 2010 à 15:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215
C_BOOLEAN:C305($vb_OK; $vb_OKAction)
$vb_OK:=False:C215
Case of 
	: (<>ve_ConsoRegion_Mode=0)  //Mode de consolidation régionale inactivé
		$vb_OKAction:=F_Report_FullDuplexMessage3(vb_SurServeur; "NO"; "Consolidation régionale : inactivée"; "Pas de consolidation")
	: (<>ve_ConsoRegion_Mode=1)  //Mode de consolidation régionale de type 115 : export
		$vb_OK:=F_Report_FullDuplexDossier(11; <>vt_ConsoRegion_Dosssier)
		If ($vb_OK=False:C215)
			$vb_OKAction:=F_Report_FullDuplexMessage3(vb_SurServeur; "NO"; "Consolidation régionale 115 : absence de repertoire ou de chemin"; "Pas de consolidation")
		End if 
	: (<>ve_ConsoRegion_Mode=2)  //Serveur régionale : import
		$vb_OK:=False:C215
		If (Size of array:C274(<>tt_T_CheminsRegionaux)>0)
			$vb_OK:=True:C214
			For ($ii; 1; Size of array:C274(<>tt_T_CheminsRegionaux))
				$vb_OK:=($vb_OK & F_Report_FullDuplexDossier(11; <>tt_T_CheminsRegionaux{$ii}))
			End for 
			If ($vb_OK=False:C215)
				$vb_OKAction:=F_Report_FullDuplexMessage3(vb_SurServeur; "NO"; "Consolidation régionale : absence de repertoire ou de chemin"; "Pas de consolidation")
			End if 
		End if 
End case 
$0:=$vb_OK