//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_ClignoteSousBouton
//{
//{          Mardi 11 Mai 2004 à 10:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_POINTER:C301($2)  //Nombre
C_POINTER:C301($3)  //Etat
C_TEXT:C284($4)  //Nom d'objet)
C_POINTER:C301($5)  //Champs a rechercher
C_LONGINT:C283($6)  //Valeur a rechercher

Case of 
	: ($1=0)
		vl_CasSIAO:=0
		vb_CasSIAO:=False:C215
		
		vl_CasSIAO:=F_CasSP([HeberGement:5]HG_HB_ID:19; 1)
		
		vb_CasSIAO:=True:C214
		Case of 
			: (vl_CasSIAO=-1)
				OBJECT SET VISIBLE:C603(*; "Cligne_SIAO"; True:C214)
				vb_CasSIAO:=True:C214
			: (vl_CasSIAO=0)
				OBJECT SET VISIBLE:C603(*; "Cligne_SIAO"; False:C215)
				vb_CasSIAO:=False:C215
			: (vl_CasSIAO>0)
				OBJECT SET VISIBLE:C603(*; "Cligne_SIAO"; True:C214)
				vb_CasSIAO:=True:C214
				SET TIMER:C645(60)
		End case 
		
	: ($1=1)
		OBJECT SET VISIBLE:C603(*; "Cligne_SIAO"; vb_CasSIAO)
		vb_CasSIAO:=Not:C34(vb_CasSIAO)
End case 
//P_ClignoteSousBouton (0;->vl_CasSP;->vb_CasSP;"Cligne_SP";[HéberGement]HG_HB_ID