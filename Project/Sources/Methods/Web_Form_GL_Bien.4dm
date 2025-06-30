//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 10-01-19, 19:22:41
// ----------------------------------------------------
// Method: Web_Form_GL_Bien
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($type; $disabled_nom; $HTML_CONTENT; FIX_DATE_FORMAT; $form_layout; $html)
C_LONGINT:C283($o)
C_OBJECT:C1216($table_o)

ARRAY TEXT:C222($TB_HTML; 150; 15)

$type:=$1
$disabled_nom:="readonly"

FIX_DATE_FORMAT:="dd/mm/yyyy"
PARAM_MANDATORY_FIELDS:=""
WEB_CHAMP_Saisissable:=""

UTL_Add_Script("gl_fiche_bien")
UTL_Add_Script("gl_liste_locations")
UTL_Add_Script("gl_charges")
UTL_Add_Script("gl_bien_inventaire_pieces")
UTL_Add_Script("gl_bien_pieces")

Web_UTL_Add_CSS("gl_fiche_bien")
Web_UTL_Add_CSS("gl_liste_usagers")
Web_UTL_Add_CSS("recherche_usager")
Web_UTL_Add_CSS("gl_liste_usagers")
Web_UTL_Add_CSS("gl_liste_locations")
Web_UTL_Add_CSS("fiche_usager")
Web_UTL_Add_CSS("form_list")
Web_UTL_Add_CSS("form")
Web_UTL_Add_CSS("gl_charges")
Web_UTL_Add_CSS("gl_bien_inventaire_pieces")

$HTML_CONTENT:=$HTML_CONTENT+"<form action=\"GL?action=bien_fiche_valider\" name=\"fiche_form\" id=\"fiche_form\" method=\"POST\" class=\"collectable form-horizontal well user_fiche\" enctype=\"multipart/form-data\" >"
$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Boutons("gl_bien_fiche_top")
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_piece_entete\">"

//=========================================================================//
// COL LEFT
//=========================================================================//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row\">"

//-------------------------------------------------------------------------//
// DIV CONTENT 1
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_cg_width_third\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Nom du bien"
$TB_HTML{$o}{6}:="Nom du bien"
$TB_HTML{$o}{7}:="fdp_width100 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="lc_gl_nom_suite"
$TB_HTML{$o}{4}:=[LesCentres:9]LC_GL_Nom_Suite:63
$TB_HTML{$o}{5}:="lc_gl_nom_suite"
$TB_HTML{$o}{6}:="lc_gl_nom_suite"
$TB_HTML{$o}{7}:="span7 search "+Choose:C955(Find in array:C230(w_variables; "retour")>0; ""; $disabled_nom)
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

READ ONLY:C145([Proprietaires:83])
QUERY:C277([Proprietaires:83]; [Proprietaires:83]ID:1=[LesCentres:9]LC_GL_Proprietaire_ID:66)

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_cg_width_third \">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Nom du propriétaire"
$TB_HTML{$o}{6}:="Nom du propriétaire"
$TB_HTML{$o}{7}:="fdp_width100 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="lc_gl_proprietaire_nom"
$TB_HTML{$o}{4}:=[Proprietaires:83]PRO_Nom:2+" "+[Proprietaires:83]PRO_Prenom:3
$TB_HTML{$o}{5}:="lc_gl_proprietaire_nom"
$TB_HTML{$o}{6}:="lc_gl_proprietaire_nom"
$TB_HTML{$o}{7}:="span7 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

// Modifié par : Scanu Rémy (25/03/2022)
$table_o:=ds:C1482.Proprietaires.query("ID IS NOT :1"; [Proprietaires:83]ID:1)
outilsOrdaSearchByRefStctre(->$table_o)

w_visiteur.proprietaires:=$table_o.orderBy("PRO_Nom asc").toCollection()
w_visiteur.entity:=ds:C1482.LesCentres.get([LesCentres:9]ID:60).toObject()

