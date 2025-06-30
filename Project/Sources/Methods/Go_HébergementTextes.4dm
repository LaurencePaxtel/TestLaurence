//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_HébergementTextes
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)
C_POINTER:C301($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)


C_TEXT:C284(va_Appel)
va_Appel:=$1

SET MENU BAR:C67(1)
READ ONLY:C145(*)

READ WRITE:C146([DePart:1])
QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$3)
MultiSoc_Filter(->[DePart:1])
If (Records in selection:C76([DePart:1])>1)
	
	DELETE SELECTION:C66([DePart:1])
End if 

QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$3)
MultiSoc_Filter(->[DePart:1])

If (Records in selection:C76([DePart:1])=0)
	READ WRITE:C146([DePart:1])
	CREATE RECORD:C68([DePart:1])
	MultiSoc_Init_Structure(->[DePart:1])
	[DePart:1]DP_ReferenceID:1:=$3
	Case of 
		: ($3=-1)
			[DePart:1]DP_Libelle:6:="Texte fax"
		: ($3=-13)
			[DePart:1]DP_Libelle:6:="Texte fax hôtel"
	End case 
	SAVE RECORD:C53([DePart:1])
	UNLOAD RECORD:C212([DePart:1])
	READ ONLY:C145([DePart:1])
End if 

READ WRITE:C146([DePart:1])
QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$3)
MultiSoc_Filter(->[DePart:1])
If (Records in selection:C76([DePart:1])=1)
	LOAD RECORD:C52([DePart:1])
	If (Not:C34(Locked:C147([DePart:1])))
		FORM SET INPUT:C55([DePart:1]; "DP_HébergementTexte")
		C_LONGINT:C283($vl_Fenetre)
		$vl_Fenetre:=i_FenêtreNo(492; 515; 4; $4; 4; "Quit_Valider")
		MODIFY RECORD:C57([DePart:1]; *)
		UNLOAD RECORD:C212([DePart:1])
		CLOSE WINDOW:C154
	Else 
		ALERT:C41("La fiche '"+$4+"' est momentanément inaccessible.")
	End if 
End if 

UNLOAD RECORD:C212([DePart:1])
READ ONLY:C145([DePart:1])

$2->:=0