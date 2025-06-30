//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 12/06/2020, 17:05:34
// ----------------------------------------------------
// Method: FAC_Modeles_Impression_Get
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)  // [Optionnel]

C_TEXT:C284($type; $modele)
C_LONGINT:C283($compteur)

ARRAY TEXT:C222(tb_fac_modeles_imp; 0)

$type:=$1

If (Count parameters:C259>1)
	$modele:=$2
End if 

READ ONLY:C145([Preferences:81])

If ($type="list")
	QUERY:C277([Preferences:81]; [Preferences:81]PREF_UID_Ref:6=SOC_ID; *)
	QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_Type:2="Facture_Modele@")
	
	MultiSoc_Filter(->[Preferences:81])
	
	ORDER BY:C49([Preferences:81]; [Preferences:81]PREF_Type:2; >)
	$compteur:=1
	
	While (Not:C34(End selection:C36([Preferences:81])))
		
		If ([Preferences:81]PREF_Value_9:19#"")
			APPEND TO ARRAY:C911(tb_fac_modeles_imp; [Preferences:81]PREF_Value_9:19)
		End if 
		
		$compteur:=$compteur+1
		NEXT RECORD:C51([Preferences:81])
	End while 
	
	INSERT IN ARRAY:C227(tb_fac_modeles_imp; 1; 1)
	
	tb_fac_modeles_imp{1}:="Modèle par défaut"
Else 
	
	If ($modele#"") & ($modele#"Modèle par défaut")
		QUERY:C277([Preferences:81]; [Preferences:81]PREF_UID_Ref:6=SOC_ID; *)
		QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_Value_9:19=$modele)
		
		MultiSoc_Filter(->[Preferences:81])
		
		If (Records in selection:C76([Preferences:81])=1)
			strc_logo:=[Preferences:81]PREF_Value_Img:16
			
			txt_strc_nom:=[Preferences:81]PREF_Value_1:3
			txt_strc_nom_suite:=[Preferences:81]PREF_Value_2:4
			txt_strc_adresse:=[Preferences:81]PREF_Value_3:5
			
			txt_titre_ligne_8:=[Preferences:81]PREF_Value_4:13
			txt_titre_ligne_9:=[Preferences:81]PREF_Value_5:14
			txt_titre_ligne_10:=[Preferences:81]PREF_Value_6:15
			
			txt_strc_tel:=[Preferences:81]PREF_Value_7:18
			txt_strc_email:=[Preferences:81]PREF_Value_8:17
			
			txt_strc_adresse:=txt_strc_adresse+Char:C90(Retour chariot:K15:38)
			txt_strc_adresse:=txt_strc_adresse+txt_strc_tel+Char:C90(Retour chariot:K15:38)
			txt_strc_adresse:=txt_strc_adresse+txt_strc_email
			
			txt_titre_ligne_5:=""
			txt_titre_ligne_6:="IBAN : "+[Preferences:81]PREF_Value_12:22
			txt_titre_ligne_7:="BIC : "+[Preferences:81]PREF_Value_13:23
			
			txt_titre_ligne_12:=[Preferences:81]PREF_Value_10:20
			txt_titre_ligne_11:=[Preferences:81]PREF_Value_11:21
			
			//Todo: GF
/*
// Modifié par : Scanu Rémy - remy@connect-io.fr (22/06/2021)
// On affiche ou masque certains éléments du formulaire en fonction du paramètre "Sans TVA" dans les paramètres du modèle d'impression
OBJET FIXER VISIBLE(txt_ht; (Chaîne([Preferences]PREF_Value_14)#"1"))
			
			
OBJET FIXER VISIBLE(txt_tva; (Chaîne([Preferences]PREF_Value_14)#"1"))
OBJET FIXER VISIBLE(num_total_tva; (Chaîne([Preferences]PREF_Value_14)#"1"))
			
OBJET FIXER VISIBLE(txt_ttc; (Chaîne([Preferences]PREF_Value_14)#"1"))
OBJET FIXER VISIBLE(num_total_ttc; (Chaîne([Preferences]PREF_Value_14)#"1"))
			
// Modifié par : Scanu Rémy - remy@connect-io.fr (30/06/2021)
Si (Chaîne([Preferences]PREF_Value_14)="1")
OBJET FIXER TITRE(*; "Variable14"; "Total")
			
OBJET FIXER TITRE(*; "Texte11"; Remplacer chaîne(OBJET Lire titre(*; "Texte11"); " HT"; ""))
OBJET FIXER TITRE(*; "Texte6"; Remplacer chaîne(OBJET Lire titre(*; "Texte6"); " HT"; ""))
			
OBJET FIXER VISIBLE(*; "Variable14"; Vrai)
Fin de si 
*/
		End if 
		
	End if 
	
End if 