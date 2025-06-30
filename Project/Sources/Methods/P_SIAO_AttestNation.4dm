//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{          Procédure : P_SIAO_AttestNation  
//{          Mardi 29 mars 2011 à 15:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)


Case of 
	: ($1=0)  //Hébergement
		FORM SET OUTPUT:C54([HeberGement:5]; "HB_Attest_Nation")
		_O_PAGE SETUP:C299([HeberGement:5]; "HB_Attest_Nation")
		
		PRINT SETTINGS:C106
		
		vt_SP_N_Identite:=[HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22+" né"+("e"*Num:C11([HeberGement:5]HG_Genre:96=True:C214))+" le "+String:C10([HeberGement:5]HG_DateNéLe:24; Interne date court:K1:7)
		vd_SP_N_DatJour:=Current date:C33
		vt_SP_N_Corps:=F_SIAODivers_Valeur("Nationalite")
		
		FORM SET OUTPUT:C54([HeberGement:5]; "HB_Attest_Nation")
		PRINT RECORD:C71([HeberGement:5]; *)
	: ($1=1)  //SIAO
		
		If (vl_SP_Reference>0)
			FORM SET OUTPUT:C54([SIAO:50]; "Si_Attest_Nation")
			_O_PAGE SETUP:C299([SIAO:50]; "Si_Attest_Nation")
			
			PRINT SETTINGS:C106
			
			If (OK=1)
				vt_SP_N_Identite:=va_SP_Civilite+" "+va_SP_Nom+" "+va_SP_Prenom+" né"+("e"*Num:C11(vb_SP_Genre=True:C214))+" le "+String:C10(vd_SP_NeLeDate; Interne date court:K1:7)
				vd_SP_N_DatJour:=Current date:C33
				vt_SP_N_Corps:=F_SIAODivers_Valeur("Nationalite")
				
				FORM SET OUTPUT:C54([SIAO:50]; "Si_Attest_Nation")
				PRINT RECORD:C71([SIAO:50]; *)
			End if 
			
		Else 
			ALERT:C41("Acune personne n'est sélectionée.")
		End if 
		
End case 