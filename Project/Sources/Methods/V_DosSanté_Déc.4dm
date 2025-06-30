//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : V_DosSanté_Déc
//{
//{          Mercredi 03 février 2003 à 17:40:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

Case of 
	: ($1=0)
		C_TEXT:C284(va_Dsanté_EtCV)
		C_TEXT:C284(va_Dsanté_Néle)
		C_TEXT:C284(va_Dsanté_Nat)
		C_TEXT:C284(va_Dsanté_Langue)
		C_TEXT:C284(va_Dsanté_DerAC)
		C_TEXT:C284(va_Dsanté_DerACrue)
		C_TEXT:C284(va_Dsanté_DerACville)
		C_BOOLEAN:C305(vb_Dsanté_Enfant)
		C_LONGINT:C283(ve_Dsanté_Enfant)
		C_TEXT:C284(va_Dsanté_SitFam)
		C_TEXT:C284(va_Dsanté_DomAC)
		C_TEXT:C284(va_Dsanté_DomACrue)
		C_TEXT:C284(va_Dsanté_DomACville)
		C_TEXT:C284(va_Dsanté_DerHéberge)  //Ne pas transférer
		
		C_TEXT:C284(va_Dsanté_Pap11)
		C_TEXT:C284(va_Dsanté_Pap12)
		C_TEXT:C284(va_Dsanté_Pap21)
		C_TEXT:C284(va_Dsanté_Pap22)
		C_TEXT:C284(va_Dsanté_Pap31)
		C_TEXT:C284(va_Dsanté_Pap32)
		
		C_TEXT:C284(va_Dsanté_Couv11)
		C_TEXT:C284(va_Dsanté_Couv12)
		C_TEXT:C284(va_Dsanté_Couv21)
		C_TEXT:C284(va_Dsanté_Couv22)
		C_TEXT:C284(va_Dsanté_Couv31)
		C_TEXT:C284(va_Dsanté_Couv32)
		
		C_TEXT:C284(va_Dsanté_Suiv1)
		C_TEXT:C284(va_Dsanté_Suiv2)
		
		C_TEXT:C284(va_Dsanté_Errer)
		
		C_TEXT:C284(va_Dsanté_Dép1)
		C_TEXT:C284(va_Dsanté_Dép2)
		C_TEXT:C284(va_Dsanté_Dép3)
		
		C_TEXT:C284(va_Dsanté_Par1)
		C_TEXT:C284(va_Dsanté_Par2)
		C_TEXT:C284(va_Dsanté_Par3)
		
		C_TEXT:C284(va_Dsanté_All1)
		C_TEXT:C284(va_Dsanté_All2)
		C_TEXT:C284(va_Dsanté_All3)
		
		C_TEXT:C284(va_Dsanté_Ethy)
		C_TEXT:C284(va_Dsanté_EthyCt)
		C_TEXT:C284(va_Dsanté_EthyQté)
		C_TEXT:C284(va_Dsanté_EthyType)
		C_TEXT:C284(va_Dsanté_EthyAnnée)
		
		C_TEXT:C284(va_Dsanté_Tabac)
		C_TEXT:C284(va_Dsanté_TabacQté)
		C_TEXT:C284(va_Dsanté_TabacType)
		C_TEXT:C284(va_Dsanté_TabacAnnée)
		
		C_TEXT:C284(va_Dsanté_Tox)
		C_TEXT:C284(va_Dsanté_ToxV1)
		C_TEXT:C284(va_Dsanté_ToxV2)
		C_TEXT:C284(va_Dsanté_ToxV3)
		C_TEXT:C284(va_Dsanté_ToxT1)
		C_TEXT:C284(va_Dsanté_ToxT2)
		C_TEXT:C284(va_Dsanté_ToxT3)
		C_TEXT:C284(va_Dsanté_ToxA1)
		C_TEXT:C284(va_Dsanté_ToxA2)
		C_TEXT:C284(va_Dsanté_ToxA3)
		
	: ($1=1)
		va_Dsanté_Néle:=""
		va_Dsanté_Nat:=""
		va_Dsanté_Langue:=""
		va_Dsanté_DerAC:=""
		va_Dsanté_DerACrue:=""
		va_Dsanté_DerACville:=""
		vb_Dsanté_Enfant:=False:C215
		ve_Dsanté_Enfant:=0
		va_Dsanté_SitFam:=""
		va_Dsanté_DomAC:=""
		va_Dsanté_DomACrue:=""
		va_Dsanté_DomACville:=""
		va_Dsanté_DerHéberge:=""  //Ne pas transférer
		
		va_Dsanté_Pap11:=""
		va_Dsanté_Pap12:=""
		va_Dsanté_Pap21:=""
		va_Dsanté_Pap22:=""
		va_Dsanté_Pap31:=""
		va_Dsanté_Pap32:=""
		
		va_Dsanté_Couv11:=""
		va_Dsanté_Couv12:=""
		va_Dsanté_Couv21:=""
		va_Dsanté_Couv22:=""
		va_Dsanté_Couv31:=""
		va_Dsanté_Couv32:=""
		
		va_Dsanté_Suiv1:=""
		va_Dsanté_Suiv2:=""
		
		va_Dsanté_Errer:=""
		
		va_Dsanté_Dép1:=""
		va_Dsanté_Dép2:=""
		va_Dsanté_Dép3:=""
		
		va_Dsanté_Par1:=""
		va_Dsanté_Par2:=""
		va_Dsanté_Par3:=""
		
		va_Dsanté_All1:=""
		va_Dsanté_All2:=""
		va_Dsanté_All3:=""
		
		va_Dsanté_Ethy:=""
		va_Dsanté_EthyCt:=""
		va_Dsanté_EthyQté:=""
		va_Dsanté_EthyType:=""
		va_Dsanté_EthyAnnée:=""
		
		va_Dsanté_Tabac:=""
		va_Dsanté_TabacQté:=""
		va_Dsanté_TabacType:=""
		va_Dsanté_TabacAnnée:=""
		
		va_Dsanté_Tox:=""
		va_Dsanté_ToxV1:=""
		va_Dsanté_ToxV2:=""
		va_Dsanté_ToxV3:=""
		va_Dsanté_ToxT1:=""
		va_Dsanté_ToxT2:=""
		va_Dsanté_ToxT3:=""
		va_Dsanté_ToxA1:=""
		va_Dsanté_ToxA2:=""
		va_Dsanté_ToxA3:=""
		
	: ($1=2)
		va_Dsanté_Néle:=[DossierSante:33]DE_LieuNéOù:18
		va_Dsanté_Nat:=[DossierSante:33]DE_Nationalité:20
		va_Dsanté_Langue:=[DossierSante:33]DE_Langue:21
		va_Dsanté_DerAC:=[DossierSante:33]DE_DernièreAdrConnue:26
		va_Dsanté_DerACrue:=[DossierSante:33]DE_DernièreAdrConnueRue:27
		va_Dsanté_DerACville:=[DossierSante:33]DE_DernièreAdrConnueVille:28
		vb_Dsanté_Enfant:=[DossierSante:33]DE_Enfant:22
		ve_Dsanté_Enfant:=[DossierSante:33]DE_EnfantNombre:23
		va_Dsanté_SitFam:=[DossierSante:33]DE_SitFamiliale:24
		va_Dsanté_DomAC:=[DossierSante:33]DE_Domiciliation:29
		va_Dsanté_DomACrue:=[DossierSante:33]DE_DomiciliationRue:30
		va_Dsanté_DomACville:=[DossierSante:33]DE_DomiciliationVille:31
		va_Dsanté_DerHéberge:=""  //Ne pas transférer
		
		va_Dsanté_Pap11:=[DossierSante:33]DE_Papiers1_1:32
		va_Dsanté_Pap12:=[DossierSante:33]DE_Papiers1_2:33
		va_Dsanté_Pap21:=[DossierSante:33]DE_Papiers2_1:34
		va_Dsanté_Pap22:=[DossierSante:33]DE_Papiers2_2:35
		va_Dsanté_Pap31:=[DossierSante:33]DE_Papiers3_1:36
		va_Dsanté_Pap32:=[DossierSante:33]DE_Papiers3_2:37
		
		va_Dsanté_Couv11:=[DossierSante:33]DE_Couverture1_1:38
		va_Dsanté_Couv12:=[DossierSante:33]DE_Couverture1_2:39
		va_Dsanté_Couv21:=[DossierSante:33]DE_Couverture2_1:40
		va_Dsanté_Couv22:=[DossierSante:33]DE_Couverture2_2:41
		va_Dsanté_Couv31:=[DossierSante:33]DE_Couverture3_1:42
		va_Dsanté_Couv32:=[DossierSante:33]DE_Couverture3_2:43
		
		va_Dsanté_Suiv1:=[DossierSante:33]DE_Suivi1_1:44
		va_Dsanté_Suiv2:=[DossierSante:33]DE_Suivi1_2:45
		
		va_Dsanté_Errer:=[DossierSante:33]DE_TempsErrance:46
		
		va_Dsanté_Dép1:=[DossierSante:33]DE_EtatDépendance1:51
		va_Dsanté_Dép2:=[DossierSante:33]DE_EtatDépendance2:52
		va_Dsanté_Dép3:=[DossierSante:33]DE_EtatDépendance3:53
		
		va_Dsanté_Par1:=[DossierSante:33]DE_EtatParasitose1:54
		va_Dsanté_Par2:=[DossierSante:33]DE_EtatParasitose2:55
		va_Dsanté_Par3:=[DossierSante:33]DE_EtatParasitose3:56
		
		va_Dsanté_All1:=[DossierSante:33]DE_EtatAllergie1:57
		va_Dsanté_All2:=[DossierSante:33]DE_EtatAllergie2:58
		va_Dsanté_All3:=[DossierSante:33]DE_EtatAllergie3:59
		
		va_Dsanté_Ethy:=[DossierSante:33]DE_Ethylisme:93
		va_Dsanté_EthyCt:=[DossierSante:33]DE_EthylismeContenant:132
		va_Dsanté_EthyQté:=[DossierSante:33]DE_EthylismeQté:94
		va_Dsanté_EthyType:=[DossierSante:33]DE_EthylismeType:95
		va_Dsanté_EthyAnnée:=[DossierSante:33]DE_EthylismeAnnées:96
		
		va_Dsanté_Tabac:=[DossierSante:33]DE_Tabac:97
		va_Dsanté_TabacQté:=[DossierSante:33]DE_TabacQté:98
		va_Dsanté_TabacType:=[DossierSante:33]DE_TabacType:99
		va_Dsanté_TabacAnnée:=[DossierSante:33]DE_TabacAnnées:100
		
		va_Dsanté_Tox:=[DossierSante:33]DE_Toxicomanie:101
		va_Dsanté_ToxV1:=[DossierSante:33]DE_ToxicomanieVoie1:102
		va_Dsanté_ToxV2:=[DossierSante:33]DE_ToxicomanieVoie2:126
		va_Dsanté_ToxV3:=[DossierSante:33]DE_ToxicomanieVoie3:127
		va_Dsanté_ToxT1:=[DossierSante:33]DE_ToxicomanieType1:103
		va_Dsanté_ToxT2:=[DossierSante:33]DE_ToxicomanieType2:128
		va_Dsanté_ToxT3:=[DossierSante:33]DE_ToxicomanieType3:129
		va_Dsanté_ToxA1:=[DossierSante:33]DE_ToxicomanieAnnées1:104
		va_Dsanté_ToxA2:=[DossierSante:33]DE_ToxicomanieAnnées2:130
		va_Dsanté_ToxA3:=[DossierSante:33]DE_ToxicomanieAnnées3:131
		
		
		
	: ($1=3)
	: ($1=4)
		[DossierSante:33]DE_LieuNéOù:18:=va_Dsanté_Néle
		[DossierSante:33]DE_Nationalité:20:=va_Dsanté_Nat
		[DossierSante:33]DE_Langue:21:=va_Dsanté_Langue
		[DossierSante:33]DE_DernièreAdrConnue:26:=va_Dsanté_DerAC
		[DossierSante:33]DE_DernièreAdrConnueRue:27:=va_Dsanté_DerACrue
		[DossierSante:33]DE_DernièreAdrConnueVille:28:=va_Dsanté_DerACville
		[DossierSante:33]DE_Enfant:22:=vb_Dsanté_Enfant
		[DossierSante:33]DE_EnfantNombre:23:=ve_Dsanté_Enfant
		[DossierSante:33]DE_SitFamiliale:24:=va_Dsanté_SitFam
		[DossierSante:33]DE_Domiciliation:29:=va_Dsanté_DomAC
		[DossierSante:33]DE_DomiciliationRue:30:=va_Dsanté_DomACrue
		[DossierSante:33]DE_DomiciliationVille:31:=va_Dsanté_DomACville
		
		va_Dsanté_DerHéberge:=""  //Ne pas transférer
		
		[DossierSante:33]DE_Papiers1_1:32:=va_Dsanté_Pap11
		[DossierSante:33]DE_Papiers1_2:33:=va_Dsanté_Pap12
		[DossierSante:33]DE_Papiers2_1:34:=va_Dsanté_Pap21
		[DossierSante:33]DE_Papiers2_2:35:=va_Dsanté_Pap22
		[DossierSante:33]DE_Papiers3_1:36:=va_Dsanté_Pap31
		[DossierSante:33]DE_Papiers3_2:37:=va_Dsanté_Pap32
		
		[DossierSante:33]DE_Couverture1_1:38:=va_Dsanté_Couv11
		[DossierSante:33]DE_Couverture1_2:39:=va_Dsanté_Couv12
		[DossierSante:33]DE_Couverture2_1:40:=va_Dsanté_Couv21
		[DossierSante:33]DE_Couverture2_2:41:=va_Dsanté_Couv22
		[DossierSante:33]DE_Couverture3_1:42:=va_Dsanté_Couv31
		[DossierSante:33]DE_Couverture3_2:43:=va_Dsanté_Couv32
		
		[DossierSante:33]DE_Suivi1_1:44:=va_Dsanté_Suiv1
		[DossierSante:33]DE_Suivi1_2:45:=va_Dsanté_Suiv2
		
		[DossierSante:33]DE_TempsErrance:46:=va_Dsanté_Errer
		
		[DossierSante:33]DE_EtatDépendance1:51:=va_Dsanté_Dép1
		[DossierSante:33]DE_EtatDépendance2:52:=va_Dsanté_Dép2
		[DossierSante:33]DE_EtatDépendance3:53:=va_Dsanté_Dép3
		
		[DossierSante:33]DE_EtatParasitose1:54:=va_Dsanté_Par1
		[DossierSante:33]DE_EtatParasitose2:55:=va_Dsanté_Par2
		[DossierSante:33]DE_EtatParasitose3:56:=va_Dsanté_Par3
		
		[DossierSante:33]DE_EtatAllergie1:57:=va_Dsanté_All1
		[DossierSante:33]DE_EtatAllergie2:58:=va_Dsanté_All2
		[DossierSante:33]DE_EtatAllergie3:59:=va_Dsanté_All3
		
		[DossierSante:33]DE_Ethylisme:93:=va_Dsanté_Ethy
		[DossierSante:33]DE_EthylismeContenant:132:=va_Dsanté_EthyCt
		[DossierSante:33]DE_EthylismeQté:94:=va_Dsanté_EthyQté
		[DossierSante:33]DE_EthylismeType:95:=va_Dsanté_EthyType
		[DossierSante:33]DE_EthylismeAnnées:96:=va_Dsanté_EthyAnnée
		
		[DossierSante:33]DE_Tabac:97:=va_Dsanté_Tabac
		[DossierSante:33]DE_TabacQté:98:=va_Dsanté_TabacQté
		[DossierSante:33]DE_TabacType:99:=va_Dsanté_TabacType
		[DossierSante:33]DE_TabacAnnées:100:=va_Dsanté_TabacAnnée
		
		[DossierSante:33]DE_Toxicomanie:101:=va_Dsanté_Tox
		[DossierSante:33]DE_ToxicomanieVoie1:102:=va_Dsanté_ToxV1
		[DossierSante:33]DE_ToxicomanieVoie2:126:=va_Dsanté_ToxV2
		[DossierSante:33]DE_ToxicomanieVoie3:127:=va_Dsanté_ToxV3
		[DossierSante:33]DE_ToxicomanieType1:103:=va_Dsanté_ToxT1
		[DossierSante:33]DE_ToxicomanieType2:128:=va_Dsanté_ToxT2
		[DossierSante:33]DE_ToxicomanieType3:129:=va_Dsanté_ToxT3
		[DossierSante:33]DE_ToxicomanieAnnées1:104:=va_Dsanté_ToxA1
		[DossierSante:33]DE_ToxicomanieAnnées2:130:=va_Dsanté_ToxA2
		[DossierSante:33]DE_ToxicomanieAnnées3:131:=va_Dsanté_ToxA3
End case 