// Modified by: KEVIN HASSAL (20/05/29)
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"input-group-mb3 mb-3 control-group iw_cg_width_third \">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Nom de l'immeuble"
$TB_HTML{$o}{6}:="Nom de l'immeuble"
$TB_HTML{$o}{7}:="fdp_width100 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="iw_select_btn"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="lc_immeuble_id"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="lc_immeuble_id"
$TB_HTML{$o}{6}:="lc_immeuble_id"
$TB_HTML{$o}{7}:="span7 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group  fdp_row_start iw_cg_width_third\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Type du bien"
$TB_HTML{$o}{6}:="Type du bien"
$TB_HTML{$o}{7}:="fdp_width100 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="lc_gl_type"
$TB_HTML{$o}{4}:=[LesCentres:9]LC_GL_Type:64
$TB_HTML{$o}{5}:="lc_gl_type"
$TB_HTML{$o}{6}:="lc_gl_type"
$TB_HTML{$o}{7}:="span7 search "+Choose:C955(Find in array:C230(w_variables; "retour")>0; ""; $disabled_nom)
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_cg_width_third\">"



$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Nombre de places"
$TB_HTML{$o}{6}:="Nombre de places"
$TB_HTML{$o}{7}:="fdp_width100 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
       $TB_HTML{$o}{1}:="input"
       $TB_HTML{$o}{2}:="text"
       $TB_HTML{$o}{3}:="lc_gl_nombre_places"
       $TB_HTML{$o}{4}:=[LesCentres:9]LC_GL_Nombre_Places:65
       $TB_HTML{$o}{5}:="lc_gl_nombre_places"
       $TB_HTML{$o}{6}:="lc_gl_nombre_places"
$TB_HTML{$o}{7}:="span7 search "+Choose:C955(Find in array:C230(w_variables; "retour")>0; ""; $disabled_nom)
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

// Modifié par : Scanu Rémy - remy@connect-io.fr (27/07/2022)
// Ajout des autres champs demandés par Laurence (Chauffage, Climatisation, Eau, Radiateur, Chaudière)
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group  fdp_row_start iw_cg_width_third\">"


