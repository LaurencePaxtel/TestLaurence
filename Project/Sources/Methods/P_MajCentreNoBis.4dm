//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_MajCentreNoBis
//{
//{          Mardi 7 octobre 2008 à 12:13
//{          Modifié : Vendredi 24 octobre 2008 à 10:52
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($vt_Texte)
C_LONGINT:C283($ii)
ARRAY LONGINT:C221($tl_Réf; 0)
C_BOOLEAN:C305($vb_OK)

READ ONLY:C145([LesCentres:9])
READ ONLY:C145([ReferenceUnique:2])

vl_Nombre:=0
vl_NombrePP:=0
vl_NombrePG:=0
vl_Numéro:=0
vl_T_CentreCodeDebut:=<>vl_T_CentreCodeDebut
vl_T_CentreCodeFin:=<>vl_T_CentreCodeFin

$vb_OK:=(vl_T_CentreCodeDebut#0)
$vb_OK:=$vb_OK & (vl_T_CentreCodeFin#0)
$vb_OK:=$vb_OK & (Abs:C99(vl_T_CentreCodeFin)>Abs:C99(vl_T_CentreCodeDebut))
If ($vb_OK)
	$vb_OK:=False:C215
	QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=Table name:C256(->[LesCentres:9]))
	MultiSoc_Filter(->[ReferenceUnique:2])
	If (Records in selection:C76([ReferenceUnique:2])=1)
		vl_Numéro:=[ReferenceUnique:2]RU_Numero:3
	End if 
	vl_Nombre:=Records in table:C83([LesCentres:9])
	ALL RECORDS:C47([LesCentres:9])
	MultiSoc_Filter(->[LesCentres:9])
	ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1; <)
	vl_NombrePG:=[LesCentres:9]LC_RéférenceID:1
	
	$vt_Texte:="Les centres : "+<>va_CR
	$vt_Texte:=$vt_Texte+"   - Nombre de fiches :   "+String:C10(vl_Nombre)+<>va_CR
	$vt_Texte:=$vt_Texte+"   - N° le plus grand   :   "+String:C10(vl_NombrePG)+<>va_CR
	$vt_Texte:=$vt_Texte+"   - N° en cours         :   "+String:C10(vl_Numéro)+<>va_CR
	$vt_Texte:=$vt_Texte+"Voulez-vous tout renuméroter entre "+String:C10(vl_T_CentreCodeDebut)+" et "+String:C10(vl_T_CentreCodeFin)+" ?"
	CONFIRM:C162($vt_Texte)
	If (OK=1)
		$vt_Texte:=$vt_Texte+<>va_CR+"Nouvelle confirmation : êtes-vous sûr et certain ?"
		BEEP:C151
		CONFIRM:C162($vt_Texte)
		$vb_OK:=(OK=1)
	End if 
Else 
	ALERT:C41("Veuillez vérifier la valeur du code  du centre !")
End if 

If ($vb_OK)  //Nettoyage des tables 
	
	READ WRITE:C146([LesCentres:9])
	READ WRITE:C146([CentresLits:16])
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
	MultiSoc_Filter(->[CentresLits:16])
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
	CREATE SET:C116([CentresLits:16]; "$LaSel")
	DIFFERENCE:C122("$Tous"; "$LaSel"; "LeReste")
	If (Records in set:C195("LeReste")>0)
		USE SET:C118("LeReste")
		DELETE SELECTION:C66([CentresLits:16])
	End if 
	
	UNLOAD RECORD:C212([LesCentres:9])
	UNLOAD RECORD:C212([CentresLits:16])
	READ ONLY:C145([LesCentres:9])
	READ ONLY:C145([CentresLits:16])
	
	$vb_OK:=(Size of array:C274($tl_Réf)>0)
End if 

