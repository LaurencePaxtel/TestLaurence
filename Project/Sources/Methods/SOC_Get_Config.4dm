//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 06/03/20, 17:02:27
// ----------------------------------------------------
// Method: SOC_Get_Config
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1)

C_TEXT:C284(SO_Facture_Prefixe; SO_Avoir_Prefixe; SOC_Fac_Mail_Texte; SO_Telephone; SO_Email; SO_Ville; SO_FAC_GI_Separer_Charges_Str; txt_strc_nom; txt_strc_nom_suite; \
txt_strc_adresse; SO_Chemin_GED; SO_Serveur_IP; SO_Serveur_Port_Web; strc_smtp_server; strc_smtp_username; strc_smtp_password; va_T_Onglet3Note; \
va_T_Onglet4Note; va_T_Onglet5Note; va_T_Onglet6Note; va_T_Onglet7Note; va_T_Onglet8Note; va_T_Onglet9Note; va_T_Onglet10Note)
C_BOOLEAN:C305(SO_Activer_TVA; SO_Activer_Module_Facturation; SO_DOS_Encours_Activer; SO_Planning_Web_Activer; SO_FAC_GI_Separer_Charges; SO_GI_Activer)
C_LONGINT:C283(SOC_ID; strc_smtp_port)
C_PICTURE:C286(strc_logo; strcLogoPng_i)
C_PICTURE:C286(strc_signature; strcSignaturePng_i)
var $Ref_Structure_t : Text

SO_Activer_Module_Facturation:=False:C215
SO_Activer_TVA:=False:C215
SO_DOS_Encours_Activer:=False:C215
SO_Planning_Web_Activer:=False:C215
SO_FAC_GI_Separer_Charges:=False:C215
SO_FAC_GI_Separer_Charges_Str:="false"
SO_GI_Activer:=False:C215

SO_Facture_Prefixe:="FAC"
SO_Avoir_Prefixe:="AV"

SO_Telephone:=""
SO_Email:=""
SO_Chemin_GED:=""

va_T_Onglet3Note:=""
va_T_Onglet4Note:=""
va_T_Onglet5Note:=""
va_T_Onglet6Note:=""
va_T_Onglet7Note:=""
va_T_Onglet8Note:=""
va_T_Onglet9Note:=""
va_T_Onglet10Note:=""

READ ONLY:C145([Structures:79])
READ ONLY:C145([SOciete:18])

