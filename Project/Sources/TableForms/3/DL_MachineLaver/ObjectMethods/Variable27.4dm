//{==================================================}
//{ LOGICIEL : Gestion de saisie des temps
//{ © DB Solutions
//{
//{          Script te_Semaine  
//{
//{          Dimanche 17 Novembre 1996 à 15:36:29
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (te_Semaine#0)
	If (vd_DateJour>!00-00-00!)
		te_Semaine{0}:=te_Semaine
		vd_DateRef:=Upg_DateSemaine(te_Semaine{te_Semaine}; Year of:C25(vd_DateJour))
		
		vd_DateJour:=vd_DateRef
		P_Planing_Charger(vd_DateJour; tl_LesObjets_ID{ta_LesObjets}; 1)
	Else 
		ALERT:C41("Veuillez indiquer l'année !")
	End if 
Else 
	te_Semaine:=te_Semaine{0}
End if 