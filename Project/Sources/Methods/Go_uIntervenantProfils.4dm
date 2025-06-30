//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uIntervenantProfils
//{
//{         Mrcredi 23 janvier 2002 à 13:53
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($ii)

C_TEXT:C284(va_Type)
C_BOOLEAN:C305(vb_Show; vb_Start)

ARRAY TEXT:C222(ta_UserGroupe; 0)
ARRAY TEXT:C222(tb_ref_structure; 0)
ARRAY TEXT:C222(ta_LesGroupes; 0)

ARRAY INTEGER:C220(te_UserGroupeTri; 0)

ARRAY LONGINT:C221(tl_LesGroupes; 0)
ARRAY LONGINT:C221(tl_UserGroupeRéf; 0)
ARRAY LONGINT:C221(tl_UserGroupe; 0)

READ ONLY:C145(*)
SET MENU BAR:C67(1)

vb_Show:=False:C215
vb_Start:=False:C215

GET GROUP LIST:C610(ta_LesGroupes; tl_LesGroupes)

If (Size of array:C274(ta_LesGroupes)>0)
	$ii:=0
	
	Repeat 
		$ii:=$ii+1
		
		// Modifié par : Scanu Rémy (23/01/2023)
		If (tl_LesGroupes{$ii}>-15000)  // -15011à -32768
			
/*
Si (tl_LesGroupes{$ii}#15002)
SUPPRIMER DANS TABLEAU(ta_LesGroupes; $ii; 1)
SUPPRIMER DANS TABLEAU(tl_LesGroupes; $ii; 1)
			
$ii:=$ii-1
Fin de si 
*/
			
		End if 
		
	Until ($ii=Size of array:C274(ta_LesGroupes))
	
	ta_LesGroupes:=3
	tl_LesGroupes:=3
Else 
	ta_LesGroupes:=0
	tl_LesGroupes:=0
End if 

READ WRITE:C146([IntervenantsProfils:31])

FORM SET INPUT:C55([IntervenantsProfils:31]; "IP_EcranSaisie")
FORM SET OUTPUT:C54([IntervenantsProfils:31]; "IP_Liste")

ALL RECORDS:C47([IntervenantsProfils:31])
MultiSoc_Filter(->[IntervenantsProfils:31])

CREATE SET:C116([IntervenantsProfils:31]; "E_Courant")
ORDER BY:C49([IntervenantsProfils:31]; [IntervenantsProfils:31]IP_Libéllé:3; >)

FIRST RECORD:C50([IntervenantsProfils:31])

$vl_Fenetre:=i_FenêtreNo(519; 419; 4; "Liste des profils : "+String:C10(Records in selection:C76([IntervenantsProfils:31])); 3; "Quit_Simple")
MODIFY SELECTION:C204([IntervenantsProfils:31]; *)

CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([IntervenantsProfils:31])

<>PR_INTPr:=0

If (vb_Show)
	Général_Show
End if 