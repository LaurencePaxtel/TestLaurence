//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure :  P_Prolongation_Add 
//{
//{          Dimanche 19 septembre 2004 à 18:48:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($vb_OK)
$vb_OK:=False:C215

If ([GrouPe:36]GP_ReferenceID:1>0)
	If ([GrouPe:36]GP_ProlongationExclu:8)
		ALERT:C41("Le groupe : "+[GrouPe:36]GP_Intitulé:4+" est exclu des prolongations !")
	Else 
		QUERY:C277([Prolongation:38]; [Prolongation:38]PR_GPHB_Référence:5=[GrouPe:36]GP_ReferenceID:1)
		MultiSoc_Filter(->[Prolongation:38])
		vL_Nb_PRo:=Records in selection:C76([Prolongation:38])
		If (vL_Nb_PRo=0)
			//Création de la première prolongation
			$vb_OK:=True:C214
		Else 
			//Création ou modification d'une  prolongation
			QUERY SELECTION:C341([Prolongation:38]; [Prolongation:38]PR_ProlongationEffectuée:11=False:C215)
			vL_Nb_PRo:=Records in selection:C76([Prolongation:38])
			If (vL_Nb_PRo=1)
				If (i_Confirmer("Il y a déjà une prolongation active !"+<>va_CR+"Voulez-vous visualiser la prolongation ?"))
					If (F_Prolongation_FicheIncluse(2))
					End if 
				End if 
			Else 
				$vb_OK:=True:C214
			End if 
		End if 
	End if 
Else 
	ALERT:C41("Veuillez sélectionner un groupe !")
End if 




If ($vb_OK)
	$vb_OK:=False:C215
	
	If (Size of array:C274(<>te_GpP_Check)>0)
		$vb_OK:=True:C214
	Else 
		ALERT:C41("Aucun membre lié à ce groupe !")
	End if 
	
	If ($vb_OK)
		$jj:=0
		For ($ii; 1; Size of array:C274(<>te_GpP_Check))
			$jj:=$jj+<>te_GpP_Check{$ii}
		End for 
		If ($jj>0)
		Else 
			$vb_OK:=False:C215
			ALERT:C41("Aucun membre n'est sélectionné !")
		End if 
	End if 
	
	If ($vb_OK)
		If (<>te_GpP_Check>0) & (<>te_GpP_Check{<>te_GpP_Check}=1)
		Else 
			$vb_OK:=False:C215
			ALERT:C41("Veuillez sélectionner le membre par défaut !")
		End if 
	End if 
	
	If ($vb_OK)
		If (i_Confirmer("Prolongation à partir des données de : "+<>ta_GpP_Clé{<>te_GpP_Check}))
		Else 
			$vb_OK:=False:C215
		End if 
	End if 
	
	If ($vb_OK)
		vd_Pro_DateDeFin:=!00-00-00!
		vl_Pro_LCréf:=0
		va_Pro_Groupe:=""
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
		FIRST RECORD:C50([HeberGement:5])
		vd_Pro_DateDeFin:=[HeberGement:5]HG_RéservationDateFin:134
		vl_Pro_LCréf:=[HeberGement:5]HG_LC_ID:61
		va_Pro_Groupe:=[HeberGement:5]HG_FamGroupe:102
		
		If (F_Prolongation_FicheIncluse(1)=True:C214)
		End if 
	End if 
End if 