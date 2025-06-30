//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 20/05/28, 13:26:56
// ----------------------------------------------------
// Method: Web_FAC_Envoi_Mail
// Description
// 
//
// Parameters
// ----------------------------------------------------

var $writePro_es : cs:C1710.DOCWPROSelection
var $document_o : Object
var $pdf_o : 4D:C1709.File
var $count : Integer
$count:=0

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; "facturation"; Est un objet:K8:27)
$ids_factures:=OB Get:C1224($O_Data; "ids_factures"; Est un texte:K8:3)
ARRAY TEXT:C222($tb_fac_id; 0)
UTL_Decoupe_texte(->$ids_factures; ->$tb_fac_id; ";")

For ($i; 1; Size of array:C274($tb_fac_id))
	
	QUERY:C277([Factures:86]; [Factures:86]ID:1=Num:C11($tb_fac_id{$i}))
	MultiSoc_Filter(->[Factures:86])
	w_visiteur.factureID:=[Factures:86]ID:1
	
	$writePro_es:=ds:C1482.DOCWPRO.query("nom = :1 AND structureRef = :2"; "Avis loyer"; Session:C1714.storage.intervenant.Ref_Structure)
	$writePro_es.refresh()
	
	$document_o:=WP New:C1317($writePro_es.first().fichier)
	outilsWProChargeData("Avis@"; ->$document_o)
	$pdf_o:=Folder:C1567(fk dossier données:K87:12).folder("temporary files").file("facture.pdf")
	
	WP EXPORT DOCUMENT:C1337($document_o; $pdf_o.platformPath; wk pdf:K81:315)
	
	
	ARRAY TEXT:C222($pieces_jointes; 0)
	APPEND TO ARRAY:C911($pieces_jointes; $pdf_o.platformPath)
	
	If ([Factures:86]FAC_Montant_TTC:8>0)
		If ([Factures:86]FAC_No_Piece:2#"")
			$texte_1:="Facture N° "+[Factures:86]FAC_No_Piece:2+" du "+String:C10([Factures:86]FAC_Date_Piece:3)
		Else 
			$texte_1:="Facture provisoire du "+String:C10([Factures:86]FAC_Date_Piece:3)
		End if 
	Else 
		$texte_1:="Avoir N° "+[Factures:86]FAC_No_Piece:2+" du "+String:C10([Factures:86]FAC_Date_Piece:3)
	End if 
	
	$subject:=$texte_1
	
	ARRAY TEXT:C222($tb_destinataire; 0)
	APPEND TO ARRAY:C911($tb_destinataire; [HeBerge:4]HB_Email:68)
	
	$msg_text_1:="Bonjour,"
	If ([Factures:86]FAC_Montant_TTC:8>0)
		$msg_text_2:=" Vous trouverez ci joint la "+$texte_1+",  d'un Montant TTC de  "+String:C10([Factures:86]FAC_Montant_TTC:8; "###,###,##0.00")+" €."
	Else 
		$msg_text_2:=" Vous trouverez ci joint l'"+$texte_1+",  d'un Montant TTC de  "+String:C10([Factures:86]FAC_Montant_TTC:8; "###,###,##0.00")+" €."
	End if 
	$msg_text_3:="Merci!"
	
	If (SOC_Fac_Mail_Texte#"")
		SOC_Fac_Mail_Texte:=Replace string:C233(SOC_Fac_Mail_Texte; "$montant_ttc"; String:C10([Factures:86]FAC_Montant_TTC:8; "###,###,##0.00")+" €")
		SOC_Fac_Mail_Texte:=Replace string:C233(SOC_Fac_Mail_Texte; "$numero_piece"; [Factures:86]FAC_No_Piece:2)
		SOC_Fac_Mail_Texte:=Replace string:C233(SOC_Fac_Mail_Texte; "$date_piece"; String:C10([Factures:86]FAC_Date_Piece:3))
		SOC_Fac_Mail_Texte:=Replace string:C233(SOC_Fac_Mail_Texte; "\r"; "<br/>&nbsp;&nbsp;&nbsp;")
		If ([Factures:86]FAC_Montant_TTC:8<0)
			SOC_Fac_Mail_Texte:=Replace string:C233(SOC_Fac_Mail_Texte; "la facture"; "l'avoir")
		End if 
		$msg_text_2:=SOC_Fac_Mail_Texte
		$msg_text_3:=""
	End if 
	
	$msg_text_4:=""
	
	$message:=MAIL_HTML_Generate($msg_text_1; $msg_text_2; $msg_text_3; $msg_text_4)
	
	QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=[Factures:86]FAC_Destinataire_ID:11)  //***
	MultiSoc_Filter(->[HeBerge:4])
	
	$error:=MAIL_Send($subject; [HeBerge:4]HB_Email:68; $message; ->$pieces_jointes)
	
	If ($error="")
		$total_sent:=$total_sent+1
	End if 
	
	$pdf_o.delete()
	
	$count:=$count+1
	
End for 


$T_Json:=JSON Stringify:C1217({Status: $count})
WEB SEND TEXT:C677($T_Json)


/*
C_OBJET($O_Output; $O_Data)

C_TEXTE($T_Json; $Status; $ids_factures)
C_BOOLÉEN($continu)

$O_Output:=Créer objet
$continu:=Vrai
TRACE
$O_Data:=Web_AGL_Get_Post_Json_Data

$O_Data:=OB Lire($O_Data; "facturation"; Est un objet)

$ids_factures:=OB Lire($O_Data; "ids_factures"; Est un texte)

LECTURE SEULEMENT([Factures])
LECTURE SEULEMENT([Factures_Lignes])

$status:="Failed"
$count:=0

TABLEAU TEXTE($tb_fac_id; 0)
UTL_Decoupe_texte(->$ids_factures; ->$tb_fac_id; ";")

C_ENTIER LONG($i; $total_sent)
TABLEAU TEXTE($pieces_jointes; 0)

SOC_Get_Config

Boucle ($i; 1; Taille tableau($tb_fac_id))

CHERCHER([Factures]; [Factures]ID=Num($tb_fac_id{$i}))
MultiSoc_Filter(->[Factures])

Si (Enregistrements trouvés([Factures])=1)

CHERCHER([Factures_Lignes]; [Factures_Lignes]FACL_Piece_ID=[Factures]ID)
MultiSoc_Filter(->[Factures_Lignes])

CHERCHER([HeBerge]; [HeBerge]ID=[Factures]FAC_Destinataire_ID)  //***
MultiSoc_Filter(->[HeBerge])

GES_GL_Imp_Maj_Variables

RÉDUIRE SÉLECTION([Factures_Lignes]; 0)


$pdf_path:=AGL_Fiche_Print(->[Factures]; "print"; ->[Factures_Lignes])

Si (Tester chemin acces($pdf_path)=Est un document)

C_TEXTE($texte_1)

AJOUTER À TABLEAU($pieces_jointes; $pdf_o.platformPath)

Si ([Factures]FAC_Montant_TTC>0)
Si ([Factures]FAC_No_Piece#"")
$texte_1:="Facture N° "+[Factures]FAC_No_Piece+" du "+Chaîne([Factures]FAC_Date_Piece)
Sinon 
$texte_1:="Facture provisoire du "+Chaîne([Factures]FAC_Date_Piece)
Fin de si 
Sinon 
$texte_1:="Avoir N° "+[Factures]FAC_No_Piece+" du "+Chaîne([Factures]FAC_Date_Piece)
Fin de si 

$subject:=$texte_1

TABLEAU TEXTE($tb_destinataire; 0)
AJOUTER À TABLEAU($tb_destinataire; [HeBerge]HB_Email)

$msg_text_1:="Bonjour,"
Si ([Factures]FAC_Montant_TTC>0)
$msg_text_2:=" Vous trouverez ci joint la "+$texte_1+",  d'un Montant TTC de  "+Chaîne([Factures]FAC_Montant_TTC; "###,###,##0.00")+" €."
Sinon 
$msg_text_2:=" Vous trouverez ci joint l'"+$texte_1+",  d'un Montant TTC de  "+Chaîne([Factures]FAC_Montant_TTC; "###,###,##0.00")+" €."
Fin de si 
$msg_text_3:="Merci!"

Si (SOC_Fac_Mail_Texte#"")
SOC_Fac_Mail_Texte:=Remplacer chaîne(SOC_Fac_Mail_Texte; "$montant_ttc"; Chaîne([Factures]FAC_Montant_TTC; "###,###,##0.00")+" €")
SOC_Fac_Mail_Texte:=Remplacer chaîne(SOC_Fac_Mail_Texte; "$numero_piece"; [Factures]FAC_No_Piece)
SOC_Fac_Mail_Texte:=Remplacer chaîne(SOC_Fac_Mail_Texte; "$date_piece"; Chaîne([Factures]FAC_Date_Piece))
SOC_Fac_Mail_Texte:=Remplacer chaîne(SOC_Fac_Mail_Texte; "\r"; "<br/>&nbsp;&nbsp;&nbsp;")
Si ([Factures]FAC_Montant_TTC<0)
SOC_Fac_Mail_Texte:=Remplacer chaîne(SOC_Fac_Mail_Texte; "la facture"; "l'avoir")
Fin de si 
$msg_text_2:=SOC_Fac_Mail_Texte
$msg_text_3:=""
Fin de si 

$msg_text_4:=""

$message:=MAIL_HTML_Generate($msg_text_1; $msg_text_2; $msg_text_3; $msg_text_4)

$error:=MAIL_Send($subject; strc_smtp_server; [SOciete]SO_Email; ->$tb_destinataire; $message; strc_smtp_username; strc_smtp_password; ->$pieces_jointes)

Si ($error="")
$total_sent:=$total_sent+1
Fin de si 

SUPPRIMER DOCUMENT($pdf_path)


Fin de si 

$ps_path:=Remplacer chaîne($pdf_path; ".pdf"; ".ps")

//Si (Tester chemin acces($ps_path)=Est un document)
//SUPPRIMER DOCUMENT($ps_path)
//Fin de si

$pdf_o.delete()

$count:=$count+1

Fin de si 

Fin de boucle 

OB FIXER($O_Output; "Status"; $count)
$T_Json:=JSON Stringify($O_Output)
WEB ENVOYER TEXTE($T_Json)

*/