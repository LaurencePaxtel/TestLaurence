//%attributes = {}
C_BOOLEAN:C305($0)  //On y passe ou pas
C_BOOLEAN:C305($1)  //Click sur le bouton NOUVEL HEBERGEMENT groupe

// C_BOOLEAN($vb_OK)
C_LONGINT:C283($ii)

// $vb_OK:=False

If ($1)
	If ([GrouPe:36]GP_ReferenceID:1>0)
		
		vb_ResGroupe:=False:C215
		vb_ResMulti:=False:C215
		
		vl_NbBoucleVrai:=0
		//Réservation de groupe
		vl_NbBoucle:=0
		P_Tab_GP(10; 0)
		For ($ii; 1; Size of array:C274(<>ta_GpClé))
			If (<>te_GpCheck{$ii}=1) & (<>te_GpEtat{$ii}=0)
				vl_NbBoucle:=vl_NbBoucle+1
			End if 
		End for 
		If (vl_NbBoucle>0)
			vl_NbBoucleVrai:=vl_NbBoucle
			vl_NbBoucle:=Size of array:C274(<>ta_GpClé)
			vb_ResGroupe:=True:C214
			vb_PasseR:=True:C214
		Else 
			vb_PasseR:=False:C215
			StrAlerte(29; "")
		End if 
	Else 
		ALERT:C41("Veuillez sélectionner un groupe !")
	End if 
Else 
	vb_PasseR:=False:C215
End if 

$0:=vb_PasseR

