//%attributes = {}
//{==================================================}
//{ LOGICIEL : DBsolutions matrice	
//{ © DBsolutions/Paxtel
//{          Procédure : i_DateServeurPoste
//{
//{          Vendredi 7 novembre 2008 à 15:53:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($1)

// Analyse des dates et heures
If ($1)
	vd_DateServeur:=Current date:C33(*)
	vd_HeureServeur:=Current time:C178(*)
	vd_DateRéelle:=vd_DateServeur
	vd_HeureRéelle:=vd_HeureServeur+(8*3600)
	
	If (vd_HeureRéelle>?23:59:59?)
		vd_DateRéelle:=vd_DateRéelle+1
		vd_HeureRéelle:=vd_HeureRéelle-(24*3600)
	End if 
	
Else 
	vd_DateRéelle:=Current date:C33
	vd_HeureRéelle:=Current time:C178
	vd_DateServeur:=vd_DateRéelle
	vd_HeureServeur:=vd_HeureRéelle-(8*3600)
	
	If (vd_HeureServeur<?00:00:00?)
		vd_DateServeur:=vd_DateServeur-1
		vd_HeureServeur:=(24*3600)+vd_HeureServeur
	End if 
	
End if 