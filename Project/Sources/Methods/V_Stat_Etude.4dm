//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : V_Stat_Etude
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

C_LONGINT:C283($ii; $NoTable)

Case of 
	: ($1=0)  //•••••••••••••••••••Déclaration
		C_TEXT:C284(vt_StTexte; va_Alfa1)
		C_DATE:C307(vd_Date1; vd_Date2)
		C_LONGINT:C283(vl_NbJ; vl_NbHBd; vl_NbHom; vl_NbFem; ve_AgeInf; ve_AgeSup; ve_Alfa1; vl_Tab0; vl_Tab1; vl_Tab2; vl_Tab3; vl_Tab4; vl_Tab5; vl_Tab6; vl_Tab7; vl_Tab8; vl_Tab9; vl_Tab10; vl_Tab11; \
			vl_Tab12; vl_Tab13; vl_Tab14; vl_Tab15; vl_Tab16; vl_Tab17; vl_Tab18; vl_Tab19; vl_Tab20; vl_Tab21; vl_Tab22; vl_Tab23; vl_Tab24; vl_Tab25; vl_Tab26; vl_NbMetro)
		
		vl_NbHBd:=0
		
		vl_NbHom:=0
		vl_NbFem:=0
		
		ve_AgeInf:=0
		ve_AgeSup:=0
		
		ARRAY TEXT:C222(<>ts_EtC; 0)
		ARRAY TEXT:C222(<>ts_Sgn; 0)
		ARRAY TEXT:C222(<>ts_Nat; 0)
		ARRAY TEXT:C222(<>ts_TBArr; 0)
		ARRAY TEXT:C222(<>ts_Néa; 0)
		ARRAY TEXT:C222(<>ts_Err; 0)
		ARRAY TEXT:C222(<>ts_Res; 0)
		ARRAY TEXT:C222(<>ts_Sui; 0)
		ARRAY TEXT:C222(<>ts_Cou; 0)
		ARRAY TEXT:C222(<>ts_Or1; 0)
		ARRAY TEXT:C222(<>ts_Or2; 0)
		ARRAY TEXT:C222(<>ts_Aut; 0)
		ARRAY TEXT:C222(<>ts_SitF; 0)
		
		// Dernier emploi
		ARRAY TEXT:C222(<>ts_DerJob; 0)
		
		//Situation professionnelle
		ARRAY TEXT:C222(<>ts_SitPro; 0)
		
		//Dernier hébergement
		ARRAY TEXT:C222(<>ts_DerHéb; 0)
		
		//Liens
		ARRAY TEXT:C222(<>ts_Lien; 0)
		
		//Pièces d'Identité
		ARRAY TEXT:C222(<>ts_PIdté; 0)
		
		//Niveau d'étude
		ARRAY TEXT:C222(<>ts_NivEtu; 0)
		
		//FM Cas spécifique
		ARRAY TEXT:C222(<>ts_CaS; 0)
		
		ARRAY INTEGER:C220(<>ts_Age; 0)
		ARRAY LONGINT:C221(<>ts_IDHB; 0)
		ARRAY LONGINT:C221(<>ts_Hatt; 0)
		ARRAY LONGINT:C221(<>ts_HClo; 0)
		
		ARRAY BOOLEAN:C223(<>ts_Nuit; 0)
		ARRAY BOOLEAN:C223(<>ts_Cloturé; 0)
		ARRAY BOOLEAN:C223(<>ts_Genre; 0)
		ARRAY BOOLEAN:C223(<>ts_Méd; 0)
		
		ARRAY DATE:C224(<>ts_Date; 0)
		
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
		
		// Age
		// Modifié par : Scanu Rémy (05/10/2023)
		ALL RECORDS:C47([TrancheAge:40])
		MultiSoc_Filter(->[TrancheAge:40])
		
		$NoTable:=Table:C252(->[TrancheAge:40])
		
		ARRAY TEXT:C222(<>ta_TBAge; [TrancheAge:40]TA_Tranche_0Nombre:1)
		ARRAY INTEGER:C220(<>te_TBAge; [TrancheAge:40]TA_Tranche_0Nombre:1)
		
		For ($ii; 1; Size of array:C274(<>ta_TrancheAge))
			<>ta_TBAge{$ii}:=Field:C253($NoTable; $ii+1)->
			<>te_TBAge{$ii}:=Field:C253($NoTable; $ii+10)->
		End for 
		
		vl_Tab2:=Size of array:C274(<>te_TBAge)
		ARRAY LONGINT:C221(<>te_NbAge; vl_Tab2)
		ARRAY LONGINT:C221(<>tl_NbAge; vl_Tab2)
		
		// Heure
		ARRAY LONGINT:C221(<>ts_Heures; 24)
		
		For ($ii; 1; 24)
			<>ts_Heures{$ii}:=$ii-1
		End for 
		
		//Heure d'appel
		ARRAY LONGINT:C221(<>te_NbHatt; 24)
		
		//Heure cloture
		ARRAY LONGINT:C221(<>te_NbHClo; 24)
		
		//Signl
		vl_Tab5:=Size of array:C274(<>ta_TBSglt)
		ARRAY LONGINT:C221(<>te_NbSglt; vl_Tab5)
		ARRAY LONGINT:C221(<>tl_NbSglt; vl_Tab5)
		
		//Nation
		vl_Tab6:=Size of array:C274(<>ta_TBNatio)
		COPY ARRAY:C226(<>ta_TBNatio; <>ta_National)
		
		ARRAY LONGINT:C221(<>te_NbNatio; vl_Tab6)
		ARRAY LONGINT:C221(<>tl_NbNatio; vl_Tab6)
		
		//Médicalisé
		ARRAY TEXT:C222(<>ta_TBMéd; 2)
		<>ta_TBMéd{1}:="Non médicalisé"
		<>ta_TBMéd{2}:="Médicalisé"
		
		vl_Tab7:=Size of array:C274(<>ta_TBMéd)
		ARRAY LONGINT:C221(<>te_NbMéd; vl_Tab7)
		ARRAY LONGINT:C221(<>tl_NbMéd; vl_Tab7)
		
		//Errance
		vl_Tab8:=Size of array:C274(<>ta_TBTpsErr)
		ARRAY LONGINT:C221(<>te_NbErr; vl_Tab8)
		ARRAY LONGINT:C221(<>tl_NbErr; vl_Tab8)
		
		//Ressource
		vl_Tab9:=Size of array:C274(<>ta_TBResAct)
		ARRAY LONGINT:C221(<>te_NbRes; vl_Tab9)
		ARRAY LONGINT:C221(<>tl_NbRes; vl_Tab9)
		
		//Suivi
		vl_Tab10:=Size of array:C274(<>ta_TBSuiSoc)
		ARRAY LONGINT:C221(<>te_NbSui; vl_Tab10)
		ARRAY LONGINT:C221(<>tl_NbSui; vl_Tab10)
		
		//Couverture
		vl_Tab11:=Size of array:C274(<>ta_TBCouSoc)
		ARRAY LONGINT:C221(<>te_NbCou; vl_Tab11)
		ARRAY LONGINT:C221(<>tl_NbCou; vl_Tab11)
		
		//Or 1
		vl_Tab12:=Size of array:C274(<>ta_TBOr1)
		ARRAY LONGINT:C221(<>te_NbOr1; vl_Tab12)
		ARRAY LONGINT:C221(<>tl_NbOr1; vl_Tab12)
		
		//Or 2
		vl_Tab13:=Size of array:C274(<>ta_TBOr2)
		ARRAY LONGINT:C221(<>te_NbOr2; vl_Tab13)
		ARRAY LONGINT:C221(<>tl_NbOr2; vl_Tab13)
		
		//Autre
		vl_Tab14:=Size of array:C274(<>ta_AtS)
		ARRAY LONGINT:C221(<>te_NbAtS; vl_Tab14)
		ARRAY LONGINT:C221(<>tl_NbAtS; vl_Tab14)
		
		//Situation de famille
		vl_Tab15:=Size of array:C274(<>ta_TBSitFam)
		ARRAY LONGINT:C221(<>te_NbSitF; vl_Tab15)
		ARRAY LONGINT:C221(<>tl_NbSitF; vl_Tab15)
		
		vl_Tab16:=Size of array:C274(<>ta_TBArr)
		ARRAY LONGINT:C221(<>te_NbArr; vl_Tab16)
		ARRAY LONGINT:C221(<>tl_NbArr; vl_Tab16)
		
		
		vl_Tab17:=Size of array:C274(<>ta_TBGare)
		ARRAY LONGINT:C221(<>te_NbGare; vl_Tab17)
		ARRAY LONGINT:C221(<>tl_NbGare; vl_Tab17)
		
		vl_Tab18:=Size of array:C274(<>ta_TBMetro)
		ARRAY LONGINT:C221(<>te_NbMetro; vl_Tab18)
		ARRAY LONGINT:C221(<>tl_NbMetro; vl_Tab18)
		
		//RipMaj
		vl_Tab19:=Size of array:C274(<>ta_TBRupMaj)
		ARRAY LONGINT:C221(<>te_TBRupMaj; vl_Tab19)
		ARRAY LONGINT:C221(<>tl_TBRupMajo; vl_Tab19)
		
		//Dernier emploi
		vl_Tab20:=Size of array:C274(<>ta_TBDerJob)
		ARRAY LONGINT:C221(<>te_TBDerJob; vl_Tab20)
		ARRAY LONGINT:C221(<>tl_TBDerJob; vl_Tab20)
		
		//Situation professionnelle
		vl_Tab21:=Size of array:C274(<>ta_TBSitPro)
		ARRAY LONGINT:C221(<>te_TBSitPro; vl_Tab21)
		ARRAY LONGINT:C221(<>tl_TBSitPro; vl_Tab21)
		
		//Dernier hébergement
		vl_Tab22:=Size of array:C274(<>ta_TBDerHéb)
		ARRAY LONGINT:C221(<>te_TBDerHéb; vl_Tab22)
		ARRAY LONGINT:C221(<>tl_TBDerHéb; vl_Tab22)
		
		//Liens
		vl_Tab23:=Size of array:C274(<>ta_TBLien)
		ARRAY LONGINT:C221(<>te_TBLien; vl_Tab23)
		ARRAY LONGINT:C221(<>tl_TBLien; vl_Tab23)
		
		//Pièces d'Identité
		vl_Tab24:=Size of array:C274(<>ta_TBPIdté)
		ARRAY LONGINT:C221(<>te_TBPIdté; vl_Tab24)
		ARRAY LONGINT:C221(<>tl_TBPIdté; vl_Tab24)
		
		//Niveau d'étude
		vl_Tab25:=Size of array:C274(<>ta_TBNivEtu)
		ARRAY LONGINT:C221(<>te_TBNivEtu; vl_Tab25)
		ARRAY LONGINT:C221(<>tl_TBNivEtu; vl_Tab25)
		
		//FM Cas spécifique
		vl_Tab26:=Size of array:C274(<>ta_FMCaS)
		ARRAY LONGINT:C221(<>te_FMCaS; vl_Tab26)
		ARRAY LONGINT:C221(<>tl_FMCaS; vl_Tab26)
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
		
		For ($ii; 1; vl_Tab2)
			<>te_NbAge{$ii}:=0
			<>tl_NbAge{$ii}:=0
		End for 
		
		//Heure cloture
		For ($ii; 1; 24)
			<>te_NbHatt{$ii}:=0
			<>te_NbHClo{$ii}:=0
		End for 
		
		For ($ii; 1; vl_Tab5)
			<>te_NbSglt{$ii}:=0
			<>tl_NbSglt{$ii}:=0
		End for 
		
		//SitFam
		For ($ii; 1; vl_Tab15)
			<>te_NbSitF{$ii}:=0
			<>tl_NbSitF{$ii}:=0
		End for 
		
		//Nation
		For ($ii; 1; vl_Tab6)
			<>te_NbNatio{$ii}:=0
			<>tl_NbNatio{$ii}:=0
		End for 
		
		//Médicalisé
		For ($ii; 1; vl_Tab7)
			<>te_NbMéd{$ii}:=0
			<>tl_NbMéd{$ii}:=0
		End for 
		
		//Errance
		For ($ii; 1; vl_Tab8)
			<>te_NbErr{$ii}:=0
			<>tl_NbErr{$ii}:=0
		End for 
		
		//Ressource
		For ($ii; 1; vl_Tab9)
			<>te_NbRes{$ii}:=0
			<>tl_NbRes{$ii}:=0
		End for 
		
		//Suivi
		For ($ii; 1; vl_Tab10)
			<>te_NbSui{$ii}:=0
			<>tl_NbSui{$ii}:=0
		End for 
		
		//Couverture
		For ($ii; 1; vl_Tab11)
			<>te_NbCou{$ii}:=0
			<>tl_NbCou{$ii}:=0
		End for 
		
		//Or 1
		For ($ii; 1; vl_Tab12)
			<>te_NbOr1{$ii}:=0
			<>tl_NbOr1{$ii}:=0
		End for 
		
		//Or 2
		For ($ii; 1; vl_Tab13)
			<>te_NbOr2{$ii}:=0
			<>tl_NbOr2{$ii}:=0
		End for 
		
		//Autre
		For ($ii; 1; vl_Tab14)
			<>te_NbAtS{$ii}:=0
			<>tl_NbAtS{$ii}:=0
		End for 
		
		For ($ii; 1; vl_Tab16)
			<>te_NbArr{$ii}:=0
			<>tl_NbArr{$ii}:=0
		End for 
		
		//Autre
		For ($ii; 1; vl_Tab17)
			<>te_NbGare{$ii}:=0
			<>tl_NbGare{$ii}:=0
		End for 
		
		For ($ii; 1; vl_Tab18)
			<>te_NbMetro{$ii}:=0
			<>tl_NbMetro{$ii}:=0
		End for 
		
		For ($ii; 1; vl_Tab19)
			<>te_TBRupMaj{$ii}:=0
			<>tl_TBRupMajo{$ii}:=0
		End for 
		
		//Dernier emploi
		For ($ii; 1; vl_Tab20)
			<>te_TBDerJob{$ii}:=0
			<>tl_TBDerJob{$ii}:=0
		End for 
		
		//Situation professionnelle
		For ($ii; 1; vl_Tab21)
			<>te_TBSitPro{$ii}:=0
			<>tl_TBSitPro{$ii}:=0
		End for 
		
		//Dernier hébergement
		For ($ii; 1; vl_Tab22)
			<>te_TBDerHéb{$ii}:=0
			<>tl_TBDerHéb{$ii}:=0
		End for 
		
		//Liens
		For ($ii; 1; vl_Tab23)
			<>te_TBLien{$ii}:=0
			<>tl_TBLien{$ii}:=0
		End for 
		
		//Pièces d'Identité
		For ($ii; 1; vl_Tab24)
			<>te_TBPIdté{$ii}:=0
			<>tl_TBPIdté{$ii}:=0
		End for 
		
		//Niveau d'étude
		For ($ii; 1; vl_Tab25)
			<>te_TBNivEtu{$ii}:=0
			<>tl_TBNivEtu{$ii}:=0
		End for 
		
		//FM Cas spécifique
		For ($ii; 1; vl_Tab26)
			<>te_FMCaS{$ii}:=0
			<>tl_FMCaS{$ii}:=0
		End for 
		
End case 