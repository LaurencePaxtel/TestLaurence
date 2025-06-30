//%attributes = {}
C_TEXT:C284($1; $T_Cle)
$T_Cle:=$1

SET QUERY LIMIT:C395(1)
QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=$T_Cle)
MultiSoc_Filter(->[HeBerge:4])
SET QUERY LIMIT:C395(0)

RELATE MANY:C262([HeBerge:4]HB_ReferenceID:1)
REDUCE SELECTION:C351([DossierSante:33]; 0)
REDUCE SELECTION:C351([Maraude:24]; 0)

ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
REDUCE SELECTION:C351([HeberGement:5]; 1)  // le plus récent

If (Records in selection:C76([HeberGement:5])=1)
	
	C_TIME:C306($H_Current_server; $H_Current_client)
	$H_Current_server:=Current time:C178(*)
	$H_Current_client:=Current time:C178
	C_DATE:C307($D_Current_server; $D_Current_client)
	$D_Current_server:=Current date:C33(*)
	$D_Current_client:=Current date:C33
	
	If (True:C214)  // Param_champ_duplique
		
		Param_champ_duplique("get")
		
		C_LONGINT:C283($L_Dup_CtrRéf)
		C_TEXT:C284($T_Dup_SitFam; $T_Dup_TpsErr; $T_Dup_DerEmp; $T_Dup_DSEmp; $T_Dup_DSEmpPlus; $T_Dup_Ctr; $T_Dup_CtrNom; $T_Dup_AutreSol; $T_Dup_Orient1; $T_Dup_Orient2; $T_Dup_Maraude)
		
		$T_Dup_SitFam:=OB Get:C1224([DePart2:76]Proprietes:2; "situation_famille"; Est un texte:K8:3)  // [HeberGement]HG_SituFamille
		$T_Dup_TpsErr:=OB Get:C1224([DePart2:76]Proprietes:2; "temps_errance"; Est un texte:K8:3)  // [HeberGement]HG_TempsErrance
		$T_Dup_DerEmp:=OB Get:C1224([DePart2:76]Proprietes:2; "dernier_emploi"; Est un texte:K8:3)  // [HeberGement]HG_DernierEmplo
		$T_Dup_DSEmp:=OB Get:C1224([DePart2:76]Proprietes:2; "duree_sans_emploi"; Est un texte:K8:3)  // [HeberGement]HG_DuréSanEmplo
		//$T_Dup_DSEmpLib:=OB Get([DePart2]Dupliquer;"dernier_emploi_lib";Is text)  // saisie libre dans [HeberGement]HG_DernierEmplo même champ
		$T_Dup_DSEmpPlus:=OB Get:C1224([DePart2:76]Proprietes:2; "duree_sans_emploi_incremente"; Est un texte:K8:3)  // ?????
		$T_Dup_Ctr:=OB Get:C1224([DePart2:76]Proprietes:2; "gestion_centre_vide"; Est un texte:K8:3)  // si "O" alors recopier les deux en dessous
		$L_Dup_CtrRéf:=OB Get:C1224([DePart2:76]Proprietes:2; "controleur_ref"; Est un entier long:K8:6)  // la variable dans le champs -> [HeberGement]HG_LC_ID
		$T_Dup_CtrNom:=OB Get:C1224([DePart2:76]Proprietes:2; "controleur_nom"; Est un texte:K8:3)  // la variable dans le champs -> [HeberGement]HG_CentreNom
		$T_Dup_AutreSol:=OB Get:C1224([DePart2:76]Proprietes:2; "autre_solution"; Est un texte:K8:3)  // [HeberGement]HG_AutreSolutio
		$T_Dup_Orient1:=OB Get:C1224([DePart2:76]Proprietes:2; "orientation1"; Est un texte:K8:3)  // [HeberGement]HG_Orientation1
		$T_Dup_Orient2:=OB Get:C1224([DePart2:76]Proprietes:2; "orientation2"; Est un texte:K8:3)  // [HeberGement]HG_Orientation2
		$T_Dup_Maraude:=OB Get:C1224([DePart2:76]Proprietes:2; "maraude"; Est un texte:K8:3)  // [HeberGement]HG_Maraude1_1
		
		Param_champ_duplique("liberer")
	End if 
	
	If (True:C214)  // Param_init_pointage
		
		Param_init_pointage("get")
		
		C_LONGINT:C283($L_PointeCtrRéf; $L_PointeCtrMed)
		C_TEXT:C284($T_PointeCtrNom; $T_PointeCtrCP; $T_PointeCtrPlateF; $T_PointeFMGroupe)
		C_BOOLEAN:C305($B_PointeCtrMed)
		
		$L_PointeCtrRéf:=OB Get:C1224([DePart2:76]Proprietes:2; "centre_ref"; Est un entier long:K8:6)
		$T_PointeCtrNom:=OB Get:C1224([DePart2:76]Proprietes:2; "centre_nom"; Est un texte:K8:3)
		$T_PointeCtrCP:=OB Get:C1224([DePart2:76]Proprietes:2; "centre_cp"; Est un texte:K8:3)
		$L_PointeCtrMed:=OB Get:C1224([DePart2:76]Proprietes:2; "centre_medicalise"; Est un entier long:K8:6)
		$B_PointeCtrMed:=OB Get:C1224([DePart2:76]Proprietes:2; "centre_is_medicalise"; Est un booléen:K8:9)
		$T_PointeCtrPlateF:=OB Get:C1224([DePart2:76]Proprietes:2; "centre_plateforme"; Est un texte:K8:3)
		$T_PointeFMGroupe:=OB Get:C1224([DePart2:76]Proprietes:2; "centre_fm_groupe"; Est un texte:K8:3)
		
		Param_init_pointage("liberer")
	End if 
	
	DUPLICATE RECORD:C225([HeberGement:5])
	[HeberGement:5]HG_Facture:172:=False:C215
	
	// Les champs dupliqués selon les réglages
	[HeberGement:5]HG_SituFamille:29:=Num:C11($T_Dup_SitFam="O")*[HeberGement:5]HG_SituFamille:29
	[HeberGement:5]HG_TempsErrance:34:=Num:C11($T_Dup_TpsErr="O")*[HeberGement:5]HG_TempsErrance:34
	[HeberGement:5]HG_DernierEmplo:37:=Num:C11($T_Dup_DerEmp="O")*[HeberGement:5]HG_DernierEmplo:37
	[HeberGement:5]HG_DuréSanEmplo:38:=Num:C11($T_Dup_DSEmp="O")*[HeberGement:5]HG_DuréSanEmplo:38
	[HeberGement:5]HG_AutreSolutio:88:=Num:C11($T_Dup_AutreSol="O")*[HeberGement:5]HG_AutreSolutio:88
	[HeberGement:5]HG_Orientation1:58:=Num:C11($T_Dup_Orient1="O")*[HeberGement:5]HG_Orientation1:58
	[HeberGement:5]HG_Orientation2:60:=Num:C11($T_Dup_Orient2="O")*[HeberGement:5]HG_Orientation2:60
	[HeberGement:5]HG_Maraude1_1:10:=Num:C11($T_Dup_Maraude="O")*[HeberGement:5]HG_Maraude1_1:10
	
	[HeberGement:5]HG_LC_ID:61:=$L_PointeCtrRéf
	[HeberGement:5]HG_CentreNom:62:=$T_PointeCtrNom
	
	[HeberGement:5]HG_ReferenceID:1:=Uut_Numerote(->[HeberGement:5])
	[HeberGement:5]HG_NbFicheLiée:79:=[HeberGement:5]HG_NbFicheLiée:79+1  //ve_IDT_NbFL
	[HeberGement:5]HG_YaFicheLiée:78:=([HeberGement:5]HG_NbFicheLiée:79>0)
	[HeberGement:5]HG_Réservation:91:=False:C215
	[HeberGement:5]HG_NuitenCours:92:=1
	[HeberGement:5]HG_NuitTOTAL:93:=1
	[HeberGement:5]HG_Reporté:94:=""
	[HeberGement:5]HG_NuitReste:95:=0
	[HeberGement:5]HG_RéservationDateFin:134:=F_RéservationDateFin($D_Current_client; [HeberGement:5]HG_NuitReste:95)
	[HeberGement:5]HG_Nuit:2:=True:C214  // vb_IDT_JN
	[HeberGement:5]HG_Date:4:=$D_Current_client
	[HeberGement:5]HG_HeureAppel:5:=$H_Current_client
	[HeberGement:5]HG_FicheNuméro:3:=i_HébérgementNoFiche("N"; [HeberGement:5]HG_Date:4; Uut_Numerote115(Current date:C33))  /// a faire : retrouver vl_Num_HBE  ->  A PRIORI elle vaut 0
	[HeberGement:5]HG_EnAttente:64:=True:C214
	[HeberGement:5]HG_DateDuJour:82:=Current date:C33
	[HeberGement:5]HG_AttenteHeur:83:=Current time:C178()
	[HeberGement:5]HG_Transmis:65:=False:C215
	[HeberGement:5]HG_PriseCharge:66:=False:C215
	[HeberGement:5]HG_Cloturée:67:=False:C215
	[HeberGement:5]HG_Permanencier:9:=Current user:C182  //va_IDT_Per
	[HeberGement:5]HG_HB_ID:19:=[HeBerge:4]HB_ReferenceID:1
	[HeberGement:5]HG_DateCreationFiche:149:=$D_Current_server
	[HeberGement:5]HG_CentreARR:63:=$T_PointeCtrCP
	[HeberGement:5]HG_Médicalisé:56:=$B_PointeCtrMed
	[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha($D_Current_server; $H_Current_server)
	SAVE RECORD:C53([HeberGement:5])
	
	If (False:C215)
		//[HeberGement]HG_UtilisateurP:=va_IDT_Util
		//[HeberGement]HG_Coordinateur:=va_IDT_Coo
		//[HeberGement]HG_Régulateur:=va_IDT_Rég
		// If (va_IDT_TypTrans>"")
		//If (F_VariablesTransite (4;1;False))
		//End if 
		
		//If (<>vb_T_ModeCHRS)
		//[HeberGement]HG_Plateforme:=<>va_UserPlateforme
		//Else 
		//[HeberGement]HG_Plateforme:=""
		//End if 
		//[HeberGement]HG_FamGroupe:=<>va_PointeFMGroupe
		//[HeberGement]HG_EtatCivil:=va_IDT_TypTrans
		//[HeberGement]HG_Signalement:=<>va_T_HBsignal
	End if 
	
End if 
