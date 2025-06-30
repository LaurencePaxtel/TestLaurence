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
C_LONGINT:C283($ii)

C_TEXT:C284(va_MotPasseOld; va_MotPasseNew; va_Validité; va_MPmot1; va_MPmot2; va_MPmotOld; va_TypeN; va_Type)
C_BOOLEAN:C305(vb_Show; vb_Start; vb_OKMP)

ARRAY TEXT:C222(ta_LesProfils; 0)
ARRAY TEXT:C222(ta_LesGroupes; 0)
ARRAY TEXT:C222(ta_UserGroupe; 0)
ARRAY TEXT:C222(ta_UserLog; 0)
ARRAY TEXT:C222(ta_LesPlatefomes; 0)

ARRAY LONGINT:C221(tl_LesProfils; 0)
ARRAY LONGINT:C221(tl_LesGroupes; 0)
ARRAY LONGINT:C221(tl_UserGroupe; 0)
ARRAY LONGINT:C221(tl_UserNo; 0)

READ ONLY:C145(*)
SET MENU BAR:C67(1)

vb_Show:=False:C215
vb_Start:=False:C215

// La liste des profils référencés
ALL RECORDS:C47([IntervenantsProfils:31])
MultiSoc_Filter(->[IntervenantsProfils:31])

ORDER BY:C49([IntervenantsProfils:31]; [IntervenantsProfils:31]IP_Libéllé:3; >)
SELECTION TO ARRAY:C260([IntervenantsProfils:31]IP_RéférenceID:1; tl_LesProfils; [IntervenantsProfils:31]IP_Libéllé:3; ta_LesProfils)

// La liste des groupes référencés
GET GROUP LIST:C610(ta_LesGroupes; tl_LesGroupes)

MULTI SORT ARRAY:C718(ta_LesGroupes; >; tl_LesGroupes)

If (Size of array:C274(ta_LesGroupes)>0)
	
	Repeat 
		$ii:=$ii+1
		
		// Modifié par : Scanu Rémy (04/01/2023)
		If (tl_LesGroupes{$ii}>-15000)  // -15011 à -32768
			
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

//Copier
C_TEXT:C284(va_InC_login; va_InC_Nom; va_InC_Prénom; va_inC_Initiales; va_inC_NomPrénom; va_inC_Plateforme)
C_LONGINT:C283(ve_inC_Type)
C_BOOLEAN:C305(vb_inC_Loft; vb_inC_Messagerie; vb_inC_Pointage)
C_PICTURE:C286(vi_inC_Signature)

va_InC_Nom:=""
va_InC_Prénom:=""
va_InC_login:=""
va_inC_Initiales:=""
va_inC_NomPrénom:=""
va_inC_Plateforme:=""

ve_inC_Type:=0

vb_inC_Loft:=False:C215
vb_inC_Messagerie:=False:C215
vb_inC_Pointage:=False:C215

READ WRITE:C146([INtervenants:10])

ALL RECORDS:C47([INtervenants:10])
MultiSoc_Filter(->[INtervenants:10])

CREATE SET:C116([INtervenants:10]; "E_Courant")
ORDER BY:C49([INtervenants:10]; [INtervenants:10]IN_Nom:4; >)

If (<>vb_T_MPMasquePlus)  //6/4/2011
	FORM SET INPUT:C55([INtervenants:10]; "IN_EcranSaisieLG")
	FORM SET OUTPUT:C54([INtervenants:10]; "IN_ListeLG")
	
	$vl_Fenetre:=i_FenêtreNo(649; 536; 4; "Liste des intervenants : "+String:C10(Records in selection:C76([INtervenants:10])); 3; "Quit_Simple")
Else 
	FORM SET INPUT:C55([INtervenants:10]; "IN_EcranSaisie")
	FORM SET OUTPUT:C54([INtervenants:10]; "IN_Liste")
	
	// Modifié par : Kevin HASSAL (27/08/2018)
	// Modification du largeur de la fenêtre pour la zone des structures
	$vl_Fenetre:=i_FenêtreNo(728; 436; 2; "Liste des intervenants : "+String:C10(Records in selection:C76([INtervenants:10])); 3; "Quit_Simple")
End if 

MODIFY SELECTION:C204([INtervenants:10]; *)

CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([INtervenants:10])

<>PR_INT:=0

If (vb_Show)
	Général_Show
End if 