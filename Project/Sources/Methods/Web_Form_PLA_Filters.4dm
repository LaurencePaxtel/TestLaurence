//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 07/04/20, 11:34:42
// ----------------------------------------------------
// Method: Web_Form_PLA_Filters
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_TEXT:C284($2)

C_TEXT:C284($granted_users; $type_filtres; $granted_heberges)
C_LONGINT:C283($o)
C_POINTER:C301($html)

var $heberge_e : cs:C1710.HeBergeEntity
var $heberge_es : cs:C1710.HeBergeSelection

ARRAY TEXT:C222($TB_HTML; 100; 15)

ARRAY LONGINT:C221($tb_granted_users; 0)

ARRAY OBJECT:C1221($tb_privileges_config; 0)

$html:=$1
$type_filtres:=$2

Case of 
	: ($type_filtres="simple")
		READ ONLY:C145([Preferences:81])
		READ ONLY:C145([Events:103])
		READ ONLY:C145([INtervenants:10])
		READ ONLY:C145([HeBerge:4])
		
		//==========================================//
		// Privilèges : utilisateurs autorisés
		//==========================================//
		QUERY:C277([Preferences:81]; [Preferences:81]PREF_UID_user:7=w_userUID; *)
		QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_Type:2="planning_web_privileges")
		MultiSoc_Filter(->[Preferences:81])
		
		If (Records in selection:C76([Preferences:81])=1)
			OB GET ARRAY:C1229([Preferences:81]PREF_Object_Value:12; "privileges"; $tb_privileges_config)
		End if 
		
		For ($i; 1; Size of array:C274($tb_privileges_config))
			APPEND TO ARRAY:C911($tb_granted_users; Num:C11($tb_privileges_config{$i}.id))
		End for 
		
		$granted_users:="0"+";"+w_userNom+";"  // Utilisateur courant String(w_userUID)
		$granted_users:=$granted_users+"|"+"-1"+"_Tous"
		
		For ($i; 1; Size of array:C274($tb_granted_users))
			QUERY:C277([INtervenants:10]; [INtervenants:10]ID:16=$tb_granted_users{$i})
			MultiSoc_Filter(->[INtervenants:10])
			
			If (Records in selection:C76([INtervenants:10])=1)
				$granted_users:=$granted_users+"|"+String:C10($tb_granted_users{$i})+"_"+[INtervenants:10]IN_NomPrénom:8
			End if 
			
		End for 
		
		//==========================================//
		// Heberges
		//==========================================//
/*
// Evénements dont je suis participant
CHERCHER([Events_Details]; [Events_Details]EVD_User_ID=w_userUID)
SÉLECTION VERS TABLEAU([Events_Details]EVD_Event_ID; $tb_eve_participe_ids)
		
CHERCHER PAR TABLEAU([Events]ID; $tb_eve_participe_ids)
MultiSoc_Filter(->[Events])
		
NOMMER ENSEMBLE([Events]; "events_participe")
		
// Granted users
AJOUTER À TABLEAU($tb_granted_users; w_userUID)
CHERCHER PAR TABLEAU([Events]EVE_User_ID; $tb_granted_users)
		
MultiSoc_Filter(->[Events])
NOMMER ENSEMBLE([Events]; "events_granted")
		
RÉUNION("events_granted"; "events_participe"; "events_result")
UTILISER ENSEMBLE("events_result")
		
VALEURS DISTINCTES([Events]EVE_HB_ID; $tb_hb_ids)
		
CHERCHER PAR TABLEAU([HeBerge]HB_ReferenceID; $tb_hb_ids)
MultiSoc_Filter(->[HeBerge])
		
TRIER([HeBerge]; [HeBerge]HB_Nom; >)
DÉBUT SELECTION([HeBerge])
		
$granted_heberges:="Tous"+";0;"
		
Boucle ($i; 1; Taille tableau($tb_hb_ids))
$granted_heberges:=$granted_heberges+"|"+Chaîne([HeBerge]HB_ReferenceID)+"_"+[HeBerge]HB_Nom+" "+[HeBerge]HB_Prénom
		
ENREGISTREMENT SUIVANT([HeBerge])
Fin de boucle 
		
EFFACER ENSEMBLE("events_participe")
EFFACER ENSEMBLE("events_granted")
EFFACER ENSEMBLE("events_result")*/
		
		// Modifié par : Scanu Rémy (12/09/2022)
		$heberge_es:=ds:C1482.HeberGement.query("Ref_Structure = :1"; Session:C1714.storage.intervenant.Ref_Structure).HG_HB_ID_1_HB_ReferenceID.orderBy("HB_Nom asc, HB_Prénom asc")
		
		$granted_heberges:="Tous"+";0;"
		
		For each ($heberge_e; $heberge_es)
			$granted_heberges:=$granted_heberges+"|"+String:C10($heberge_e.HB_ReferenceID)+"_"+String:C10($heberge_e.HB_Nom)+" "+String:C10($heberge_e.HB_Prénom)
		End for each 
		
		$html->:=$html->+"<div class=\" iw_btns_top_right\">"
		$html->:=$html->+"<div class=\"control-group iw_pla_filters_right \">"
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="label"
		$TB_HTML{$o}{2}:="label"
		$TB_HTML{$o}{3}:=""
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Usager"
		$TB_HTML{$o}{6}:="Usager"
		$TB_HTML{$o}{7}:="search fdp_placeholder"
		$html->:=$html->+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="select"
		$TB_HTML{$o}{2}:=""
		$TB_HTML{$o}{3}:="pla_granted_heberges"
		$TB_HTML{$o}{4}:=$granted_heberges
		$TB_HTML{$o}{5}:="Usager"
		$TB_HTML{$o}{6}:="pla_granted_heberges"
		$TB_HTML{$o}{7}:="fdp_span3 span7 fdp_row_start iw_cg_width_half select2"
		$html->:=$html->+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
		$html->:=$html->+"</div>"
		
		$html->:=$html->+"<div class=\"control-group iw_pla_filters_right iw_padding_right_5px\">"
		$o:=$o+1
		$TB_HTML{$o}{1}:="label"
		$TB_HTML{$o}{2}:="label"
		$TB_HTML{$o}{3}:=""
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Utilisateur"
		$TB_HTML{$o}{6}:="Utilisateur"
		$TB_HTML{$o}{7}:=" search fdp_placeholder"
		$html->:=$html->+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
		
		$o:=$o+1
		$TB_HTML{$o}{1}:="iw_select"
		$TB_HTML{$o}{2}:=""
		$TB_HTML{$o}{3}:="pla_granted_users"
		$TB_HTML{$o}{4}:=$granted_users
		$TB_HTML{$o}{5}:="Utilisateurs"
		$TB_HTML{$o}{6}:="pla_granted_users"
		$TB_HTML{$o}{7}:="fdp_span3 span7 fdp_row_start iw_cg_width_half"
		$html->:=$html->+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
		
		$html->:=$html->+"</div>"
	Else 
		$html->:=$html->+"<div class=\"pla_filtres_top\">"
		$html->:=$html->+Web_Form_Recherche_Event("calendrier")
		$html->:=$html->+"</div>"
End case 

$html->:=$html->+"</div>"