If ($vb_OK)  //Renumérotation
	i_Message("Numérotation en cours : ")
	READ WRITE:C146([LesCentres:9])
	READ WRITE:C146([CentresLits:16])
	READ WRITE:C146([HeberGement:5])
	READ WRITE:C146([Prolongation:38])
	MESSAGES ON:C181
	
	For ($ii; 1; Size of array:C274($tl_Réf))
		i_MessageSeul("Numérotation en cours : "+String:C10(Size of array:C274($tl_Réf))+"/"+String:C10($ii))
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=$tl_Réf{$ii})
		If (Records in selection:C76([LesCentres:9])=1)
			LOAD RECORD:C52([LesCentres:9])
			vl_Numéro:=(vl_T_CentreCodeDebut*-1)
			//Pour respecter l'unicité du n° de référence
			//La première passe de la numérotion se fait en négatif
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_LC_ID:61=[LesCentres:9]LC_RéférenceID:1)
			If (Records in selection:C76([HeberGement:5])>0)
				APPLY TO SELECTION:C70([HeberGement:5]; [HeberGement:5]HG_LC_ID:61:=vl_Numéro)
			End if 
			
			QUERY:C277([CentresLits:16]; [CentresLits:16]CL_LC_ID:2=[LesCentres:9]LC_RéférenceID:1)
			If (Records in selection:C76([CentresLits:16])>0)
				APPLY TO SELECTION:C70([CentresLits:16]; P_APPL_CentreNo)
			End if 
			
			QUERY:C277([Prolongation:38]; [Prolongation:38]PR_LC_ID:9=[LesCentres:9]LC_RéférenceID:1)
			If (Records in selection:C76([Prolongation:38])>0)
				APPLY TO SELECTION:C70([Prolongation:38]; [Prolongation:38]PR_LC_ID:9:=vl_Numéro)
			End if 
			[LesCentres:9]LC_RéférenceID:1:=vl_Numéro
			SAVE RECORD:C53([LesCentres:9])
			UNLOAD RECORD:C212([LesCentres:9])
			vl_T_CentreCodeDebut:=vl_T_CentreCodeDebut+1
		End if 
	End for 
	
	//Vérification des hébergements n'ayant pas Le Lien Réf Centre renuméroté
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_LC_ID:61>0)
	MultiSoc_Filter(->[HeberGement:5])
	If (Records in selection:C76([HeberGement:5])>0)
		ALERT:C41("[HéberGement] : "+String:C10(Records in selection:C76([HeberGement:5]))+" sans une bonne référence Centre."+<>va_CR+"Ces liens  vont être remis à zéro.")
		APPLY TO SELECTION:C70([HeberGement:5]; [HeberGement:5]HG_LC_ID:61:=0)
	End if 
	//Vérification des Disponibilités n'ayant pas Le Lien Réf Centre renuméroté  
	QUERY:C277([CentresLits:16]; [CentresLits:16]CL_LC_ID:2>0)
	MultiSoc_Filter(->[CentresLits:16])
	If (Records in selection:C76([CentresLits:16])>0)
		ALERT:C41("[CentresLits] ou Disponibilité : "+String:C10(Records in selection:C76([CentresLits:16]))+" sans une bonne référence Centre."+<>va_CR+"Ces dispobibilités vont être supprimées.")
		DELETE SELECTION:C66([CentresLits:16])
	End if 
	
	//Pour respecter l'unicité du n° de référence
	//La deuxième passe transforme en positif les numéros négatif
	i_MessageSeul("Numérotation en cours : "+"Phase 2                  ")
	ALL RECORDS:C47([LesCentres:9])
	MultiSoc_Filter(->[LesCentres:9])
	APPLY TO SELECTION:C70([LesCentres:9]; P_APPL_CentreNo1)
	ALL RECORDS:C47([CentresLits:16])
	MultiSoc_Filter(->[CentresLits:16])
	APPLY TO SELECTION:C70([CentresLits:16]; P_APPL_CentreNo2)
	ALL RECORDS:C47([HeberGement:5])
	MultiSoc_Filter(->[HeberGement:5])
	APPLY TO SELECTION:C70([HeberGement:5]; P_APPL_CentreNo3)
	ALL RECORDS:C47([Prolongation:38])
	MultiSoc_Filter(->[Prolongation:38])
	APPLY TO SELECTION:C70([Prolongation:38]; P_APPL_CentreNo4)
	
	//Synchronisation de la numérotation avec Table des références
	ALL RECORDS:C47([LesCentres:9])
	MultiSoc_Filter(->[LesCentres:9])
	ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1; <)
	vl_NombrePG:=[LesCentres:9]LC_RéférenceID:1  //Numéro à reporter
	
	UNLOAD RECORD:C212([LesCentres:9])
	UNLOAD RECORD:C212([CentresLits:16])
	UNLOAD RECORD:C212([HeberGement:5])
	UNLOAD RECORD:C212([Prolongation:38])
	
	MESSAGES OFF:C175
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
	
	vl_Nombre:=Records in table:C83([LesCentres:9])
	ALL RECORDS:C47([LesCentres:9])
	MultiSoc_Filter(->[LesCentres:9])
	ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1; <)
	vl_NombrePG:=[LesCentres:9]LC_RéférenceID:1
	ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1; >)
	vl_NombrePP:=[LesCentres:9]LC_RéférenceID:1
	
	$vt_Texte:="Les centres : "+String:C10(vl_Nombre)+"fiche(s)"+<>va_CR
	$vt_Texte:=$vt_Texte+"   - N° le plus petit    :   "+String:C10(vl_NombrePP)+<>va_CR
	$vt_Texte:=$vt_Texte+"   - N° le plus grand   :   "+String:C10(vl_NombrePG)+<>va_CR
	$vt_Texte:=$vt_Texte+"Mise à jour effectuée."
	ALERT:C41($vt_Texte)
End if 