$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Type de chauffage"
$TB_HTML{$o}{6}:="Type de chauffage"
$TB_HTML{$o}{7}:="fdp_width100 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="lc_chauffagetype"
$TB_HTML{$o}{4}:=";;|Collectif_Collectif"+Choose:C955([LesCentres:9]LC_ChauffageType:87="Collectif"; "_s"; "")+"|Individuel_Individuel"+Choose:C955([LesCentres:9]LC_ChauffageType:87="Individuel"; "_s"; "")
$TB_HTML{$o}{5}:="lc_chauffagetype"
$TB_HTML{$o}{6}:="lc_chauffagetype"
$TB_HTML{$o}{7}:="span7 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_cg_width_third\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Energie du chauffage"
$TB_HTML{$o}{6}:="Energie du chauffage"
$TB_HTML{$o}{7}:="fdp_width100 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="lc_chauffageenergie"
$TB_HTML{$o}{4}:=";;|Electrique_Electrique"+Choose:C955([LesCentres:9]LC_ChauffageEnergie:88="Electrique"; "_s"; "")+"|Gaz_Gaz"+Choose:C955([LesCentres:9]LC_ChauffageEnergie:88="Gaz"; "_s"; "")+"|Fioul_Fioul"+Choose:C955([LesCentres:9]LC_ChauffageEnergie:88="Fioul"; "_s"; "")
$TB_HTML{$o}{5}:="lc_chauffageenergie"
$TB_HTML{$o}{6}:="lc_chauffageenergie"
$TB_HTML{$o}{7}:="span7 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_cg_width_third\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Type eau chaude"
$TB_HTML{$o}{6}:="Type eau chaude"
$TB_HTML{$o}{7}:="fdp_width100 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="lc_eauchaudetype"
$TB_HTML{$o}{4}:=";;|Collectif_Collectif"+Choose:C955([LesCentres:9]LC_EauChaudeType:90="Collectif"; "_s"; "")+"|Individuel_Individuel"+Choose:C955([LesCentres:9]LC_EauChaudeType:90="Individuel"; "_s"; "")
$TB_HTML{$o}{5}:="lc_eauchaudetype"
$TB_HTML{$o}{6}:="lc_eauchaudetype"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_cg_width_third\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Energie de l'eau chaude"
$TB_HTML{$o}{6}:="Energie de l'eau chaude"
$TB_HTML{$o}{7}:="fdp_width100 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="lc_eauchaudeenergie"
$TB_HTML{$o}{4}:=";;|Electrique_Electrique"+Choose:C955([LesCentres:9]LC_EauChaudeEnergie:91="Electrique"; "_s"; "")+"|Gaz_Gaz"+Choose:C955([LesCentres:9]LC_EauChaudeEnergie:91="Gaz"; "_s"; "")+"|Fioul_Fioul"+Choose:C955([LesCentres:9]LC_EauChaudeEnergie:91="Fioul"; "_s"; "")
$TB_HTML{$o}{5}:="lc_eauchaudeenergie"
$TB_HTML{$o}{6}:="lc_eauchaudeenergie"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_cg_width_third\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Conventionné"
$TB_HTML{$o}{6}:="Conventionné"
$TB_HTML{$o}{7}:="fdp_width100 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="lc_conventionne"
$TB_HTML{$o}{4}:=outilsWebSelectGetOptionHTML("GI: Conventionné"; [LesCentres:9]LC_Conventionne:105)
$TB_HTML{$o}{5}:="lc_conventionne"
$TB_HTML{$o}{6}:="lc_conventionne"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw"

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"rowB control-group iw_cg_width_third\">"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"col-12\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"g-align-bottom-leftB\">"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_input_small"
$TB_HTML{$o}{2}:="iw_input_small"
$TB_HTML{$o}{3}:="lc_radiateurnb"
$TB_HTML{$o}{4}:=String:C10([LesCentres:9]LC_RadiateurNb:92)
$TB_HTML{$o}{5}:="Nombre de radiateur"
$TB_HTML{$o}{6}:="lc_radiateurnb"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group  fdp_row_start iw_cg_width_third\">"

$o:=$o+1
$TB_HTML{$o}{1}:="iw_input_small"
$TB_HTML{$o}{2}:="iw_input_small"
$TB_HTML{$o}{3}:="lc_parking"
$TB_HTML{$o}{4}:=String:C10([LesCentres:9]LC_Parking:106)
$TB_HTML{$o}{5}:="Nombre de parkings"
$TB_HTML{$o}{6}:="lc_parking"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_cg_width_third\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Climatisation"
$TB_HTML{$o}{6}:="Climatisation"
$TB_HTML{$o}{7}:="fdp_width100 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="lc_climatisation"
$TB_HTML{$o}{4}:=String:C10([LesCentres:9]LC_Climatisation:89)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="lc_climatisation"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

