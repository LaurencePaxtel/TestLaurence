//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DebutParamMail  
//{           
//{          Lundi 3 mai 2010 à 12:55:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_TEXT:C284($vt_Dummy)
C_LONGINT:C283($vl_Ref; $vl_Position)

$vl_Ref:=-62

Case of 
	: ($1=0)
		C_TEXT:C284(<>vt_M_SMTP_Host; <>va_M_SMTP_Passe; <>vt_M_MailFrom; <>vt_M_MailTo; <>vt_M_MailToListe; <>vt_M_MailObjet; <>vt_M_MailBody; <>vt_M_MailErreur)
		C_BOOLEAN:C305(<>vb_M_MailOui)
		
		ARRAY TEXT:C222(<>tt_M_MailTo; 0)
	: ($1=1)
		ARRAY TEXT:C222(<>tt_M_MailTo; 0)
		
		READ WRITE:C146([DePart:1])
		
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$vl_Ref)
		MultiSoc_Filter(->[DePart:1])
		
		If (Records in selection:C76([DePart:1])=1)
			$vt_Dummy:=[DePart:1]DP_Texte:7
			$vt_Dummy:=Substring:C12($vt_Dummy; 4)
			
			<>vb_M_MailOui:=(Substring:C12($vt_Dummy; 1; Position:C15("<1>"; $vt_Dummy)-1)="vrai")
			$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15("<1>"; $vt_Dummy)+3)
			
			<>vt_M_SMTP_Host:=Substring:C12($vt_Dummy; 1; Position:C15("<2>"; $vt_Dummy)-1)
			$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15("<2>"; $vt_Dummy)+3)
			
			<>va_M_SMTP_Passe:=Substring:C12($vt_Dummy; 1; Position:C15("<3>"; $vt_Dummy)-1)
			$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15("<3>"; $vt_Dummy)+3)
			
			<>vt_M_MailFrom:=Substring:C12($vt_Dummy; 1; Position:C15("<4>"; $vt_Dummy)-1)
			$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15("<4>"; $vt_Dummy)+3)
			
			<>vt_M_MailToListe:=Substring:C12($vt_Dummy; 1; Position:C15("<5>"; $vt_Dummy)-1)
			$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15("<5>"; $vt_Dummy)+3)
			
			<>vt_M_MailObjet:=$vt_Dummy
			UNLOAD RECORD:C212([DePart:1])
			
			If (<>vt_M_MailToListe>"")
				$vt_Dummy:=<>vt_M_MailToListe
				
				Repeat 
					$vl_Position:=Position:C15(","; $vt_Dummy)
					
					If ($vl_Position>0)
						INSERT IN ARRAY:C227(<>tt_M_MailTo; Size of array:C274(<>tt_M_MailTo)+1)
						
						<>tt_M_MailTo:=Size of array:C274(<>tt_M_MailTo)
						<>tt_M_MailTo{<>tt_M_MailTo}:=Substring:C12($vt_Dummy; 1; Position:C15(","; $vt_Dummy)-1)
						$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(","; $vt_Dummy)+1)
					Else 
						
						If ($vt_Dummy>"")
							INSERT IN ARRAY:C227(<>tt_M_MailTo; Size of array:C274(<>tt_M_MailTo)+1)
							
							<>tt_M_MailTo:=Size of array:C274(<>tt_M_MailTo)
							<>tt_M_MailTo{<>tt_M_MailTo}:=$vt_Dummy
							$vt_Dummy:=""
						End if 
						
					End if 
					
				Until ($vt_Dummy="")
				
			End if 
			
		Else 
			ARRAY TEXT:C222(<>tt_M_MailTo; 0)
			
			<>vt_M_SMTP_Host:=""
			<>va_M_SMTP_Passe:=""
			<>vt_M_MailFrom:=""
			<>vt_M_MailTo:=""
			<>vt_M_MailToListe:=""
			<>vt_M_MailObjet:=""
			
			<>vb_M_MailOui:=False:C215
			
			DELETE SELECTION:C66([DePart:1])
			
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			
			[DePart:1]DP_ReferenceID:1:=$vl_Ref
			[DePart:1]DP_Libelle:6:="Paramètres des mails de report"
			[DePart:1]DP_Texte:7:="<0>"+"<1>"+"<2>"+"<3>"+"<4>"+"<5>"
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		
		READ ONLY:C145([DePart:1])
	: ($1=2)
		READ WRITE:C146([DePart:1])
		
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$vl_Ref)
		MultiSoc_Filter(->[DePart:1])
		
		If (Records in selection:C76([DePart:1])=1)
			
			Repeat 
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			
			[DePart:1]DP_Texte:7:=""
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+"<0>"+("vrai"*Num:C11(<>vb_M_MailOui))+("faux"*Num:C11(<>vb_M_MailOui=False:C215))
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+"<1>"+<>vt_M_SMTP_Host
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+"<2>"+<>va_M_SMTP_Passe
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+"<3>"+<>vt_M_MailFrom
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+"<4>"+<>vt_M_MailToListe
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+"<5>"+<>vt_M_MailObjet
			
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		
		READ ONLY:C145([DePart:1])
End case 