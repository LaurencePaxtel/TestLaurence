//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uAgeDéfaut
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
READ ONLY:C145(*)
SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 
C_LONGINT:C283(ve_AgeH; ve_AgeF; ve_AgeHNew; ve_AgeFNew)
C_TEXT:C284(va_NoFiche)
C_LONGINT:C283(ve_NbUSers)
ve_NbUSers:=Count users:C342
If (ve_NbUSers>1)
	ALERT:C41("Il y a "+String:C10(ve_NbUSers-1)+" utilisateurs connectés !"+Char:C90(13)+"Veuillez demander aux autres utilisateurs de se déconnecter.")
Else 
	i_Message("Chargement en cours…")
	ve_AgeH:=0
	ve_AgeF:=0
	ve_AgeHNew:=0
	ve_AgeFNew:=0
	//◊ve_ageHom:=45
	//◊ve_ageFem:=40
	TRACE:C157
	QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubFichier:3=-1)
	MultiSoc_Filter(->[LesRubriques:21])
	If (Records in selection:C76([LesRubriques:21])=1)
		ve_AgeH:=[LesRubriques:21]NuméroTri:1
		ve_AgeF:=[LesRubriques:21]RubNuméro:4
	Else 
		If (Records in selection:C76([LesRubriques:21])=0)
		Else 
			READ WRITE:C146([LesRubriques:21])
			DELETE SELECTION:C66([LesRubriques:21])
			READ ONLY:C145([LesRubriques:21])
		End if 
		READ WRITE:C146([LesRubriques:21])
		CREATE RECORD:C68([LesRubriques:21])
		MultiSoc_Init_Structure(->[LesRubriques:21])
		[LesRubriques:21]RubFichier:3:=-1
		[LesRubriques:21]RubNom:2:="Ages des inconnus : NuméroTri = Hommes; RubNuméro = femmes"
		[LesRubriques:21]NuméroTri:1:=<>ve_ageHom
		[LesRubriques:21]RubNuméro:4:=<>ve_ageFem
		SAVE RECORD:C53([LesRubriques:21])
		UNLOAD RECORD:C212([LesRubriques:21])
		READ ONLY:C145([LesRubriques:21])
		ve_AgeH:=<>ve_ageHom
		ve_AgeF:=<>ve_ageFem
	End if 
	CLOSE WINDOW:C154
	
	READ WRITE:C146([DePart:1])
	QUERY:C277([DePart:1]; [DePart:1]DP_Param:3=True:C214)
	MultiSoc_Filter(->[DePart:1])
	If (Records in selection:C76([DePart:1])=1)
		LOAD RECORD:C52([DePart:1])
		If (Not:C34(Locked:C147([DePart:1])))
			FORM SET INPUT:C55([DePart:1]; "DP_AgeDéfaut")
			$vl_Fenetre:=i_FenêtreNo(352; 296; 5; "Modification des ages par défaut des inconnus"; 4; "")
			MODIFY RECORD:C57([DePart:1]; *)
			UNLOAD RECORD:C212([DePart:1])
			
			CLOSE WINDOW:C154($vl_Fenetre)
		Else 
			ALERT:C41("Fiche non accessible !")
		End if 
		UNLOAD RECORD:C212([DePart:1])
		READ ONLY:C145([DePart:1])
	End if 
End if 
<>PR_AgeDéfaut:=0
If (vb_Show)
	Général_Show
End if 