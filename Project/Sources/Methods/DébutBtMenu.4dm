//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DébutBtMenu  
//{          Les noms des boutons du menu 
//{          Vendredi 5 novembre 2004 à 11:07:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_TEXT:C284($2)

C_LONGINT:C283($ii; $v_Forground; $v_Background; $v_Style)
$v_Forground:=Noir:K11:16
$v_Background:=0
$v_Style:=Normal:K14:1+Italique:K14:3
Case of 
	: ($1=0)
		C_TEXT:C284(<>va_M_Demande; <>va_M_Adresses; <>va_M_Situations; <>va_M_Associations)
		C_TEXT:C284(<>va_M_Centres; <>va_M_Disponibilités; <>va_M_Options; <>va_M_Transmission)
		C_TEXT:C284(<>va_M_Différée; <>va_M_Prolongation; <>va_M_Utilitaires)
		C_TEXT:C284(<>va_M_LocRec; <>va_M_LocFic; <>va_M_HbJour; <>va_M_HbNuit; <>va_M_TélJour; <>va_M_TélNuit)
		C_TEXT:C284(<>va_M_Items; <>va_M_Fusion)
		C_TEXT:C284(<>va_M_Veil115; <>va_M_VeilMaraude)
		C_TEXT:C284(<>va_M_MarJour; <>va_M_MarNuit)
		C_TEXT:C284(<>va_M_Etats; <>va_M_Prestations; <>va_M_Accueil)
		C_TEXT:C284(<>va_M_Liste; <>va_M_Report; <>va_M_Santé; <>va_M_Planning)
		
		C_LONGINT:C283(<>ve_M_Demande; <>ve_M_Adresses; <>ve_M_Situations; <>ve_M_Associations)
		C_LONGINT:C283(<>ve_M_Centres; <>ve_M_Disponibilités; <>ve_M_Options; <>ve_M_Transmission)
		C_LONGINT:C283(<>ve_M_Différée; <>ve_M_Prolongation; <>ve_M_Utilitaires)
		C_LONGINT:C283(<>ve_M_LocRec; <>ve_M_LocFic; <>ve_M_HbJour; <>ve_M_HbNuit; <>ve_M_TélJour; <>ve_M_TélNuit)
		C_LONGINT:C283(<>ve_M_Items; <>ve_M_Fusion)
		C_LONGINT:C283(<>ve_M_Veil115; <>ve_M_VeilMaraude)
		C_LONGINT:C283(<>ve_M_MarJour; <>ve_M_MarNuit)
		C_LONGINT:C283(<>ve_M_Etats; <>ve_M_Prestations; <>ve_M_Accueil)
		C_LONGINT:C283(<>ve_M_Liste; <>ve_M_Report; <>ve_M_Santé)
		
		C_TEXT:C284(<>va_M_TransJour; <>va_M_TransNuit)
		
		
		
		
		C_LONGINT:C283(<>ve_MT_Localisation; <>ve_MT_Hébergement; <>ve_MT_Télécopie; <>ve_MT_Transfert)
		C_LONGINT:C283(<>ve_MT_Veille; <>ve_MT_Maraude; <>ve_MT_Social; <>ve_MT_Stats; <>ve_MT_Dossier)
		
		
		//01/02/2011
		C_TEXT:C284(<>va_M_SiaoDossier; <>va_M_SiaoVeil)
		C_LONGINT:C283(<>ve_M_SiaoDossier; <>ve_M_SiaoVeil)
		C_LONGINT:C283(<>ve_MT_Siao)
		
		//06/04/2011
		C_TEXT:C284(<>va_M_AnonymeStat; <>va_M_AnonymeExport)
		C_LONGINT:C283(<>ve_M_AnonymeStat; <>ve_M_AnonymeExport)
		C_LONGINT:C283(<>ve_MT_Anonyme)
		
		
		//FIN 01/02/2011 
		
		$ii:=1
		<>ve_M_Demande:=$ii
		<>ve_M_Adresses:=$ii
		<>ve_M_Situations:=$ii
		<>ve_M_Associations:=$ii
		<>ve_M_Centres:=$ii
		<>ve_M_Disponibilités:=$ii
		<>ve_M_Options:=$ii
		<>ve_M_Transmission:=$ii
		<>ve_M_Différée:=$ii
		<>ve_M_Prolongation:=$ii
		<>ve_M_Utilitaires:=$ii
		<>ve_M_LocRec:=$ii
		<>ve_M_LocFic:=$ii
		<>ve_M_HbJour:=$ii
		<>ve_M_HbNuit:=$ii
		<>ve_M_TélJour:=$ii
		<>ve_M_TélNuit:=$ii
		<>ve_M_Items:=$ii
		<>ve_M_Fusion:=$ii
		<>ve_M_Veil115:=$ii
		<>ve_M_VeilMaraude:=$ii
		<>ve_M_MarJour:=$ii
		<>ve_M_MarNuit:=$ii
		<>ve_M_Etats:=$ii
		<>ve_M_Prestations:=$ii
		<>ve_M_Accueil:=$ii
		<>ve_M_Liste:=$ii
		<>ve_M_Report:=$ii
		<>ve_M_Santé:=$ii
		
		<>ve_M_SiaoDossier:=$ii
		<>ve_M_SiaoVeil:=$ii
		
		<>ve_M_AnonymeStat:=$ii
		<>ve_M_AnonymeExport:=$ii
		
		<>ve_MT_Localisation:=$ii
		<>ve_MT_Hébergement:=$ii
		<>ve_MT_Télécopie:=$ii
		<>ve_MT_Transfert:=$ii
		<>ve_MT_Veille:=$ii
		<>ve_MT_Maraude:=$ii
		<>ve_MT_Social:=$ii
		<>ve_MT_Stats:=$ii
		<>ve_MT_Dossier:=$ii
		
		<>ve_MT_Siao:=$ii
		<>ve_MT_Anonyme:=$ii
		
		
		
	: ($1=1)
		<>va_M_Demande:="Demande de prestations"
		<>va_M_Adresses:="Adresses utiles"
		<>va_M_Situations:="Situations particulières"
		<>va_M_Associations:="Associations"
		
		<>va_M_Centres:="Centres d'hébergement"
		<>va_M_Disponibilités:="Disponibilités"
		<>va_M_Options:="Option Veille"
		<>va_M_Transmission:="Transmission"
		
		<>va_M_Différée:="Saisie différée"
		<>va_M_Prolongation:="Prolongation"
		<>va_M_Utilitaires:="Utilitaires"
		
		<>va_M_LocRec:="Recherche"
		<>va_M_LocFic:="Fiche n°"
		
		<>va_M_HbJour:="Jour"
		<>va_M_HbNuit:="Nuit"
		
		<>va_M_TélJour:="Jour"
		<>va_M_TélNuit:="Nuit"
		
		<>va_M_TransJour:="Jour"
		<>va_M_TransTélNuit:="Nuit"
		
		<>va_M_Items:="Items"
		<>va_M_Fusion:="Fusion"
		
		<>va_M_Veil115:="Hébergement"  //"115"
		<>va_M_VeilMaraude:="Maraude"
		
		<>va_M_MarJour:="Jour"
		<>va_M_MarNuit:="Nuit"
		
		<>va_M_Etats:="Etats"
		<>va_M_Prestations:="Prestations"
		<>va_M_Accueil:="P. Accueil"
		
		<>va_M_Liste:="Liste"
		<>va_M_Report:="Report"
		<>va_M_Santé:="Veille"
		
		<>va_M_Planning:="Planning"
		
		<>va_M_TransJour:="Jour"
		<>va_M_TransNuit:="Nuit"
		
		
		<>va_M_SiaoDossier:="Dossier"
		<>va_M_SiaoVeil:="Veille"
		
		<>va_M_AnonymeStat:="Stats"
		<>va_M_AnonymeExport:="Exports"
		
		
		// Get indexed string
		<>va_M_Demande:=xliff_Txt_Get_Indexed_String_(30004; 10)
		<>va_M_Adresses:=xliff_Txt_Get_Indexed_String_(30004; 11)
		<>va_M_Situations:=xliff_Txt_Get_Indexed_String_(30004; 12)
		<>va_M_Associations:=xliff_Txt_Get_Indexed_String_(30004; 13)
		
		<>va_M_Centres:=xliff_Txt_Get_Indexed_String_(30004; 14)
		<>va_M_Disponibilités:=xliff_Txt_Get_Indexed_String_(30004; 15)
		<>va_M_Options:=xliff_Txt_Get_Indexed_String_(30004; 17)
		<>va_M_Transmission:=xliff_Txt_Get_Indexed_String_(30004; 16)
		
		<>va_M_Différée:=xliff_Txt_Get_Indexed_String_(30004; 18)
		<>va_M_Prolongation:=xliff_Txt_Get_Indexed_String_(30004; 19)
		<>va_M_Utilitaires:="Utilitaires"
		
		<>va_M_LocRec:=xliff_Txt_Get_Indexed_String_(30004; 21)
		<>va_M_LocFic:=xliff_Txt_Get_Indexed_String_(30004; 22)
		
		<>va_M_HbJour:=xliff_Txt_Get_Indexed_String_(30004; 23)
		<>va_M_HbNuit:=xliff_Txt_Get_Indexed_String_(30004; 24)
		
		<>va_M_TélJour:=xliff_Txt_Get_Indexed_String_(30004; 25)
		<>va_M_TélNuit:=xliff_Txt_Get_Indexed_String_(30004; 26)
		
		<>va_M_TransJour:=xliff_Txt_Get_Indexed_String_(30004; 39)
		<>va_M_TransTélNuit:=xliff_Txt_Get_Indexed_String_(30004; 40)
		
		<>va_M_Items:=xliff_Txt_Get_Indexed_String_(30004; 1274)
		<>va_M_Fusion:=xliff_Txt_Get_Indexed_String_(30004; 28)
		
		<>va_M_Veil115:=xliff_Txt_Get_Indexed_String_(30004; 29)
		<>va_M_VeilMaraude:=xliff_Txt_Get_Indexed_String_(30004; 30)
		
		
		<>va_M_MarJour:=xliff_Txt_Get_Indexed_String_(30004; 31)
		<>va_M_MarNuit:=xliff_Txt_Get_Indexed_String_(30004; 32)
		
		<>va_M_Etats:=xliff_Txt_Get_Indexed_String_(30004; 33)
		<>va_M_Prestations:=xliff_Txt_Get_Indexed_String_(30004; 34)
		<>va_M_Accueil:=xliff_Txt_Get_Indexed_String_(30004; 35)
		
		<>va_M_Liste:=xliff_Txt_Get_Indexed_String_(30004; 36)
		<>va_M_Report:=xliff_Txt_Get_Indexed_String_(30004; 37)
		<>va_M_Santé:=xliff_Txt_Get_Indexed_String_(30004; 38)
		
		<>va_M_TransJour:=xliff_Txt_Get_Indexed_String_(30004; 39)
		<>va_M_TransNuit:=xliff_Txt_Get_Indexed_String_(30004; 40)
		
		
		<>va_M_SiaoDossier:=xliff_Txt_Get_Indexed_String_(30004; 41)
		<>va_M_SiaoVeil:=xliff_Txt_Get_Indexed_String_(30004; 42)
		
		<>va_M_AnonymeStat:=xliff_Txt_Get_Indexed_String_(30004; 43)
		<>va_M_AnonymeExport:=xliff_Txt_Get_Indexed_String_(30004; 44)
	: ($1=2)
		<>ve_M_Demande:=Num:C11($2[[1]])
		<>ve_M_Adresses:=Num:C11($2[[2]])
		<>ve_M_Situations:=Num:C11($2[[3]])
		<>ve_M_Associations:=Num:C11($2[[4]])
		<>ve_M_Centres:=Num:C11($2[[5]])
		<>ve_M_Disponibilités:=Num:C11($2[[6]])
		<>ve_M_Options:=Num:C11($2[[7]])
		<>ve_M_Transmission:=Num:C11($2[[8]])
		<>ve_M_Différée:=Num:C11($2[[9]])
		<>ve_M_Prolongation:=Num:C11($2[[10]])
		<>ve_M_Utilitaires:=Num:C11($2[[11]])
		<>ve_M_LocRec:=Num:C11($2[[12]])
		<>ve_M_LocFic:=Num:C11($2[[13]])
		<>ve_M_HbJour:=Num:C11($2[[14]])
		<>ve_M_HbNuit:=Num:C11($2[[15]])
		<>ve_M_TélJour:=Num:C11($2[[16]])
		<>ve_M_TélNuit:=Num:C11($2[[17]])
		<>ve_M_Items:=Num:C11($2[[18]])
		<>ve_M_Fusion:=Num:C11($2[[19]])
		<>ve_M_Veil115:=Num:C11($2[[20]])
		<>ve_M_VeilMaraude:=Num:C11($2[[21]])
		<>ve_M_MarJour:=Num:C11($2[[22]])
		<>ve_M_MarNuit:=Num:C11($2[[23]])
		<>ve_M_Etats:=Num:C11($2[[24]])
		<>ve_M_Prestations:=Num:C11($2[[25]])
		<>ve_M_Accueil:=Num:C11($2[[26]])
		<>ve_M_Liste:=Num:C11($2[[27]])
		<>ve_M_Report:=Num:C11($2[[28]])
		<>ve_M_Santé:=Num:C11($2[[29]])
		
		
		
		<>ve_MT_Localisation:=Num:C11($2[[30]])
		<>ve_MT_Hébergement:=Num:C11($2[[31]])
		<>ve_MT_Télécopie:=Num:C11($2[[32]])
		<>ve_MT_Transfert:=Num:C11($2[[33]])
		<>ve_MT_Veille:=Num:C11($2[[34]])
		<>ve_MT_Maraude:=Num:C11($2[[35]])
		<>ve_MT_Social:=Num:C11($2[[36]])
		<>ve_MT_Stats:=Num:C11($2[[37]])
		<>ve_MT_Dossier:=Num:C11($2[[38]])
		
		If (Length:C16($2)>=40)
			<>ve_M_SiaoDossier:=Num:C11($2[[39]])
			<>ve_M_SiaoVeil:=Num:C11($2[[40]])
		Else 
			<>ve_M_SiaoDossier:=1
			<>ve_M_SiaoVeil:=1
		End if 
		<>ve_MT_Siao:=Num:C11((<>ve_M_SiaoDossier=1) | (<>ve_M_SiaoVeil=1))
		
		If (Length:C16($2)>=42)
			<>ve_M_AnonymeStat:=Num:C11($2[[41]])
			<>ve_M_AnonymeExport:=Num:C11($2[[42]])
		Else 
			<>ve_M_AnonymeStat:=1
			<>ve_M_AnonymeExport:=1
		End if 
		<>ve_MT_Anonyme:=Num:C11((<>ve_M_AnonymeStat=1) | (<>ve_M_AnonymeExport=1))
		
		
	: ($1=3)
		$2:=String:C10(<>ve_M_Demande)
		$2:=$2+String:C10(<>ve_M_Adresses)
		$2:=$2+String:C10(<>ve_M_Situations)
		$2:=$2+String:C10(<>ve_M_Associations)
		$2:=$2+String:C10(<>ve_M_Centres)
		$2:=$2+String:C10(<>ve_M_Disponibilités)
		$2:=$2+String:C10(<>ve_M_Options)
		$2:=$2+String:C10(<>ve_M_Transmission)
		$2:=$2+String:C10(<>ve_M_Différée)
		$2:=$2+String:C10(<>ve_M_Prolongation)
		$2:=$2+String:C10(<>ve_M_Utilitaires)
		$2:=$2+String:C10(<>ve_M_LocRec)
		$2:=$2+String:C10(<>ve_M_LocFic)
		$2:=$2+String:C10(<>ve_M_HbJour)
		$2:=$2+String:C10(<>ve_M_HbNuit)
		$2:=$2+String:C10(<>ve_M_TélJour)
		$2:=$2+String:C10(<>ve_M_TélNuit)
		$2:=$2+String:C10(<>ve_M_Items)
		$2:=$2+String:C10(<>ve_M_Fusion)
		$2:=$2+String:C10(<>ve_M_Veil115)
		$2:=$2+String:C10(<>ve_M_VeilMaraude)
		$2:=$2+String:C10(<>ve_M_MarJour)
		$2:=$2+String:C10(<>ve_M_MarNuit)
		$2:=$2+String:C10(<>ve_M_Etats)
		$2:=$2+String:C10(<>ve_M_Prestations)
		$2:=$2+String:C10(<>ve_M_Accueil)
		$2:=$2+String:C10(<>ve_M_Liste)
		$2:=$2+String:C10(<>ve_M_Report)
		$2:=$2+String:C10(<>ve_M_Santé)
		
		
		$2:=$2+String:C10(<>ve_MT_Localisation)
		$2:=$2+String:C10(<>ve_MT_Hébergement)
		$2:=$2+String:C10(<>ve_MT_Télécopie)
		$2:=$2+String:C10(<>ve_MT_Transfert)
		$2:=$2+String:C10(<>ve_MT_Veille)
		$2:=$2+String:C10(<>ve_MT_Maraude)
		$2:=$2+String:C10(<>ve_MT_Social)
		$2:=$2+String:C10(<>ve_MT_Stats)
		$2:=$2+String:C10(<>ve_MT_Dossier)
		
		$2:=$2+String:C10(<>ve_M_SiaoDossier)
		$2:=$2+String:C10(<>ve_M_SiaoVeil)
		
		$2:=$2+String:C10(<>ve_M_AnonymeStat)
		$2:=$2+String:C10(<>ve_M_AnonymeExport)
		
		
		
		[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+$2
		
		
	: ($1=4)
		If (Size of array:C274(te_LesIndices)>0)
			
			
			<>ve_M_Demande:=te_LesIndices{1}
			<>ve_M_Adresses:=te_LesIndices{2}
			<>ve_M_Situations:=te_LesIndices{3}
			
			<>ve_M_Associations:=te_LesIndices{4}
			<>ve_M_Centres:=te_LesIndices{5}
			
			<>ve_M_Disponibilités:=te_LesIndices{6}
			<>ve_M_Options:=te_LesIndices{7}
			<>ve_M_Transmission:=te_LesIndices{8}
			<>ve_M_Différée:=te_LesIndices{9}
			<>ve_M_Prolongation:=te_LesIndices{10}
			
			<>ve_M_Utilitaires:=te_LesIndices{11}
			
			<>ve_M_LocRec:=te_LesIndices{12}
			<>ve_M_LocFic:=te_LesIndices{13}
			
			<>ve_M_HbJour:=te_LesIndices{14}
			<>ve_M_HbNuit:=te_LesIndices{15}
			
			<>ve_M_TélJour:=te_LesIndices{16}
			<>ve_M_TélNuit:=te_LesIndices{17}
			
			<>ve_M_Items:=te_LesIndices{18}
			<>ve_M_Fusion:=te_LesIndices{19}
			<>ve_M_Veil115:=te_LesIndices{20}
			<>ve_M_VeilMaraude:=te_LesIndices{21}
			<>ve_M_MarJour:=te_LesIndices{22}
			<>ve_M_MarNuit:=te_LesIndices{23}
			<>ve_M_Etats:=te_LesIndices{24}
			<>ve_M_Prestations:=te_LesIndices{25}
			<>ve_M_Accueil:=te_LesIndices{26}
			<>ve_M_Liste:=te_LesIndices{27}
			<>ve_M_Report:=te_LesIndices{28}
			<>ve_M_Santé:=te_LesIndices{29}
			
			
			<>ve_MT_Localisation:=te_LesIndices{30}
			<>ve_MT_Hébergement:=te_LesIndices{31}
			<>ve_MT_Télécopie:=te_LesIndices{32}
			<>ve_MT_Transfert:=te_LesIndices{33}
			<>ve_MT_Veille:=te_LesIndices{34}
			<>ve_MT_Maraude:=te_LesIndices{35}
			<>ve_MT_Social:=te_LesIndices{36}
			<>ve_MT_Stats:=te_LesIndices{37}
			<>ve_MT_Dossier:=te_LesIndices{38}
			
			<>ve_M_SiaoDossier:=te_LesIndices{39}
			<>ve_M_SiaoVeil:=te_LesIndices{40}
			
			<>ve_M_AnonymeStat:=te_LesIndices{41}
			<>ve_M_AnonymeExport:=te_LesIndices{42}
			
			
		End if 
		
	: ($1=5)
		P_BoutonDépart(<>ve_M_Demande; -><>va_M_Demande; $v_Forground; $v_Background; $v_Style)
		OBJECT SET VISIBLE:C603(*; "GIP_Demande_@"; (<>ve_M_Demande=1))
		P_BoutonDépart(<>ve_M_Adresses; -><>va_M_Adresses; $v_Forground; $v_Background; $v_Style)
		OBJECT SET VISIBLE:C603(*; "GIP_AdUtil_@"; (<>ve_M_Adresses=1))
		P_BoutonDépart(<>ve_M_Situations; -><>va_M_Situations; $v_Forground; $v_Background; $v_Style)
		OBJECT SET VISIBLE:C603(*; "GIP_SitPar_@"; (<>ve_M_Situations=1))
		
		P_BoutonDépart(<>ve_M_Associations; -><>va_M_Associations; $v_Forground; $v_Background; $v_Style)
		
		P_BoutonDépart(<>ve_M_Centres; -><>va_M_Centres; $v_Forground; $v_Background; $v_Style)
		P_BoutonDépart(<>ve_M_Disponibilités; -><>va_M_Disponibilités; $v_Forground; $v_Background; $v_Style)
		P_BoutonDépart(<>ve_M_Options; -><>va_M_Options; $v_Forground; $v_Background; $v_Style)
		
		P_BoutonDépart(<>ve_M_Transmission; -><>va_M_Transmission; $v_Forground; $v_Background; $v_Style)
		// Si (Appartient au groupe(Utilisateur courant;◊Groupe_ADMIN))
		//    Sinon 
		//   INACTIVER BOUTON(b_Opt_1)
		//  Fin de si 
		
		P_BoutonDépart(<>ve_M_Différée; -><>va_M_Différée; $v_Forground; $v_Background; $v_Style)
		P_BoutonDépart(<>ve_M_Prolongation; -><>va_M_Prolongation; $v_Forground; $v_Background; $v_Style)
		
		OBJECT SET VISIBLE:C603(*; "Outil_@"; True:C214)
		If (User in group:C338(Current user:C182; <>Groupe_ADMIN))
		Else 
			P_BoutonDépart(<>ve_M_Utilitaires; -><>va_M_Utilitaires; $v_Forground; $v_Background; $v_Style)
			OBJECT SET VISIBLE:C603(*; "Outil_@"; (<>ve_M_Utilitaires=1))
		End if 
		
		P_BoutonDépart(<>ve_M_LocRec; -><>va_M_LocRec; $v_Forground; $v_Background; $v_Style)
		P_BoutonDépart(<>ve_M_LocFic; -><>va_M_LocFic; $v_Forground; $v_Background; $v_Style)
		OBJECT SET VISIBLE:C603(*; "Localisation_Texte1"; (<>ve_MT_Localisation=1))
		
		P_BoutonDépart(<>ve_M_HbJour; -><>va_M_HbJour; $v_Forground; $v_Background; $v_Style)
		P_BoutonDépart(<>ve_M_HbNuit; -><>va_M_HbNuit; $v_Forground; $v_Background; $v_Style)
		OBJECT SET VISIBLE:C603(*; "Hébergement_Texte1"; (<>ve_MT_Hébergement=1))
		
		P_BoutonDépart(<>ve_M_TélJour; -><>va_M_TélJour; $v_Forground; $v_Background; $v_Style)
		P_BoutonDépart(<>ve_M_TélNuit; -><>va_M_TélNuit; $v_Forground; $v_Background; $v_Style)
		OBJECT SET VISIBLE:C603(*; "Télécopie_Texte1"; (<>ve_MT_Télécopie=1))
		
		
		//Transfert
		P_BoutonDépart(<>ve_M_TélJour; -><>va_M_TransJour; $v_Forground; $v_Background; $v_Style)
		P_BoutonDépart(<>ve_M_TélNuit; -><>va_M_TransNuit; $v_Forground; $v_Background; $v_Style)
		OBJECT SET VISIBLE:C603(*; "Correction_Texte1"; (<>ve_MT_Transfert=1))
		
		P_BoutonDépart(<>ve_M_Veil115; -><>va_M_Veil115; $v_Forground; $v_Background; $v_Style)
		P_BoutonDépart(<>ve_M_VeilMaraude; -><>va_M_VeilMaraude; $v_Forground; $v_Background; $v_Style)
		OBJECT SET VISIBLE:C603(*; "Veille_Texte1"; (<>ve_MT_Veille=1))
		
		P_BoutonDépart(<>ve_M_MarJour; -><>va_M_MarJour; $v_Forground; $v_Background; $v_Style)
		P_BoutonDépart(<>ve_M_MarNuit; -><>va_M_MarNuit; $v_Forground; $v_Background; $v_Style)
		OBJECT SET VISIBLE:C603(*; "Maraude_Texte1"; (<>ve_MT_Maraude=1))
		
		P_BoutonDépart(<>ve_M_SiaoDossier; -><>va_M_SiaoDossier; $v_Forground; $v_Background; $v_Style)
		P_BoutonDépart(<>ve_M_SiaoVeil; -><>va_M_SiaoVeil; $v_Forground; $v_Background; $v_Style)
		OBJECT SET VISIBLE:C603(*; "SIAO_Texte1"; (<>ve_MT_Siao=1))
		
		P_BoutonDépart(<>ve_M_AnonymeStat; -><>va_M_AnonymeStat; $v_Forground; $v_Background; $v_Style)
		OBJECT SET VISIBLE:C603(*; "  EtatStatAnonym_@"; (<>ve_M_AnonymeStat=1))
		
		P_BoutonDépart(<>ve_M_AnonymeExport; -><>va_M_AnonymeExport; $v_Forground; $v_Background; $v_Style)
		OBJECT SET VISIBLE:C603(*; "Anonyme_Texte"; (<>ve_MT_Anonyme=1))
		
		P_BoutonDépart(<>ve_M_Accueil; -><>va_M_Accueil; $v_Forground; $v_Background; $v_Style)
		P_BoutonDépart(<>ve_M_Santé; -><>va_M_Santé; $v_Forground; $v_Background; $v_Style)
		OBJECT SET VISIBLE:C603(*; "Social_Texte1"; (<>ve_MT_Social=1))
		
		P_BoutonDépart(<>ve_M_Items; -><>va_M_Items; $v_Forground; $v_Background; $v_Style)
		P_BoutonDépart(<>ve_M_Fusion; -><>va_M_Fusion; $v_Forground; $v_Background; $v_Style)
		
		P_BoutonDépart(<>ve_M_Etats; -><>va_M_Etats; $v_Forground; $v_Background; $v_Style)
		OBJECT SET VISIBLE:C603(*; "EtatStat_@"; (<>ve_M_Etats=1))
		OBJECT SET VISIBLE:C603(*; "EtatStat_@"; (<>ve_MT_Stats=1))
		P_BoutonDépart(<>ve_M_Report; -><>va_M_Report; $v_Forground; $v_Background; $v_Style)
		OBJECT SET VISIBLE:C603(*; "Statistiques_Texte1"; (<>ve_MT_Stats=1))
		
		
		P_BoutonDépart(<>ve_M_Liste; -><>va_M_Liste; $v_Forground; $v_Background; $v_Style)
		OBJECT SET VISIBLE:C603(*; "ListeDos_@"; (<>ve_M_Liste=1))
		OBJECT SET VISIBLE:C603(*; "Dossier_Texte1"; (<>ve_MT_Dossier=1))
		
		P_BoutonDépart(<>ve_M_Prestations; -><>va_M_Prestations; $v_Forground; $v_Background; $v_Style)
		
		
	: ($1=13)
		<>va_M_Demande:=("Demande de prestations"*<>ve_M_Demande)+("…"*Num:C11(<>ve_M_Demande=0))
		
		<>va_M_Adresses:=("Adresses utiles"*<>ve_M_Adresses)+("…"*Num:C11(<>ve_M_Adresses=0))
		<>va_M_Situations:=("Situations particulières"*<>ve_M_Situations)+("…"*Num:C11(<>ve_M_Situations=0))
		<>va_M_Associations:=("Associations"*<>ve_M_Associations)+("…"*Num:C11(<>ve_M_Associations=0))
		
		<>va_M_Centres:=("Centres d'hébergement"*<>ve_M_Centres)+("…"*Num:C11(<>ve_M_Centres=0))
		<>va_M_Disponibilités:=("Disponibilités"*<>ve_M_Disponibilités)+("…"*Num:C11(<>ve_M_Disponibilités=0))
		<>va_M_Options:=("Option Veille"*<>ve_M_Options)+("…"*Num:C11(<>ve_M_Options=0))
		<>va_M_Transmission:=("Transmission"*<>ve_M_Transmission)+("…"*Num:C11(<>ve_M_Transmission=0))
		
		<>va_M_Différée:=("Saisie différée"*<>ve_M_Différée)+("…"*Num:C11(<>ve_M_Différée=0))
		<>va_M_Prolongation:=("Prolongation"*<>ve_M_Prolongation)+("…"*Num:C11(<>ve_M_Prolongation=0))
		<>va_M_Utilitaires:=("Utilitaires"*<>ve_M_Utilitaires)+("…"*Num:C11(<>ve_M_Utilitaires=0))
		
		<>va_M_LocRec:=("Recherche"*<>ve_M_LocRec)+("…"*Num:C11(<>ve_M_LocRec=0))
		<>va_M_LocFic:=("Fiche n°"*<>ve_M_LocFic)+("…"*Num:C11(<>ve_M_LocFic=0))
		
		<>va_M_HbJour:=("Jour"*<>ve_M_HbJour)+("…"*Num:C11(<>ve_M_HbJour=0))
		<>va_M_HbNuit:=("Nuit"*<>ve_M_HbNuit)+("…"*Num:C11(<>ve_M_HbNuit=0))
		
		<>va_M_TélJour:=("Jour"*<>ve_M_TélJour)+("…"*Num:C11(<>ve_M_TélJour=0))
		<>va_M_TélNuit:=("Nuit"*<>ve_M_TélNuit)+("…"*Num:C11(<>ve_M_TélNuit=0))
		
		//Transfert
		<>va_M_TransJour:=("Jour"*<>ve_M_TélJour)+("…"*Num:C11(<>ve_M_TélJour=0))
		<>va_M_TransNuit:=("Nuit"*<>ve_M_TélNuit)+("…"*Num:C11(<>ve_M_TélNuit=0))
		
		
		
		<>va_M_Items:=("Items"*<>ve_M_Items)+("…"*Num:C11(<>ve_M_Items=0))
		<>va_M_Fusion:=("Fusion"*<>ve_M_Fusion)+("…"*Num:C11(<>ve_M_Fusion=0))
		
		<>va_M_Veil115:=("115"*<>ve_M_Veil115)+("…"*Num:C11(<>ve_M_Veil115=0))
		<>va_M_VeilMaraude:=("Maraude"*<>ve_M_VeilMaraude)+("…"*Num:C11(<>ve_M_VeilMaraude=0))
		
		<>va_M_MarJour:=("Jour"*<>ve_M_MarJour)+("…"*Num:C11(<>ve_M_MarJour=0))
		<>va_M_MarNuit:=("Nuit"*<>ve_M_MarNuit)+("…"*Num:C11(<>ve_M_MarNuit=0))
		
		<>va_M_Etats:=("Etats"*<>ve_M_Etats)+("…"*Num:C11(<>ve_M_Etats=0))
		<>va_M_Prestations:=("Prestations"*<>ve_M_Prestations)+("…"*Num:C11(<>ve_M_Prestations=0))
		<>va_M_Accueil:=("P. Acceuil"*<>ve_M_Accueil)+("…"*Num:C11(<>ve_M_Accueil=0))
		
		<>va_M_Liste:=("Liste"*<>ve_M_Liste)+("…"*Num:C11(<>ve_M_Liste=0))
		<>va_M_Report:=("Report"*<>ve_M_Report)+("…"*Num:C11(<>ve_M_Report=0))
		<>va_M_Santé:=("Veille"*<>ve_M_Santé)+("…"*Num:C11(<>ve_M_Santé=0))
		
		
		
		
		
	: ($1=14)
		If (7=8)
			If (<>ve_M_Demande=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Demande; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Demande; $v_Style)
			End if 
			If (<>ve_M_Adresses=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Adresses; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Adresses; $v_Style)
			End if 
			If (<>ve_M_Situations=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Situations; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Situations; $v_Style)
			End if 
			If (<>ve_M_Associations=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Associations; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Associations; $v_Style)
			End if 
			If (<>ve_M_Centres=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Centres; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Centres; $v_Style)
			End if 
			
			If (<>ve_M_Disponibilités=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Disponibilités; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Disponibilités; $v_Style)
			End if 
			If (<>ve_M_Options=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Options; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Options; $v_Style)
			End if 
			If (<>ve_M_Transmission=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Transmission; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Transmission; $v_Style)
			End if 
			If (<>ve_M_Différée=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Différée; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Différée; $v_Style)
			End if 
			If (<>ve_M_Prolongation=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Prolongation; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Prolongation; $v_Style)
			End if 
			
			If (<>ve_M_Utilitaires=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Utilitaires; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Utilitaires; $v_Style)
			End if 
			
			If (<>ve_M_LocRec=0)
				_O_OBJECT SET COLOR:C271(<>va_M_LocRec; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_LocRec; $v_Style)
			End if 
			If (<>ve_M_LocFic=0)
				_O_OBJECT SET COLOR:C271(<>va_M_LocFic; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_LocFic; $v_Style)
			End if 
			
			If (<>ve_M_HbJour=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Transmission; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Transmission; $v_Style)
			End if 
			If (<>ve_M_HbNuit=0)
				_O_OBJECT SET COLOR:C271(<>va_M_HbNuit; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_HbNuit; $v_Style)
			End if 
			
			If (<>ve_M_TélJour=0)
				_O_OBJECT SET COLOR:C271(<>va_M_TélJour; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_TélJour; $v_Style)
				//Transfert
				_O_OBJECT SET COLOR:C271(<>va_M_TransJour; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_TransJour; $v_Style)
				
			End if 
			If (<>ve_M_TélNuit=0)
				_O_OBJECT SET COLOR:C271(<>va_M_TélNuit; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_TélNuit; $v_Style)
				//Transfert
				_O_OBJECT SET COLOR:C271(<>va_M_TransNuit; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_TransNuit; $v_Style)
			End if 
			
			
			
			If (<>ve_M_Items=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Items; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Items; $v_Style)
			End if 
			If (<>ve_M_Fusion=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Fusion; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Fusion; $v_Style)
			End if 
			If (<>ve_M_Veil115=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Veil115; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Veil115; $v_Style)
			End if 
			If (<>ve_M_VeilMaraude=0)
				_O_OBJECT SET COLOR:C271(<>va_M_VeilMaraude; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_VeilMaraude; $v_Style)
			End if 
			If (<>ve_M_MarJour=0)
				_O_OBJECT SET COLOR:C271(<>va_M_MarJour; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_MarJour; $v_Style)
			End if 
			If (<>ve_M_MarNuit=0)
				_O_OBJECT SET COLOR:C271(<>va_M_MarNuit; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_MarNuit; $v_Style)
			End if 
			If (<>ve_M_Etats=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Etats; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Etats; $v_Style)
			End if 
			If (<>ve_M_Prestations=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Prestations; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Prestations; $v_Style)
			End if 
			If (<>ve_M_Accueil=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Accueil; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Accueil; $v_Style)
			End if 
			If (<>ve_M_Liste=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Liste; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Liste; $v_Style)
			End if 
			If (<>ve_M_Report=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Report; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Report; $v_Style)
			End if 
			If (<>ve_M_Santé=0)
				_O_OBJECT SET COLOR:C271(<>va_M_Santé; ($v_Forground+(256*$v_Background)))
				OBJECT SET FONT STYLE:C166(<>va_M_Santé; $v_Style)
			End if 
			
		End if 
		
		
End case 