//$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start iw_cg_width_third\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_cg_width_third\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Chaudière"
$TB_HTML{$o}{6}:="Chaudière"
$TB_HTML{$o}{7}:="fdp_width100 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="lc_chaudiere"
$TB_HTML{$o}{4}:=String:C10([LesCentres:9]LC_Chaudiere:93)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="lc_chaudiere"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_cg_width_third\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Chauffe-eau"
$TB_HTML{$o}{6}:="Chauffe-eau"
$TB_HTML{$o}{7}:="fdp_width100 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="lc_chauffeeau"
$TB_HTML{$o}{4}:=String:C10([LesCentres:9]LC_ChauffeEau:94)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="lc_chauffeeau"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_cg_width_third\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Cave"
$TB_HTML{$o}{6}:="Cave"
$TB_HTML{$o}{7}:="fdp_width100 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="lc_cave"
$TB_HTML{$o}{4}:=String:C10([LesCentres:9]LC_Cave:102)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="lc_cave"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_cg_width_third\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Balcon"
$TB_HTML{$o}{6}:="Balcon"
$TB_HTML{$o}{7}:="fdp_width100 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="lc_balcon"
$TB_HTML{$o}{4}:=String:C10([LesCentres:9]LC_Balcon:103)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="lc_balcon"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_cg_width_third\">"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Terrasse"
$TB_HTML{$o}{6}:="Terrasse"
$TB_HTML{$o}{7}:="fdp_width100 search"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="iw_radio"
$TB_HTML{$o}{2}:="iw_radio"
$TB_HTML{$o}{3}:="lc_terrasse"
$TB_HTML{$o}{4}:=String:C10([LesCentres:9]LC_Terrasse:104)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="lc_terrasse"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw"
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$o:=$o+1
$TB_HTML{$o}{1}:="label"
$TB_HTML{$o}{2}:="label"
$TB_HTML{$o}{3}:=""
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Observations"
$TB_HTML{$o}{6}:="Observations"
$TB_HTML{$o}{7}:="fdp_width100 search "
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="textarea"
$TB_HTML{$o}{3}:="fac_notes"
$TB_HTML{$o}{4}:=String:C10([LesCentres:9]LC_Observations:108)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="lc_observations"
$TB_HTML{$o}{7}:="span7 search"+WEB_CHAMP_Saisissable
$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_cg_width_third\">"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

$HTML_CONTENT:=$HTML_CONTENT+"</div>"  //iw_div_content
$HTML_CONTENT:=$HTML_CONTENT+"</div>"  //row
//=========================================================================//

//=========================================================================//

$HTML_CONTENT:=$HTML_CONTENT+"</div>"  //fin entete

//==============================================================//
// LES LOCATIONS
//==============================================================//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_width_full\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_titre_liste iw_width_half\">"
$HTML_CONTENT:=$HTML_CONTENT+"LES LOCATIONS"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

BTN_LISTE:=""
BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons\">"
BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
BTN_LISTE:=BTN_LISTE+"<button id=\"btn_inventaire_pieces\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-building-o\"></i>"+LANG_TXT_BTN_INVENTAIRE+"</button>"
BTN_LISTE:=BTN_LISTE+"<button id=\"btn_recalculer_irl_loc\" type=\"reset\" class=\"fdp_Button fdp_btn_top fdp-btn-orange iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-calculator\"></i>"+LANG_TXT_BTN_RECALCULER_IRL+"</button>"
BTN_LISTE:=BTN_LISTE+"<button id=\"btn_reset_loc\" type=\"reset\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-eraser\"></i>"+LANG_TXT_BTN_CLEAR+"</button>"
BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new_loc\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NOUVELLE_LOCATION+"</button>"
BTN_LISTE:=BTN_LISTE+"<button id=\"btn_display_all_loc\" type=\"submit\" class=\"fdp_Button fdp_btn_top iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-eye\"></i>"+LANG_TXT_BTN_AFFICHER_TOUT+"</button>"
BTN_LISTE:=BTN_LISTE+"<button id=\"btn_search_loc\" type=\"submit\" class=\"fdp_Button fdp_btn_top\" onclick=\"return false;\"><i class=\"fa fa-search\"></i>"+LANG_TXT_BTN_SEARCH+"</button>"
BTN_LISTE:=BTN_LISTE+"</div>"
BTN_LISTE:=BTN_LISTE+"</div>"
BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE_TOP:=BTN_LISTE
BTN_LISTE:=""

$form_layout:="static"

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_width_full iw_search_form\">"

Web_Form_Locations(->$form_layout; ->$HTML_CONTENT)

$HTML_CONTENT:=$HTML_CONTENT+BTN_LISTE_TOP
$HTML_CONTENT:=$HTML_CONTENT+"</div>"

$HTML_CONTENT:=$HTML_CONTENT+"<div  class=\"iw_piece_lignes\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div id=\"list_table_locations\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"table\">"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//===============================END LOCATIONS==========================================//

