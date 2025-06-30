//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_HébergementActionNotes  
//{
//{          Lundi 28 Juillet 1997 à 17:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_TEXT:C284($T_Message)
C_LONGINT:C283($L_Max_onglet; $vl_Fenetre)
C_BOOLEAN:C305($vb_OK)

C_TEXT:C284(va_Note_LG_1; va_Note_LG_2; va_Note_LG_3; va_Note_LG_4; vt_TempNOTE; vt_TempNOTE2; vt_TempNOTE3; vt_TempNOTETRANS; vt_TempNOTEMARAUDE; vt_TempNOTEMARAUDE2; vt_TempNOTEFFV; vt_TempNOTEComptable)
C_LONGINT:C283(vl_Note_LG_1; vl_Note_LG_2; vl_Note_LG_3; vl_Note_LG_4; vl_Note_LG_5; vl_Note_LG_6; vl_Note_LG_MAX)  // #20170713-2

C_LONGINT:C283(<>L_Onglet_notes_C)

// Un jour il faudrait fusionner [HeBerge];"HB_Notes4" avec [HeBerge];"HB_Notes4F"
ARRAY TEXT:C222(ta_Page; 4)  // #20170713-1

SET MENU BAR:C67(1)

If (<>vb_T_ModeCHRS)
	$L_Max_onglet:=8
Else 
	$L_Max_onglet:=7
End if 

ta_Page{1}:=<>va_T_Onglet6Note
ta_Page{2}:=<>va_T_Onglet3Note
ta_Page{3}:=<>va_T_Onglet4Note  // #20170713-3
ta_Page{4}:=<>va_T_Onglet5Note  // #20170713-3

If (User in group:C338(Current user:C182; <>Groupe_Maraude))  // #20170713-2
	APPEND TO ARRAY:C911(ta_Page; "Maraude")
	APPEND TO ARRAY:C911(ta_Page; "Maraude2")
End if 

// Modifié par : Kevin HASSAL (09/12/2018)
// Ajoute du note FVV 
If (User in group:C338(Current user:C182; <>Groupe_FVV))
	APPEND TO ARRAY:C911(ta_Page; "FVV")
End if 

// Modified by: Kevin HASSAL (16/01/2020)
// Ajoute du note Comptable 
If (User in group:C338(Current user:C182; <>Groupe_Comptable))
	APPEND TO ARRAY:C911(ta_Page; "Comptable")
	APPEND TO ARRAY:C911(ta_Page; "Facturation")
End if 

// Modifié par : Kevin HASSAL (05/12/2018)
// Ajout de l'onglet : note FFV
<>L_Onglet_notes_C:=New list:C375

APPEND TO LIST:C376(<>L_Onglet_notes_C; "Coordonnées"; 1)
APPEND TO LIST:C376(<>L_Onglet_notes_C; "N° confidentiels"; 2)
APPEND TO LIST:C376(<>L_Onglet_notes_C; "Photo"; 3)
APPEND TO LIST:C376(<>L_Onglet_notes_C; <>va_T_Onglet6Note; 4)
APPEND TO LIST:C376(<>L_Onglet_notes_C; <>va_T_Onglet3Note; 5)
APPEND TO LIST:C376(<>L_Onglet_notes_C; <>va_T_Onglet7Note; 6)
APPEND TO LIST:C376(<>L_Onglet_notes_C; <>va_T_Onglet4Note; 7)  //"Suivi"
APPEND TO LIST:C376(<>L_Onglet_notes_C; <>va_T_Onglet5Note; 8)  //"Note Transfert"
APPEND TO LIST:C376(<>L_Onglet_notes_C; <>va_T_Onglet8Note; 9)
APPEND TO LIST:C376(<>L_Onglet_notes_C; <>va_T_Onglet9Note; 10)
APPEND TO LIST:C376(<>L_Onglet_notes_C; <>va_T_Onglet10Note; 11)
APPEND TO LIST:C376(<>L_Onglet_notes_C; "Comptable"; 13)


// Modifié par : Scanu Rémy (13/07/2022)
APPEND TO LIST:C376(<>L_Onglet_notes_C; "Note archive"; 12)

If (User in group:C338(Current user:C182; <>Groupe_Maraude)=False:C215)  // #20170731-1
	DELETE FROM LIST:C624(<>L_Onglet_notes_C; 6)
	DELETE FROM LIST:C624(<>L_Onglet_notes_C; 7)
End if 

If (Not:C34(<>vb_T_ModeCHRS))
	DELETE FROM LIST:C624(<>L_Onglet_notes_C; 8)
End if 

// Modifié par : Kevin HASSAL (09/12/2018)
// Ajout du note FVV 
If (User in group:C338(Current user:C182; <>Groupe_FVV)=False:C215)
	DELETE FROM LIST:C624(<>L_Onglet_notes_C; 9)
End if 

