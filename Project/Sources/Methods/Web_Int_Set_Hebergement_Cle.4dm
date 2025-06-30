//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 12/11/18, 07:41:17
// ----------------------------------------------------
// Méthode : Web_Int_Set_Hebergement_Cle
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($statut_t; $type_fiche; $fiche_type_action; $fiche_numero)
C_LONGINT:C283($id; $hg_hb_id; $hg_referenceid; $process_el)
C_BOOLEAN:C305($continue_b)
C_OBJECT:C1216($O_Output; $O_Data)

ARRAY TEXT:C222($tb_restricted; 0)

$O_Output:=New object:C1471
$continue_b:=True:C214

$O_Data:=Web_AGL_Get_Post_Json_Data

$O_Data:=OB Get:C1224($O_Data; "hebergement_cle"; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))
$hg_hb_id:=Num:C11(OB Get:C1224($O_Data; "hg_hb_id"; Est un texte:K8:3))
$type_fiche:=OB Get:C1224($O_Data; "hg_nuit"; Est un texte:K8:3)
$fiche_type_action:=OB Get:C1224($O_Data; "fiche_type_action"; Est un texte:K8:3)

$statut_t:="failed"

APPEND TO ARRAY:C911($tb_restricted; "id")
APPEND TO ARRAY:C911($tb_restricted; "hg_hb_id")
APPEND TO ARRAY:C911($tb_restricted; "hg_nuit")
APPEND TO ARRAY:C911($tb_restricted; "hg_referenceid")
APPEND TO ARRAY:C911($tb_restricted; "fiche_numero")

READ WRITE:C146([HeberGement:5])

If ($fiche_type_action="update")
	QUERY:C277([HeberGement:5]; [HeberGement:5]ID:168=$id)
	
	If (Records in selection:C76([HeberGement:5])=1)
		$continue_b:=Not:C34(Locked:C147([HeberGement:5]))
	Else 
		CLEAR VARIABLE:C89($continue_b)
	End if 
	
Else 
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$hg_hb_id)
	MultiSoc_Filter(->[HeBerge:4])
	
	If (Records in selection:C76([HeBerge:4])=1)
		$hg_referenceid:=Num:C11(OB Get:C1224($O_Data; "hg_referenceid"; Est un texte:K8:3))
		$fiche_numero:=OB Get:C1224($O_Data; "fiche_numero"; Est un texte:K8:3)
		
		CREATE RECORD:C68([HeberGement:5])
		MultiSoc_Init_Structure(->[HeberGement:5])
		
		[HeberGement:5]HG_HB_ID:19:=$hg_hb_id
		[HeberGement:5]HG_ReferenceID:1:=$hg_referenceid
		[HeberGement:5]HG_FicheNuméro:3:=$fiche_numero
		
		[HeberGement:5]HG_Nuit:2:=($type_fiche="N")
		
		[HeberGement:5]HG_DateNéLe:24:=[HeBerge:4]HB_DateNéLe:5
		[HeberGement:5]HG_DateCreationFiche:149:=Current date:C33(*)
		[HeberGement:5]HG_Date:4:=Current date:C33(*)
		
		// Modifié par : Scanu Rémy (13/06/2023)
		[HeberGement:5]HG_Nom:21:=[HeBerge:4]HB_Nom:3
		[HeberGement:5]HG_Prénom:22:=[HeBerge:4]HB_Prénom:4
	Else 
		$O_Output.notificationError:="L'hébergé n'a pas pu être trouvé dans la base données."
		CLEAR VARIABLE:C89($continue_b)
	End if 
	
End if 

If ($continue_b)
	Web_AGL_Json_To_Record(->[HeberGement:5]; ->$O_Data; ->$tb_restricted)
	Web_Fam_Set_Composition(->$O_Data)
	
	// not use GF - 06/12/24
	//Si (<>ve_Si_ModeCHRS=1)  //• Si fiche d'hébergement profil Prestation
	
	//[HeberGement]HG_Réservation:=([HeberGement]HG_NuitTOTAL>1)
	
	//Si ([HeberGement]HG_Réservation=Faux)
	//[HeberGement]HG_NuitTOTAL:=1
	//Fin de si 
	
	//[HeberGement]HG_NuitReste:=[HeberGement]HG_NuitTOTAL-[HeberGement]HG_NuitenCours
	//[HeberGement]HG_RéservationDateFin:=F_RéservationDateFin([HeberGement]HG_Date; [HeberGement]HG_NuitReste)
	//Sinon 
	
	If ([HeberGement:5]HG_NuitTOTAL:93<[HeberGement:5]HG_NuitenCours:92)
		[HeberGement:5]HG_NuitTOTAL:93:=[HeberGement:5]HG_NuitenCours:92
	End if 
	
	[HeberGement:5]HG_NuitReste:95:=[HeberGement:5]HG_NuitTOTAL:93-[HeberGement:5]HG_NuitenCours:92
	[HeberGement:5]HG_RéservationDateFin:134:=F_RéservationDateFin([HeberGement:5]HG_Date:4; [HeberGement:5]HG_NuitReste:95)
	
	If ([HeberGement:5]HG_FamChef:103=True:C214)
		[HeberGement:5]HG_FamNbJour:107:=[HeberGement:5]HG_NuitTOTAL:93
		P_HG_FamilleTotal
	End if 
	
	//Fin de si // not use GF - 06/12/24
	
	// Modifié par : Scanu Rémy (15/06/2023)
	Web_HG_StatutClôture
	P_Transfert_HBAlors("Libelle")
	
	// Modifié par : Scanu Rémy (06/02/2024)
	// Ajout du genre
	[HeberGement:5]HG_Genre:96:=F_EtatCivilGenre([HeberGement:5]HG_EtatCivil:20)
	
	If (w_visiteur.notificationError=Null:C1517)
		SAVE RECORD:C53([HeberGement:5])
		UNLOAD RECORD:C212([HeberGement:5])
		
		// Modifié par : Scanu Rémy (29/05/2024)
		If ($O_Data.reportManuelDate#Null:C1517)
			$process_el:=New process:C317("outilsManageHebergement"; 0; "Report manuel structure "+w_visiteur.Ref_Structure+" - "+Substring:C12(Generate UUID:C1066; 1; 5); 2; $id; Date:C102($O_Data.reportManuelDate))
			$O_Output.notificationError:="Report manuel en tâche de fond en cours jusqu'au "+$O_Data.reportManuelDate+"... Vous pouvez continuer de travailler."
		End if 
		
		$statut_t:="success"
	Else 
		$O_Output.notificationError:=w_visiteur.notificationError
	End if 
	
End if 

READ ONLY:C145([HeberGement:5])

OB SET:C1220($O_Output; "status"; $statut_t)
$T_Json:=JSON Stringify:C1217($O_Output)

WEB SEND TEXT:C677($T_Json)