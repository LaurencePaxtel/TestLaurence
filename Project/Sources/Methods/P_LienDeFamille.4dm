//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP :© DBsolutions
//{          Méthode :  b_DossierSIAO
//{          Vendredi 13 janvier 2012 à 12:20:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}


C_LONGINT:C283($vl_Fenetre)

C_LONGINT:C283(vl_LDF_ID; vl_LDF_Indice; vl_LDF_Taille)
C_TEXT:C284(va_LDF_Lien; va_LDF_LienTrans; va_LDF_Temp; va_LDF_Type; va_LDF_Cas)
C_TIME:C306(vh_LDF_DebutRenum; vh_LDF_FinRenum; vh_LDF_DebutChef; vh_LDF_FinChef; vh_LDF_DebutNonChef; vh_LDF_FinNonChef; vh_LDF_DebutCas; vh_LDF_FinCas; vh_LDF_DebutDos; vh_LDF_FinDos)
C_TIME:C306(vh_LDF_DureRenum; vh_LDF_DureChef; vh_LDF_DureNonChef; vh_LDF_DureCas; vh_LDF_DureDos)
vh_LDF_DebutRenum:=?00:00:00?
vh_LDF_FinRenum:=vh_LDF_DebutRenum
vh_LDF_DebutChef:=vh_LDF_DebutRenum
vh_LDF_FinChef:=vh_LDF_DebutRenum
vh_LDF_DebutNonChef:=vh_LDF_DebutRenum
vh_LDF_FinNonChef:=vh_LDF_DebutRenum
vh_LDF_DebutCas:=vh_LDF_DebutRenum
vh_LDF_FinCas:=vh_LDF_DebutRenum
vh_LDF_DebutDos:=vh_LDF_DebutRenum
vh_LDF_FinDos:=vh_LDF_DebutRenum

vh_LDF_DureRenum:=vh_LDF_DebutRenum
vh_LDF_DureChef:=vh_LDF_DebutRenum
vh_LDF_DureNonChef:=vh_LDF_DebutRenum
vh_LDF_DureCas:=vh_LDF_DebutRenum
vh_LDF_DureDos:=vh_LDF_DebutRenum

If (Records in selection:C76([HeberGement:5])>0)
	//$vl_Fenetre:=i_FenêtreNo (466;277;5;"Données des dossiers SIAO";2;"")
	$vl_Fenetre:=i_FenêtreNo(466; 327; 5; "Données des dossiers SIAO"; 2; "")
	DIALOG:C40([DiaLogues:3]; "DL_RecHGDossierSIAO")
	CLOSE WINDOW:C154($vl_Fenetre)
Else 
	ALERT:C41("Aucune fiche à traiter.")
End if 