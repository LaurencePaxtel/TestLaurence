//Formule Format : iListe reports
If (Form event code:C388=Sur affichage corps:K2:22)
	If ([HeberGement:5]HG_FamGroupe:102="") | ([HeberGement:5]HG_FamGroupe:102="115")
		va_GroupeAS:="115"
	Else 
		va_GroupeAS:="DA"
	End if 
	If ([HeberGement:5]HG_FamChef:103)
		OBJECT SET FONT STYLE:C166(va_GroupeAS; 4)
	Else 
		OBJECT SET FONT STYLE:C166(va_GroupeAS; 0)
	End if 
	va_NomClé:=Uut_HébergéClé(->[HeberGement:5]HG_Nom:21; ->[HeberGement:5]HG_Prénom:22; ->[HeberGement:5]HG_DateNéLe:24)
	If ([HeberGement:5]HG_Réservation:91)
		va_Réservation:="Reservation"
	Else 
		va_Réservation:=""
	End if 
	va_Rép2:=String:C10([HeberGement:5]HG_NuitenCours:92)+"/"+String:C10([HeberGement:5]HG_NuitTOTAL:93)
	If ([HeberGement:5]HG_ER_Excuse:124=False:C215)
		va_Excusé:="Excusée jusqu'au "+String:C10([HeberGement:5]HG_ER_DateFin:126; 2)
	Else 
		va_Excusé:=""
	End if 
	va_Rép3:=String:C10([HeberGement:5]HG_ER_NuitEnCours:127)+"/"+String:C10([HeberGement:5]HG_ER_NuitTotal:128)
	
	
	va_Remp:=""
	If ([HeberGement:5]HG_ER_RemplaceQuiRéf:131>0)
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_ER_RemplaceQuiRéf:131)
		MultiSoc_Filter(->[HeBerge:4])
		va_Remp:=[HeBerge:4]HB_Clé:2
	End if 
End if 