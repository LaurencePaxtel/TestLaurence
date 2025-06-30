//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_FusionBt
//{
//{          Mercredi 29 janvier 2003 à 11:13:57
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
Case of 
	: ($1=0)
		OBJECT SET ENABLED:C1123(b_CléRetirer; False:C215)
		OBJECT SET ENABLED:C1123(b_VoirNotesTab; False:C215)
		OBJECT SET ENABLED:C1123(b_VoirSPTab; False:C215)
		OBJECT SET ENABLED:C1123(b_ModCléHGTab; False:C215)
		OBJECT SET ENABLED:C1123(b_SUPCléHGTab; False:C215)
	: ($1=1)
		OBJECT SET ENABLED:C1123(b_CléRetirer; True:C214)
		OBJECT SET ENABLED:C1123(b_VoirNotesTab; True:C214)
		OBJECT SET ENABLED:C1123(b_VoirSPTab; True:C214)
		OBJECT SET ENABLED:C1123(b_ModCléHGTab; True:C214)
		OBJECT SET ENABLED:C1123(b_SUPCléHGTab; True:C214)
		If (va_IDT_Typ1>"") & (Size of array:C274(tl_Fu_Référence)>0)
			OBJECT SET ENABLED:C1123(b_Fuse; True:C214)
		End if 
	: ($1=2)
	: ($1=3)
	: ($1=4)
End case 