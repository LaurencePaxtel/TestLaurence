//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergéDossierCréer
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)  //Nom
C_POINTER:C301($2)  //Prénom
C_POINTER:C301($3)  //Age
C_LONGINT:C283($vl_NbFiches)

C_TEXT:C284(<>va_TDT_Typ)
C_TEXT:C284(<>va_TDT_Nom)
C_TEXT:C284(<>va_TDT_Pré)
C_DATE:C307(<>vd_TDT_NéLe)
C_BOOLEAN:C305(<>vb_TDT_Genr)
C_TEXT:C284(<>va_TDT_Nat)
C_TEXT:C284(<>va_TDT_Clé)
C_TEXT:C284(<>va_TDT_Titr)
C_LONGINT:C283(<>ve_TDT_NbFL)

$vl_NbFiches:=0
C_TEXT:C284($UneClé)
$UneClé:=Uut_HébergéClé($1; $2; $3)
QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=$UneClé)
MultiSoc_Filter(->[HeBerge:4])
$vl_NbFiches:=Records in selection:C76([HeBerge:4])

Case of 
	: ($vl_NbFiches>1)
		StrAlerte(11; $UneClé)
		REJECT:C38
	: ($vl_NbFiches=0)
		READ WRITE:C146([HeBerge:4])
		CREATE RECORD:C68([HeBerge:4])
		MultiSoc_Init_Structure(->[HeBerge:4])
		[HeBerge:4]HB_ReferenceID:1:=Uut_Numerote(->[HeBerge:4])
		[HeBerge:4]HB_Clé:2:=$UneClé
		[HeBerge:4]HB_Nom:3:=$1->
		[HeBerge:4]HB_Prénom:4:=$2->
		[HeBerge:4]HB_DateNéLe:5:=$3->
		[HeBerge:4]HG_Genre:39:=(x_IDTG_2=1)
		[HeBerge:4]HB_FicheCrééele:46:=Current date:C33(*)
		vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
		SAVE RECORD:C53([HeBerge:4])
		UNLOAD RECORD:C212([HeBerge:4])
		READ ONLY:C145([HeBerge:4])
		
		<>va_TDT_Typ:=va_IDT_Typ1
		<>va_TDT_Nom:=va_IDT_Nom
		<>va_TDT_Pré:=va_IDT_Pré
		<>vd_TDT_NéLe:=vd_IDT_NéLe
		<>vb_TDT_Genr:=(x_IDTG_2=1)
		<>va_TDT_Nat:=va_IDT_Nat
		<>va_TDT_Clé:=va_IDT_Clé
		<>va_TDT_Titr:=va_IDT_Titr
		<>ve_TDT_NbFL:=ve_IDT_NbFL
		vb_NewEtC:=True:C214
		
	: ($vl_NbFiches=1)
		vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
		StrAlerte(11; $UneClé)
		REJECT:C38
		
End case 