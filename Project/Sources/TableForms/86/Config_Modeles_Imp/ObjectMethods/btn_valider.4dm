// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 10/06/2020, 16:03:08
// ----------------------------------------------------
// Method: [Factures].Config_Modeles_Imp.btn_valider
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		C_LONGINT:C283($i)
		C_BOOLEAN:C305($continu)
		
		$continu:=True:C214
		
		For ($i; 1; 10)
			EXECUTE FORMULA:C63("$var_modele_nom:=var_modele_nom_"+String:C10($i))
			EXECUTE FORMULA:C63("$var_strc_nom:=var_strc_nom_"+String:C10($i))
			EXECUTE FORMULA:C63("$var_strc_nom_suite:=var_strc_nom_suite_"+String:C10($i))
			EXECUTE FORMULA:C63("$var_strc_adresse:=var_strc_adresse_"+String:C10($i))
			EXECUTE FORMULA:C63("$var_strc_telephone:=var_strc_telephone_"+String:C10($i))
			EXECUTE FORMULA:C63("$var_strc_email:=var_strc_email_"+String:C10($i))
			EXECUTE FORMULA:C63("$var_strc_logo:=var_strc_logo_"+String:C10($i))
			EXECUTE FORMULA:C63("$var_strc_pied_1:=var_strc_pied_"+String:C10($i)+"_1")
			EXECUTE FORMULA:C63("$var_strc_pied_2:=var_strc_pied_"+String:C10($i)+"_2")
			EXECUTE FORMULA:C63("$var_strc_pied_3:=var_strc_pied_"+String:C10($i)+"_3")
			
			EXECUTE FORMULA:C63("$var_strc_commentaire_1:=var_strc_commentaire_"+String:C10($i)+"_1")
			EXECUTE FORMULA:C63("$var_strc_commentaire_2:=var_strc_commentaire_"+String:C10($i)+"_2")
			EXECUTE FORMULA:C63("$var_strc_iban:=var_strc_iban_"+String:C10($i))
			EXECUTE FORMULA:C63("$var_strc_bic:=var_strc_bic_"+String:C10($i))
			
			EXECUTE FORMULA:C63("$var_strc_sans_tva:=var_strc_sans_tva_"+String:C10($i))
			
			If ($var_modele_nom#"")
				READ ONLY:C145([Preferences:81])
				
				QUERY:C277([Preferences:81]; [Preferences:81]PREF_UID_Ref:6=SOC_ID; *)
				QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_Type:2#"Facture_Modele_"+String:C10($i); *)
				QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_Value_9:19=$var_modele_nom)
				
				MultiSoc_Filter(->[Preferences:81])
				
				If (Records in selection:C76([Preferences:81])>0)
					$continu:=False:C215
				End if 
				
			End if 
			
			If ($continu)
				READ WRITE:C146([Preferences:81])
				
				QUERY:C277([Preferences:81]; [Preferences:81]PREF_UID_Ref:6=SOC_ID; *)
				QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_Type:2="Facture_Modele_"+String:C10($i))
				
				MultiSoc_Filter(->[Preferences:81])
				
				If ($var_modele_nom#"") & ($var_strc_nom#"")
					
					If (Records in selection:C76([Preferences:81])=0)
						CREATE RECORD:C68([Preferences:81])
						
						MultiSoc_Init_Structure(->[Preferences:81])
						
						[Preferences:81]PREF_UID_Ref:6:=SOC_ID
						[Preferences:81]PREF_Type:2:="Facture_Modele_"+String:C10($i)
					End if 
					
					If ($var_modele_nom="")
						$var_modele_nom:=[Preferences:81]PREF_Type:2
					End if 
					
					[Preferences:81]PREF_Value_1:3:=$var_strc_nom
					[Preferences:81]PREF_Value_2:4:=$var_strc_nom_suite
					
					[Preferences:81]PREF_Value_3:5:=$var_strc_adresse
					[Preferences:81]PREF_Value_7:18:=$var_strc_telephone
					[Preferences:81]PREF_Value_8:17:=$var_strc_email
					[Preferences:81]PREF_Value_Img:16:=$var_strc_logo
					
					[Preferences:81]PREF_Value_4:13:=$var_strc_pied_1
					[Preferences:81]PREF_Value_5:14:=$var_strc_pied_2
					[Preferences:81]PREF_Value_6:15:=$var_strc_pied_3
					
					[Preferences:81]PREF_Value_9:19:=$var_modele_nom
					
					[Preferences:81]PREF_Value_10:20:=$var_strc_commentaire_1
					[Preferences:81]PREF_Value_11:21:=$var_strc_commentaire_2
					[Preferences:81]PREF_Value_12:22:=$var_strc_iban
					[Preferences:81]PREF_Value_13:23:=$var_strc_bic
					
					[Preferences:81]PREF_Value_14:25:=String:C10($var_strc_sans_tva)
					
					If ([Preferences:81]PREF_Type:2#"") | ([Preferences:81]PREF_Value_1:3#"")
						SAVE RECORD:C53([Preferences:81])
					Else 
						
						If (Records in selection:C76([Preferences:81])=1)
							DELETE RECORD:C58([Preferences:81])
						End if 
						
					End if 
					
				Else 
					DELETE RECORD:C58([Preferences:81])
				End if 
				
			End if 
			
			UNLOAD RECORD:C212([Preferences:81])
		End for 
		
		READ ONLY:C145([Preferences:81])
		
		If ($continu)
			VALIDATE TRANSACTION:C240
			ACCEPT:C269
		Else 
			ALERT:C41("Il éxiste déja un modèle ayant le même nom, vous devez choisir un num unique pour chaque modèle.")
		End if 
		
End case 