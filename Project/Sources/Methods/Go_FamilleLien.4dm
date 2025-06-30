//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_FamilleLien
//{
//{          Mercredi 23 janvier 2002 à 15:36
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_TEXT:C284(va_LaFamille; va_LaFamilleNom)
C_BOOLEAN:C305(vb_EstChéf; vb_Show)

READ ONLY:C145(*)
SET MENU BAR:C67(1)

vb_Show:=False:C215

If (vb_Show)
	Général_Hide
End if 

MESSAGES OFF:C175

vb_EstChéf:=$1
va_LeNoFAM:=""
va_CléFam:=$2+" : "+va_LaFamille

If ($3="")
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_CléFam:47#$3)
	MultiSoc_Filter(->[HeBerge:4])
Else 
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_CléFam:47=$3)
	MultiSoc_Filter(->[HeBerge:4])
End if 

ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
FORM SET INPUT:C55([DiaLogues:3]; "DL_HébergementFamille")

$vl_Fenetre:=i_FenêtreNo(491; 343; 4; $2; 4; "Quit_Simple")
ADD RECORD:C56([DiaLogues:3])

CLOSE WINDOW:C154($vl_Fenetre)

If (va_LeNoFAM>"")
	<>va_LeNoFAM:=va_LeNoFAM
	
	POST OUTSIDE CALL:C329(<>PR_Hébergement)
	POST OUTSIDE CALL:C329(<>PR_HébergementR)
	POST OUTSIDE CALL:C329(<>PR_HébergementV)
End if 

<>PR_Lien:=0

If (vb_Show)
	Général_Show
End if 