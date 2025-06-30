//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : F_CentreNoModifier
//{
//{          Mercredi 6 octobre 2010 à 11:45
//{          Modifié : Vendredi 24 octobre 2008 à 10:52
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215
C_TEXT:C284($vt_Texte)
C_LONGINT:C283($ii; $vl_Dif)
ARRAY LONGINT:C221($tl_Réf; 0)
C_BOOLEAN:C305($vb_OK)

READ ONLY:C145([LesCentres:9])
READ ONLY:C145([ReferenceUnique:2])

vl_Nombre:=0
vl_NombrePP:=0
vl_NombrePG:=0
vl_Numéro:=0


vb_T_CentreCodeNew:=False:C215
ve_T_CentreCodeNew:=0
vl_T_CentreCodeNewDebut:=1
vl_T_CentreCodeNewFin:=999999

$vl_Fenetre:=i_FenêtreNo(466; 272; 16; "N° du centre"; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_CentreNoModifier")
vb_T_CentreCodeNew:=(OK=1)
CLOSE WINDOW:C154($vl_Fenetre)


$vb_OK:=False:C215
If (vb_T_CentreCodeNew)
	vb_T_CentreCodeNew:=False:C215
	$vt_Texte:="Voulez-vous tout renuméroter entre "+String:C10(vl_T_CentreCodeNewDebut)+" et "+String:C10(vl_T_CentreCodeNewFin)+" ?"
	CONFIRM:C162($vt_Texte)
	If (OK=1)
		$vt_Texte:=$vt_Texte+<>va_CR+"Nouvelle confirmation : êtes-vous sûr et certain ?"
		BEEP:C151
		CONFIRM:C162($vt_Texte)
		$vb_OK:=(OK=1)
	End if 
End if 


If ($vb_OK)  //Nettoyage des tables 
	i_Message("Vérification en cours : ")
	READ WRITE:C146([LesCentres:9])
	READ WRITE:C146([CentresLits:16])
	READ WRITE:C146([HeberGement:5])
	READ WRITE:C146([Prolongation:38])
	//Mise au propre de la table
	//Centres
	//Disponibilités
	//en supprimant lesz fiches ayant une référence à zéro ou négative
	QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1<=0)
	MultiSoc_Filter(->[LesCentres:9])
	If (Records in selection:C76([LesCentres:9])>0)
		DELETE SELECTION:C66([LesCentres:9])
	End if 
	QUERY:C277([CentresLits:16]; [CentresLits:16]CL_LC_ID:2<=0)
	MultiSoc_Filter(->[LesCentres:9])
	If (Records in selection:C76([CentresLits:16])>0)
		DELETE SELECTION:C66([CentresLits:16])
	End if 
	
	//SELECTION
	//Centres
	//Disponibilités
	//Suppression des fiches  Disponibilités orphelines
	ALL RECORDS:C47([LesCentres:9])
	MultiSoc_Filter(->[LesCentres:9])
	ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1; >)
	SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; $tl_Réf)
	
	
	ALL RECORDS:C47([CentresLits:16])
	MultiSoc_Filter(->[CentresLits:16])
	CREATE SET:C116([CentresLits:16]; "$Tous")
	
	
	
	QUERY WITH ARRAY:C644([CentresLits:16]CL_LC_ID:2; $tl_Réf)
	MultiSoc_Filter(->[CentresLits:16])
	CREATE SET:C116([CentresLits:16]; "$LaSel")
	DIFFERENCE:C122("$Tous"; "$LaSel"; "LeReste")
	If (Records in set:C195("LeReste")>0)
		USE SET:C118("LeReste")
		DELETE SELECTION:C66([CentresLits:16])
	End if 
	
	UNLOAD RECORD:C212([LesCentres:9])
	UNLOAD RECORD:C212([CentresLits:16])
	
	
	//1
	// 999 999
	//1 000 001
	//1 999 999
	
	//50 000 001
	//50 999 999
	If (ve_T_CentreCodeNew<<>ve_T_CentreCode)
		$vl_Dif:=-(<>vl_T_CentreCodeDebut-vl_T_CentreCodeNewDebut)
		
	Else 
		//ve_T_CentreCodeNew>◊ve_T_CentreCode
		$vl_Dif:=vl_T_CentreCodeNewDebut-<>vl_T_CentreCodeDebut
	End if 
	
	
	i_MessageSeul("Numérotation en cours : ")
	MESSAGES ON:C181
	QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1>=<>vl_T_CentreCodeDebut; *)
	QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_RéférenceID:1<=<>vl_T_CentreCodeFin)
	MultiSoc_Filter(->[LesCentres:9])
	If (Records in selection:C76([LesCentres:9])>0)
		
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1; >)
		SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; $tl_Réf)
		For ($ii; 1; Size of array:C274($tl_Réf))
			i_MessageSeul("Numérotation en cours : "+String:C10(Size of array:C274($tl_Réf))+"/"+String:C10($ii))
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=$tl_Réf{$ii})
			If (Records in selection:C76([LesCentres:9])=1)
				LOAD RECORD:C52([LesCentres:9])
				vl_Numéro:=[LesCentres:9]LC_RéférenceID:1+$vl_Dif
				If (vl_NombrePG=0)
					vl_NombrePG:=vl_Numéro
				Else 
					If (vl_Numéro>vl_NombrePG)
						vl_NombrePG:=vl_Numéro
					End if 
				End if 
				//Pour respecter l'unicité du n° de référence
				//La première passe de la numérotion se fait en négatif
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_LC_ID:61=[LesCentres:9]LC_RéférenceID:1)
				MultiSoc_Filter(->[HeberGement:5])
				If (Records in selection:C76([HeberGement:5])>0)
					APPLY TO SELECTION:C70([HeberGement:5]; [HeberGement:5]HG_LC_ID:61:=vl_Numéro)
				End if 
				
				QUERY:C277([CentresLits:16]; [CentresLits:16]CL_LC_ID:2=[LesCentres:9]LC_RéférenceID:1)
				MultiSoc_Filter(->[CentresLits:16])
				If (Records in selection:C76([CentresLits:16])>0)
					APPLY TO SELECTION:C70([CentresLits:16]; P_APPL_CentreNoModifier)
				End if 
				
				
				QUERY:C277([Prolongation:38]; [Prolongation:38]PR_LC_ID:9=[LesCentres:9]LC_RéférenceID:1)
				MultiSoc_Filter(->[Prolongation:38])
				If (Records in selection:C76([Prolongation:38])>0)
					APPLY TO SELECTION:C70([Prolongation:38]; [Prolongation:38]PR_LC_ID:9:=vl_Numéro)
				End if 
				[LesCentres:9]LC_RéférenceID:1:=vl_Numéro
				SAVE RECORD:C53([LesCentres:9])
				UNLOAD RECORD:C212([LesCentres:9])
			End if 
		End for 
		
	Else 
		vl_NombrePG:=0
	End if 
	
	
	vb_T_CentreCodeNew:=True:C214
	
	UNLOAD RECORD:C212([LesCentres:9])
	UNLOAD RECORD:C212([CentresLits:16])
	UNLOAD RECORD:C212([HeberGement:5])
	UNLOAD RECORD:C212([Prolongation:38])
	READ ONLY:C145([LesCentres:9])
	READ ONLY:C145([CentresLits:16])
	READ ONLY:C145([HeberGement:5])
	READ ONLY:C145([Prolongation:38])
	CLOSE WINDOW:C154
	READ WRITE:C146([ReferenceUnique:2])
	QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=Table name:C256(->[LesCentres:9]))
	MultiSoc_Filter(->[ReferenceUnique:2])
	If (i_NonVerrou(->[ReferenceUnique:2]))
		[ReferenceUnique:2]RU_Numero:3:=vl_NombrePG+1
		SAVE RECORD:C53([ReferenceUnique:2])
		UNLOAD RECORD:C212([ReferenceUnique:2])
	End if 
	READ ONLY:C145([ReferenceUnique:2])
	BEEP:C151
	BEEP:C151
	
	
End if 


$0:=vb_T_CentreCodeNew



