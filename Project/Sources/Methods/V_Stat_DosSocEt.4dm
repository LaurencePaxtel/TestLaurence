//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : V_Stat_DosSocEt
//{
//{          Mardi 24 mai 2005 à 11:48:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($ii)

Case of 
	: ($1=-10)
		If ($2=1)
			ve_AgeInf:=0
			ve_AgeSup:=0
		End if 
		$ii:=$2
		sSexe:=$ii
		sEtCv:=$ii
		sAge:=$ii
		sNatio:=$ii
		sNeOu:=$ii
		sLangue:=$ii
		sDerHb:=$ii
		sCoSSp:=$ii
		sMatri:=$ii
		sEnfant:=$ii
		
		
		sPersMaj:=$ii
		sTpsErr:=$ii
		sDerSSP:=$ii
		sAss:=$ii
		sEnCh:=$ii
		sRefus:=$ii
		sConn:=$ii
		sComp:=$ii
		
		sPap:=$ii
		sPap_1:=$ii
		sRegime:=$ii
		sRegime_1:=$ii
		sSuivi:=$ii
		sSuivi_1:=$ii
		sCouv:=$ii
		sCouv_1:=$ii
		sRess:=$ii
		sRess_1:=$ii
		sSor:=$ii
		sSor_1:=$ii
		
	: ($1=0)  //•••••••••••••••••••Déclaration
		C_DATE:C307(vd_Date1; vd_Date2)
		C_LONGINT:C283(vl_NbJ)
		C_TEXT:C284(vt_StTexte)
		C_LONGINT:C283(vl_NbHBd)
		vl_NbHBd:=0
		C_LONGINT:C283(vl_NbHom)
		C_LONGINT:C283(vl_NbFem)
		vl_NbHom:=0
		vl_NbFem:=0
		
		
		C_LONGINT:C283(ve_AgeInf)
		C_LONGINT:C283(ve_AgeSup)
		
		ve_AgeInf:=0
		ve_AgeSup:=0
		
		C_LONGINT:C283(vl_Tab0)
		
		C_LONGINT:C283(vl_Tab1)
		C_LONGINT:C283(vl_Tab2)
		C_LONGINT:C283(vl_Tab3)
		C_LONGINT:C283(vl_Tab4)
		C_LONGINT:C283(vl_Tab5)
		C_LONGINT:C283(vl_Tab6)
		C_LONGINT:C283(vl_Tab7)
		C_LONGINT:C283(vl_Tab8)
		C_LONGINT:C283(vl_Tab9)
		
		C_LONGINT:C283(vl_Tab10)
		C_LONGINT:C283(vl_Tab11)
		C_LONGINT:C283(vl_Tab12)
		C_LONGINT:C283(vl_Tab13)
		C_LONGINT:C283(vl_Tab14)
		C_LONGINT:C283(vl_Tab15)
		C_LONGINT:C283(vl_Tab16)
		C_LONGINT:C283(vl_Tab17)
		C_LONGINT:C283(vl_Tab18)
		C_LONGINT:C283(vl_Tab19)
		
		C_LONGINT:C283(vl_Tab20)
		C_LONGINT:C283(vl_Tab21)
		C_LONGINT:C283(vl_Tab22)
		C_LONGINT:C283(vl_Tab23)
		C_LONGINT:C283(vl_Tab24)
		C_LONGINT:C283(vl_Tab25)
		C_LONGINT:C283(vl_Tab26)
		C_LONGINT:C283(vl_Tab27)
		C_LONGINT:C283(vl_Tab28)
		C_LONGINT:C283(vl_Tab29)
		
		C_LONGINT:C283(vl_Tab30)
		
		
		//Genre
		vl_Tab0:=2
		ARRAY TEXT:C222(<>ta_TBGenre; vl_Tab0)
		ARRAY LONGINT:C221(<>te_NbGenre; vl_Tab0)
		ARRAY LONGINT:C221(<>tl_TBGenre; vl_Tab0)
		<>ta_TBGenre{1}:="Masculin"
		<>ta_TBGenre{2}:="Féminin"
		<>te_NbGenre{1}:=0
		<>te_NbGenre{2}:=0
		<>tl_TBGenre{1}:=0
		<>tl_TBGenre{2}:=0
		
		//Etat civil◊ts_EtC
		vl_Tab1:=Size of array:C274(<>ta_TBEtCiv)
		ARRAY LONGINT:C221(<>te_NbEtCiv; vl_Tab1)
		ARRAY LONGINT:C221(<>tl_NbEtCiv; vl_Tab1)
		
		//Age
		ARRAY TEXT:C222(<>ta_TBAge; 9)
		<>ta_TBAge{1}:="de 0 jusqu' à  3"
		<>ta_TBAge{2}:="plus de 3 et moins de 18"
		<>ta_TBAge{3}:="plus de 18 jusqu' à 24"
		<>ta_TBAge{4}:="plus de 24 jusqu' à 29"
		<>ta_TBAge{5}:="plus de 29 jusqu' à 39"
		<>ta_TBAge{6}:="plus de 39 jusqu' à 49"
		<>ta_TBAge{7}:="plus de 49 jusqu' à 59"
		<>ta_TBAge{8}:="plus de 59 jusqu' à 69"
		<>ta_TBAge{9}:="plus de 69"
		ARRAY INTEGER:C220(<>te_TBAge; 9)
		<>te_TBAge{1}:=3
		<>te_TBAge{2}:=18
		<>te_TBAge{3}:=24
		<>te_TBAge{4}:=29
		<>te_TBAge{5}:=39
		<>te_TBAge{6}:=49
		<>te_TBAge{7}:=59
		<>te_TBAge{8}:=69
		<>te_TBAge{9}:=70
		
		vl_Tab2:=Size of array:C274(<>te_TBAge)
		ARRAY LONGINT:C221(<>te_NbAge; vl_Tab2)
		ARRAY LONGINT:C221(<>tl_NbAge; vl_Tab2)
		
		//Nationalité
		vl_Tab3:=Size of array:C274(<>ta_TBNatio)
		ARRAY LONGINT:C221(te_NbNatio; vl_Tab3)
		ARRAY LONGINT:C221(tl_NbNatio; vl_Tab3)
		
		//Lieu de naissance
		vl_Tab4:=Size of array:C274(<>ta_TBLieuNé)
		ARRAY LONGINT:C221(te_TBLieuNé; vl_Tab4)
		ARRAY LONGINT:C221(tl_TBLieuNé; vl_Tab4)
		
		//Langue
		vl_Tab5:=Size of array:C274(<>ta_Lgs)
		ARRAY LONGINT:C221(te_Lgs; vl_Tab5)
		ARRAY LONGINT:C221(tl_Lgs; vl_Tab5)
		
		//Provenance / Dernier hébergement
		vl_Tab6:=Size of array:C274(<>ta_DerLH)
		ARRAY LONGINT:C221(te_DerLH; vl_Tab6)
		ARRAY LONGINT:C221(tl_DerLH; vl_Tab6)
		
		//Motif / Connu SSP
		vl_Tab7:=Size of array:C274(<>ta_MRCssp)
		ARRAY LONGINT:C221(te_MRCssp; vl_Tab7)
		ARRAY LONGINT:C221(tl_MRCssp; vl_Tab7)
		
		//Situationd de famille / Etat matri
		vl_Tab8:=Size of array:C274(<>ta_TBSitFam)
		ARRAY LONGINT:C221(te_TBSitFam; vl_Tab8)
		ARRAY LONGINT:C221(tl_TBSitFam; vl_Tab8)
		
		//Enfants
		vl_Tab9:=2
		ARRAY TEXT:C222(<>ta_TBEnfant; vl_Tab9)
		ARRAY LONGINT:C221(<>te_TBEnfant; vl_Tab9)
		ARRAY LONGINT:C221(<>tl_TBEnfant; vl_Tab9)
		<>ta_TBEnfant{1}:="Non"
		<>ta_TBEnfant{2}:="Oui"
		<>te_TBEnfant{1}:=0
		<>te_TBEnfant{2}:=0
		<>tl_TBEnfant{1}:=0
		<>tl_TBEnfant{2}:=0
		
		//Pers Maj
		vl_Tab10:=Size of array:C274(<>ta_MRMpro)
		ARRAY LONGINT:C221(te_MRMpro; vl_Tab10)
		ARRAY LONGINT:C221(tl_MRMpro; vl_Tab10)
		
		//Temps d'errance
		vl_Tab11:=Size of array:C274(<>ta_TBTpsErr)
		ARRAY LONGINT:C221(te_TBTpsErr; vl_Tab11)
		ARRAY LONGINT:C221(tl_TBTpsErr; vl_Tab11)
		
		//Prem!ère SSP / Cat Socio Prof
		vl_Tab12:=Size of array:C274(<>ta_MRPssp)
		ARRAY LONGINT:C221(te_MRPssp; vl_Tab12)
		ARRAY LONGINT:C221(tl_MRPssp; vl_Tab12)
		
		//Assistante/Référent social
		vl_Tab13:=Size of array:C274(<>ta_InAsSoc)
		ARRAY LONGINT:C221(te_InAsSoc; vl_Tab13)
		ARRAY LONGINT:C221(tl_InAsSoc; vl_Tab13)
		
		//En charge EMA / Emploi
		vl_Tab14:=Size of array:C274(<>ta_MRPch)
		ARRAY LONGINT:C221(te_MRPch; vl_Tab14)
		ARRAY LONGINT:C221(tl_MRPch; vl_Tab14)
		
		//Motif du refus de prise en charge / Niveau scolaire
		vl_Tab15:=Size of array:C274(<>ta_MRrefu)
		ARRAY LONGINT:C221(te_MRrefu; vl_Tab15)
		ARRAY LONGINT:C221(tl_MRrefu; vl_Tab15)
		
		//Personne chez qui aller / Problème de santé
		vl_Tab16:=Size of array:C274(<>ta_MRQui)
		ARRAY LONGINT:C221(te_MRQui; vl_Tab16)
		ARRAY LONGINT:C221(tl_MRQui; vl_Tab16)
		
		//Compagnie actuelle/Problématique
		vl_Tab17:=Size of array:C274(<>ta_DScomp)
		ARRAY LONGINT:C221(te_DScomp; vl_Tab17)
		ARRAY LONGINT:C221(tl_DScomp; vl_Tab17)
		
		
		//Papier
		vl_Tab18:=2
		ARRAY TEXT:C222(<>ta_Papier; vl_Tab18)
		ARRAY LONGINT:C221(<>te_Papier; vl_Tab18)
		ARRAY LONGINT:C221(<>tl_Papier; vl_Tab18)
		<>ta_Papier{1}:="Non"
		<>ta_Papier{2}:="Oui"
		<>te_Papier{1}:=0
		<>te_Papier{2}:=0
		<>tl_Papier{1}:=0
		<>tl_Papier{2}:=0
		
		//Papier 1
		vl_Tab19:=Size of array:C274(<>ta_DSidté)
		ARRAY LONGINT:C221(te_DSidté; vl_Tab19)
		ARRAY LONGINT:C221(tl_DSidté; vl_Tab19)
		
		//Régime
		vl_Tab20:=2
		ARRAY TEXT:C222(<>ta_Régime; vl_Tab20)
		ARRAY LONGINT:C221(<>te_Régime; vl_Tab20)
		ARRAY LONGINT:C221(<>tl_Régime; vl_Tab20)
		<>ta_Régime{1}:="Non"
		<>ta_Régime{2}:="Oui"
		<>te_Régime{1}:=0
		<>te_Régime{2}:=0
		<>tl_Régime{1}:=0
		<>tl_Régime{2}:=0
		
		//Régime 1
		vl_Tab21:=Size of array:C274(<>ta_DSrég)
		ARRAY LONGINT:C221(te_DSrég; vl_Tab21)
		ARRAY LONGINT:C221(tl_DSrég; vl_Tab21)
		
		//Suivi
		vl_Tab22:=2
		ARRAY TEXT:C222(<>ta_Suivi; vl_Tab22)
		ARRAY LONGINT:C221(<>te_Suivi; vl_Tab22)
		ARRAY LONGINT:C221(<>tl_Suivi; vl_Tab22)
		<>ta_Suivi{1}:="Non"
		<>ta_Suivi{2}:="Oui"
		<>te_Suivi{1}:=0
		<>te_Suivi{2}:=0
		<>tl_Suivi{1}:=0
		<>tl_Suivi{2}:=0
		
		//Suivi 1
		vl_Tab23:=Size of array:C274(<>ta_DSsuivi)
		ARRAY LONGINT:C221(te_DSsuivi; vl_Tab23)
		ARRAY LONGINT:C221(tl_DSsuivi; vl_Tab23)
		
		
		//Couverture sociale
		vl_Tab24:=2
		ARRAY TEXT:C222(<>ta_Couverture; vl_Tab24)
		ARRAY LONGINT:C221(<>te_Couverture; vl_Tab24)
		ARRAY LONGINT:C221(<>tl_Couverture; vl_Tab24)
		<>ta_Couverture{1}:="Non"
		<>ta_Couverture{2}:="Oui"
		<>te_Couverture{1}:=0
		<>te_Couverture{2}:=0
		<>tl_Couverture{1}:=0
		<>tl_Couverture{2}:=0
		
		//Coouverture sociale 1
		vl_Tab25:=Size of array:C274(<>ta_DScs)
		ARRAY LONGINT:C221(te_DScs; vl_Tab25)
		ARRAY LONGINT:C221(tl_DScs; vl_Tab25)
		
		
		//Ressources
		vl_Tab26:=2
		ARRAY TEXT:C222(<>ta_Ressource; vl_Tab26)
		ARRAY LONGINT:C221(<>te_Ressource; vl_Tab26)
		ARRAY LONGINT:C221(<>tl_Ressource; vl_Tab26)
		<>ta_Ressource{1}:="Non"
		<>ta_Ressource{2}:="Oui"
		<>te_Ressource{1}:=0
		<>te_Ressource{2}:=0
		<>tl_Ressource{1}:=0
		<>tl_Ressource{2}:=0
		
		//Ressources 1
		vl_Tab27:=Size of array:C274(<>ta_MRrs)
		ARRAY LONGINT:C221(te_MRrs; vl_Tab27)
		ARRAY LONGINT:C221(tl_MRrs; vl_Tab27)
		
		//Sortie
		vl_Tab28:=2
		ARRAY TEXT:C222(<>ta_Sortie; vl_Tab28)
		ARRAY LONGINT:C221(<>te_Sortie; vl_Tab28)
		ARRAY LONGINT:C221(<>tl_Sortie; vl_Tab28)
		<>ta_Sortie{1}:="Non"
		<>ta_Sortie{2}:="Oui"
		<>te_Sortie{1}:=0
		<>te_Sortie{2}:=0
		<>tl_Sortie{1}:=0
		<>tl_Sortie{2}:=0
		
		// Sortie 1
		vl_Tab29:=Size of array:C274(<>ta_MRSctr)
		ARRAY LONGINT:C221(te_MRSctr; vl_Tab29)
		ARRAY LONGINT:C221(tl_MRSctr; vl_Tab29)
		
		
	: ($1=1)  //•••••••••••••••••••Mise à zéro
		
		//Genre    
		<>te_NbGenre{1}:=0
		<>te_NbGenre{2}:=0
		<>tl_TBGenre{1}:=0
		<>tl_TBGenre{2}:=0
		
		vl_Tab1:=Size of array:C274(<>te_NbEtCiv)
		For ($ii; 1; vl_Tab1)
			<>te_NbEtCiv{$ii}:=0
			<>tl_NbEtCiv{$ii}:=0
		End for 
		vl_Tab2:=Size of array:C274(<>te_TBAge)
		For ($ii; 1; vl_Tab2)
			<>te_NbAge{$ii}:=0
			<>tl_NbAge{$ii}:=0
		End for 
		
		
		vl_Tab3:=Size of array:C274(<>ta_TBNatio)
		For ($ii; 1; vl_Tab3)
			te_NbNatio{$ii}:=0
			tl_NbNatio{$ii}:=0
		End for 
		
		vl_Tab4:=Size of array:C274(<>ta_TBLieuNé)
		For ($ii; 1; vl_Tab4)
			te_TBLieuNé{$ii}:=0
			tl_TBLieuNé{$ii}:=0
		End for 
		
		vl_Tab5:=Size of array:C274(<>ta_Lgs)
		For ($ii; 1; vl_Tab5)
			te_Lgs{$ii}:=0
			tl_Lgs{$ii}:=0
		End for 
		
		vl_Tab6:=Size of array:C274(<>ta_DerLH)
		For ($ii; 1; vl_Tab6)
			te_DerLH{$ii}:=0
			tl_DerLH{$ii}:=0
		End for 
		vl_Tab7:=Size of array:C274(<>ta_MRCssp)
		For ($ii; 1; vl_Tab7)
			te_MRCssp{$ii}:=0
			tl_MRCssp{$ii}:=0
		End for 
		vl_Tab8:=Size of array:C274(<>ta_TBSitFam)
		For ($ii; 1; vl_Tab8)
			te_TBSitFam{$ii}:=0
			tl_TBSitFam{$ii}:=0
		End for 
		vl_Tab9:=Size of array:C274(<>ta_TBEnfant)
		For ($ii; 1; vl_Tab9)
			<>te_TBEnfant{$ii}:=0
			<>tl_TBEnfant{$ii}:=0
		End for 
		vl_Tab10:=Size of array:C274(<>ta_MRMpro)
		For ($ii; 1; vl_Tab10)
			te_MRMpro{$ii}:=0
			tl_MRMpro{$ii}:=0
		End for 
		vl_Tab11:=Size of array:C274(<>ta_TBTpsErr)
		For ($ii; 1; vl_Tab11)
			te_TBTpsErr{$ii}:=0
			tl_TBTpsErr{$ii}:=0
		End for 
		vl_Tab12:=Size of array:C274(<>ta_MRPssp)
		For ($ii; 1; vl_Tab12)
			te_MRPssp{$ii}:=0
			tl_MRPssp{$ii}:=0
		End for 
		vl_Tab13:=Size of array:C274(<>ta_InAsSoc)
		For ($ii; 1; vl_Tab13)
			te_InAsSoc{$ii}:=0
			tl_InAsSoc{$ii}:=0
		End for 
		vl_Tab14:=Size of array:C274(<>ta_MRPch)
		For ($ii; 1; vl_Tab14)
			te_MRPch{$ii}:=0
			tl_MRPch{$ii}:=0
		End for 
		vl_Tab15:=Size of array:C274(<>ta_MRrefu)
		For ($ii; 1; vl_Tab15)
			te_MRrefu{$ii}:=0
			tl_MRrefu{$ii}:=0
		End for 
		vl_Tab16:=Size of array:C274(<>ta_MRQui)
		For ($ii; 1; vl_Tab16)
			te_MRQui{$ii}:=0
			tl_MRQui{$ii}:=0
		End for 
		vl_Tab17:=Size of array:C274(<>ta_DScomp)
		For ($ii; 1; vl_Tab17)
			te_DScomp{$ii}:=0
			tl_DScomp{$ii}:=0
		End for 
		//vl_Tab18:=2
		<>te_Papier{1}:=0
		<>te_Papier{2}:=0
		<>tl_Papier{1}:=0
		<>tl_Papier{2}:=0
		vl_Tab19:=Size of array:C274(<>ta_DSidté)
		For ($ii; 1; vl_Tab19)
			te_DSidté{$ii}:=0
			tl_DSidté{$ii}:=0
		End for 
		
		//vl_Tab20:=2
		<>te_Régime{1}:=0
		<>te_Régime{2}:=0
		<>tl_Régime{1}:=0
		<>tl_Régime{2}:=0
		vl_Tab21:=Size of array:C274(<>ta_DSrég)
		For ($ii; 1; vl_Tab21)
			te_DSrég{$ii}:=0
			tl_DSrég{$ii}:=0
		End for 
		
		//vl_Tab22:=2
		<>te_Suivi{1}:=0
		<>te_Suivi{2}:=0
		<>tl_Suivi{1}:=0
		<>tl_Suivi{2}:=0
		vl_Tab23:=Size of array:C274(<>ta_DSsuivi)
		For ($ii; 1; vl_Tab23)
			te_DSsuivi{$ii}:=0
			tl_DSsuivi{$ii}:=0
		End for 
		
		//vl_Tab24:=2
		<>te_Couverture{1}:=0
		<>te_Couverture{2}:=0
		<>tl_Couverture{1}:=0
		<>tl_Couverture{2}:=0
		vl_Tab25:=Size of array:C274(<>ta_DScs)
		For ($ii; 1; vl_Tab25)
			te_DScs{$ii}:=0
			tl_DScs{$ii}:=0
		End for 
		
		//vl_Tab26:=2
		<>te_Ressource{1}:=0
		<>te_Ressource{2}:=0
		<>tl_Ressource{1}:=0
		<>tl_Ressource{2}:=0
		vl_Tab27:=Size of array:C274(<>ta_MRrs)
		For ($ii; 1; vl_Tab27)
			te_MRrs{$ii}:=0
			tl_MRrs{$ii}:=0
		End for 
		
		//vl_Tab28:=2
		<>te_Sortie{1}:=0
		<>te_Sortie{2}:=0
		<>tl_Sortie{1}:=0
		<>tl_Sortie{2}:=0
		vl_Tab29:=Size of array:C274(<>ta_MRSctr)
		For ($ii; 1; vl_Tab29)
			te_MRSctr{$ii}:=0
			tl_MRSctr{$ii}:=0
		End for 
		
		
End case 