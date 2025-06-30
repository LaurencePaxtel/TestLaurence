//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 20/12/19, 17:47:42
// ----------------------------------------------------
// Method: HG_Pointage
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_DATE:C307($4)
C_REAL:C285($5)

C_TEXT:C284($T_Cle; $return; $T_PointeCtrCP)
C_LONGINT:C283($id_origine; $i_el; $nbFiche_el)
C_REAL:C285($montant_r)
C_BOOLEAN:C305($B_PointeCtrMed; $stop_b)
C_TIME:C306($H_Current_server; $H_Current_client)
C_DATE:C307($D_Current_server; $D_Current_client)

C_TIME:C306(var_heure_fiche)
C_DATE:C307(var_date_fiche)

$T_Cle:=$1
$nbFiche_el:=1

If (Count parameters:C259>1)
	$id_origine:=$2
End if 

If (Count parameters:C259>=3)
	$nbFiche_el:=$3
End if 

// Modifié par : Scanu Rémy (24/03/2023)
// Ajout d'un 5° paramètre
If (Count parameters:C259=5)
	$montant_r:=$5
End if 

If ($T_Cle#"")
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=$T_Cle)
	MultiSoc_Filter(->[HeBerge:4])
	
	RELATE MANY:C262([HeBerge:4]HB_ReferenceID:1)
	MultiSoc_Filter(->[HeberGement:5])
	
	REDUCE SELECTION:C351([DossierSante:33]; 0)
	REDUCE SELECTION:C351([Maraude:24]; 0)
	
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
	
	REDUCE SELECTION:C351([HeberGement:5]; 1)  // le plus récent
	
	If (Records in selection:C76([HeberGement:5])=1)
		$H_Current_server:=Current time:C178(*)
		$H_Current_client:=Current time:C178
		
		$D_Current_server:=Current date:C33(*)
		$D_Current_client:=Current date:C33
		
		If ($id_origine>0)
			$D_Current_server:=var_date_fiche
			$D_Current_client:=var_date_fiche
			$H_Current_server:=var_heure_fiche
			$H_Current_client:=var_heure_fiche
		End if 
		
/*Si (Vrai)  // Param_champ_duplique
Param_champ_duplique("get")
		
$T_Dup_SitFam:=OB Lire([DePart2]Proprietes; "situation_famille"; Est un texte)  // [HeberGement]HG_SituFamille
$T_Dup_TpsErr:=OB Lire([DePart2]Proprietes; "temps_errance"; Est un texte)  // [HeberGement]HG_TempsErrance
$T_Dup_DerEmp:=OB Lire([DePart2]Proprietes; "dernier_emploi"; Est un texte)  // [HeberGement]HG_DernierEmplo
$T_Dup_DSEmp:=OB Lire([DePart2]Proprietes; "duree_sans_emploi"; Est un texte)  // [HeberGement]HG_DuréSanEmplo
		
$T_Dup_DSEmpPlus:=OB Lire([DePart2]Proprietes; "duree_sans_emploi_incremente"; Est un texte)  // ?????
$T_Dup_Ctr:=OB Lire([DePart2]Proprietes; "gestion_centre_vide"; Est un texte)  // si "O" alors recopier les deux en dessous
$L_Dup_CtrRéf:=OB Lire([DePart2]Proprietes; "controleur_ref"; Est un entier long)  // la variable dans le champs -> [HeberGement]HG_LC_ID
$T_Dup_CtrNom:=OB Lire([DePart2]Proprietes; "controleur_nom"; Est un texte)  // la variable dans le champs -> [HeberGement]HG_CentreNom
$T_Dup_AutreSol:=OB Lire([DePart2]Proprietes; "autre_solution"; Est un texte)  // [HeberGement]HG_AutreSolutio
$T_Dup_Orient1:=OB Lire([DePart2]Proprietes; "orientation1"; Est un texte)  // [HeberGement]HG_Orientation1
$T_Dup_Orient2:=OB Lire([DePart2]Proprietes; "orientation2"; Est un texte)  // [HeberGement]HG_Orientation2
$T_Dup_Maraude:=OB Lire([DePart2]Proprietes; "maraude"; Est un texte)  // [HeberGement]HG_Maraude1_1
$T_Dup_Nationalite:=OB Lire([DePart2]Proprietes; "nationalite"; Est un texte)  // [HeberGement]HG_Nationalité
		
Param_champ_duplique("liberer")
Fin de si */
		