//=============================================================================//
// SINISTRES
//=============================================================================//
BTN_LISTE:=""

BTN_LISTE:=BTN_LISTE+"<div class=\"iw_width_full\">"

BTN_LISTE:=BTN_LISTE+"<div class=\"iw_titre_liste iw_width_half\">"
BTN_LISTE:=BTN_LISTE+"LES SINISTRES"
BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons iw_width_half\">"
BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new_sinistre\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px fdp_btn_piece_ligne\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NOUVEAU_SINISTRE+"</button>"
BTN_LISTE:=BTN_LISTE+"<button id=\"btn_dashboard_sinistres\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-brown iw_margin_left_5px fdp_btn_piece_ligne\" onclick=\"return false;\"><i class=\"fa fa-dashboard\"></i>"+LANG_TXT_BTN_TABLEAU_DE_BORD+"</button>"
BTN_LISTE:=BTN_LISTE+"</div>"
BTN_LISTE:=BTN_LISTE+"</div>"
BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE_TOP:=BTN_LISTE
BTN_LISTE:=""

$HTML_CONTENT:=$HTML_CONTENT+BTN_LISTE_TOP

$HTML_CONTENT:=$HTML_CONTENT+"<div  class=\"iw_piece_lignes\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div id=\"list_table_sinistres\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"table\">"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//===============================END SINISTRES==========================================//

//=============================================================================//
// LES CHARGES
//=============================================================================//
BTN_LISTE:=""

BTN_LISTE:=BTN_LISTE+"<div class=\"iw_width_full\">"

BTN_LISTE:=BTN_LISTE+"<div class=\"iw_titre_liste iw_width_half\">"
BTN_LISTE:=BTN_LISTE+"LES CHARGES"
BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons iw_width_half\">"
BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new_charge\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px fdp_btn_piece_ligne\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NOUVELLE_CHARGE+"</button>"
BTN_LISTE:=BTN_LISTE+"</div>"
BTN_LISTE:=BTN_LISTE+"</div>"
BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE_TOP:=BTN_LISTE
BTN_LISTE:=""

$HTML_CONTENT:=$HTML_CONTENT+BTN_LISTE_TOP

$HTML_CONTENT:=$HTML_CONTENT+"<div  class=\"iw_piece_lignes\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div id=\"list_table_charges\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"table\">"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//===============================END CHARGES==========================================//

//=============================================================================//
// LES EQUIPEMENTS
//=============================================================================//
BTN_LISTE:=""

BTN_LISTE:=BTN_LISTE+"<div class=\"iw_width_full\">"

BTN_LISTE:=BTN_LISTE+"<div class=\"iw_titre_liste iw_width_half\">"
BTN_LISTE:=BTN_LISTE+"LES ÉQUIPEMENTS"
BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE:=BTN_LISTE+"<div class=\"span6 fdp_boutons iw_width_half\">"
BTN_LISTE:=BTN_LISTE+"<div class=\"buttons\">"
BTN_LISTE:=BTN_LISTE+"<div class=\"btn-wrapper\">"
BTN_LISTE:=BTN_LISTE+"<button id=\"btn_suppr_equipement\" class=\"fdp_Button fdp_btn_top fdp-btn-red iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-trash\"></i>Supprimer</button>"

// Modifié par : Scanu Rémy (17/10/2022)
//BTN_LISTE:=BTN_LISTE+"<button id=\"btn_add_kit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>Ajouter un kit</button>"

BTN_LISTE:=BTN_LISTE+"<button id=\"btn_new_equipement\" type=\"submit\" class=\"fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px fdp_btn_piece_ligne\" onclick=\"return false;\"><i class=\"fa fa-plus\"></i>"+LANG_TXT_BTN_NOUVEAU_EQU+"</button>"
BTN_LISTE:=BTN_LISTE+"</div>"
BTN_LISTE:=BTN_LISTE+"</div>"
BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE:=BTN_LISTE+"<div id=\"kitSelection\" class=\"rowB\">"

