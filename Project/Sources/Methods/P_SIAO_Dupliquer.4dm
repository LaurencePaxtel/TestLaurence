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
		Case of 
			: ([SIAO:50]Si_Fermeture:46>!00-00-00!)
				$vb_OK:=i_Confirmer("Voulez-vous dupliquer le dossier : "+[SIAO:50]Si_Demande_Numero:3+" du demandeur "+[SIAO:50]Si_Demandeur:20+" ?")
				$ii:=3
			: ([SIAO:50]Si_DemandeAnnulee:29)
				$vb_OK:=i_Confirmer("Voulez-vous dupliquer le dossier : "+[SIAO:50]Si_Demande_Numero:3+" du demandeur "+[SIAO:50]Si_Demandeur:20+" ?")
				$ii:=2
			Else 
				$vb_OK:=i_Confirmer("Voulez-vous dupliquer le dossier : "+[SIAO:50]Si_Demande_Numero:3+" du demandeur "+[SIAO:50]Si_Demandeur:20+" ?")
				If ($vb_OK)
					If (i_Confirmer("Voulez-vous fermer le dossier d'origine : "+[SIAO:50]Si_Demande_Numero:3+" du demandeur "+[SIAO:50]Si_Demandeur:20+" ?"))
						$ii:=1
					Else 
						$ii:=0
					End if 
				End if 
		End case 
		If ($vb_OK)
			vl_SIAO_RefAttestation:=[SIAO:50]Si_RéférenceID:1
			Process_Go10(-><>PR_SIAOFiche; "Go_SIAOFiche"; "SIAO fiche"; 128; [SIAO:50]Si_RéférenceID:1; "D"; $ii; 0; "")
			
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