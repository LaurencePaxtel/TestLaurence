//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementDécoupageSOMME
//{
//{          MARDI 19 janvier 2010 à 14:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($ii)
C_DATE:C307($vd_Date; $vd_Debut; $vd_Fin)
C_POINTER:C301(vp_Pointeur; vp_Pointeur2; vp_Pointeur3)

$vd_Date:=!00-00-00!
$vb_OK:=($1>1980)
$vb_OK:=$vb_OK & ($1<2080)

If ($vb_OK)
	$vd_Date:=Date:C102("01/01/"+String:C10(vl_Annee; "0000"))
	For ($ii; 1; 12)
		i_MessageSeul("Recherche : "+String:C10($ii; "00")+"/12")
		//••• La sélection du mois
		$vd_Debut:=Add to date:C393($vd_Date; 0; $ii-1; 0)
		$vd_Fin:=Add to date:C393($vd_Date; 0; $ii; -1)
		
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=$vd_Debut; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=$vd_Fin; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
		
		MultiSoc_Filter(->[HeberGement:5])
		
		//Centre 
		P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_LC_ID:61; ->tl_xCentre; ->te_xCentre)
		
		CREATE SET:C116([HeberGement:5]; "E_Perimetre")
		//•• Nuitées totales Nombre
		P_HébergementDécoupageAffecte(0; $ii; Records in selection:C76([HeberGement:5]))
		//•• Nuitées totales Fiches
		P_HébergementDécoupageAffecte(1; $ii; 0)
		
		//Etat civil  
		P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_EtatCivil:20; ->ta_CritEtCiv; ->te_CritEtCiv)
		
		
	End for 
End if 
