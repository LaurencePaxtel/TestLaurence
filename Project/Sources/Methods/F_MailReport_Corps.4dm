//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_MailReport_Corps
//{
//{          Lundi 3 mai 2010 à 15:44
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_TEXT:C284($vt_Temp; $va_ALaLigne)

$va_ALaLigne:=Char:C90(13)

Case of 
	: ($1=1)  //Appel depuis Go_ReportParProcess
		<>vt_M_MailBody:="<< "+<>va_T_00+" >>"+$va_ALaLigne
		
		If (vb_SurServeur)
			<>vt_M_MailBody:=<>vt_M_MailBody+"Report auto sur Serveur"
			<>vt_M_MailBody:=<>vt_M_MailBody+", le "+String:C10(Current date:C33(*))+" à "+String:C10(Current time:C178(*))
		Else 
			<>vt_M_MailBody:=<>vt_M_MailBody+"Report auto sur Poste"
			<>vt_M_MailBody:=<>vt_M_MailBody+", le "+String:C10(Current date:C33)+" à "+String:C10(Current time:C178)
		End if 
		
		<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne+"          Fiches reportées : "+String:C10(Size of array:C274(tl_Trans_Réf_HG))
		<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne+("-"*30)
		<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne
		<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne
		
		<>vt_M_MailBody:=<>vt_M_MailBody+"Liste des personnes en fin d'hébergement : "+String:C10(vL_NbSortants)
		
		If (vL_NbSortants>0)
			
			Repeat 
				$vt_Temp:=String:C10(Day of:C23([HeberGement:5]HG_DateNéLe:24); "00")+"-"+String:C10(Month of:C24([HeberGement:5]HG_DateNéLe:24); "00")+"-"+String:C10(Year of:C25([HeberGement:5]HG_DateNéLe:24); "0000")
				<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne+[HeberGement:5]HG_Plateforme:139+" : "+[HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22+" "+$vt_Temp
				
				NEXT RECORD:C51([HeberGement:5])
			Until (End selection:C36([HeberGement:5]))
			
		End if 
		
		<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne
		<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne
		<>vt_M_MailBody:=<>vt_M_MailBody+"Bonne réception"
		
		If (True:C214)
			$0:=F_MailReportEnvoyer
		End if 
		
	: ($1=2)  //Appel depuis La liste écran
		<>vt_M_MailBody:="<< "+<>va_T_00+" >>"
		<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne+"Liste des personnes en fin d'hébergement "+va_TitreRecherche
		<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne+"          Nombre de personnes : "+String:C10(vL_NbFiches)
		<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne
		
		If (vL_NbFiches>0)
			FIRST RECORD:C50([HeberGement:5])
			
			Repeat 
				$vt_Temp:=String:C10(Day of:C23([HeberGement:5]HG_DateNéLe:24); "00")+"-"+String:C10(Month of:C24([HeberGement:5]HG_DateNéLe:24); "00")+"-"+String:C10(Year of:C25([HeberGement:5]HG_DateNéLe:24); "0000")
				<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne+[HeberGement:5]HG_Plateforme:139+" : "+[HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22+" "+$vt_Temp
				
				NEXT RECORD:C51([HeberGement:5])
			Until (End selection:C36([HeberGement:5]))
			
		End if 
		
		<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne
		<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne
		<>vt_M_MailBody:=<>vt_M_MailBody+"Bonne réception"
		
		If (True:C214)
			$0:=F_MailReportEnvoyer
		End if 
		
	: ($1=3)  //Appel depuis P_Report_Auto
		<>vt_M_MailBody:="<< "+<>va_T_00+" >>"+$va_ALaLigne
		<>vt_M_MailBody:=<>vt_M_MailBody+"Report Poste"
		<>vt_M_MailBody:=<>vt_M_MailBody+", effectué le "+String:C10(Current date:C33)+" à "+String:C10(Current time:C178)
		<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne+"          Fiches reportées : "+String:C10(vl_NbFichesReport)
		<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne+("-"*30)
		<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne
		<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne
		
		<>vt_M_MailBody:=<>vt_M_MailBody+"Liste des personnes en fin d'hébergement : "+String:C10(vL_NbSortants)
		
		If (vL_NbSortants>0)
			
			Repeat 
				$vt_Temp:=String:C10(Day of:C23([HeberGement:5]HG_DateNéLe:24); "00")+"-"+String:C10(Month of:C24([HeberGement:5]HG_DateNéLe:24); "00")+"-"+String:C10(Year of:C25([HeberGement:5]HG_DateNéLe:24); "0000")
				<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne+[HeberGement:5]HG_Plateforme:139+" : "+[HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22+" "+$vt_Temp
				
				NEXT RECORD:C51([HeberGement:5])
			Until (End selection:C36([HeberGement:5]))
			
		End if 
		
		<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne
		<>vt_M_MailBody:=<>vt_M_MailBody+$va_ALaLigne
		<>vt_M_MailBody:=<>vt_M_MailBody+"Bonne réception"
		
		If (True:C214)
			$0:=F_MailReportEnvoyer
		End if 
		
End case 