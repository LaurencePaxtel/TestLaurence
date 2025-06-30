//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_Maj_SIAOCodeSite
//{          Jeudi 24 février 2011 à 17:153
//{          Modifié : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($ii)
$ii:=Records in table:C83([SIAO:50])
If ($ii>0)
	If (i_Confirmer("Mise à jour du code site dans le n° SIAO : "+String:C10($ii)+" dossier"+("s"*Num:C11($ii>1))+" à traiter."))
		MESSAGES ON:C181
		READ WRITE:C146([SIAO:50])
		ALL RECORDS:C47([SIAO:50])
		MultiSoc_Filter(->[SIAO:50])
		APPLY TO SELECTION:C70([SIAO:50]; [SIAO:50]Si_Demande_Numero:3:=F_Site([SOciete:18]SO_Site:8)+Substring:C12([SIAO:50]Si_Demande_Numero:3; 4))
		
		READ ONLY:C145([SIAO:50])
		MESSAGES OFF:C175
	End if 
Else 
	ALERT:C41("Il n'existe aucun dossier SIAO !")
End if 