/*
// Not use - GF - 06/12/24
Param_init_pointage("get")
		
$T_PointeCtrCP:=OB Lire([DePart2]Proprietes; "centre_cp"; Est un texte)
$B_PointeCtrMed:=OB Lire([DePart2]Proprietes; "centre_is_medicalise"; Est un booléen)
		
LIBÉRER ENREGISTREMENT([DePart2])
*/
		
		// Modifié par : Scanu Rémy (05/08/2022)
		F_VariablesTransite(2; 1; False:C215)
		
		// Modifié par : Scanu Rémy (24/01/2024)
		If (Value type:C1509(erreurMessageDuplication_t)#Est une variable indéfinie:K8:13)
			$stop_b:=(erreurMessageDuplication_t#"")
		End if 
		
		If ($stop_b=False:C215)
			
			// Modifié par : Scanu Rémy (09/12/2022)
			For ($i_el; 1; $nbFiche_el)
				DUPLICATE RECORD:C225([HeberGement:5])
				F_VariablesTransite(4; 1; False:C215)
				
/*[HeberGement]HG_Facture:=Faux
				
// Les champs dupliqués selon les réglages
[HeberGement]HG_SituFamille:=Num($T_Dup_SitFam="O")*[HeberGement]HG_SituFamille
[HeberGement]HG_TempsErrance:=Num($T_Dup_TpsErr="O")*[HeberGement]HG_TempsErrance
[HeberGement]HG_DernierEmplo:=Num($T_Dup_DerEmp="O")*[HeberGement]HG_DernierEmplo
[HeberGement]HG_DuréSanEmplo:=Num($T_Dup_DSEmp="O")*[HeberGement]HG_DuréSanEmplo
[HeberGement]HG_AutreSolutio:=Num($T_Dup_AutreSol="O")*[HeberGement]HG_AutreSolutio
[HeberGement]HG_Orientation1:=Num($T_Dup_Orient1="O")*[HeberGement]HG_Orientation1
[HeberGement]HG_Orientation2:=Num($T_Dup_Orient2="O")*[HeberGement]HG_Orientation2
[HeberGement]HG_Maraude1_1:=Num($T_Dup_Maraude="O")*[HeberGement]HG_Maraude1_1*/
				
				If (Records in selection:C76([LesCentres:9])=1)
					[HeberGement:5]HG_LC_ID:61:=[LesCentres:9]LC_RéférenceID:1
					[HeberGement:5]HG_CentreNom:62:=[LesCentres:9]LC_Nom:4
				End if 
				
				[HeberGement:5]HG_Origine_ID:175:=$id_origine
				
				[HeberGement:5]HG_ReferenceID:1:=Uut_Numerote(->[HeberGement:5])
				[HeberGement:5]HG_NbFicheLiée:79:=[HeberGement:5]HG_NbFicheLiée:79+1  //ve_IDT_NbFL
				[HeberGement:5]HG_YaFicheLiée:78:=([HeberGement:5]HG_NbFicheLiée:79>0)
				[HeberGement:5]HG_Réservation:91:=False:C215
				[HeberGement:5]HG_NuitenCours:92:=1
				[HeberGement:5]HG_NuitTOTAL:93:=1
				[HeberGement:5]HG_Reporté:94:=""
				[HeberGement:5]HG_NuitReste:95:=0
				[HeberGement:5]HG_Nuit:2:=vb_IDT_JN
				[HeberGement:5]HG_RéservationDateFin:134:=F_RéservationDateFin($D_Current_client; [HeberGement:5]HG_NuitReste:95)
				
				// Modifié par : Scanu Rémy (16/12/2022) et re-modifié par Scanu Rémy (04/04/2023)
				Case of 
					: (Count parameters:C259>=4)
						[HeberGement:5]HG_Date:4:=$4
					Else 
						[HeberGement:5]HG_Date:4:=$D_Current_client
				End case 
				
				[HeberGement:5]HG_DateCreationFiche:149:=$D_Current_server
				[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha($D_Current_server; $H_Current_server)
				[HeberGement:5]HG_HeureAppel:5:=Current time:C178
				[HeberGement:5]HG_HeureAppel:5:=$H_Current_client
				
				If (vb_IDT_JN)
					[HeberGement:5]HG_FicheNuméro:3:=i_HébérgementNoFiche("N"; [HeberGement:5]HG_Date:4; Uut_Numerote115([HeberGement:5]HG_Date:4))
				Else 
					[HeberGement:5]HG_FicheNuméro:3:=i_HébérgementNoFiche("J"; [HeberGement:5]HG_Date:4; Uut_Numerote115([HeberGement:5]HG_Date:4))
				End if 
				
				[HeberGement:5]HG_EnAttente:64:=True:C214
				[HeberGement:5]HG_DateDuJour:82:=Current date:C33
				[HeberGement:5]HG_AttenteHeur:83:=Current time:C178
				[HeberGement:5]HG_Transmis:65:=False:C215
				[HeberGement:5]HG_PriseCharge:66:=False:C215
				[HeberGement:5]HG_Cloturée:67:=False:C215
				[HeberGement:5]HG_Permanencier:9:=Current user:C182  //va_IDT_Per
				[HeberGement:5]HG_HB_ID:19:=[HeBerge:4]HB_ReferenceID:1
				//[HeberGement]HG_CentreARR:=$T_PointeCtrCP  // Not use - GF - 06/12/24
				//[HeberGement]HG_Médicalisé:=$B_PointeCtrMed  // Not use - GF - 06/12/24
				[HeberGement:5]HG_FamGroupe:102:=txt_groupe
				
				
				If (Session:C1714.storage.intervenant.Plateforme#Null:C1517)
					[HeberGement:5]HG_Plateforme:139:=Session:C1714.storage.intervenant.Plateforme
				Else 
					[HeberGement:5]HG_Plateforme:139:=Storage:C1525.intervenantsDetail.UserPlateforme
				End if 
				
				[HeberGement:5]HG_Cloturée:67:=True:C214
				[HeberGement:5]HG_Nom:21:=Uppercase:C13([HeBerge:4]HB_Nom:3)
				[HeberGement:5]HG_Prénom:22:=Uppercase:C13([HeBerge:4]HB_Prénom:4)
				
				If (Count parameters:C259=5)
					[HeberGement:5]HG_Montant:179:=$montant_r
				End if 
				
				SAVE RECORD:C53([HeberGement:5])
			End for 
			
			$return:="true"
		Else 
			$return:=erreurMessageDuplication_t
		End if 
		
	Else 
		$return:="Aucune fiche d'hébergement pour l'usager sélectionné."
	End if 
	
Else 
	$return:="Vous devez choisir un hébergé"
End if 

If (Application type:C494#4D Server:K5:6) & ($return#"true")
	ALERT:C41($return)
Else 
	$0:=$return  //mode web
End if 