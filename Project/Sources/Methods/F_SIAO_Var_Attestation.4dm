//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Fonction : F_SIAO_Var_Attestation
//{
//{          Lundi 7 février 2011 à 15:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($vl_Reference)

Case of 
	: ($1=0)
		C_TEXT:C284(va_SIAO_AT_Site)
		C_TEXT:C284(va_SIAO_AT_SiteAdresse; va_SIAO_AT_SiteCP; va_SIAO_AT_SiteVille; va_SIAO_AT_SiteMail)
		C_TEXT:C284(va_SIAO_AT_SiteTel; va_SIAO_AT_SiteFax)
		
		C_TEXT:C284(va_SIAO_AT_Demande; va_SIAO_AT_Demandeur)
		C_TEXT:C284(vt_SIAO_AT_DemandeurSuite; vt_SIAO_AT_Dossier)
		C_TEXT:C284(va_SIAO_AT_Statut; va_SIAO_AT_Souhait; va_SIAO_AT_Actuel; va_SIAO_AT_Proposition; va_SIAO_AT_Professionnel)
		C_TEXT:C284(vt_SIAO_AT_Notes; vt_SIAO_AT_Referent; vt_SIAO_AT_DemSignature)
		C_TEXT:C284(va_SIAO_AT_Ville)
		
		$vb_OK:=F_SIAO_Var_Attestation(1; 0)
		
	: ($1=1)
		va_SIAO_AT_Site:=""
		va_SIAO_AT_SiteAdresse:=""
		va_SIAO_AT_SiteCP:=""
		va_SIAO_AT_SiteVille:=""
		va_SIAO_AT_SiteMail:=""
		
		va_SIAO_AT_SiteTel:=""
		va_SIAO_AT_SiteFax:=""
		
		va_SIAO_AT_Demande:=""
		va_SIAO_AT_Demandeur:=""
		vt_SIAO_AT_DemandeurSuite:=""
		vt_SIAO_AT_Dossier:=""
		va_SIAO_AT_Statut:=""
		va_SIAO_AT_Souhait:=""
		va_SIAO_AT_Actuel:=""
		va_SIAO_AT_Proposition:=""
		va_SIAO_AT_Professionnel:=""
		vt_SIAO_AT_Notes:=""
		vt_SIAO_AT_Referent:=""
		vt_SIAO_AT_DemSignature:=""
		va_SIAO_AT_Ville:=""
		
	: ($1=10)
		QUERY:C277([SIAO_SiteReference:54]; [SIAO_SiteReference:54]Sa_RéférenceID:1=1)
		If (Records in selection:C76([SIAO_SiteReference:54])=1)
			va_SIAO_AT_Site:=[SIAO_SiteReference:54]Sa_ReferenceNom:6
			va_SIAO_AT_SiteAdresse:=[SIAO_SiteReference:54]Sa_Adresse1:8
			va_SIAO_AT_SiteCP:=[SIAO_SiteReference:54]Sa_CodePostal:11
			va_SIAO_AT_SiteVille:=[SIAO_SiteReference:54]Sa_Ville:12
			If ([SIAO_SiteReference:54]Sa_Téléphone:17>"")
				va_SIAO_AT_SiteTel:="Téléphone : "+[SIAO_SiteReference:54]Sa_Téléphone:17
			Else 
				va_SIAO_AT_SiteTel:=""
			End if 
			If ([SIAO_SiteReference:54]Sa_Télécopie:21>"")
				va_SIAO_AT_SiteFax:="Télécopie : "+[SIAO_SiteReference:54]Sa_Télécopie:21
				If (va_SIAO_AT_SiteTel>"")
					va_SIAO_AT_SiteFax:=" - "+va_SIAO_AT_SiteFax
				End if 
			Else 
				va_SIAO_AT_SiteFax:=""
			End if 
			If ([SIAO_SiteReference:54]Sa_eMail:22>"")
				va_SIAO_AT_SiteMail:="email : "+[SIAO_SiteReference:54]Sa_eMail:22
				If (va_SIAO_AT_SiteTel>"") | ([SIAO_SiteReference:54]Sa_Télécopie:21>"")
					va_SIAO_AT_SiteMail:=" - "+va_SIAO_AT_SiteMail
				End if 
			Else 
				va_SIAO_AT_SiteMail:=""
			End if 
			va_SIAO_AT_Ville:=[SIAO_SiteReference:54]Sa_Ville:12
		End if 
		
		
		
	: ($1=2)
		$vb_OK:=F_SIAO_Var_Attestation(1; 0)
		
		QUERY:C277([SIAO_SiteReference:54]; [SIAO_SiteReference:54]Sa_RéférenceID:1=1)
		If (Records in selection:C76([SIAO_SiteReference:54])=1)
			va_SIAO_AT_Site:=[SIAO_SiteReference:54]Sa_ReferenceNom:6
			va_SIAO_AT_SiteAdresse:=[SIAO_SiteReference:54]Sa_Adresse1:8
			va_SIAO_AT_SiteCP:=[SIAO_SiteReference:54]Sa_CodePostal:11
			va_SIAO_AT_SiteVille:=[SIAO_SiteReference:54]Sa_Ville:12
			If ([SIAO_SiteReference:54]Sa_Téléphone:17>"")
				va_SIAO_AT_SiteTel:="Téléphone : "+[SIAO_SiteReference:54]Sa_Téléphone:17
			Else 
				va_SIAO_AT_SiteTel:=""
			End if 
			If ([SIAO_SiteReference:54]Sa_Télécopie:21>"")
				va_SIAO_AT_SiteFax:="Télécopie : "+[SIAO_SiteReference:54]Sa_Télécopie:21
				If (va_SIAO_AT_SiteTel>"")
					va_SIAO_AT_SiteFax:=" - "+va_SIAO_AT_SiteFax
				End if 
			Else 
				va_SIAO_AT_SiteFax:=""
			End if 
			If ([SIAO_SiteReference:54]Sa_eMail:22>"")
				va_SIAO_AT_SiteMail:="email : "+[SIAO_SiteReference:54]Sa_eMail:22
				If (va_SIAO_AT_SiteTel>"") | ([SIAO_SiteReference:54]Sa_Télécopie:21>"")
					va_SIAO_AT_SiteMail:=" - "+va_SIAO_AT_SiteMail
				End if 
			Else 
				va_SIAO_AT_SiteMail:=""
			End if 
			va_SIAO_AT_Ville:=[SIAO_SiteReference:54]Sa_Ville:12
		End if 
		
		va_SIAO_AT_Demande:=("Individuel"*Num:C11([SIAO:50]Si_Demande_Type:5=1))+("Famille"*Num:C11([SIAO:50]Si_Demande_Type:5=2))+("Groupé"*Num:C11([SIAO:50]Si_Demande_Type:5=3))
		va_SIAO_AT_Demandeur:=[SIAO:50]Si_Demandeur:20
		
		QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1)
		If (Records in selection:C76([SIAO_Personnes:51])>1)
			ORDER BY:C49([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Rang:7; >)
			Repeat 
				If ([SIAO_Personnes:51]Sp_Rang:7=1)
					$vl_Reference:=[SIAO_Personnes:51]Sp_RéférenceID:1
					
				Else 
					vt_SIAO_AT_DemandeurSuite:=vt_SIAO_AT_DemandeurSuite+(" ; "*Num:C11(vt_SIAO_AT_DemandeurSuite>""))
					vt_SIAO_AT_DemandeurSuite:=vt_SIAO_AT_DemandeurSuite+[SIAO_Personnes:51]Sp_Nom:11+" "+[SIAO_Personnes:51]Sp_Prenom:13+" "+String:C10([SIAO_Personnes:51]Sp_Date_de_naissance:14; Interne date court:K1:7)
					
				End if 
				NEXT RECORD:C51([SIAO_Personnes:51])
			Until (End selection:C36([SIAO_Personnes:51]))
		End if 
		
		vt_SIAO_AT_Dossier:=("Insertion"*Num:C11([SIAO:50]Si_Trans_Type:34=True:C214))+("Urgence"*Num:C11([SIAO:50]Si_Trans_Type:34=False:C215))+" - N° "+[SIAO:50]Si_Demande_Numero:3+" le "+String:C10([SIAO:50]Si_Demande_Date:2; Interne date court:K1:7)
		va_SIAO_AT_Statut:=[SIAO:50]Si_Etat_Type:41
		
		
		va_SIAO_AT_Souhait:=[SIAO:50]Si_Log_Souhaite1:22
		QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=$vl_Reference; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=ta_SIAO_PageTitre{7}; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6="A")
		If (Records in selection:C76([SIAO_Situations:52])>0)
			va_SIAO_AT_Actuel:=[SIAO_Situations:52]Ss_Intitule:9
		End if 
		
		
		
		QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=$vl_Reference; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=ta_SIAO_PageTitre{12}; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6="C")
		If (Records in selection:C76([SIAO_Situations:52])>0)
			va_SIAO_AT_Proposition:=[SIAO_Situations:52]Ss_Intitule:9
		End if 
		
		QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=$vl_Reference; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=ta_SIAO_PageTitre{12}; *)
		QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6="A")
		If (Records in selection:C76([SIAO_Situations:52])>0)
			va_SIAO_AT_Professionnel:=[SIAO_Situations:52]Ss_Intitule:9
		End if 
		
		vt_SIAO_AT_Notes:=[SIAO:50]Si_Demandeur_Suivi:45
		
		If (7=8)
			QUERY:C277([SIAO_SiteAccueil:55]; [SIAO_SiteAccueil:55]Sr_RéférenceID:1=[SIAO:50]Si_OrigineSiteAccueil_ID:19)
			MultiSoc_Filter(->[SIAO_SiteAccueil:55])
			If (Records in selection:C76([SIAO_SiteAccueil:55])=1)
				vt_SIAO_AT_Referent:=[SIAO_SiteAccueil:55]Sr_Nom:5+" "+[SIAO_SiteAccueil:55]Sr_Prénom:6
				//[SIAO_Référents]Sr_Civilité
				//[SIAO_Référents]Sr_Nom
				//[SIAO_Référents]Sr_Prénom
				//[SIAO_Référents]Sr_Téléphone
				//[SIAO_Référents]Sr_Télécopie
				//[SIAO_Référents]Sr_mail
			End if 
		End if 
		
		
End case 