//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_FicheSurDisque
//{          Vendredi 29 avril 2010 à 14:00
//{          Modifiée : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}

//F_FicheSurDisque (->tl_Trans_Réf_HG;Faux;"Tranfert";"") 
//◊vt_T_CheminRépServeur/◊vt_T_CheminRép
//◊va_Rép_TransReport/◊va_Rép_TransPresta

C_BOOLEAN:C305($0)
$0:=False:C215

C_POINTER:C301($1)  //Pointeur sur le tableau
C_BOOLEAN:C305($2)  //vb_Serveur : Serveur ou sur le poste
C_TEXT:C284($3)  //Titre de l'action
C_TEXT:C284($4)  //Chemin du répertoire (Soit Serveur, soit Poste)
C_TEXT:C284($5)  //Repertoire
C_TEXT:C284($6)  //Titre message 
C_LONGINT:C283($7)  //TYPE EXPORT

//Message : 
// - Consolidation en cours …
// - Export des prestations en cours

C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($ii)
C_TEXT:C284($va_Lignes)

//•(1) Y a til des fiches à transférer
$vb_OK:=(Size of array:C274($1->)>0)

//•(2) Le répertoir de transfert existe-t-il
If ($vb_OK)
	$vb_OK:=(Test path name:C476($4)=Est un dossier:K24:2)
	If ($vb_OK=False:C215)
		i_MessagerieFiche($2; ("Export Serveur"*Num:C11($2))+("Export Poste"*Num:C11($2=False:C215)); "NO"; $3+" : absence de repertoire ou de chemin"; "Fiche exportée : 0")
	End if 
	
	//•(3) Le répertoire des prestations  existe t il
	If ($vb_OK)
		vt_FullDuplexDossier:=$4+$5+Séparateur dossier:K24:12
		$vb_OK:=(Test path name:C476(vt_FullDuplexDossier)=Est un dossier:K24:2)
		If ($vb_OK=False:C215)
			CREATE FOLDER:C475(vt_FullDuplexDossier)
			If (OK=1)
				$vb_OK:=True:C214
			End if 
		End if 
	End if 
	
	//•(4) On lance te transfert 
	If ($vb_OK)
		If ($2=False:C215)
			i_Message($6)
		End if 
		
		$va_Lignes:=String:C10(Size of array:C274($1->))
		READ WRITE:C146([HeberGement:5])
		For ($ii; 1; Size of array:C274($1->))
			If ($2=False:C215)
				i_MessageSeul($6+$va_Lignes+"/"+String:C10($ii))
			End if 
			$vb_OK:=F_FicheSurDisqueLoop($ii; $1->{$ii}; $2; False:C215; $7)
		End for 
		UNLOAD RECORD:C212([HeberGement:5])
		READ ONLY:C145([HeberGement:5])
		If ($2=False:C215)
			CLOSE WINDOW:C154
		End if 
	End if 
	
	//•(5) Déroulement du transfert 
	If ($vb_OK)
		i_MessagerieFiche($2; ("Export Serveur"*Num:C11($2))+("Export Poste"*Num:C11($2=False:C215)); "NO"; $3+" : Export réalisé"; String:C10(Size of array:C274($1->))+" fiche(s)")
	Else 
		i_MessagerieFiche($2; ("Export Serveur"*Num:C11($2))+("Export Poste"*Num:C11($2=False:C215)); "NO"; $3+" : Export non réalisé"; "0 fiche")
	End if 
End if 