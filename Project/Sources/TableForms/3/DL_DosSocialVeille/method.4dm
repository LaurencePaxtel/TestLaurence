//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          FormuleFormat : [DiaLogues];"DL_MaraudeVeilleB"
//{
//{          Vendredi 3 mars 2006 à 15:09
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		
		
		[DiaLogues:3]DL_Date:2:=Current date:C33(*)
		[DiaLogues:3]DL_Date2:8:=[DiaLogues:3]DL_Date:2
		[DiaLogues:3]DL_LibelAutre:5:=""
		[DiaLogues:3]DL_Libellé:3:=""
		[DiaLogues:3]DL_LibelPlus:6:=""
		P_DosSocialVeilleFind
	: ($vl_EventFF=Sur double clic:K2:5)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		If ((vl_SourisX>7) & (vl_SourisX<758)) & ((vl_SourisY>144) & (vl_SourisY<497))
			If ([DossierSocial:25]DS_Référence:1>0)
				P_VarDS(-1)
				If (F_UnDossierTypeModifié(->[DossierSocial:25]; "DS_EcranSaisie"; "Fiche Dossier Social"; 0))
				End if 
			End if 
		End if 
End case 