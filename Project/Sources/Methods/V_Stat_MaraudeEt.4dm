//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : V_Stat_MaraudeET
//{
//{          Mardi 10 mai 2005 à 11:25:00
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
		sNeOu:=$ii
		sSignal:=$ii
		sEmplace:=$ii
		sCP:=$ii
		sDem:=$ii
		sQuar:=$ii
		sDure:=$ii
		
		sEgene:=$ii
		sEcut:=$ii
		sRel:=$ii
		sHy:=$ii
		sHan:=$ii
		sLangue:=$ii
		sORsoc:=$ii
		sORmed:=$ii
		
		sDerHb:=$ii
		sDemHb:=$ii
		sPers:=$ii
		sMotif:=$ii
		sMode:=$ii
		sTemps:=$ii
		sComp:=$ii
		sCouv:=$ii
		sRess:=$ii
		sPap:=$ii
		sRegime:=$ii
		sSuivi:=$ii
		
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
		
		//Lieu de naissance
		vl_Tab3:=Size of array:C274(<>ta_TBLieuNé)
		ARRAY LONGINT:C221(te_TBLieuNé; vl_Tab3)
		ARRAY LONGINT:C221(tl_TBLieuNé; vl_Tab3)
		//Signl
		vl_Tab4:=Size of array:C274(<>ta_MRsg)
		ARRAY LONGINT:C221(te_MRsg; vl_Tab4)
		ARRAY LONGINT:C221(tl_MRsg; vl_Tab4)
		//Emplacement
		vl_Tab5:=Size of array:C274(<>ta_TBPorte)
		ARRAY LONGINT:C221(te_TBPorte; vl_Tab5)
		ARRAY LONGINT:C221(tl_TBPorte; vl_Tab5)
		//CodePostal (arrondissement)
		vl_Tab6:=Size of array:C274(<>ta_TBArr)
		ARRAY LONGINT:C221(te_TBArr; vl_Tab6)
		ARRAY LONGINT:C221(tl_TBArr; vl_Tab6)
		//Demande
		vl_Tab7:=Size of array:C274(<>ta_MRDem)
		ARRAY LONGINT:C221(te_MRDem; vl_Tab7)
		ARRAY LONGINT:C221(tl_MRDem; vl_Tab7)
		//Quartier
		vl_Tab8:=Size of array:C274(<>ta_MRqua)
		ARRAY LONGINT:C221(te_MRqua; vl_Tab8)
		ARRAY LONGINT:C221(tl_MRqua; vl_Tab8)
		//Etat général
		vl_Tab9:=Size of array:C274(<>ta_MReGé)
		ARRAY LONGINT:C221(te_MReGé; vl_Tab9)
		ARRAY LONGINT:C221(tl_MReGé; vl_Tab9)
		//Etat cutané
		vl_Tab10:=Size of array:C274(<>ta_MReCu)
		ARRAY LONGINT:C221(te_MReCu; vl_Tab10)
		ARRAY LONGINT:C221(tl_MReCu; vl_Tab10)
		//Realtion
		vl_Tab11:=Size of array:C274(<>ta_MRrel)
		ARRAY LONGINT:C221(te_MRrel; vl_Tab11)
		ARRAY LONGINT:C221(tl_MRrel; vl_Tab11)
		//Realtion
		vl_Tab12:=Size of array:C274(<>ta_MRhyg)
		ARRAY LONGINT:C221(te_MRhyg; vl_Tab12)
		ARRAY LONGINT:C221(tl_MRhyg; vl_Tab12)
		//Handicap
		vl_Tab13:=Size of array:C274(<>ta_MRhan)
		ARRAY LONGINT:C221(te_MRhan; vl_Tab13)
		ARRAY LONGINT:C221(tl_MRhan; vl_Tab13)
		//Langue
		vl_Tab14:=Size of array:C274(<>ta_Lgs)
		ARRAY LONGINT:C221(te_Lgs; vl_Tab14)
		ARRAY LONGINT:C221(tl_Lgs; vl_Tab14)
		//Or sociale
		vl_Tab15:=Size of array:C274(<>ta_OrSc)
		ARRAY LONGINT:C221(te_OrSc; vl_Tab15)
		ARRAY LONGINT:C221(tl_OrSc; vl_Tab15)
		//Or médicale
		vl_Tab16:=Size of array:C274(<>ta_OrMd)
		ARRAY LONGINT:C221(te_OrMd; vl_Tab16)
		ARRAY LONGINT:C221(tl_OrMd; vl_Tab16)
		
		//Dernier hébergement
		vl_Tab17:=Size of array:C274(<>ta_DerLH)
		ARRAY LONGINT:C221(te_DerLH; vl_Tab17)
		ARRAY LONGINT:C221(tl_DerLH; vl_Tab17)
		//Demande hébergement
		vl_Tab18:=2
		ARRAY TEXT:C222(<>ta_MRdemHb; vl_Tab18)
		ARRAY LONGINT:C221(<>te_MRdemHb; vl_Tab18)
		ARRAY LONGINT:C221(<>tl_MRdemHb; vl_Tab18)
		<>ta_MRdemHb{1}:="Non"
		<>ta_MRdemHb{2}:="Oui"
		<>te_MRdemHb{1}:=0
		<>te_MRdemHb{2}:=0
		<>tl_MRdemHb{1}:=0
		<>tl_MRdemHb{2}:=0
		//Personne chez qui aller
		vl_Tab19:=Size of array:C274(<>ta_MRQui)
		ARRAY LONGINT:C221(te_MRQui; vl_Tab19)
		ARRAY LONGINT:C221(tl_MRQui; vl_Tab19)
		//Motif du refus de prise en charge
		vl_Tab20:=Size of array:C274(<>ta_MRrefu)
		ARRAY LONGINT:C221(te_MRrefu; vl_Tab20)
		ARRAY LONGINT:C221(tl_MRrefu; vl_Tab20)
		//Quel mode
		vl_Tab21:=Size of array:C274(<>ta_Qmod)
		ARRAY LONGINT:C221(te_Qmod; vl_Tab21)
		ARRAY LONGINT:C221(tl_Qmod; vl_Tab21)
		//Temps d'errance
		vl_Tab22:=Size of array:C274(<>ta_TBTpsErr)
		ARRAY LONGINT:C221(te_TBTpsErr; vl_Tab22)
		ARRAY LONGINT:C221(tl_TBTpsErr; vl_Tab22)
		//Compagnie actuelle
		vl_Tab23:=Size of array:C274(<>ta_DScomp)
		ARRAY LONGINT:C221(te_DScomp; vl_Tab23)
		ARRAY LONGINT:C221(tl_DScomp; vl_Tab23)
		//Coouverture sociale
		vl_Tab24:=Size of array:C274(<>ta_DScs)
		ARRAY LONGINT:C221(te_DScs; vl_Tab24)
		ARRAY LONGINT:C221(tl_DScs; vl_Tab24)
		//Ressources
		vl_Tab25:=Size of array:C274(<>ta_MRrs)
		ARRAY LONGINT:C221(te_MRrs; vl_Tab25)
		ARRAY LONGINT:C221(tl_MRrs; vl_Tab25)
		//Papiers d'identité
		vl_Tab26:=Size of array:C274(<>ta_DSidté)
		ARRAY LONGINT:C221(te_DSidté; vl_Tab26)
		ARRAY LONGINT:C221(tl_DSidté; vl_Tab26)
		//Régime
		vl_Tab27:=Size of array:C274(<>ta_DSrég)
		ARRAY LONGINT:C221(te_DSrég; vl_Tab27)
		ARRAY LONGINT:C221(tl_DSrég; vl_Tab27)
		//Suivi
		vl_Tab28:=Size of array:C274(<>ta_DSsuivi)
		ARRAY LONGINT:C221(te_DSsuivi; vl_Tab28)
		ARRAY LONGINT:C221(tl_DSsuivi; vl_Tab28)
		
		
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
		vl_Tab3:=Size of array:C274(<>ta_TBLieuNé)
		For ($ii; 1; vl_Tab3)
			te_TBLieuNé{$ii}:=0
			tl_TBLieuNé{$ii}:=0
		End for 
		vl_Tab4:=Size of array:C274(<>ta_MRsg)
		For ($ii; 1; vl_Tab4)
			te_MRsg{$ii}:=0
			tl_MRsg{$ii}:=0
		End for 
		vl_Tab5:=Size of array:C274(<>ta_TBPorte)
		For ($ii; 1; vl_Tab5)
			te_TBPorte{$ii}:=0
			tl_TBPorte{$ii}:=0
		End for 
		vl_Tab6:=Size of array:C274(<>ta_TBArr)
		For ($ii; 1; vl_Tab6)
			te_TBArr{$ii}:=0
			tl_TBArr{$ii}:=0
		End for 
		vl_Tab7:=Size of array:C274(<>ta_MRDem)
		For ($ii; 1; vl_Tab7)
			te_MRDem{$ii}:=0
			tl_MRDem{$ii}:=0
		End for 
		vl_Tab8:=Size of array:C274(<>ta_MRqua)
		For ($ii; 1; vl_Tab8)
			te_MRqua{$ii}:=0
			tl_MRqua{$ii}:=0
		End for 
		vl_Tab9:=Size of array:C274(<>ta_MReGé)
		For ($ii; 1; vl_Tab9)
			te_MReGé{$ii}:=0
			tl_MReGé{$ii}:=0
		End for 
		vl_Tab10:=Size of array:C274(<>ta_MReCu)
		For ($ii; 1; vl_Tab10)
			te_MReCu{$ii}:=0
			tl_MReCu{$ii}:=0
		End for 
		vl_Tab11:=Size of array:C274(<>ta_MRrel)
		For ($ii; 1; vl_Tab11)
			te_MRrel{$ii}:=0
			tl_MRrel{$ii}:=0
		End for 
		vl_Tab12:=Size of array:C274(<>ta_MRhyg)
		For ($ii; 1; vl_Tab12)
			te_MRhyg{$ii}:=0
			tl_MRhyg{$ii}:=0
		End for 
		vl_Tab13:=Size of array:C274(<>ta_MRhan)
		For ($ii; 1; vl_Tab13)
			te_MRhan{$ii}:=0
			tl_MRhan{$ii}:=0
		End for 
		vl_Tab14:=Size of array:C274(<>ta_Lgs)
		For ($ii; 1; vl_Tab14)
			te_Lgs{$ii}:=0
			tl_Lgs{$ii}:=0
		End for 
		vl_Tab15:=Size of array:C274(<>ta_OrSc)
		For ($ii; 1; vl_Tab15)
			te_OrSc{$ii}:=0
			tl_OrSc{$ii}:=0
		End for 
		vl_Tab16:=Size of array:C274(<>ta_OrMd)
		For ($ii; 1; vl_Tab16)
			te_OrMd{$ii}:=0
			tl_OrMd{$ii}:=0
		End for 
		vl_Tab17:=Size of array:C274(<>ta_DerLH)
		For ($ii; 1; vl_Tab17)
			te_DerLH{$ii}:=0
			tl_DerLH{$ii}:=0
		End for 
		//vl_Tab18:=2
		<>te_MRdemHb{1}:=0
		<>te_MRdemHb{2}:=0
		<>tl_MRdemHb{1}:=0
		<>tl_MRdemHb{2}:=0
		vl_Tab19:=Size of array:C274(<>ta_MRQui)
		For ($ii; 1; vl_Tab19)
			te_MRQui{$ii}:=0
			tl_MRQui{$ii}:=0
		End for 
		vl_Tab20:=Size of array:C274(<>ta_MRrefu)
		For ($ii; 1; vl_Tab20)
			te_MRrefu{$ii}:=0
			tl_MRrefu{$ii}:=0
		End for 
		vl_Tab21:=Size of array:C274(<>ta_Qmod)
		For ($ii; 1; vl_Tab21)
			te_Qmod{$ii}:=0
			tl_Qmod{$ii}:=0
		End for 
		vl_Tab22:=Size of array:C274(<>ta_TBTpsErr)
		For ($ii; 1; vl_Tab22)
			te_TBTpsErr{$ii}:=0
			tl_TBTpsErr{$ii}:=0
		End for 
		vl_Tab23:=Size of array:C274(<>ta_DScomp)
		For ($ii; 1; vl_Tab23)
			te_DScomp{$ii}:=0
			tl_DScomp{$ii}:=0
		End for 
		vl_Tab24:=Size of array:C274(<>ta_DScs)
		For ($ii; 1; vl_Tab24)
			te_DScs{$ii}:=0
			tl_DScs{$ii}:=0
		End for 
		vl_Tab25:=Size of array:C274(<>ta_MRrs)
		For ($ii; 1; vl_Tab25)
			te_MRrs{$ii}:=0
			tl_MRrs{$ii}:=0
		End for 
		vl_Tab26:=Size of array:C274(<>ta_DSidté)
		For ($ii; 1; vl_Tab26)
			te_DSidté{$ii}:=0
			tl_DSidté{$ii}:=0
		End for 
		vl_Tab27:=Size of array:C274(<>ta_DSrég)
		For ($ii; 1; vl_Tab27)
			te_DSrég{$ii}:=0
			tl_DSrég{$ii}:=0
		End for 
		vl_Tab28:=Size of array:C274(<>ta_DSsuivi)
		For ($ii; 1; vl_Tab28)
			te_DSsuivi{$ii}:=0
			tl_DSsuivi{$ii}:=0
		End for 
		
End case 