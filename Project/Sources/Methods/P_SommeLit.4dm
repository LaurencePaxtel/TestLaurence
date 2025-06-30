//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_SommeLit
//{
//{          Vendrdi 26 novembre 2004 à 15:13:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)

Case of 
	: ($1=-1)
		C_LONGINT:C283(vl_LC_sCapa; vl_LC_sRep; vl_LC_sExc; vl_LC_sSor; vl_LC_sDpJ; vl_LC_sAbsJ; vl_LC_sRveil; vl_LC_sDpT; vl_LC_sDist; vl_LC_sRest; vl_LC_sRpl)
		C_LONGINT:C283(vl_LC_cCapa; vl_LC_cDpT; vl_LC_cNbPers; vl_LC_cNbPersNew; vl_LC_cNbFamille; vl_LC_cNbAdulte; vl_LC_cEnfant)
	: ($1=0)
		vl_LC_sCapa:=0
		vl_LC_sRep:=0
		vl_LC_sExc:=0
		vl_LC_sRpl:=0
		vl_LC_sSor:=0
		vl_LC_sDpJ:=0
		vl_LC_sAbsJ:=0
		vl_LC_sRveil:=0
		
		vl_LC_sDpT:=0
		vl_LC_sDist:=0
		vl_LC_sRest:=0
	: ($1=1)
		vl_LC_sCapa:=Sum:C1([CentresLits:16]CL_Capacité:4)
		vl_LC_sRep:=Sum:C1([CentresLits:16]CL_Report:11)
		vl_LC_sExc:=Sum:C1([CentresLits:16]CL_Excusés:14)
		vl_LC_sRpl:=Sum:C1([CentresLits:16]CL_Remplacants:28)
		vl_LC_sSor:=Sum:C1([CentresLits:16]CL_Sortants:15)
		vl_LC_sDpJ:=Sum:C1([CentresLits:16]CL_DispoDuJour:12)
		vl_LC_sAbsJ:=Sum:C1([CentresLits:16]CL_Absents:13)
		vl_LC_sRveil:=Sum:C1([CentresLits:16]CL_RestantsVeille:16)
		
		vl_LC_sDpT:=Sum:C1([CentresLits:16]CL_DispoTotal:5)
		vl_LC_sDist:=Sum:C1([CentresLits:16]CL_Distribué:6)
		vl_LC_sRest:=Sum:C1([CentresLits:16]CL_Restant:7)
	: ($1=2)
		vl_LC_cCapa:=0
		vl_LC_cDpT:=0
		vl_LC_cNbPers:=0
		vl_LC_cNbPersNew:=0
		vl_LC_cNbFamille:=0
		vl_LC_cNbAdulte:=0
		vl_LC_cEnfant:=0
	: ($1=3)
		vl_LC_cCapa:=Sum:C1([CentresLits:16]CL_Capacité:4)
		vl_LC_cDpT:=Sum:C1([CentresLits:16]CL_DispoTotal:5)
		vl_LC_cNbPers:=Sum:C1([CentresLits:16]CL_NbPersonnes:18)
		vl_LC_cNbPersNew:=Sum:C1([CentresLits:16]CL_NbPersonnesNouvelles:19)
		vl_LC_cNbFamille:=Sum:C1([CentresLits:16]CL_NbFamilles:20)
		vl_LC_cNbAdulte:=Sum:C1([CentresLits:16]CL_NbAdultes:21)
		vl_LC_cEnfant:=Sum:C1([CentresLits:16]CL_NbEnfants:22)
End case 