BTN_LISTE:=BTN_LISTE+"<div class=\"col-6\">"
BTN_LISTE:=BTN_LISTE+"</div>"
BTN_LISTE:=BTN_LISTE+"<div class=\"col-6\">"
BTN_LISTE:=BTN_LISTE+"<button id=\"btn_valid_kit\" class=\"fdp_Button fdp_btn_top fdp-btn-blue iw_margin_left_5px iw_margin_bottom_10px\" onclick=\"return false;\"><i class=\"fa fa-check\"></i>Ajouter le kit</button>"
BTN_LISTE:=BTN_LISTE+"<select id=\"kitList\" class=\"iw_float_right\">"
BTN_LISTE:=BTN_LISTE+"<option value=\"\">Sélectionnez un kit</option>"
BTN_LISTE:=BTN_LISTE+"</select>"
BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE:=BTN_LISTE+"</div>"

BTN_LISTE_TOP:=BTN_LISTE
BTN_LISTE:=""

$HTML_CONTENT:=$HTML_CONTENT+BTN_LISTE_TOP

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_piece_lignes\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div id=\"list_table_equipements\" class=\"fdp_resp_table wrap-table100 iw-alternance-only\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"table\">"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//===============================END LES EQUIPEMENTS==========================================//

// DEBUT PIED 
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_piece_pied \" style=\"\">"

//=========================================================================//
// COL LEFT
//=========================================================================//

$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_col_left iw_display_none\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row\">"

//-------------------------------------------------------------------------//
// DIV CONTENT 1
//-------------------------------------------------------------------------//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content iw_third\">"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//-------------------------------------------------------------------------//

$HTML_CONTENT:=$HTML_CONTENT+"</div>"  //row
$HTML_CONTENT:=$HTML_CONTENT+"</div>"  // col left
//=========================================================================//

//=========================================================================//
// COL RIGHT
//=========================================================================//
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_col_right iw_display_none\">"
$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row\">"

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</div>"
//=========================================================================//

//=========================================================================//
// Hidden 
//=========================================================================//
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="fac_destinataire_id"
$TB_HTML{$o}{4}:=String:C10([Factures:86]FAC_Destinataire_ID:11)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="fac_destinataire_id"
$TB_HTML{$o}{7}:=""

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="record_id"
$TB_HTML{$o}{4}:=String:C10([LesCentres:9]ID:60)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="record_id"
$TB_HTML{$o}{7}:=""

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="ref_structure"
$TB_HTML{$o}{4}:=[Factures:86]Ref_Structure:19
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="ref_structure"
$TB_HTML{$o}{7}:=""

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory"
$TB_HTML{$o}{4}:=PARAM_MANDATORY_FIELDS
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory"
$TB_HTML{$o}{7}:=""

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="method"
$TB_HTML{$o}{4}:="GET"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="method"
$TB_HTML{$o}{7}:=""

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="form_back_view"
$TB_HTML{$o}{4}:=web_form_back_view
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="form_back_view"
$TB_HTML{$o}{7}:=""

$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="action"
$TB_HTML{$o}{4}:=$action
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="action"
$TB_HTML{$o}{7}:=""

$HTML_CONTENT:=$HTML_CONTENT+"</div>"
$HTML_CONTENT:=$HTML_CONTENT+"</form>"

$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Sinistre_Popup("gl_sinistre_bien_valider"; "sinistres_biens_list_json"; False:C215)
$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Charge_Popup("gl_charge_bien_valider"; "charges_biens_list_json"; False:C215)
$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Inventaire_Popup("gl_inventaire_pieces_valider"; "inventaire_pieces_list_json")
$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Pieces_Popup("gl_bien_pieces_valider"; "gl_bien_pieces_list_json")

$html:=Web_Form_GI_Immeuble
$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Popup("immeuble"; ->$html; False:C215)

$html:=Web_Form_GI_Equipement("LK")
$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Popup("equipement"; ->$html; False:C215)

$0:=$HTML_CONTENT