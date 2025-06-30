//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_Intervenant
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($ii; $vl_Fenetre)

C_TEXT:C284(va_MotPasseOld; va_MotPasseNew; va_TypeN; va_Type; va_UU_Nom; va_UU_Nom; va_UU_Proc; va_UU_MP)
C_LONGINT:C283(vl_UU_Réf; vl_UU_NbAccès)
C_BOOLEAN:C305(vb_Show; vb_Start)
C_DATE:C307(vd_UU_Date)

ARRAY TEXT:C222(ta_UserLog; 0)

ARRAY LONGINT:C221(tl_UserNo; 0)
ARRAY LONGINT:C221(tl_UU_GP; 0)

READ ONLY:C145(*)
SET MENU BAR:C67(1)

va_UU_Nom:=""
va_UU_Proc:=""
va_UU_MP:=""

vl_UU_Réf:=0
vl_UU_NbAccès:=0

vb_Show:=False:C215
vb_Start:=False:C215

vd_UU_Date:=!00-00-00!

// La liste des utilisateurs référencés
GET USER LIST:C609(ta_UserLog; tl_UserNo)

If (Size of array:C274(ta_UserLog)>0)
	CLEAR VARIABLE:C89($ii)
	
	// Modifié par : Scanu Rémy (04/01/2023)
/*
Repeter 
$ii:=$ii+1
	
Si (tl_UserNo{$ii}>=-10)  //-11 à -15010
SUPPRIMER DANS TABLEAU(ta_UserLog; $ii; 1)
SUPPRIMER DANS TABLEAU(tl_UserNo; $ii; 1)
	
$ii:=$ii-1
Fin de si 
	
Jusque ($ii=Taille tableau(ta_UserLog))
*/
	
	SORT ARRAY:C229(ta_UserLog; tl_UserNo; >)
End if 

READ WRITE:C146([INtervenants:10])

FORM SET OUTPUT:C54([INtervenants:10]; "IN_ListeRAZ")
ALL RECORDS:C47([INtervenants:10])

MultiSoc_Filter(->[INtervenants:10])

CREATE SET:C116([INtervenants:10]; "E_Courant")
ORDER BY:C49([INtervenants:10]; [INtervenants:10]IN_Nom:4; >)

FIRST RECORD:C50([INtervenants:10])
$vl_Fenetre:=i_FenêtreNo(519; 419; 4; "Liste des intervenants : "+String:C10(Records in selection:C76([INtervenants:10])); 3; "Quit_Simple")

MODIFY SELECTION:C204([INtervenants:10]; *)
CLOSE WINDOW:C154($vl_Fenetre)

READ ONLY:C145([INtervenants:10])

<>PR_INTRaz:=0

If (vb_Show)
	Général_Show
End if 