If (Application type:C494=4D Server:K5:6) & ((Value type:C1509(ref_soc_active)#Est une variable indéfinie:K8:13) && (ref_soc_active#""))
	QUERY:C277([Structures:79]; [Structures:79]STRC_Initiales:2=ref_soc_active)
Else 
	If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
		$Ref_Structure_t:=Session:C1714.storage.intervenant.Ref_Structure
	Else 
		$Ref_Structure_t:=Storage:C1525.societeDetail.Ref_Structure
	End if 
	QUERY:C277([Structures:79]; [Structures:79]STRC_Initiales:2=$Ref_Structure_t)
End if 

QUERY:C277([SOciete:18]; [SOciete:18]ID:94=[Structures:79]STRC_Societe_ID:6)

If (Records in selection:C76([SOciete:18])=1)
	SOC_ID:=[SOciete:18]ID:94
	
	strc_logo:=[Structures:79]STRC_Logo:5
	strcLogoPng_i:=strc_logo
	CONVERT PICTURE:C1002(strcLogoPng_i; "image/png")
	
	strc_signature:=[SOciete:18]SO_SignatureElectronique:130
	strcSignaturePng_i:=strc_signature
	CONVERT PICTURE:C1002(strcSignaturePng_i; "image/png")
	
	If (Count parameters:C259=1)
		
		Case of 
			: ($1=1)
				//outilsTransformPicture (->strc_logo;196;65)
		End case 
		
	End if 
	
	txt_strc_nom:=[SOciete:18]SO_Libel01:3
	txt_strc_nom_suite:=[SOciete:18]SO_Libel02:4
	
	txt_strc_adresse:=[SOciete:18]SO_Libel03:5
	SO_Ville:=[SOciete:18]SO_Ville:76
	SO_FAC_GI_Separer_Charges:=[SOciete:18]SO_FAC_GI_Separer_Charges:121
	
	If (SO_FAC_GI_Separer_Charges)
		SO_FAC_GI_Separer_Charges_Str:="true"
	Else 
		SO_FAC_GI_Separer_Charges_Str:="false"
	End if 
	
	SO_Activer_Module_Facturation:=[SOciete:18]SO_Activer_Module_Facturation:98
	SO_Activer_TVA:=[SOciete:18]SO_Activer_TVA:103
	
	If ([SOciete:18]SO_Facture_Prefixe:104#"")
		SO_Facture_Prefixe:=[SOciete:18]SO_Facture_Prefixe:104
	End if 
	
	If ([SOciete:18]SO_Avoir_Prefixe:105#"")
		SO_Avoir_Prefixe:=[SOciete:18]SO_Avoir_Prefixe:105
	End if 
	
	SO_Telephone:=[SOciete:18]SO_Telephone:115
	SO_Email:=[SOciete:18]SO_Email:116
	
	SO_DOS_Encours_Activer:=[SOciete:18]SO_DOS_Encours_Activer:109
	SO_GI_Activer:=[SOciete:18]SO_GI_Activer:139
	SO_DC_Activer:=[SOciete:18]SO_DC_Activer:140
	
	
	SOC_Fac_Mail_Texte:=[SOciete:18]SO_Fac_Mail_Texte:110
	
	SO_Planning_Web_Activer:=[SOciete:18]SO_Planning_Web_Activer:114
	
	i_entete:=[Structures:79]STRC_Logo:5
	i_pied:=[Structures:79]STRC_Logo:5
	
	strc_smtp_server:=[SOciete:18]SO_SMTP_Server:111
	strc_smtp_username:=[SOciete:18]SO_SMTP_Username:112
	strc_smtp_password:=[SOciete:18]SO_SMTP_Password:113
	strc_smtp_port:=[SOciete:18]SO_SMTP_Port:117
	
	FAC_Modeles_Impression_Get("list")
	
	SO_Chemin_GED:=[SOciete:18]SO_Chemin_GED:96
	SO_Serveur_IP:=[SOciete:18]SO_Serveur_IP:119
	SO_Serveur_Port_Web:=[SOciete:18]SO_Serveur_Port_Web:120
	
	va_T_Onglet3Note:=Choose:C955(Length:C16([SOciete:18]SO_OngletNote_3:33)>0; [SOciete:18]SO_OngletNote_3:33; "Note 2")
	va_T_Onglet4Note:=Choose:C955(Length:C16([SOciete:18]SO_OngletNote_4:73)>0; [SOciete:18]SO_OngletNote_4:73; "Note 4")
	va_T_Onglet5Note:=Choose:C955(Length:C16([SOciete:18]SO_OngletNote_5:74)>0; [SOciete:18]SO_OngletNote_5:74; "Note 5")
	va_T_Onglet6Note:=Choose:C955(Length:C16([SOciete:18]SO_Ongletnote_6:93)>0; [SOciete:18]SO_Ongletnote_6:93; "Note 1")
	va_T_Onglet7Note:=Choose:C955(Length:C16([SOciete:18]SO_Ongletnote_7:95)>0; [SOciete:18]SO_Ongletnote_7:95; "Note 3")
	va_T_Onglet8Note:=Choose:C955(Length:C16([SOciete:18]SO_OngletNote_8:122)>0; [SOciete:18]SO_OngletNote_8:122; "Maraude 1")
	va_T_Onglet9Note:=Choose:C955(Length:C16([SOciete:18]SO_OngletNote_9:123)>0; [SOciete:18]SO_OngletNote_9:123; "Maraude 2")
	va_T_Onglet10Note:=Choose:C955(Length:C16([SOciete:18]SO_OngletNote_10:124)>0; [SOciete:18]SO_OngletNote_10:124; "FVV")
End if 