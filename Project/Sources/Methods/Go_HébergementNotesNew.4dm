//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 19/07/22, 14:53:36
// ----------------------------------------------------
// Méthode : Go_HébergementNotesNew
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_TEXT:C284($T_Message; $position_t)
C_LONGINT:C283($i_el)
C_BOOLEAN:C305($vb_OK)
C_COLLECTION:C1488($proprieteToKeep_c)

C_LONGINT:C283(<>L_Onglet_notes_C)


SET MENU BAR:C67(1)

<>L_Onglet_notes_C:=New list:C375
$i_el:=$i_el+1

APPEND TO LIST:C376(<>L_Onglet_notes_C; "Note"; $i_el)

If (<>vb_T_ModeCHRS=True:C214)
	$i_el:=$i_el+1
	APPEND TO LIST:C376(<>L_Onglet_notes_C; "Photo"; $i_el)
End if 

If (User in group:C338(Current user:C182; <>Groupe_Comptable)=True:C214)
	$i_el:=$i_el+1
	APPEND TO LIST:C376(<>L_Onglet_notes_C; "Administratif"; $i_el)
End if 

If (User in group:C338(Current user:C182; <>Groupe_Notes) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	// Modifié par : Scanu Rémy (03/08/2022)
	//CHERCHER([HeBerge]; [HeBerge]HB_ReferenceID=$1)
	READ WRITE:C146([HeBerge:4])
	READ WRITE:C146([Adresses:53])
	
	QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=$1)
	MultiSoc_Filter(->[HeBerge:4])
	
	If (Records in selection:C76([HeBerge:4])=1)
		
		// Modifié par : Scanu Rémy (13/04/2023)
		// On enlève la vérification sur le verouillage de la fiche de la table [HeBerge]
		//$L_Erreur:=4DREC_Load_Record(->[HeBerge]; ->$T_Message)  // #PHONE2017
		$L_Erreur:=1
		
		Case of 
			: ($L_Erreur=1)
				// Modified by: Kevin HASSAL (11-12-2018)
				$vb_OK:=(<>vb_T_NoteNonModifiables=False:C215)
				$vb_OK:=$vb_OK | (User in group:C338(Current user:C182; <>Groupe_NotesModife))
				
				$proprieteToKeep_c:=New collection:C1472
				outilsManageNote(99; ->$proprieteToKeep_c; <>ref_soc_active; Current user:C182)
				
				$position_t:="center"
				outilsCreateWindowsForm("HB_Notes4New"; ->$position_t; New object:C1471("typeNote"; $proprieteToKeep_c); ->[HeBerge:4])
			: ((<>PR_HBAction#0) | (<>PR_HBActionV#0))
				ALERT:C41("Veuillez au préalable fermer la fiche 'Actions'.")
			: ((<>PR_HBST#0) | (<>PR_HBSTV#0) | (<>PR_HBSP#0))
				ALERT:C41("Veuillez au préalable fermer la fiche SP.")
			Else 
				ALERT:C41($T_Message)  // #PHONE2017
		End case 
		
		UNLOAD RECORD:C212([HeBerge:4])
		READ ONLY:C145([HeBerge:4])
	Else 
		StrAlerte(4; "")
		UNLOAD RECORD:C212([HeBerge:4])
	End if 
	
Else 
	StrAlerte(6; "'Note'")
End if 

Case of 
	: ($2="N")
		<>PR_HBNotes:=0
	: ($2="V")
		<>PR_HBNotesV:=0
	: ($2="P")
		<>PR_HBNotesP:=0
End case 

CLEAR LIST:C377(<>L_Onglet_notes_C; *)