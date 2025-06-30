//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_StatDASS
//{
//{          Lundi 17 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 

READ ONLY:C145(*)
If (7=7)
	i_Message("Chargement en cours …")
	
	//DDASS : avant le 26/1/2009
	//V_Stat_Etude (0)
	//TABLEAU ALPHA(45;ta_Page;5)
	//ta_Page{1}:="Demandeur"
	//ta_Page{2}:="Centres d'hébergement"
	//ta_Page{3}:="Orientation"
	//ta_Page{4}:="Prestations"
	//ta_Page{5}:="Rapport"
	//ta_Page:=1
	//Fin DDASS : avant le 26/1/2009
	
	V_Stat_CHRS(0)
	
	ARRAY TEXT:C222(ta_xGroupe; 0)
	COPY ARRAY:C226(<>ta_FMGrp; ta_xGroupe)
	INSERT IN ARRAY:C227(ta_xGroupe; 1; 1)
	ta_xGroupe{1}:="115"
	ARRAY INTEGER:C220(te_xGroupe; Size of array:C274(ta_xGroupe))
	For ($ii; 1; Size of array:C274(ta_xGroupe))
		If (Substring:C12(ta_xGroupe{$ii}; 1; 2)="40")
			te_xGroupe{$ii}:=0
		Else 
			te_xGroupe{$ii}:=1
		End if 
	End for 
	$TailleTab:=Size of array:C274(ta_xGroupe)
	ARRAY LONGINT:C221(tl_xGroupe; $TailleTab)
	C_LONGINT:C283(vl_xGroupe)
	
	
	ARRAY TEXT:C222(ta_Page; 5)
	ta_Page{1}:="Demandeur"
	ta_Page{2}:="Centres d'hébergement"
	ta_Page{3}:="Prestations"
	ta_Page{4}:="Signalement et Identité"
	ta_Page{5}:="Rapport"
	ta_Page:=1
	
	CLOSE WINDOW:C154
	
	
	READ WRITE:C146([DiaLogues:3])
	//FORMULAIRE ENTREE([DiaLogues];"DL_StatDASS")
	//va_Titre:="Statistiques : DDASS"
	//$vl_Fenetre:=i_FenêtreNo (632;436;4;va_Titre;1;"Quit_StatDASS")
	
	FORM SET INPUT:C55([DiaLogues:3]; "DL_StatCHRS")
	va_Titre:="Statistiques : Taux Occupation"  //26/1/2009
	//  $vl_Fenetre:=i_FenêtreNo (752;436;4;va_Titre;1;"Quit_StatDASS")
	C_LONGINT:C283($vl_Fenetre)
	$vl_Fenetre:=i_FenêtreNo(752; 608; 4; va_Titre; 1; "Quit_StatDASS")
	
	ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
	CLOSE WINDOW:C154($vl_Fenetre)
	READ ONLY:C145([DiaLogues:3])
Else 
	ALERT:C41("Développement en cours…")
End if 
<>PR_StatC:=0
If (vb_Show)
	Général_Show
End if 