//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_Report_FullDuplex
//{
//{          Vendrdi 31 octobre 2008 à 15:00
//{          Modifiée : 31 octobre 2008 à 15:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_POINTER:C301($1)  //Pointeur sur le tableau
C_BOOLEAN:C305($2)  //vb_Serveur : Serveur ou sur le poste
C_TEXT:C284($3)  //Titre de l'action

C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($ii)
C_TEXT:C284($va_Lignes)

//•(1) Est ce une base CHRS  et y a til des fiches reportées
$vb_OK:=<>vb_T_ModeCHRS & <>vb_T_FullDuplex

If ($vb_OK)
	$vb_OK:=(Size of array:C274($1->)>0)
End if 

//•(2) Le répertoir de transfert existe-t-il        
If ($vb_OK)
	
	If ($2)
		$vb_Ok:=F_Report_FullDuplexDossier(11; <>vt_T_CheminRépServeur)
		
		If ($vb_OK=False:C215)
			$vb_OK:=F_Report_FullDuplexMessage2($2; "NO"; $3+" : absence de repertoire ou de chemin"; "Fiche reportée : 0")
		End if 
		
	Else 
		$vb_Ok:=F_Report_FullDuplexDossier(11; <>vt_T_CheminRép)
		
		If ($vb_OK=False:C215)
			$vb_OK:=F_Report_FullDuplexMessage2($2; "NO"; $3+" : absence de repertoire ou de chemin"; "Fiche reportée : 0")
		End if 
		
	End if 
	
End if 

//•(3) Le répertoire du report pour le Centre 115 centralisateur  existe t il
If ($vb_OK)
	// on cherche le répertoire on l'on exporte les fiches reportées
	//  ◊va_Rép_TransReport:="115Report"
	//  ◊va_Rép_TransReportLU:="115LU"
	
	If ($2)
		vt_FullDuplexDossier:=<>vt_T_CheminRépServeur+<>va_Rép_TransReport+Séparateur dossier:K24:12
		$vb_Ok:=F_Report_FullDuplexDossier(3; <>va_Rép_TransReport)
	Else 
		vt_FullDuplexDossier:=<>vt_T_CheminRép+<>va_Rép_TransReport+Séparateur dossier:K24:12
		$vb_Ok:=F_Report_FullDuplexDossier(0; <>va_Rép_TransReport)
	End if 
	
End if 

//•(4) On lance te transfert
If ($vb_OK)
	
	If ($2=False:C215)
		i_Message("Consolidation en cours…")
	End if 
	
	$va_Lignes:=String:C10(Size of array:C274($1->))
	READ WRITE:C146([HeberGement:5])
	
	For ($ii; 1; Size of array:C274($1->))
		
		If ($2=False:C215)
			i_MessageSeul("Consolidation en cours "+$va_Lignes+"/"+String:C10($ii))
		End if 
		
		$vb_OK:=F_Report_FullDuplexLoop($ii; $1->{$ii}; $2; False:C215)
	End for 
	
	UNLOAD RECORD:C212([HeberGement:5])
	READ ONLY:C145([HeberGement:5])
	
	If ($2=False:C215)
		CLOSE WINDOW:C154
	End if 
	
End if 

//•(5) Est ce une base CHRS  et y a til eu des fiches reportées
If (<>vb_T_ModeCHRS & <>vb_T_FullDuplex)
	
	If ($vb_OK)
		$vb_OK:=F_Report_FullDuplexMessage2($2; "OK"; $3+" : Export réalisé"; String:C10(Size of array:C274($1->))+" fiche(s)")
	Else 
		$vb_OK:=F_Report_FullDuplexMessage2($2; "NO"; $3+" : Export non réalisé"; "0 fiche")
	End if 
	
End if 