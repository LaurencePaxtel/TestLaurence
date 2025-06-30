//%attributes = {}
C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($ii)
$vb_OK:=False:C215
$ii:=0
If (vl_SIAO_RefAttestation>0)
	CREATE SET:C116([SIAO:50]; "E_SIAO")
	QUERY:C277([SIAO:50]; [SIAO:50]Si_RéférenceID:1=vl_SIAO_RefAttestation)
	MultiSoc_Filter(->[SIAO:50])
	If (Records in selection:C76([SIAO:50])=1)
		$vb_OK:=i_Confirmer("Voulez-vous supprimer le dossier : "+[SIAO:50]Si_Demande_Numero:3+" du demandeur "+[SIAO:50]Si_Demandeur:20+" ?")
		
		
		If ($vb_OK)
			vl_SIAO_RefAttestation:=[SIAO:50]Si_RéférenceID:1
			$vb_OK:=F_SIAO_FicheSupprimer(vl_SIAO_RefAttestation)
		End if 
	Else 
		ALERT:C41("Aucun dossier trouvé !")
	End if 
	USE SET:C118("E_SIAO")
	CLEAR SET:C117("E_SIAO")
	vL_NbFiches:=Records in selection:C76([SIAO:50])
	If (vL_NbFiches>0)
		P_SIAO_Sort(2)
	Else 
		vl_SIAO_RefAttestation:=0
	End if 
Else 
	ALERT:C41("Vous devez sélectionner un dossier.")
End if 
