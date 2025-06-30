//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_SIAO_Var
//{          Mercredi 1 décembre 2010 à 10:45:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($ii)
C_BOOLEAN:C305($vb_OK)
Case of 
	: ($1=0)
		C_LONGINT:C283(vl_SIAO_Accueil)
		C_TEXT:C284(va_SIAO_Accueil)
		C_TEXT:C284(va_SIAO_Accueil_Ad1; va_SIAO_Accueil_Ad2; va_SIAO_Accueil_Ad3; va_SIAO_Accueil_Ville)
		C_TEXT:C284(va_SIAO_Accueil_CP)
		C_TEXT:C284(va_SIAO_Accueil_Bureau)
		C_TEXT:C284(va_SIAO_Accueil_Tel)
		C_TEXT:C284(va_SIAO_Accueil_Fax)
		C_TEXT:C284(va_SIAO_Accueil_mail)
		vl_SIAO_Accueil:=0
		
		C_LONGINT:C283(vl_SIAO_Referent)
		C_TEXT:C284(va_SIAO_Referent_Civilite)
		C_TEXT:C284(va_SIAO_Referent_Nom)
		C_TEXT:C284(va_SIAO_Referent_Prénom)
		C_TEXT:C284(va_SIAO_Referent_Tel; va_SIAO_Referent_Fax)
		C_TEXT:C284(va_SIAO_Referent_mail)
		C_TEXT:C284(va_SIAO_Referent_NomPrenom)
		
		C_LONGINT:C283(vl_SIAO_Action)
		C_TEXT:C284(va_SIAO_Action)
		
		ARRAY LONGINT:C221(tl_SIAO_Referent_ID; 0)
		ARRAY TEXT:C222(ta_SIAO_Referent_Nom; 0)
		ALL RECORDS:C47([SIAO_SiteAccueil:55])
		MultiSoc_Filter(->[SIAO_SiteAccueil:55])
		ORDER BY:C49([SIAO_SiteAccueil:55]; [SIAO_SiteAccueil:55]Sr_NomPrénom:12)
		SELECTION TO ARRAY:C260([SIAO_SiteAccueil:55]Sr_RéférenceID:1; tl_SIAO_Referent_ID; [SIAO_SiteAccueil:55]Sr_NomPrénom:12; ta_SIAO_Referent_Nom)
		
		
		C_TEXT:C284(va_SIAO_ITEM_Titre)
		
	: ($1=1)
		ALL RECORDS:C47([SIAO_SiteAccueil:55])
		MultiSoc_Filter(->[SIAO_SiteAccueil:55])
		ORDER BY:C49([SIAO_SiteAccueil:55]; [SIAO_SiteAccueil:55]Sr_NomPrénom:12)
		SELECTION TO ARRAY:C260([SIAO_SiteAccueil:55]Sr_RéférenceID:1; tl_SIAO_Referent_ID; [SIAO_SiteAccueil:55]Sr_NomPrénom:12; ta_SIAO_Referent_Nom)
		
		
	: ($1=2)
		QUERY:C277([SIAO_SiteReference:54]; [SIAO_SiteReference:54]Sa_RéférenceID:1=1)
		MultiSoc_Filter(->[SIAO_SiteReference:54])
		If (Records in selection:C76([SIAO_SiteReference:54])=0)
			READ WRITE:C146([SIAO_SiteReference:54])
			CREATE RECORD:C68([SIAO_SiteReference:54])
			MultiSoc_Init_Structure(->[SIAO_SiteReference:54])
			[SIAO_SiteReference:54]Sa_RéférenceID:1:=1
			SAVE RECORD:C53([SIAO_SiteReference:54])
			UNLOAD RECORD:C212([SIAO_SiteReference:54])
			READ ONLY:C145([SIAO_SiteReference:54])
			QUERY:C277([SIAO_SiteReference:54]; [SIAO_SiteReference:54]Sa_RéférenceID:1=1)
		End if 
		vl_SIAO_Accueil:=[SIAO_SiteReference:54]Sa_RéférenceID:1
		va_SIAO_Accueil:=[SIAO_SiteReference:54]Sa_ReferenceNom:6
		va_SIAO_Accueil_Bureau:=[SIAO_SiteReference:54]Sa_ReferenceBureau:7
		va_SIAO_Accueil_Ad1:=[SIAO_SiteReference:54]Sa_Adresse1:8
		va_SIAO_Accueil_Ad2:=[SIAO_SiteReference:54]Sa_Adresse2:9
		va_SIAO_Accueil_Ad3:=[SIAO_SiteReference:54]Sa_Adresse3:10
		va_SIAO_Accueil_CP:=[SIAO_SiteReference:54]Sa_CodePostal:11
		va_SIAO_Accueil_Ville:=[SIAO_SiteReference:54]Sa_Ville:12
		va_SIAO_Accueil_Tel:=[SIAO_SiteReference:54]Sa_Téléphone:17
		va_SIAO_Accueil_Fax:=[SIAO_SiteReference:54]Sa_Télécopie:21
		va_SIAO_Accueil_mail:=[SIAO_SiteReference:54]Sa_eMail:22
		
	: ($1=3)
		If (i_Confirmer("Voulez- vous confirmer l'enregistrement des données du site de référence ?"))
			READ WRITE:C146([SIAO_SiteReference:54])
			QUERY:C277([SIAO_SiteReference:54]; [SIAO_SiteReference:54]Sa_RéférenceID:1=1)
			MultiSoc_Filter(->[SIAO_SiteReference:54])
			If (Records in selection:C76([SIAO_SiteReference:54])=1)
				If (i_NonVerrou(->[SIAO_SiteReference:54]))
					[SIAO_SiteReference:54]Sa_ReferenceNom:6:=va_SIAO_Accueil
					[SIAO_SiteReference:54]Sa_ReferenceBureau:7:=va_SIAO_Accueil_Bureau
					[SIAO_SiteReference:54]Sa_Adresse1:8:=va_SIAO_Accueil_Ad1
					[SIAO_SiteReference:54]Sa_Adresse2:9:=va_SIAO_Accueil_Ad2
					[SIAO_SiteReference:54]Sa_Adresse3:10:=va_SIAO_Accueil_Ad3
					[SIAO_SiteReference:54]Sa_CodePostal:11:=va_SIAO_Accueil_CP
					[SIAO_SiteReference:54]Sa_Ville:12:=va_SIAO_Accueil_Ville
					[SIAO_SiteReference:54]Sa_Téléphone:17:=va_SIAO_Accueil_Tel
					[SIAO_SiteReference:54]Sa_Télécopie:21:=va_SIAO_Accueil_Fax
					[SIAO_SiteReference:54]Sa_eMail:22:=va_SIAO_Accueil_mail
					[SIAO_SiteReference:54]Sa_Date:2:=Current date:C33
					SAVE RECORD:C53([SIAO_SiteReference:54])
					UNLOAD RECORD:C212([SIAO_SiteReference:54])
				End if 
			End if 
			UNLOAD RECORD:C212([SIAO_SiteReference:54])
			READ ONLY:C145([SIAO_SiteReference:54])
		End if 
		
	: ($1=4)
		vl_SIAO_Referent:=0
		va_SIAO_Referent_Civilite:=""
		va_SIAO_Referent_Nom:=""
		va_SIAO_Referent_Prénom:=""
		va_SIAO_Referent_Tel:=""
		va_SIAO_Referent_Fax:=""
		va_SIAO_Referent_mail:=""
		va_SIAO_Referent_NomPrenom:=""
		
		
	: ($1=5)
		$vb_OK:=((va_SIAO_Referent_Nom>"") & (va_SIAO_Referent_Prénom>""))
		If ($vb_OK=False:C215)
			ALERT:C41("Le nom et le prénom sont obligatoires !")
		Else 
			$vb_OK:=False:C215
			If (vl_SIAO_Referent>0)  //Modification
				READ WRITE:C146([SIAO_SiteAccueil:55])
				QUERY:C277([SIAO_SiteAccueil:55]; [SIAO_SiteAccueil:55]Sr_RéférenceID:1=vl_SIAO_Referent)
				MultiSoc_Filter(->[SIAO_SiteAccueil:55])
				If (Records in selection:C76([SIAO_SiteAccueil:55])=1)
					If (i_NonVerrou(->[SIAO_SiteReference:54]))
						[SIAO_SiteAccueil:55]Sr_Civilité:4:=va_SIAO_Referent_Civilite
						[SIAO_SiteAccueil:55]Sr_Nom:5:=va_SIAO_Referent_Nom
						[SIAO_SiteAccueil:55]Sr_Prénom:6:=va_SIAO_Referent_Prénom
						[SIAO_SiteAccueil:55]Sr_Téléphone:9:=va_SIAO_Referent_Tel
						[SIAO_SiteAccueil:55]Sr_Télécopie:10:=va_SIAO_Referent_Fax
						[SIAO_SiteAccueil:55]Sr_mail:11:=va_SIAO_Referent_mail
						[SIAO_SiteAccueil:55]Sr_NomPrénom:12:=va_SIAO_Referent_Nom+" "+va_SIAO_Referent_Prénom
						[SIAO_SiteAccueil:55]Sr_Date:2:=Current date:C33
						SAVE RECORD:C53([SIAO_SiteAccueil:55])
						$vb_OK:=True:C214
					End if 
				End if 
				UNLOAD RECORD:C212([SIAO_SiteAccueil:55])
				READ ONLY:C145([SIAO_SiteAccueil:55])
				
			Else   //Création
				$ii:=Find in array:C230(ta_SIAO_Referent_Nom; (va_SIAO_Referent_Nom+" "+va_SIAO_Referent_Prénom))
				If ($ii>0)
					$vb_OK:=False:C215
					ALERT:C41("Cette identité "+va_SIAO_Referent_Nom+" "+va_SIAO_Referent_Prénom+" existe déjà dans la liste des sites d'accueil.")
				Else 
					$vb_OK:=i_Confirmer(va_SIAO_Referent_Nom+" "+va_SIAO_Referent_Prénom+<>va_CR+"Voulez-vous créer la fiche du site d'accueil ?")
				End if 
				If ($vb_OK)
					READ WRITE:C146([SIAO_SiteAccueil:55])
					CREATE RECORD:C68([SIAO_SiteAccueil:55])
					MultiSoc_Init_Structure(->[SIAO_SiteAccueil:55])
					[SIAO_SiteAccueil:55]Sr_RéférenceID:1:=Uut_Numerote(->[SIAO_SiteAccueil:55])
					vl_SIAO_Referent:=[SIAO_SiteAccueil:55]Sr_RéférenceID:1
					[SIAO_SiteAccueil:55]Sr_Civilité:4:=va_SIAO_Referent_Civilite
					[SIAO_SiteAccueil:55]Sr_Nom:5:=va_SIAO_Referent_Nom
					[SIAO_SiteAccueil:55]Sr_Prénom:6:=va_SIAO_Referent_Prénom
					[SIAO_SiteAccueil:55]Sr_Téléphone:9:=va_SIAO_Referent_Tel
					[SIAO_SiteAccueil:55]Sr_Télécopie:10:=va_SIAO_Referent_Fax
					[SIAO_SiteAccueil:55]Sr_mail:11:=va_SIAO_Referent_mail
					[SIAO_SiteAccueil:55]Sr_NomPrénom:12:=va_SIAO_Referent_Nom+" "+va_SIAO_Referent_Prénom
					[SIAO_SiteAccueil:55]Sr_Date:2:=Current date:C33
					SAVE RECORD:C53([SIAO_SiteAccueil:55])
					UNLOAD RECORD:C212([SIAO_SiteAccueil:55])
					READ ONLY:C145([SIAO_SiteAccueil:55])
				End if 
			End if 
		End if 
		If ($vb_OK)
			P_SIAO_Var(1; 0)
		End if 
	: ($1=6)
		If (va_SIAO_Referent_NomPrenom>"")
			$ii:=Find in array:C230(ta_SIAO_Referent_Nom; va_SIAO_Referent_NomPrenom)
			If ($ii>0)
				QUERY:C277([SIAO_SiteAccueil:55]; [SIAO_SiteAccueil:55]Sr_RéférenceID:1=tl_SIAO_Referent_ID{$ii})
				MultiSoc_Filter(->[SIAO_SiteAccueil:55])
				If (Records in selection:C76([SIAO_SiteAccueil:55])=1)
					vl_SIAO_Referent:=[SIAO_SiteAccueil:55]Sr_RéférenceID:1
					va_SIAO_Referent_Civilite:=[SIAO_SiteAccueil:55]Sr_Civilité:4
					va_SIAO_Referent_Nom:=[SIAO_SiteAccueil:55]Sr_Nom:5
					va_SIAO_Referent_Prénom:=[SIAO_SiteAccueil:55]Sr_Prénom:6
					va_SIAO_Referent_Tel:=[SIAO_SiteAccueil:55]Sr_Téléphone:9
					va_SIAO_Referent_Fax:=[SIAO_SiteAccueil:55]Sr_Télécopie:10
					va_SIAO_Referent_mail:=[SIAO_SiteAccueil:55]Sr_mail:11
				End if 
			End if 
		End if 
		UNLOAD RECORD:C212([SIAO_SiteAccueil:55])
		
	: ($1=7)
		QUERY:C277([SIAO_SiteAccueil:55]; [SIAO_SiteAccueil:55]Sr_RéférenceID:1=$2)
		MultiSoc_Filter(->[SIAO_SiteAccueil:55])
		If (Records in selection:C76([SIAO_SiteAccueil:55])=1)
			vl_SIAO_Referent:=[SIAO_SiteAccueil:55]Sr_RéférenceID:1
			va_SIAO_Referent_Civilite:=[SIAO_SiteAccueil:55]Sr_Civilité:4
			va_SIAO_Referent_Nom:=[SIAO_SiteAccueil:55]Sr_Nom:5
			va_SIAO_Referent_Prénom:=[SIAO_SiteAccueil:55]Sr_Prénom:6
			va_SIAO_Referent_Tel:=[SIAO_SiteAccueil:55]Sr_Téléphone:9
			va_SIAO_Referent_Fax:=[SIAO_SiteAccueil:55]Sr_Télécopie:10
			va_SIAO_Referent_mail:=[SIAO_SiteAccueil:55]Sr_mail:11
			[SIAO_SiteAccueil:55]Sr_NomPrénom:12:=va_SIAO_Referent_Nom+" "+va_SIAO_Referent_Prénom
		Else 
			vl_SIAO_Referent:=0
			va_SIAO_Referent_Civilite:=""
			va_SIAO_Referent_Nom:=""
			va_SIAO_Referent_Prénom:=""
			va_SIAO_Referent_Tel:=""
			va_SIAO_Referent_Fax:=""
			va_SIAO_Referent_mail:=""
			va_SIAO_Referent_NomPrenom:=""
		End if 
		UNLOAD RECORD:C212([SIAO_SiteAccueil:55])
		
	: ($1=8)
		If (va_SIAO_Referent_NomPrenom>"")
			$ii:=Find in array:C230(ta_SIAO_Referent_Nom; va_SIAO_Referent_NomPrenom)
			If ($ii>0)
				QUERY:C277([SIAO_SiteAccueil:55]; [SIAO_SiteAccueil:55]Sr_RéférenceID:1=tl_SIAO_Referent_ID{$ii})
				MultiSoc_Filter(->[SIAO_SiteAccueil:55])
				If (Records in selection:C76([SIAO_SiteAccueil:55])>0)
					vl_SIAO_Referent:=[SIAO_SiteAccueil:55]Sr_RéférenceID:1
					va_SIAO_Referent_Civilite:=[SIAO_SiteAccueil:55]Sr_Civilité:4
					va_SIAO_Referent_Nom:=[SIAO_SiteAccueil:55]Sr_Nom:5
					va_SIAO_Referent_Prénom:=[SIAO_SiteAccueil:55]Sr_Prénom:6
					va_SIAO_Referent_Tel:=[SIAO_SiteAccueil:55]Sr_Téléphone:9
					va_SIAO_Referent_Fax:=[SIAO_SiteAccueil:55]Sr_Télécopie:10
					va_SIAO_Referent_mail:=[SIAO_SiteAccueil:55]Sr_mail:11
					[SIAO:50]Si_OrigineSiteAccueil_ID:19:=vl_SIAO_Referent
					[SIAO:50]Si_Origine_SiteAccueil:18:=va_SIAO_Referent_Nom+" "+va_SIAO_Referent_Prénom
					REDRAW:C174([SIAO:50]Si_Origine_SiteAccueil:18)
				End if 
			End if 
		End if 
		UNLOAD RECORD:C212([SIAO_SiteAccueil:55])
		
		
	: ($1=9)
		$vb_OK:=(vl_SIAO_Referent>0)
		If ($vb_OK)
			$vb_OK:=False:C215
			READ WRITE:C146([SIAO_SiteAccueil:55])
			QUERY:C277([SIAO_SiteAccueil:55]; [SIAO_SiteAccueil:55]Sr_RéférenceID:1=vl_SIAO_Referent)
			MultiSoc_Filter(->[SIAO_SiteAccueil:55])
			If (Records in selection:C76([SIAO_SiteAccueil:55])=1)
				If (i_NonVerrou(->[SIAO_SiteAccueil:55]))
					If (i_Confirmer("Voulez- vous confirmer la suppression des données du site d'accueil : "+[SIAO_SiteAccueil:55]Sr_Nom:5+" "+[SIAO_SiteAccueil:55]Sr_Prénom:6+" ?"))
						
						DELETE RECORD:C58([SIAO_SiteAccueil:55])
						vl_SIAO_Referent:=0
						va_SIAO_Referent_Civilite:=""
						va_SIAO_Referent_Nom:=""
						va_SIAO_Referent_Prénom:=""
						va_SIAO_Referent_Tel:=""
						va_SIAO_Referent_Fax:=""
						va_SIAO_Referent_mail:=""
						va_SIAO_Referent_NomPrenom:=""
						$vb_OK:=True:C214
					End if 
				End if 
			End if 
			UNLOAD RECORD:C212([SIAO_SiteAccueil:55])
			READ ONLY:C145([SIAO_SiteAccueil:55])
			If ($vb_OK)
				P_SIAO_Var(1; 0)
			End if 
		Else 
			ALERT:C41("Aucune fiche en ligne !")
		End if 
		
		
End case 