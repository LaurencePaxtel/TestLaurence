//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_GPMod
//{
//{          Vendredi 27 février 2004 à 11:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($vl_Fenetre)

If (Form event code:C388=Sur clic:K2:4)
	LOAD RECORD:C52([GrouPe:36])
	
	If ([GrouPe:36]GP_ReferenceID:1>0)
		READ WRITE:C146([GrouPe:36])
		
		If (i_NonVerrou(->[GrouPe:36]))
			FORM SET INPUT:C55([GrouPe:36]; "GP_EcranSaisie")
			
			$vl_Fenetre:=i_FenêtreNo(519; 248; 4; "Groupe : modifier"; 4; "")
			MODIFY RECORD:C57([GrouPe:36]; *)
			
			CLOSE WINDOW:C154($vl_Fenetre)
			UNLOAD RECORD:C212([GrouPe:36])
		End if 
		
		READ ONLY:C145([GrouPe:36])
	Else 
		ALERT:C41("Veuillez sélectionner un groupe !")
	End if 
	
End if 