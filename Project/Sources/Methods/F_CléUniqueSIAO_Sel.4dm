//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : F_CléUniqueSIAO_Sel
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215

C_LONGINT:C283($1)
C_POINTER:C301($2)
C_BOOLEAN:C305($3)
C_BOOLEAN:C305($4)
C_LONGINT:C283($5)
C_POINTER:C301($6)  //Type
C_BOOLEAN:C305(vb_EtatCivil)
vb_EtatCivil:=($5=1)


If (<>PR_CleUnique_ID=0)
Else 
End if 


C_BOOLEAN:C305(vb_Sel_CleUnique)
C_BOOLEAN:C305(vb_Sel_CleNew)
C_LONGINT:C283(vl_Sel_CleUnique; vL_Nb_HG_F; vl_NbHGi; vL_Nb_SI_F; vl_NbHGs; ve_NbSP)



vb_Sel_CleUnique:=False:C215
vb_Sel_CleNew:=False:C215
C_LONGINT:C283($vl_Fenetre)
READ WRITE:C146([DePart:1])
FORM SET INPUT:C55([DePart:1]; "DL_CleUniqueSIAOSans")
If (7=7)
	$vl_Fenetre:=i_FenêtreNo(498+7+30; 460; 4; "Demandeurs"; 3; "Quit_Simple")
Else 
	$vl_Fenetre:=i_FenêtreNo(498+7; 673+7; 4; "Demandeurs"; 3; "Quit_Simple")
End if 
ADD RECORD:C56([DePart:1]; *)  //lpc 08122017 ascenceur
UNLOAD RECORD:C212([DePart:1])
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DePart:1])

If (vb_Sel_CleUnique)
	$0:=True:C214
	$2->:=vl_Sel_CleUnique
	If (vb_Sel_CleNew)
		$6->:=vl_Sel_CleUnique
	Else 
		$6->:=0
	End if 
End if 