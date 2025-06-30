//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          FormuleFormat : [DiaLogues];"DL_MaraudeVeilleB"
//{
//{          Vendredi 1 juillet 2004 à 11:04
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		
		C_TIME:C306($vh_HeureC)
		[DiaLogues:3]DL_Date:2:=Current date:C33(*)
		[DiaLogues:3]DL_Date2:8:=[DiaLogues:3]DL_Date:2
		[DiaLogues:3]DL_LibelAutre:5:=""
		[DiaLogues:3]DL_Libellé:3:=""
		[DiaLogues:3]DL_LibelPlus:6:=""
		rJourNuit1:=1
		rJourNuit2:=1
		$vh_HeureC:=Current time:C178
		rJourNuit1:=Num:C11(($vh_HeureC>=?08:00:00?) & ($vh_HeureC<=?19:59:59?))  //Jour
		rJourNuit2:=Num:C11(rJourNuit1=0)  //Nuit
		P_MaraudeVeilleFind
	: ($vl_EventFF=Sur double clic:K2:5)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		If ((vl_SourisX>7) & (vl_SourisX<758)) & ((vl_SourisY>144) & (vl_SourisY<497))
			If ([Maraude:24]MR_RéférenceID:1>0)
				p_VarMR(-1)
				If (F_UnDossierTypeModifié(->[Maraude:24]; "MR_EcranSaisie"; "Fiche Dossier EMA"; 1))
				End if 
			End if 
		End if 
End case 