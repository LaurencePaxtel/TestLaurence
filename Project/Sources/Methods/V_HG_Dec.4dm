//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : V_HG_Déc
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

Case of 
	: ($1=0)
		C_TEXT:C284(va_Identité)
		C_TEXT:C284(va_Ptr_Var1)
		C_TEXT:C284(va_Ptr_Var2)
		C_TEXT:C284(va_Ptr_Var3)
		C_LONGINT:C283(ve_Ptr_Tri)
		C_TEXT:C284(va_Titre)
		C_TEXT:C284(va_NomRub)
		C_TEXT:C284(va_CtrLib)
		
		C_BOOLEAN:C305(vb_NewEtC)
		C_BOOLEAN:C305(vb_NewFiche)
		
		
		C_LONGINT:C283(vl_Num_HBE)
		C_LONGINT:C283(vl_RéfU_HG)
		C_LONGINT:C283(vl_RéfU_HB)
		C_LONGINT:C283(vl_RéfU_HBB)
		
		C_TEXT:C284(va_Rép)
		C_TEXT:C284(va_Rép2)
		
		C_DATE:C307(vd_HébergéDateDuJour; vd_HébergéAge)
		C_LONGINT:C283(ve_HébergéAge)
	: ($1=1)
		va_Identité:=""
		va_Ptr_Var1:=""
		va_Ptr_Var2:=""
		va_Ptr_Var3:=""
		ve_Ptr_Tri:=0
		va_NomRub:=""
		
		va_CtrLib:=""
		vb_NewEtC:=False:C215
		vb_NewFiche:=False:C215
		
		vl_Num_HBE:=0
		vl_RéfU_HG:=0
		
		vl_RéfU_HB:=0
		vl_RéfU_HBB:=0
		va_Rép:=""
		va_Rép2:=""
End case 