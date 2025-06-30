//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_Regional_Transfert
//{          Vendrdi 28 janvier 2011 à 11:55
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

//•(1) Est ce une base à tranfsérer et  ya t il des des fiches 
$vb_OK:=(<>ve_ConsoRegion_Mode=1)  //28/1/2011 : Export pour le régional

If ($vb_OK)
	$vb_OK:=(Size of array:C274($1->)>0)
End if 

vt_FullDuplexDossier:=<>vt_CheminRégion
If (7=8)
	If (<>vt_CheminRégion[[Length:C16(<>vt_CheminRégion)]]#Séparateur dossier:K24:12)
		vt_FullDuplexDossier:=vt_FullDuplexDossier+Séparateur dossier:K24:12
	End if 
	vt_FullDuplexDossier:=vt_FullDuplexDossier+<>vt_DossierRégion
	If (vt_FullDuplexDossier[[Length:C16(vt_FullDuplexDossier)]]#Séparateur dossier:K24:12)
		vt_FullDuplexDossier:=vt_FullDuplexDossier+Séparateur dossier:K24:12
	End if 
End if 


//•(2) Le répertoir d'export régional existe-t-il        
If ($vb_OK)
	If ($2)
		$vb_Ok:=F_Report_FullDuplexDossier(11; vt_FullDuplexDossier)
		If ($vb_OK=False:C215)
			$vb_OK:=F_Regional_TransfertMessage($2; "NO"; $3+" : absence de repertoire ou de chemin"; "Fiche transférée : 0")
			
		End if 
	Else 
		$vb_Ok:=F_Report_FullDuplexDossier(11; vt_FullDuplexDossier)
		If ($vb_OK=False:C215)
			$vb_OK:=F_Regional_TransfertMessage($2; "NO"; $3+" : absence de repertoire ou de chemin"; "Fiche transférée : 0")
		End if 
	End if 
End if 

//•(3) Le répertoire du report pour le Centre 115 centralisateur  existe t il
If ($vb_OK)
	If ($2)
		vt_FullDuplexDossier:=vt_FullDuplexDossier
	Else 
		vt_FullDuplexDossier:=vt_FullDuplexDossier
	End if 
End if 


//•(4) On lance te transfert
If ($vb_OK)
	If ($2=False:C215)
		i_Message("Consolidation régionale en cours…")
	End if 
	$va_Lignes:=String:C10(Size of array:C274($1->))
	READ WRITE:C146([HeberGement:5])
	For ($ii; 1; Size of array:C274($1->))
		If ($2=False:C215)
			i_MessageSeul("Consolidation régionale en cours "+$va_Lignes+"/"+String:C10($ii))
		End if 
		$vb_OK:=F_Regional_TransfertLoop($ii; $1->{$ii}; $2; False:C215)
	End for 
	UNLOAD RECORD:C212([HeberGement:5])
	READ ONLY:C145([HeberGement:5])
	If ($2=False:C215)
		CLOSE WINDOW:C154
	End if 
End if 
//•(5) Est ce une base à tranfsérer et y a t il eu des fiches tranférés 

If (<>ve_ConsoRegion_Mode=1)  //28/1/2011 : Export pour le régional
	If ($vb_OK)
		$vb_OK:=F_Regional_TransfertMessage($2; "OK"; $3+" : Consolidation régionale réalisée"; String:C10(Size of array:C274($1->))+" fiche(s)")
	Else 
		$vb_OK:=F_Regional_TransfertMessage($2; "NO"; $3+" : Consolidation régionale non réalisée"; "0 fiche")
	End if 
End if 
