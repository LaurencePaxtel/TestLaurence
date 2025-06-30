//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementExcuserValider
//{
//{          Mardi 11 Mai 2004 à 10:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

<>vd_PourExcuseDate:=!00-00-00!
<>vl_PourExcuseRéf:=0
<>vl_PourExcuseRéfHB:=0
<>vl_PourExcuseRéfCT:=0
<>vd_PourExcuseNuit:=False:C215

C_LONGINT:C283(vl_PourExcuseNb)

LOAD RECORD:C52([HeberGement:5])
If ([HeberGement:5]HG_ReferenceID:1>0)
	<>vd_PourExcuseDate:=[HeberGement:5]HG_Date:4
	<>vl_PourExcuseRéf:=[HeberGement:5]HG_ReferenceID:1
	<>vl_PourExcuseRéfHB:=[HeberGement:5]HG_HB_ID:19
	<>vl_PourExcuseRéfCT:=0
	<>vd_PourExcuseNuit:=[HeberGement:5]HG_Nuit:2
	
	vl_PourExcuseNb:=0
	vb_OK:=True:C214
Else 
	vb_OK:=False:C215
	StrAlerte(5; "")  //sélectionner la fiche
End if 

If (vb_OK)  //Si on est sur une fiche
	If ([HeberGement:5]HG_Réservation:91=False:C215)
		vb_OK:=False:C215
		ALERT:C41("Pas de réservation !!!")
	End if 
	
	If (vb_OK)
		If ([HeberGement:5]HG_ER_Remplaçant:130)
			vb_OK:=False:C215
			ALERT:C41("C'est un remplaçant  !!!")
		End if 
	End if 
	
	If (vb_OK)
		If ([HeberGement:5]HG_Réservation:91) & ([HeberGement:5]HG_NuitenCours:92=1)
			vb_OK:=False:C215
			ALERT:C41("C'est sa première nuit  !!!")
		End if 
	End if 
	
	If (vb_OK)
		If ([HeberGement:5]HG_Réservation:91) & ([HeberGement:5]HG_NuitReste:95=0)
			vb_OK:=False:C215
			ALERT:C41("C'est un sortant !!!")
		End if 
	End if 
	
	If (vb_OK)
		SET QUERY DESTINATION:C396(Vers variable:K19:4; vl_PourExcuseNb)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4><>vd_PourExcuseDate)
		MultiSoc_Filter(->[HeberGement:5])
		SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
		If (vl_PourExcuseNb>0)
			vb_OK:=False:C215
			ALERT:C41("Vérifier les dates  !!!"+<>va_CR+"Ce doit être à la date du jour !!!")
		End if 
	End if 
End if 

If (vb_OK)
	
	<>vt_PourExcuseRemp:=""
	
	<>vd_PourExcuseEnCours:=False:C215
	BEEP:C151
	//ALERTE("Remettre le lit !!!!")
	
	Process_Go(-><>PR_HébergementRemp; "Go_HébergementExcuserRP"; "HébergementExcuserR"; 64)
	
	Repeat 
		IDLE:C311
	Until (<>vd_PourExcuseEnCours)
	
	READ WRITE:C146([HeberGement:5])
	If (i_NonVerrou(->[HeberGement:5]))
		P_Profil
		va_JourNuit:=(("N"*Num:C11([HeberGement:5]HG_Nuit:2))+("J"*Num:C11([HeberGement:5]HG_Nuit:2=False:C215)))
		FORM SET INPUT:C55([HeberGement:5]; "HG_EcranSaisieExcuse")
		$vl_Fenetre:=i_FenêtreNo(383; 438; 4; "Hébergement : "+Uut_HébergéClé(->[HeberGement:5]HG_Nom:21; ->[HeberGement:5]HG_Prénom:22; ->[HeberGement:5]HG_DateNéLe:24); 3; "")
		MODIFY RECORD:C57([HeberGement:5]; *)
		UNLOAD RECORD:C212([HeberGement:5])
		CLOSE WINDOW:C154($vl_Fenetre)
	End if 
	READ ONLY:C145([HeberGement:5])
End if 