//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_ConsoRegional
//{          Lundi 19 juillet 2010 à 17:25
//{          Modifiée : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
C_POINTER:C301($1)  //Pointeur sur le tableau
C_BOOLEAN:C305($2)  //vb_Serveur : Serveur ou sur le poste
C_TEXT:C284($3)  //Titre de l'action

C_BOOLEAN:C305($vb_LeRegional)

C_BOOLEAN:C305($vb_OK)

//•(1) 
//Du 115 vers le repertoire pour le régionnal 
//ou Le régional qui pompe les réperoires régionaux des 115

$vb_LeRegional:=False:C215


//•(2) Le répertoir de transfert existe-t-il        
If ($vb_LeRegional)  //Le régional
	$vb_Ok:=False:C215
Else   //Le 115
	//Recherche du chemin 
	$vb_Ok:=F_Report_FullDuplexDossier(11; <>vt_ConsoRegion_Dosssier)
	If ($vb_OK=False:C215)
		$vb_OK:=F_Report_FullDuplexMessage3($2; "NO"; $3+" : absence de repertoire ou de chemin"; "Consolidation régionale : 0")
	End if 
End if 




If ($vb_OK)
	If ($vb_LeRegional)  //Le régional
		$vb_Ok:=False:C215
	Else   //Le 115
		//Recherche du dossier lu et création s'il n'existe pas
		$vb_Ok:=F_Report_FullDuplexDossier(11; <>vt_ConsoRegion_Dosssier)
		If ($vb_OK=False:C215)
			$vb_OK:=F_Report_FullDuplexMessage3($2; "NO"; $3+" : absence de repertoire ou de chemin"; "Consolidation régionale : 0")
		End if 
	End if 
	
End if 