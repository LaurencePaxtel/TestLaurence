//%attributes = {"preemptive":"capable"}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementNo
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)  //J = Jour; N = Nuit
C_TEXT:C284($user_t)

If ([HeberGement:5]HG_Date:4#!00-00-00!)
	[HeberGement:5]HG_Date:4:=[HeberGement:5]HG_Date:4
Else 
	[HeberGement:5]HG_Date:4:=Current date:C33
End if 

[HeberGement:5]HG_HeureAppel:5:=Current time:C178()
[HeberGement:5]HG_FicheNuméro:3:=i_HébérgementNoFiche($1; [HeberGement:5]HG_Date:4; vl_Num_HBE)

[HeberGement:5]HG_Nuit:2:=($1="N")
[HeberGement:5]HG_EnAttente:64:=True:C214
[HeberGement:5]HG_DateDuJour:82:=Current date:C33
[HeberGement:5]HG_AttenteHeur:83:=Current time:C178()
[HeberGement:5]HG_Transmis:65:=False:C215
[HeberGement:5]HG_PriseCharge:66:=False:C215
[HeberGement:5]HG_Cloturée:67:=False:C215

va_Identité:=""
If (Session:C1714.storage=Null:C1517)
	// 4D client
	$user_t:=Storage:C1525.intervenantsDetail.UserCourant
	
	If (Storage:C1525.intervenantsDetail.Privileges.query("nom IS :1"; "Permanencier").length=1)
		[HeberGement:5]HG_Permanencier:9:=$user_t
	End if 
Else 
	// web
	$user_t:=Session:C1714.storage.intervenant.Login
	If (Session:C1714.storage.intervenant.Privileges.query("nom IS :1"; "Permanencier").length=1)
		[HeberGement:5]HG_Permanencier:9:=$user_t
	End if 
End if 




va_Identité:=[HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22