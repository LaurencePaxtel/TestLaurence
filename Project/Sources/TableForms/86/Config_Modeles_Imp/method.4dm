// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 12/06/2020, 16:14:01
// ----------------------------------------------------
// Method: [Factures].Config_Modeles_Imp
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		C_TEXT:C284(txt_titre_fenetre_modeles)
		C_LONGINT:C283($i)
		
		txt_titre_fenetre_modeles:="Paramétrage des modèles d'impression"
		
		SOC_Get_Config
		
		READ ONLY:C145([Preferences:81])
		
		START TRANSACTION:C239
		
		/// Modele 1
		C_TEXT:C284(var_modele_nom_1; var_strc_nom_1; var_strc_nom_suite_1; var_strc_adresse_1; var_strc_pied_1_1; var_strc_pied_1_2; var_strc_pied_1_3; var_strc_telephone_1; var_strc_email_1)
		C_PICTURE:C286(var_strc_logo_1)
		C_LONGINT:C283(var_strc_sans_tva_1)
		
		/// Modele 2
		C_TEXT:C284(var_modele_nom_2; var_strc_nom_2; var_strc_nom_suite_2; var_strc_adresse_2; var_strc_pied_2_1; var_strc_pied_2_2; var_strc_pied_2_3; var_strc_telephone_2; var_strc_email_2)
		C_PICTURE:C286(var_strc_logo_2)
		C_LONGINT:C283(var_strc_sans_tva_2)
		
		/// Modele 3
		C_TEXT:C284(var_modele_nom_3; var_strc_nom_3; var_strc_nom_suite_3; var_strc_adresse_3; var_strc_pied_3_1; var_strc_pied_3_2; var_strc_pied_3_3; var_strc_telephone_3; var_strc_email_3)
		C_PICTURE:C286(var_strc_logo_3)
		C_LONGINT:C283(var_strc_sans_tva_3)
		
		/// Modele 4
		C_TEXT:C284(var_modele_nom_4; var_strc_nom_4; var_strc_nom_suite_4; var_strc_adresse_4; var_strc_pied_4_1; var_strc_pied_4_2; var_strc_pied_4_3; var_strc_telephone_4; var_strc_email_4)
		C_PICTURE:C286(var_strc_logo_4)
		C_LONGINT:C283(var_strc_sans_tva_4)
		
		/// Modele 5
		C_TEXT:C284(var_modele_nom_5; var_strc_nom_5; var_strc_nom_suite_5; var_strc_adresse_5; var_strc_pied_5_1; var_strc_pied_5_2; var_strc_pied_5_3; var_strc_telephone_5; var_strc_email_5)
		C_PICTURE:C286(var_strc_logo_5)
		C_LONGINT:C283(var_strc_sans_tva_5)
		
		/// Modele 6
		C_TEXT:C284(var_modele_nom_6; var_strc_nom_6; var_strc_nom_suite_6; var_strc_adresse_6; var_strc_pied_6_1; var_strc_pied_6_2; var_strc_pied_6_3; var_strc_telephone_6; var_strc_email_6)
		C_PICTURE:C286(var_strc_logo_6)
		C_LONGINT:C283(var_strc_sans_tva_6)
		
		/// Modele 7
		C_TEXT:C284(var_modele_nom_7; var_strc_nom_7; var_strc_nom_suite_7; var_strc_adresse_7; var_strc_pied_7_1; var_strc_pied_7_2; var_strc_pied_7_3; var_strc_telephone_7; var_strc_email_7)
		C_PICTURE:C286(var_strc_logo_7)
		C_LONGINT:C283(var_strc_sans_tva_7)
		
		/// Modele 8
		C_TEXT:C284(var_modele_nom_8; var_strc_nom_8; var_strc_nom_suite_8; var_strc_adresse_8; var_strc_pied_8_1; var_strc_pied_8_2; var_strc_pied_8_3; var_strc_telephone_8; var_strc_email_8)
		C_PICTURE:C286(var_strc_logo_8)
		C_LONGINT:C283(var_strc_sans_tva_8)
		
		/// Modele 9
		C_TEXT:C284(var_modele_nom_9; var_strc_nom_9; var_strc_nom_suite_9; var_strc_adresse_9; var_strc_pied_9_1; var_strc_pied_9_2; var_strc_pied_9_3; var_strc_telephone_9; var_strc_email_9)
		C_PICTURE:C286(var_strc_logo_9)
		C_LONGINT:C283(var_strc_sans_tva_9)
		
		/// Modele 10
		C_TEXT:C284(var_modele_nom_10; var_strc_nom_10; var_strc_nom_suite_10; var_strc_adresse_10; var_strc_pied_10_1; var_strc_pied_10_2; var_strc_pied_10_3; var_strc_telephone_10; var_strc_email_10)
		C_PICTURE:C286(var_strc_logo_10)
		C_LONGINT:C283(var_strc_sans_tva_10)
		
		For ($i; 1; 10)
			QUERY:C277([Preferences:81]; [Preferences:81]PREF_UID_Ref:6=SOC_ID; *)
			QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_Type:2="Facture_Modele_"+String:C10($i))
			
			MultiSoc_Filter(->[Preferences:81])
			
			If (Records in selection:C76([Preferences:81])=1)
				EXECUTE FORMULA:C63("$var_modele_nom:=->var_modele_nom_"+String:C10($i))
				EXECUTE FORMULA:C63("$var_strc_nom:=->var_strc_nom_"+String:C10($i))
				EXECUTE FORMULA:C63("$var_strc_nom_suite:=->var_strc_nom_suite_"+String:C10($i))
				EXECUTE FORMULA:C63("$var_strc_adresse:=->var_strc_adresse_"+String:C10($i))
				EXECUTE FORMULA:C63("$var_strc_telephone:=->var_strc_telephone_"+String:C10($i))
				EXECUTE FORMULA:C63("$var_strc_email:=->var_strc_email_"+String:C10($i))
				EXECUTE FORMULA:C63("$var_strc_logo:=->var_strc_logo_"+String:C10($i))
				EXECUTE FORMULA:C63("$var_strc_pied_1:=->var_strc_pied_"+String:C10($i)+"_1")
				EXECUTE FORMULA:C63("$var_strc_pied_2:=->var_strc_pied_"+String:C10($i)+"_2")
				EXECUTE FORMULA:C63("$var_strc_pied_3:=->var_strc_pied_"+String:C10($i)+"_3")
				
				EXECUTE FORMULA:C63("$var_strc_commentaire_1:=->var_strc_commentaire_"+String:C10($i)+"_1")
				EXECUTE FORMULA:C63("$var_strc_commentaire_2:=->var_strc_commentaire_"+String:C10($i)+"_2")
				EXECUTE FORMULA:C63("$var_strc_iban:=->var_strc_iban_"+String:C10($i))
				EXECUTE FORMULA:C63("$var_strc_bic:=->var_strc_bic_"+String:C10($i))
				
				// Modifié par : Scanu Rémy - remy@connect-io.fr (22/06/2021)
				// Ajout booléen qui indique si on souhaite le modèle sans TVA
				EXECUTE FORMULA:C63("$var_strc_sans_tva:=->var_strc_sans_tva_"+String:C10($i))
				
				$var_modele_nom->:=[Preferences:81]PREF_Value_9:19
				
				$var_strc_nom->:=[Preferences:81]PREF_Value_1:3
				$var_strc_nom_suite->:=[Preferences:81]PREF_Value_2:4
				
				$var_strc_adresse->:=[Preferences:81]PREF_Value_3:5
				$var_strc_telephone->:=[Preferences:81]PREF_Value_7:18
				$var_strc_email->:=[Preferences:81]PREF_Value_8:17
				
				$var_strc_logo->:=[Preferences:81]PREF_Value_Img:16
				
				$var_strc_pied_1->:=[Preferences:81]PREF_Value_4:13
				$var_strc_pied_2->:=[Preferences:81]PREF_Value_5:14
				$var_strc_pied_3->:=[Preferences:81]PREF_Value_6:15
				
				$var_strc_commentaire_1->:=[Preferences:81]PREF_Value_10:20
				$var_strc_commentaire_2->:=[Preferences:81]PREF_Value_11:21
				
				$var_strc_iban->:=[Preferences:81]PREF_Value_12:22
				$var_strc_bic->:=[Preferences:81]PREF_Value_13:23
				
				// Modifié par : Scanu Rémy - remy@connect-io.fr (22/06/2021)
				// Ajout booléen qui indique si on souhaite le modèle sans TVA
				$var_strc_sans_tva->:=Num:C11([Preferences:81]PREF_Value_14:25)
			End if 
			
		End for 
		
End case 