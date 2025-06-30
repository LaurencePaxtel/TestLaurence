//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementGPClic
//{
//{          Mardi 9 mars 2004 à 10:20
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)  //1=Un click; 2=Double Clic

C_LONGINT:C283($vl_Fenetre)

If ($2=1)  //Un click
	
	If ($1>0)
		P_Tab_GP(4; 0)
	Else 
		P_Tab_GP(0; 0)
	End if 
	
Else 
	
	If (Macintosh control down:C544) | (Windows Ctrl down:C562)
		
		If ($1>0)
			READ WRITE:C146([GrouPe:36])
			
			If (i_NonVerrou(->[GrouPe:36]))
				FORM SET INPUT:C55([GrouPe:36]; "GP_EcranSaisie")
				
				$vl_Fenetre:=i_FenêtreNo(519; 248; 4; "Groupe : modifier"; 4; "")
				MODIFY RECORD:C57([GrouPe:36]; *)
				
				CLOSE WINDOW:C154($vl_Fenetre)
				
				UNLOAD RECORD:C212([GrouPe:36])
			End if 
			
			READ ONLY:C145([GrouPe:36])
		End if 
		
	End if 
	
End if 