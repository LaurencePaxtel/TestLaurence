//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : P_SIAO_MontantSaisie
//{
//{          Lundi 24 Janvier 2011 à 11:26:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)
Case of 
	: ($1=1)
		
		OBJECT SET ENTERABLE:C238(vr_Ss_RS_Montant1; ($2=1))
		OBJECT SET ENTERABLE:C238(vr_Ss_RS_Montant2; ($2=1))
		OBJECT SET ENTERABLE:C238(vr_Ss_RS_Montant3; ($2=1))
		OBJECT SET ENTERABLE:C238(vr_Ss_RS_Montant4; ($2=1))
		OBJECT SET ENTERABLE:C238(vr_Ss_RS_Montant5; ($2=1))
		
		OBJECT SET ENTERABLE:C238(vd_Ss_RS_Debut1; ($2=1))
		OBJECT SET ENTERABLE:C238(vd_Ss_RS_Debut2; ($2=1))
		OBJECT SET ENTERABLE:C238(vd_Ss_RS_Debut3; ($2=1))
		OBJECT SET ENTERABLE:C238(vd_Ss_RS_Debut4; ($2=1))
		OBJECT SET ENTERABLE:C238(vd_Ss_RS_Debut5; ($2=1))
		
		
		OBJECT SET ENTERABLE:C238(vd_Ss_RS_Fin1; ($2=1))
		OBJECT SET ENTERABLE:C238(vd_Ss_RS_Fin2; ($2=1))
		OBJECT SET ENTERABLE:C238(vd_Ss_RS_Fin3; ($2=1))
		OBJECT SET ENTERABLE:C238(vd_Ss_RS_Fin4; ($2=1))
		OBJECT SET ENTERABLE:C238(vd_Ss_RS_Fin5; ($2=1))
		
		
		
		
		
		If ($2=1)
			GOTO OBJECT:C206(vr_Ss_RS_Montant1)
		End if 
		
	: ($1=2)
		
		OBJECT SET ENTERABLE:C238(vr_Ss_DT_Montant1; ($2=1))
		OBJECT SET ENTERABLE:C238(vr_Ss_DT_Montant2; ($2=1))
		OBJECT SET ENTERABLE:C238(vr_Ss_DT_Montant3; ($2=1))
		OBJECT SET ENTERABLE:C238(vr_Ss_DT_Montant4; ($2=1))
		OBJECT SET ENTERABLE:C238(vr_Ss_DT_Montant5; ($2=1))
		
		OBJECT SET ENTERABLE:C238(vd_Ss_DT_Debut1; ($2=1))
		OBJECT SET ENTERABLE:C238(vd_Ss_DT_Debut2; ($2=1))
		OBJECT SET ENTERABLE:C238(vd_Ss_DT_Debut3; ($2=1))
		OBJECT SET ENTERABLE:C238(vd_Ss_DT_Debut4; ($2=1))
		OBJECT SET ENTERABLE:C238(vd_Ss_DT_Debut5; ($2=1))
		
		
		OBJECT SET ENTERABLE:C238(vd_Ss_DT_Fin1; ($2=1))
		OBJECT SET ENTERABLE:C238(vd_Ss_DT_Fin2; ($2=1))
		OBJECT SET ENTERABLE:C238(vd_Ss_DT_Fin3; ($2=1))
		OBJECT SET ENTERABLE:C238(vd_Ss_DT_Fin4; ($2=1))
		OBJECT SET ENTERABLE:C238(vd_Ss_DT_Fin5; ($2=1))
		
		
		OBJECT SET ENTERABLE:C238(vr_Ss_DT_Montant1_2; ($2=1))
		OBJECT SET ENTERABLE:C238(vr_Ss_DT_Montant2_2; ($2=1))
		
		OBJECT SET ENTERABLE:C238(vd_Ss_DT_Debut1_2; ($2=1))
		OBJECT SET ENTERABLE:C238(vd_Ss_DT_Debut2_2; ($2=1))
		
		OBJECT SET ENTERABLE:C238(vd_Ss_DT_Fin1_2; ($2=1))
		OBJECT SET ENTERABLE:C238(vd_Ss_DT_Fin2_2; ($2=1))
		
		
		If ($2=1)
			GOTO OBJECT:C206(vr_Ss_DT_Montant1)
		End if 
End case 