// Modifié par : Kevin HASSAL (09/01/2020)
// Ajout du note comptable 
If (User in group:C338(Current user:C182; <>Groupe_Comptable)=False:C215)
	DELETE FROM LIST:C624(<>L_Onglet_notes_C; 10)
	DELETE FROM LIST:C624(<>L_Onglet_notes_C; 11)
End if 

va_Note_LG_1:="Point rouge indique la capacité maximum de la note. Passez à la suivante."
va_Note_LG_1:="Point rouge indique : capacité maximum de la note. Passez à la suivante."
va_Note_LG_2:=va_Note_LG_1
va_Note_LG_3:=va_Note_LG_1
va_Note_LG_4:=va_Note_LG_1
va_Note_LG_5:=va_Note_LG_1
va_Note_LG_6:=va_Note_LG_1

vl_Note_LG_MAX:=31500

If (User in group:C338(Current user:C182; <>Groupe_Notes) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	// Modifié par : Scanu Rémy (03/08/2022)
	//CHERCHER([HeBerge]; [HeBerge]HB_ReferenceID=$1)
	QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=$1)
	MultiSoc_Filter(->[HeBerge:4])
	
	If (Records in selection:C76([HeBerge:4])=1)
		READ WRITE:C146([HeBerge:4])
		
		$L_Erreur:=4DREC_Load_Record(->[HeBerge:4]; ->$T_Message)  // #PHONE2017
		
		If ($L_Erreur=1)
			vl_Note_LG_1:=Length:C16([HeBerge:4]Notes:6)
			vl_Note_LG_2:=Length:C16([HeBerge:4]HB_Notes3:54)
			vl_Note_LG_3:=Length:C16([HeBerge:4]HB_Notes2:50)
			vl_Note_LG_4:=Length:C16([HeBerge:4]HB_NotesTrans:53)
			vl_Note_LG_5:=Length:C16([HeBerge:4]HB_Maraude:41)
			vl_Note_LG_6:=Length:C16([HeBerge:4]HB_Maraude2:51)
			vl_Note_LG_7:=Length:C16([HeBerge:4]HB_Note_FVV:69)
			
			// Modified by: Kevin HASSAL (11-12-2018)
			$vb_OK:=(<>vb_T_NoteNonModifiables=False:C215)
			$vb_OK:=$vb_OK | (User in group:C338(Current user:C182; <>Groupe_NotesModife))
			
			Case of 
				: (($vb_OK) & (User in group:C338(Current user:C182; <>Groupe_NotesMARModife)) & (User in group:C338(Current user:C182; <>Groupe_NotesFVVModife)))
					FORM SET INPUT:C55([HeBerge:4]; "HB_Notes4")
					$vl_Fenetre:=i_FenêtreNo(492; 562; 4; "Notes du demandeur"; 3; "Quit_HBNotes")
				: (($vb_OK) & (User in group:C338(Current user:C182; <>Groupe_NotesMARModife)) & (User in group:C338(Current user:C182; <>Groupe_NotesFVVModife)=False:C215))
					FORM SET INPUT:C55([HeBerge:4]; "HB_Notes_VVF")
					$vl_Fenetre:=i_FenêtreNo(492; 562; 4; "Notes du demandeur"; 3; "Quit_HBNotesF")
				: (($vb_OK) & (User in group:C338(Current user:C182; <>Groupe_NotesMARModife)=False:C215) & (User in group:C338(Current user:C182; <>Groupe_NotesFVVModife)))
					FORM SET INPUT:C55([HeBerge:4]; "HB_Notes_VFV")
					$vl_Fenetre:=i_FenêtreNo(492; 562; 4; "Notes du demandeur"; 3; "Quit_HBNotesF")
				: (($vb_OK) & (User in group:C338(Current user:C182; <>Groupe_NotesMARModife)=False:C215) & (User in group:C338(Current user:C182; <>Groupe_NotesFVVModife)=False:C215))
					FORM SET INPUT:C55([HeBerge:4]; "HB_Notes_VFF")
					$vl_Fenetre:=i_FenêtreNo(492; 562; 4; "Notes du demandeur"; 3; "Quit_HBNotesF")
				Else 
					FORM SET INPUT:C55([HeBerge:4]; "HB_Notes4F")
					$vl_Fenetre:=i_FenêtreNo(492; 562; 4; "Notes du demandeur"; 3; "Quit_HBNotesF")
			End case 
			
			MODIFY RECORD:C57([HeBerge:4]; *)
			UNLOAD RECORD:C212([HeBerge:4])
			
			CLOSE WINDOW:C154($vl_Fenetre)
			SAVE RECORD:C53([Adresses:53])
		Else 
			
			Case of 
				: ((<>PR_HBAction#0) | (<>PR_HBActionV#0))
					ALERT:C41("Veuillez au préalable fermer la fiche 'Actions'.")
				: ((<>PR_HBST#0) | (<>PR_HBSTV#0) | (<>PR_HBSP#0))
					ALERT:C41("Veuillez au préalable fermer la fiche SP.")
				Else 
					ALERT:C41($T_Message)  // #PHONE2017
			End case 
			
		End if 
		
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