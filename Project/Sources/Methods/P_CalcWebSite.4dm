//%attributes = {}
//Les paramètres obligatoires
C_BOOLEAN:C305($vb_OK)

$vb_OK:=(vt_ws_Répertoire>"")
If ($vb_OK)
	If (Test path name:C476(vt_ws_Répertoire)=Est un dossier:K24:2)
		$vb_OK:=(va_ws_NomDocument>"")
		If ($vb_OK)
			$vb_OK:=(Num:C11(va_ws_Heures)>0)
			If ($vb_OK)
			Else 
				ALERT:C41("Aucune heure n'est retenue !")
				$vb_OK:=False:C215
			End if 
		Else 
			ALERT:C41("Le nom du documment n'est pas renseigné !")
			$vb_OK:=False:C215
		End if 
	Else 
		ALERT:C41("Le repertoire n'existe pas ou n'est pas à l'adresse indiqué !")
		$vb_OK:=False:C215
	End if 
Else 
	ALERT:C41("Le chemin n'est pas renseigné !")
	$vb_OK:=False:C215
End if 

If ($vb_OK)
	//DATE et HEURE courante
	vd_ws_Date:=Current date:C33
	vh_ws_DateHeure:=Current time:C178
	If (vb_SurServeur)
		P_ServeurDateHeure(->vd_ws_Date; ->vh_ws_DateHeure)
	End if 
	vd_Date1:=vd_ws_Date
	vh_Heure1:=vh_ws_DateHeure
	
	//vd_Date1:=!09/03/09!
	
	$vb_OK:=False:C215
	
	vl_HeureNo:=vh_Heure1\3600
	If (vb_ws_LancerFirst=True:C214)
		$vb_OK:=True:C214
	Else 
		vl_MinuteNo:=((vh_Heure1\60)%60)
		If (va_ws_Heures[[vl_HeureNo]]="1")
			If (vl_HeureLast#vl_HeureNo)
				$vb_OK:=True:C214
			Else 
				If (Num:C11(va_ws_Heures)=1)
					$vb_OK:=True:C214
				End if 
			End if 
		End if 
	End if 
	
	
	If ($vb_OK)
		va_ws_Message:="Calcul en cours…"
		OBJECT SET ENABLED:C1123(b_Ann; False:C215)
		P_TauxPresentation(1; 0)
		vl_HeureLast:=vl_HeureNo
		OBJECT SET ENABLED:C1123(b_Ann; True:C214)
	End if 
	
	If (7=7)
		vd_ws_Date:=Current date:C33
		vh_ws_DateHeure:=Current time:C178
		If (vb_SurServeur)
			P_ServeurDateHeure(->vd_ws_Date; ->vh_ws_DateHeure)
		End if 
		vd_Date1:=vd_ws_Date
		vh_Heure1:=vh_ws_DateHeure
	End if 
	
	P_ws_ProchainCalcul(vd_Date1; vh_Heure1)
	
	vb_ws_LancerFirst:=False:C215
	
End if 






//**********
//Avant le 15/9/2009
//*************
If (7=8)
	
	C_BOOLEAN:C305($vb_OK)
	$vb_OK:=(vt_ws_Répertoire>"")
	If ($vb_OK)
		If (Test path name:C476(vt_ws_Répertoire)=Est un dossier:K24:2)
			$vb_OK:=(va_ws_NomDocument>"")
			If ($vb_OK)
				$vb_OK:=(vh_ws_Période>?00:01:00?)
				If ($vb_OK)
					
				Else 
					ALERT:C41("La périodicité ne doit pas être inférieur au quart d'heure !")
					$vb_OK:=False:C215
				End if 
			Else 
				ALERT:C41("Le nom du documment n'est pas renseigné !")
				$vb_OK:=False:C215
			End if 
		Else 
			ALERT:C41("Le repertoire n'existe pas ou n'est pas à l'adresse indiqué !")
			$vb_OK:=False:C215
		End if 
	Else 
		ALERT:C41("Le chemin n'est pas renseigné !")
		$vb_OK:=False:C215
	End if 
	
	
	
	If ($vb_OK)
		
		vd_ws_Date:=Current date:C33
		vh_ws_DateHeure:=Current time:C178
		If (vb_SurServeur)
			P_ServeurDateHeure(->vd_ws_Date; ->vh_ws_DateHeure)
		End if 
		
		If (7=8)
			If (vd_ws_Date=!00-00-00!)
				vd_ws_Date:=Current date:C33
				vh_ws_DateHeure:=Current time:C178
				If (vb_SurServeur)
					P_ServeurDateHeure(->vd_ws_Date; ->vh_ws_DateHeure)
				End if 
			End if 
		End if 
		
		vd_Date1:=vd_ws_Date
		vh_Heure1:=vh_ws_DateHeure
		va_ws_Message:="Calculs en cours…"
		OBJECT SET ENABLED:C1123(b_Ann; False:C215)
		// vd_Date1:=!09/03/09!
		P_TauxPresentation(1; 0)
		
		OBJECT SET ENABLED:C1123(b_Ann; True:C214)
		
		vd_ws_Date:=Current date:C33
		vh_ws_DateHeure:=Current time:C178
		If (vb_SurServeur)
			P_ServeurDateHeure(->vd_ws_Date; ->vh_ws_DateHeure)
		End if 
		
		vd_Date1:=vd_ws_Date
		vh_Heure1:=vh_ws_DateHeure
		va_ws_Message:="Prochains calculs le "+String:C10(vd_ws_Date)+" à "+String:C10(Current time:C178+vh_ws_Période)
		
		vb_ws_LancerFirst:=False:C215
	End if 
End if 