//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uTables
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($ii; $ij; $vl_Fenetre)

C_TEXT:C284(va_TTStrDummy)
C_BOOLEAN:C305(vb_Show)

ARRAY TEXT:C222(ta_TTStrLib; 0)
ARRAY TEXT:C222(ta_TTStrStr; 0)

ARRAY INTEGER:C220(tl_TTStrCas; 0)

ARRAY LONGINT:C221(tl_TTStrNo; 0)
ARRAY LONGINT:C221(tl_TTStrRéf; 0)

READ ONLY:C145(*)
SET MENU BAR:C67(1)

vb_Show:=False:C215

// #BS Migration v15 30/05/16
// Remplacement de la commande obsolète
// STRING LIST TO ARRAY par xliff_STRING_LIST_TO_ARRAY
xliff_STRING_LIST_TO_ARRAY_(30000; ->ta_TTStrStr)

$ij:=Size of array:C274(ta_TTStrStr)

If ($ij>0)
	ARRAY TEXT:C222(ta_TTStrLib; $ij)
	
	ARRAY LONGINT:C221(tl_TTStrRéf; $ij)
	ARRAY LONGINT:C221(tl_TTStrNo; $ij)
	
	ARRAY INTEGER:C220(tl_TTStrCas; $ij)
	
	For ($ii; 1; $ij)
		tl_TTStrNo{$ii}:=$ii
		va_TTStrDummy:=ta_TTStrStr{$ii}
		
		ta_TTStrLib{$ii}:=Substring:C12(va_TTStrDummy; 1; Position:C15(";"; va_TTStrDummy)-1)
		va_TTStrDummy:=Substring:C12(va_TTStrDummy; Position:C15(";"; va_TTStrDummy)+1)
		
		tl_TTStrRéf{$ii}:=Num:C11(Substring:C12(va_TTStrDummy; 1; Position:C15(";"; va_TTStrDummy)-1))
		va_TTStrDummy:=Substring:C12(va_TTStrDummy; Position:C15(";"; va_TTStrDummy)+1)
		
		tl_TTStrCas{$ii}:=Num:C11(va_TTStrDummy)
	End for 
	
End if 

READ WRITE:C146([TypesTables:11])
READ WRITE:C146([TAbles:12])

ALL RECORDS:C47([TypesTables:11])
ORDER BY:C49([TypesTables:11]; [TypesTables:11]TT_Libellé:4; >)

FORM SET INPUT:C55([TypesTables:11]; "TT_EcranSaisie")
FORM SET OUTPUT:C54([TypesTables:11]; "TT_Liste")

$vl_Fenetre:=i_FenêtreNo(632; 436; 4; "Liste des tables"; 1; "Quit_Simple")
MODIFY SELECTION:C204([TypesTables:11]; *)

CLOSE WINDOW:C154($vl_Fenetre)

UNLOAD RECORD:C212([TypesTables:11])
UNLOAD RECORD:C212([TAbles:12])

READ ONLY:C145([TypesTables:11])
READ ONLY:C145([TAbles:12])

<>PR_Tab:=0

If (vb_Show)
	Général_Show
End if 