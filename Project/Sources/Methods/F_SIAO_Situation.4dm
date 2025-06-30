//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Fonction : F_SIAO_Situation
//{          Vendrdi 11 février 2011 à 11:12:25
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
C_LONGINT:C283($1)  //Cas (non utilisé pour le momment à 1
C_LONGINT:C283($2)  //Ref SIAO Personne
C_LONGINT:C283($3)  //Ref SIAO 
C_TEXT:C284($4)  //$va_Theme
C_TEXT:C284($5)  //$va_SousTheme
C_LONGINT:C283($6)  //Indice de départ
C_LONGINT:C283($7)  //Indice d'arrivée (nombre)




C_LONGINT:C283($ii)

For ($ii; $6; $7)
	QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=$2; *)
	QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_ID:2=$3; *)
	QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=$4; *)
	QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6=$5; *)
	QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Rang:7=$ii)
	If (Records in selection:C76([SIAO_Situations:52])=0)
		READ WRITE:C146([SIAO_Situations:52])
		CREATE RECORD:C68([SIAO_Situations:52])
		MultiSoc_Init_Structure(->[SIAO_Situations:52])
		[SIAO_Situations:52]Ss_RéférenceID:1:=Uut_Numerote(->[SIAO_Situations:52])
		[SIAO_Situations:52]Ss_SIAO_ID:2:=$3
		[SIAO_Situations:52]Ss_SIAO_Personne_ID:3:=$2
		[SIAO_Situations:52]Ss_Famille:4:=""
		[SIAO_Situations:52]Ss_Theme:5:=$4
		[SIAO_Situations:52]Ss_SousTheme:6:=$5
		[SIAO_Situations:52]Ss_Rang:7:=$ii
		[SIAO_Situations:52]Ss_Intitule:9:=""
		[SIAO_Situations:52]Ss_Commentaire:22:=""
		[SIAO_Situations:52]Ss_Note:30:=""
		SAVE RECORD:C53([SIAO_Situations:52])
		UNLOAD RECORD:C212([SIAO_Situations:52])
		READ ONLY:C145([SIAO_Situations:52])
	End if 
End for 
QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=$2; *)
QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_ID:2=$3; *)
QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=$4; *)
QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6=$5; *)
QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Rang:7>$7)
If (Records in selection:C76([SIAO_Situations:52])>0)
	READ WRITE:C146([SIAO_Situations:52])
	DELETE SELECTION:C66([SIAO_Situations:52])
	READ ONLY:C145([SIAO_Situations:52])
End if 