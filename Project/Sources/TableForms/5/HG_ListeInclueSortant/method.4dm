If (Form event code:C388=Sur affichage corps:K2:22)
	va_JN:=""
	va_Réserve:=""
	va_Réserve:="Reste : "+String:C10([HeberGement:5]HG_NuitReste:95)+" Réservation : "+String:C10([HeberGement:5]HG_NuitenCours:92)+" sur "+String:C10([HeberGement:5]HG_NuitTOTAL:93)
	va_NomClé:=Uut_HébergéClé(->[HeberGement:5]HG_Nom:21; ->[HeberGement:5]HG_Prénom:22; ->[HeberGement:5]HG_DateNéLe:24)
	OBJECT SET VISIBLE:C603(*; "LeTiret"; ([HeberGement:5]HG_ReferenceID:1>0))
	
End if 

