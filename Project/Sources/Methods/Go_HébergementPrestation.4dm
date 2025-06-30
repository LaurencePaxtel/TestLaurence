//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_HébergementPrestation
//{
//{          Lundi 21 mai 2001 à 13:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
READ ONLY:C145(*)
SET MENU BAR:C67(1)



C_BOOLEAN:C305(vb_Show)
vb_Show:=True:C214
If (vb_Show)
	Général_Hide
End if 


If (F_VariablesTransite(0; 1; False:C215))
End if 
If (F_VariablesTransite(1; 1; False:C215))
End if 
//V_IDT_Déc (0)
//V_IDT_Déc (1)

C_BOOLEAN:C305(vb_passe1)
C_LONGINT:C283(vL_Nb_HB_F)
C_LONGINT:C283(vL_Nb_HG_F)

C_LONGINT:C283(vl_RéfU_HB)
C_LONGINT:C283(vl_RéfU_HG)
vL_Nb_HB_F:=0
vL_Nb_HG_F:=0
vb_passe1:=False:C215

vl_RéfU_HB:=0
vl_RéfU_HG:=0
<>Vl_RefUfich:=0
C_TEXT:C284(va_Rép)
C_TEXT:C284(va_Rép2)
va_Rép:=""
va_Rép2:=""

C_LONGINT:C283(vL_RéfHBOld)

C_TEXT:C284(va_HGRPré)
C_DATE:C307(va_HGRNé)
va_HGRPré:=""
va_HGRNé:=!00-00-00!



va_FrappeClavier:=""
va_FrappeClavierP:=""
va_FrappeClavierD:=""
READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_Prestations")
va_Titre:="Recherche de prestations"
$vl_Fenetre:=i_FenêtreNo(632; 508; 4; va_Titre; 1; "Quit_Show")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
<>PR_HébergementRG:=0

If (vb_Show)
	Général_Show
End if 