//%attributes = {}
// Method Install_process_calendrier  

C_BOOLEAN:C305($1)
Case of 
	: (Count parameters:C259=0)
		
		C_LONGINT:C283($L_Process)
		$L_Process:=New process:C317(Current method name:C684; 0; Current method name:C684; False:C215; *)
	Else 
		// #20170605-3
		
		READ ONLY:C145(*)
		
		
		C_OBJECT:C1216($O_RecTolist)
		OB SET:C1220($O_RecTolist; "element_uid"; ->[TAbles:12]ID:9)
		OB SET:C1220($O_RecTolist; "element_label"; ->[TAbles:12]TB_Libellé:6)
		OB SET:C1220($O_RecTolist; "element_position"; ->[TAbles:12]TB_Ordre:8)
		OB SET:C1220($O_RecTolist; "use_selection"; True:C214)
		
		C_LONGINT:C283(L_ListeTypeRDV; L_Liste_resultat)
		
		QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_ID:2=210)  // Type de rdv ID 210
		MultiSoc_Filter(->[TAbles:12])
		L_ListeTypeRDV:=4DLISTE_from_Records(->$O_RecTolist)
		
		QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_ID:2=211)  // Resultat du rdv ID 211
		MultiSoc_Filter(->[TAbles:12])
		L_Liste_resultat:=4DLISTE_from_Records(->$O_RecTolist)
		
		REDUCE SELECTION:C351([TAbles:12]; 0)
		
		
		C_LONGINT:C283($L_Ref)
		$L_Ref:=Open form window:C675("hmCal"; Form fenêtre standard:K39:10; Centrée horizontalement:K39:1; En haut:K39:5)
		
		C_OBJECT:C1216($O_Usagers; $O_Permanenciers; $O_Kram)
		$O_Usagers:=JSON Parse:C1218("{}")  // #20170605-2
		$O_Permanenciers:=JSON Parse:C1218("{}")  // #20170605-2 à mettre à jour dès 16R3
		$O_Usagers:=Usagers_vers_objet
		$O_Permanenciers:=Permanenciers_vers_objet
		
		// 1 - Les RDV d'un permancier entre deux dates
		// 2 - Les RDV d'un usager entre deux dates
		// 3 - Les RDV d'usagers avec des permanenciers entre deux dates
		// 4 - Les RDV de tout le monde entre deux dates
		C_LONGINT:C283($L_Filtre)
		$L_Filtre:=New list:C375
		APPEND TO LIST:C376($L_Filtre; "Les RDV d'un permancier entre deux dates"; 1)
		APPEND TO LIST:C376($L_Filtre; "Les RDV d'un usager entre deux dates"; 2)
		APPEND TO LIST:C376($L_Filtre; "Les RDV d'usagers avec un permanencier entre deux dates"; 3)
		APPEND TO LIST:C376($L_Filtre; "Les RDV de tous les permanenciers entre deux dates"; 4)
		
		C_DATE:C307($D_Current_serveur_paxtel)
		$D_Current_serveur_paxtel:=Current date:C33(*)
		OB SET:C1220($O_Kram; "date_start"; Add to date:C393($D_Current_serveur_paxtel; -1; 0; 0))
		OB SET:C1220($O_Kram; "date_end"; Add to date:C393($D_Current_serveur_paxtel; 0; 1; 0))
		OB SET:C1220($O_Kram; "filtre"; $L_Filtre)
		
		CALL FORM:C1391($L_Ref; "hm_Cal_populate"; $O_Usagers; $O_Permanenciers; $O_Kram)
		
		DIALOG:C40("hmCal")
		CLOSE WINDOW:C154($L_Ref)
		
		CLEAR LIST:C377(L_ListeTypeRDV)
		CLEAR LIST:C377(L_Liste_statut)
End case 





// 

// #SYNTAX: $L_liste:=4DLISTE_from_Records (->4DObject) 
// #PARAMETERS:
//     $0 Long            : List
//     $1 Object          : Object with properties described as below
//
// Mandatory properties:
//     "element_uid"         associates a field pointer. Ex: ->[Table_1]ID
//     "element_label"       associates a field pointer. Ex: ->[Table_1]Titre)
//
// Optional properties:
//     "element_position"    associates a field pointer. Ex: ->[Table_1]Ordre)
//     "parent_id"           associates an integer.      Ex: 0
//     "element_parent"      associates a field pointer. Ex: ->[Table_1]ID_Parent
//     "use_selection"       built a list based on       Ex: True
//                           current selection