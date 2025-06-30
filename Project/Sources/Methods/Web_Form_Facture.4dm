//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 20-12-18, 12:21:17
// ----------------------------------------------------
// Method: Web_Form_Facture
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($type; $disabled; $HTML_CONTENT; $path_t; $destinataireFacture_t)
C_LONGINT:C283($o)
C_BOOLEAN:C305($privileges_facturation)

var $factures_e : cs:C1710.FacturesEntity
C_TEXT:C284(FIX_DATE_FORMAT)

ARRAY TEXT:C222($TB_HTML; 150; 15)

ARRAY TEXT:C222($tb_enum_values; 0)
ARRAY TEXT:C222($observationModele_at; 0)

$type:=$1

WEB_CHAMP_Saisissable:=""

$HTML_CONTENT:=""
FIX_DATE_FORMAT:="dd/mm/yyyy"

PARAM_MANDATORY_FIELDS:=""

If (ds:C1482.Factures.get([Factures:86]ID:1)#Null:C1517)
	w_visiteur.entity:=ds:C1482.Factures.get([Factures:86]ID:1).toObject()
	$factures_e:=ds:C1482.Factures.get([Factures:86]ID:1)
Else 
	w_visiteur.entity:=ds:C1482.Factures.new().toObject()
	$factures_e:=ds:C1482.Factures.new()
End if 

$privileges_facturation:=Web_User_Check_Privilege("Privilege Facturation Web")

Case of 
	: (Bool:C1537(Num:C11(w_visiteur.newInvoice))=True:C214) | ([Factures:86]FAC_Type_Piece:40="autre")
		//PARAM_MANDATORY_FIELDS:="fac_locataire_nom;fac_locataire_id;fac_date_piece;fac_type;fac_date_echeance;fac_montant_ttc;fac_categorie" modif LPC 19/08/2024 : suppression du champs bligatoire total TTC pour pouvoir valider des factures à 0€ TTC
		PARAM_MANDATORY_FIELDS:="fac_locataire_nom;fac_locataire_id;fac_date_piece;fac_type;fac_date_echeance;fac_categorie"
	: ([Factures:86]FAC_Cloture:10=False:C215)
		//PARAM_MANDATORY_FIELDS:="fac_bien_nom;fac_locataire_nom;fac_bien_id;fac_locataire_id;fac_date_piece;fac_type;fac_date_echeance;fac_montant_ttc" modif LPC 19/08/2024 : suppression du champs bligatoire total TTC pour pouvoir valider des factures à 0€ TTC
		PARAM_MANDATORY_FIELDS:="fac_bien_nom;fac_locataire_nom;fac_bien_id;fac_locataire_id;fac_date_piece;fac_type;fac_date_echeance"
End case 

WEB_CHAMP_Saisissable:=""

If ([Factures:86]FAC_Type:21="Définitive")
	$disabled:="readonly"
	WEB_CHAMP_Saisissable:="readonly"
End if 

If ($type="entete")
	$HTML_CONTENT:=$HTML_CONTENT+"<form action=\"GL?action=facture_fiche_valider\" name=\"fiche_form\" id=\"fiche_form\" method=\"POST\" class=\"collectable form-horizontal well user_fiche\" enctype=\"multipart/form-data\" >"
	$HTML_CONTENT:=$HTML_CONTENT+Web_Form_Boutons("facture_fiche_top")
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_piece_entete\">"
	
	//=========================================================================//
	// COL LEFT
	//=========================================================================//
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_col_left\">"
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row\">"
	
	//-------------------------------------------------------------------------//
	// DIV CONTENT 1
	//-------------------------------------------------------------------------//
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content\">"
	
	WEB_CHAMP_Saisissable:=""
	
	If ([Factures:86]FAC_Bien_Nom:30#"")
		WEB_CHAMP_Saisissable:="readonly"
	End if 
	
	If (Bool:C1537(Num:C11(w_visiteur.newInvoice))=True:C214) | ([Factures:86]FAC_Type_Piece:40="autre")
		$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_third\">"
	End if 
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+Choose:C955((Bool:C1537(Num:C11(w_visiteur.newInvoice))=True:C214) | ([Factures:86]FAC_Type_Piece:40="autre"); ""; " iw_div_half")+"\">"
	
	$o:=$o+1
	
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Bien loué"
	$TB_HTML{$o}{6}:="Bien loué"
	$TB_HTML{$o}{7}:="fdp_width100 search"
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="fac_bien_nom"
	$TB_HTML{$o}{4}:=[Factures:86]FAC_Bien_Nom:30
	$TB_HTML{$o}{5}:="Destinataire"
	$TB_HTML{$o}{6}:="fac_bien_nom"
	$TB_HTML{$o}{7}:="span7 search"+Choose:C955((Bool:C1537(Num:C11(w_visiteur.newInvoice))=True:C214) | ([Factures:86]FAC_Type_Piece:40="autre"); " readonly"; WEB_CHAMP_Saisissable)
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	// Modifié par : Scanu Rémy (03/06/2024)
	// Ajout choix de l'hébergé pour nouvelle facture
	If (Bool:C1537(Num:C11(w_visiteur.newInvoice))=True:C214) | ([Factures:86]FAC_Type_Piece:40="autre")
		$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group\">"
		
		$o:=$o+1
		
		$TB_HTML{$o}{1}:="label"
		$TB_HTML{$o}{2}:="label"
		$TB_HTML{$o}{3}:=""
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Usager"
		$TB_HTML{$o}{6}:="Usager"
		$TB_HTML{$o}{7}:="fdp_width100 search"
		$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
		
		$o:=$o+1
		
		$TB_HTML{$o}{1}:="input"
		$TB_HTML{$o}{2}:="text"
		$TB_HTML{$o}{3}:="fac_locataire_nom"
		$TB_HTML{$o}{4}:=[Factures:86]FAC_Locataire_Nom:31
		$TB_HTML{$o}{5}:="Usager"
		$TB_HTML{$o}{6}:="fac_locataire_nom"
		$TB_HTML{$o}{7}:="span7 search"
		$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
		$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	End if 
	
	WEB_CHAMP_Saisissable:=""
	
	If ([Factures:86]FAC_Locataire_Nom:31#"")
		WEB_CHAMP_Saisissable:="readonly"
	End if 
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group"+Choose:C955((Bool:C1537(Num:C11(w_visiteur.newInvoice))=True:C214) | ([Factures:86]FAC_Type_Piece:40="autre"); ""; " iw_div_half")+"\">"
	
	$o:=$o+1
	
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Destinataire"
	$TB_HTML{$o}{6}:="Destinataire"
	$TB_HTML{$o}{7}:="fdp_width100 search"
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	
	$destinataireFacture_t:="Sélection d'un élément;;"
	$destinataireFacture_t:=$destinataireFacture_t+"|"+String:C10([Factures:86]FAC_Locataire_ID:29)+"_"+[Factures:86]FAC_Locataire_Nom:31+" - locataire"+Choose:C955([Factures:86]FAC_Destinataire_ID:11=[Factures:86]FAC_Locataire_ID:29; "_s"; "")
	$destinataireFacture_t:=$destinataireFacture_t+"|"+String:C10([Factures:86]FAC_Bien_Proprietaire_ID:35)+"_"+[Factures:86]FAC_Bien_Proprietaire_Nom:36+" - propriétaire"+Choose:C955([Factures:86]FAC_Destinataire_ID:11=[Factures:86]FAC_Bien_Proprietaire_ID:35; "_s"; "")
	
	$TB_HTML{$o}{1}:="select"
	$TB_HTML{$o}{2}:=""
	$TB_HTML{$o}{3}:="fac_destinataire_id"
	$TB_HTML{$o}{4}:=$destinataireFacture_t
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_destinataire_id"
	$TB_HTML{$o}{7}:="span7 search"
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	If (Bool:C1537(Num:C11(w_visiteur.newInvoice))=True:C214) | ([Factures:86]FAC_Type_Piece:40="autre")
		$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	End if 
	
	If (Bool:C1537(Num:C11(w_visiteur.newInvoice))=True:C214) | ([Factures:86]FAC_Type_Piece:40="autre")
		$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_third\">"
	End if 
	
	WEB_CHAMP_Saisissable:=""
	
	If ([Factures:86]FAC_Type:21="Définitive")
		$disabled:="readonly"
		WEB_CHAMP_Saisissable:="readonly"
	End if 
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group "+Choose:C955((Bool:C1537(Num:C11(w_visiteur.newInvoice))=True:C214) | ([Factures:86]FAC_Type_Piece:40="autre"); ""; " iw_div_half")+"\">"
	$o:=$o+1
	
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Date"
	$TB_HTML{$o}{6}:="Date"
	$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder fdp_row_start"
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="fac_date_piece"
	$TB_HTML{$o}{4}:=String:C10([Factures:86]FAC_Date_Piece:3)
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_date_piece"
	$TB_HTML{$o}{7}:="span7 search fdp_placeholder datepicker fdp_row_start"+WEB_CHAMP_Saisissable
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	// Modifié par : Scanu Rémy (03/06/2024)
	// Ajout choix de l'hébergé pour nouvelle facture
	If (Bool:C1537(Num:C11(w_visiteur.newInvoice))=True:C214) | ([Factures:86]FAC_Type_Piece:40="autre")
		$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group\">"
		
		$o:=$o+1
		
		$TB_HTML{$o}{1}:="label"
		$TB_HTML{$o}{2}:="label"
		$TB_HTML{$o}{3}:=""
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:="Catégorie"
		$TB_HTML{$o}{6}:="Catégorie"
		$TB_HTML{$o}{7}:="fdp_width100 search"
		$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
		
		$o:=$o+1
		
		$TB_HTML{$o}{1}:="select"
		$TB_HTML{$o}{2}:=""
		$TB_HTML{$o}{3}:="fac_categorie"
		$TB_HTML{$o}{4}:=outilsWebSelectGetOptionHTML("Catégorie facture"; [Factures:86]FAC_Categorie:65)
		$TB_HTML{$o}{5}:="Catégorie"
		$TB_HTML{$o}{6}:="fac_categorie"
		$TB_HTML{$o}{7}:="span7 search"
		$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
		$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	End if 
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group "+Choose:C955((Bool:C1537(Num:C11(w_visiteur.newInvoice))=True:C214) | ([Factures:86]FAC_Type_Piece:40="autre"); ""; " iw_div_half")+"\">"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Type facture"
	$TB_HTML{$o}{6}:="Type facture"
	$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="select"
	$TB_HTML{$o}{2}:=""
	$TB_HTML{$o}{3}:="fac_type"
	$TB_HTML{$o}{4}:=outilsWebSelectGetOptionHTML(New collection:C1472("Provisoire"; "Définitive"); [Factures:86]FAC_Type:21)
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_type"
	$TB_HTML{$o}{7}:="fdp_span3 span7"+WEB_CHAMP_Saisissable
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	If (Bool:C1537(Num:C11(w_visiteur.newInvoice))=True:C214) | ([Factures:86]FAC_Type_Piece:40="autre")
		$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	End if 
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start\">"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Adresse de facturation"
	$TB_HTML{$o}{6}:="Adresse de facturation"
	$TB_HTML{$o}{7}:="fdp_width100 search"
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="textarea"
	$TB_HTML{$o}{3}:="fac_adresse_facturation"
	$TB_HTML{$o}{4}:=[Factures:86]FAC_Adresse_Facturation:14
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_adresse_facturation"
	$TB_HTML{$o}{7}:="span7 search"+WEB_CHAMP_Saisissable
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	$values_c:=UTL_Web_Get_Enumeration_Values("Modes de règlements")
	If ($values_c.length#0)
		COLLECTION TO ARRAY:C1562($values_c; $tb_enum_values)
	End if 
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half\">"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Mode du règlement"
	$TB_HTML{$o}{6}:="Mode du règlement"
	$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="select"
	$TB_HTML{$o}{2}:=""
	$TB_HTML{$o}{3}:="fac_mode_reglement"
	$TB_HTML{$o}{4}:=outilsWebSelectGetOptionHTML(->$tb_enum_values; [Factures:86]FAC_Mode_Reglement:22)
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_mode_reglement"
	$TB_HTML{$o}{7}:="fdp_span3 span7"+WEB_CHAMP_Saisissable
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half   \">"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Date d'échéance"
	$TB_HTML{$o}{6}:="Date d'échéance"
	$TB_HTML{$o}{7}:="fdp_width100 search "
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="fac_date_echeance"
	
	If ([Factures:86]FAC_Date_Echeance:20#!00-00-00!)
		$TB_HTML{$o}{4}:=String:C10([Factures:86]FAC_Date_Echeance:20)
	Else 
		$TB_HTML{$o}{4}:=String:C10(Add to date:C393(Current date:C33(*); 0; 0; 10))
	End if 
	
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_date_echeance"
	$TB_HTML{$o}{7}:="span7 search datepicker"+WEB_CHAMP_Saisissable
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	//-------------------------------------------------------------------------//
	
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"  //row
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"  // col left
	//=========================================================================//
	
	//=========================================================================//
	// COL RIGHT
	//=========================================================================//
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_col_right\">"
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row\">"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group  fdp_row_start  \">"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="N° Pièce"
	$TB_HTML{$o}{6}:="N° Pièce"
	$TB_HTML{$o}{7}:="fdp_width100 search "
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="fac_no_piece"
	$TB_HTML{$o}{4}:=[Factures:86]FAC_No_Piece:2
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_no_piece"
	$TB_HTML{$o}{7}:="span7 disabled"
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half\">"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Modèle d'observation"
	$TB_HTML{$o}{6}:="Modèle d'observation"
	$TB_HTML{$o}{7}:="fdp_width100 search "
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$path_t:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"customContent"+Séparateur dossier:K24:12+String:C10(w_userUID)+Séparateur dossier:K24:12+"observation"+Séparateur dossier:K24:12+"modele"
	DOCUMENT LIST:C474($path_t; $observationModele_at)
	
	// Modifié par : Scanu Rémy (22/03/2023)
	$o:=$o+1
	$TB_HTML{$o}{1}:="select"
	$TB_HTML{$o}{2}:=""
	$TB_HTML{$o}{3}:="fac_modele"
	$TB_HTML{$o}{4}:=outilsWebSelectGetOptionHTML(->$observationModele_at; Formula:C1597(Substring:C12($1; 0; Position:C15("."; $1)-1)); False:C215)
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_modele"
	$TB_HTML{$o}{7}:="span7 search"+WEB_CHAMP_Saisissable
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group fdp_row_start\">"
	
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
	$TB_HTML{$o}{4}:=[Factures:86]FAC_Notes:17
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_notes"
	$TB_HTML{$o}{7}:="span7 search"+WEB_CHAMP_Saisissable
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half\">"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Statut"
	$TB_HTML{$o}{6}:="Statut"
	$TB_HTML{$o}{7}:="fdp_width100 search"
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="fac_statut"
	$TB_HTML{$o}{4}:=[Factures:86]FAC_Statut:16
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_statut"
	$TB_HTML{$o}{7}:="span7 search disabled"+WEB_CHAMP_Saisissable
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half\">"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Solde antérieur"
	$TB_HTML{$o}{6}:="Solde antérieur"
	$TB_HTML{$o}{7}:="fdp_width100 search"
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	// Modifié par : Scanu Rémy (03/09/2021)
	// La modification du solde antérieur n'est possible que pour la première facture
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="fac_solde_anterieur"
	$TB_HTML{$o}{4}:=String:C10($factures_e.FAC_Solde_Anterieur_cal)
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_solde_anterieur"
	$TB_HTML{$o}{7}:="span7 search disabled"+WEB_CHAMP_Saisissable
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group iw_div_half iw_100p fdp_row_start iw_display_none\">"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Clôturée"
	$TB_HTML{$o}{6}:="Clôturée"
	$TB_HTML{$o}{7}:="fdp_width100 search fdp_placeholder"
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="iw_radio"
	$TB_HTML{$o}{2}:="iw_radio"
	$TB_HTML{$o}{3}:="fac_cloture"
	$TB_HTML{$o}{4}:=String:C10([Factures:86]FAC_Cloture:10)
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_cloture"
	$TB_HTML{$o}{7}:="span7 search fdp_placeholder"+WEB_CHAMP_Saisissable
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	//=========================================================================//
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"  //fin entete
Else 
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_piece_pied\">"
	
	//=========================================================================//
	// COL LEFT
	//=========================================================================//
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_col_left\">"
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row\">"
	
	//-------------------------------------------------------------------------//
	// DIV CONTENT 1
	//-------------------------------------------------------------------------//
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_div_content iw_third\">"
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group\">"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Taux de remise global"
	$TB_HTML{$o}{6}:="Taux de remise global"
	$TB_HTML{$o}{7}:="fdp_width100 search"
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="fac_taux_remise"
	$TB_HTML{$o}{4}:=String:C10([Factures:86]FAC_Taux_Remise:4)
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_taux_remise"
	$TB_HTML{$o}{7}:="span7 search readonly"+WEB_CHAMP_Saisissable
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group\">"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Montant remise"
	$TB_HTML{$o}{6}:="Montant remise"
	$TB_HTML{$o}{7}:="fdp_width100 search"
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="fac_montant_remise"
	$TB_HTML{$o}{4}:=String:C10([Factures:86]FAC_Montant_remise:5)
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_montant_remise"
	$TB_HTML{$o}{7}:="span7 search readonly"+WEB_CHAMP_Saisissable
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group\">"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Acompte"
	$TB_HTML{$o}{6}:="Acompte"
	$TB_HTML{$o}{7}:="fdp_width100 search"
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="fac_acompte"
	$TB_HTML{$o}{4}:=String:C10([Factures:86]FAC_Acompte:18)
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_acompte"
	$TB_HTML{$o}{7}:="span7 search readonly"+WEB_CHAMP_Saisissable
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	//-------------------------------------------------------------------------//
	
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"  //row
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"  // col left
	//=========================================================================//
	
	//=========================================================================//
	// COL RIGHT
	//=========================================================================//
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"iw_col_right\">"
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"row iw_third\">"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group  fdp_row_start\">"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Montant HT"
	$TB_HTML{$o}{6}:="Montant HT"
	$TB_HTML{$o}{7}:="fdp_width100 search readonly"
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="fac_montant_ht"
	$TB_HTML{$o}{4}:=String:C10([Factures:86]FAC_Montant_HT:6)
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_montant_ht"
	$TB_HTML{$o}{7}:="span7 search readonly"+WEB_CHAMP_Saisissable
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group\">"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Montant TTC"
	$TB_HTML{$o}{6}:="Montant TTC"
	$TB_HTML{$o}{7}:="fdp_width100 search readonly "
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="fac_montant_ttc"
	$TB_HTML{$o}{4}:=String:C10([Factures:86]FAC_Montant_TTC:8)
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_montant_ttc"
	$TB_HTML{$o}{7}:="span7 search readonly"+WEB_CHAMP_Saisissable
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	$HTML_CONTENT:=$HTML_CONTENT+"<div class=\"control-group\">"
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="label"
	$TB_HTML{$o}{2}:="label"
	$TB_HTML{$o}{3}:=""
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:="Net à payer"
	$TB_HTML{$o}{6}:="Net à payer"
	$TB_HTML{$o}{7}:="fdp_width100 search readonly"
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="text"
	$TB_HTML{$o}{3}:="fac_net_a_payer"
	$TB_HTML{$o}{4}:=String:C10($factures_e.FAC_Net_A_Payer_cal)
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_net_a_payer"
	$TB_HTML{$o}{7}:="span7 search readonly"+WEB_CHAMP_Saisissable
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	$HTML_CONTENT:=$HTML_CONTENT+"</div>"
	
	//=========================================================================//
	
	//=========================================================================//
	// Hidden 
	//=========================================================================//
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="record_id"
	$TB_HTML{$o}{4}:=String:C10([Factures:86]ID:1)
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
	$TB_HTML{$o}{3}:="statut_cloture"
	
	If ($privileges_facturation)
		$TB_HTML{$o}{4}:=String:C10([Factures:86]FAC_Cloture:10)
	Else 
		$TB_HTML{$o}{4}:="True"
	End if 
	
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="statut_cloture"
	$TB_HTML{$o}{7}:=""
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="privilege_facturation"
	
	If ($privileges_facturation)
		$TB_HTML{$o}{4}:="True"
	Else 
		$TB_HTML{$o}{4}:="False"
	End if 
	
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="privilege_facturation"
	$TB_HTML{$o}{7}:=""
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="id_selected"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="id_selected"
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
	$TB_HTML{$o}{3}:="fac_bien_id"
	$TB_HTML{$o}{4}:=String:C10([Factures:86]FAC_Bien_ID:28)
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_bien_id"
	$TB_HTML{$o}{7}:=""
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="fac_locataire_id"
	$TB_HTML{$o}{4}:=String:C10([Factures:86]FAC_Locataire_ID:29)
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_locataire_id"
	$TB_HTML{$o}{7}:=""
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="current_type_ligne"
	$TB_HTML{$o}{4}:=""
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="current_type_ligne"
	$TB_HTML{$o}{7}:=""
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="fac_type_facture"
	$TB_HTML{$o}{4}:=[Factures:86]FAC_Type:21
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_type_facture"
	$TB_HTML{$o}{7}:=""
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="fac_solde_du"
	$TB_HTML{$o}{4}:=String:C10($factures_e.FAC_Solde_Du_cal)
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="fac_solde_du"
	$TB_HTML{$o}{7}:=""
	$HTML_CONTENT:=$HTML_CONTENT+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	
	$o:=$o+1
	$TB_HTML{$o}{1}:="input"
	$TB_HTML{$o}{2}:="hidden"
	$TB_HTML{$o}{3}:="intervenantID"
	$TB_HTML{$o}{4}:=String:C10(w_userUID)
	$TB_HTML{$o}{5}:=""
	$TB_HTML{$o}{6}:="intervenantID"
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
End if 

$0:=$HTML_CONTENT