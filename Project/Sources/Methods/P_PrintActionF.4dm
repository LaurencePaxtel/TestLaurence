//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_PrintActionf
//{
//{          Mardi 15 juin 2004 à 15:24:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

C_LONGINT:C283($vl_ii)
C_BOOLEAN:C305($vb_OK)

ve_NoPage:=0

If (User in group:C338(Current user:C182; <>Groupe_Actions))
	
	// Modifié par : Scanu Rémy (09/11/2022)
	// Correction bug impression sur nouvel enregistrement, fait perdre la sélection
	If (Is new record:C668([HeberGement:5])=False:C215)
		LOAD RECORD:C52([HeberGement:5])  // #BS 23/06/16 Migration v15
	End if 
	
	If ([HeberGement:5]HG_ReferenceID:1>0)
		$vb_OK:=True:C214
	Else 
		StrAlerte(5; "")
	End if 
	
Else 
	StrAlerte(6; "'Imprimer Actions F'")
End if 

If ($vb_OK)
	
	If ($1=1)  // Bouton dans saisie Ecran
		va_NomClé:=Uut_HébergéClé(->[HeberGement:5]HG_Nom:21; ->[HeberGement:5]HG_Prénom:22; ->[HeberGement:5]HG_DateNéLe:24)
		va_Rép:=""
		
		If ([HeberGement:5]HG_NuitenCours:92>1)
			va_Rép:=String:C10([HeberGement:5]HG_NuitenCours:92)+"/"+String:C10([HeberGement:5]HG_NuitTOTAL:93)
		End if 
		
		vh_Htr:=Current time:C178
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
		MultiSoc_Filter(->[HeBerge:4])
		
		If (Records in selection:C76([HeBerge:4])=1)
			vt_Action:=[HeBerge:4]HB_ActionsF:49
		Else 
			vt_Action:=""
		End if 
		
		_O_PAGE SETUP:C299([HeberGement:5]; "HG_PrtActionAF")
		PRINT SETTINGS:C106
		
		If (OK=1)
			FORM SET OUTPUT:C54([HeberGement:5]; "HG_PrtActionAF")
			PRINT RECORD:C71([HeberGement:5]; *)
		End if 
		
	Else   // Depuis la lite de veille
		$vl_ii:=[HeberGement:5]HG_ReferenceID:1
		<>vl_RéfU_HBV:=[HeberGement:5]HG_HB_ID:19
		
		CREATE SET:C116([HeberGement:5]; "$E_HGt")
		
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=$vl_ii)
		MultiSoc_Filter(->[HeberGement:5])
		
		If (Records in selection:C76([HeberGement:5])=1)
			va_NomClé:=Uut_HébergéClé(->[HeberGement:5]HG_Nom:21; ->[HeberGement:5]HG_Prénom:22; ->[HeberGement:5]HG_DateNéLe:24)
			va_Rép:=""
			
			If ([HeberGement:5]HG_NuitenCours:92>1)
				va_Rép:=String:C10([HeberGement:5]HG_NuitenCours:92)+"/"+String:C10([HeberGement:5]HG_NuitTOTAL:93)
			End if 
			
			vh_Htr:=?00:00:00?
			vh_Htr:=Current time:C178
			
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
			
			If (Records in selection:C76([HeBerge:4])=1)
				vt_Action:=[HeBerge:4]HB_ActionsF:49
			Else 
				vt_Action:=""
			End if 
			
			_O_PAGE SETUP:C299([HeberGement:5]; "HG_PrtActionAF")
			PRINT SETTINGS:C106
			
			If (OK=1)
				FORM SET OUTPUT:C54([HeberGement:5]; "HG_PrtActionAF")
			End if 
			
			PRINT SELECTION:C60([HeberGement:5]; *)
		End if 
		
		USE SET:C118("$E_HGt")
	End if 
	
End if 