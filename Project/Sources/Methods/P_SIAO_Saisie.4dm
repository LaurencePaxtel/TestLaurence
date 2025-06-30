//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_SIAO_Saisie
//{          Mercredi 1 decembre 2010 à 10:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)
Case of 
	: (($1=(->R1)) | ($1=(->R2)) | ($1=(->R3)))
		[SIAO:50]Si_Demande_Type:5:=(1*Num:C11(R1=1))+(2*Num:C11(R2=1))+(3*Num:C11(R3=1))
		
		
	: (($1=(->x1)) | ($1=(->x2)))
		vb_SP_Genre:=($1->=1)
		
		
		
End case 