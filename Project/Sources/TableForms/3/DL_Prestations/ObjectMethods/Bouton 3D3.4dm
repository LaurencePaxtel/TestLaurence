//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_VoirHG  
//{
//{          Lundi 28 Juillet 1997 à 17:08:57
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (Form event code:C388=Sur clic:K2:4)
	If ([HeBerge:4]HB_ReferenceID:1>0)
		vl_RéfU_HB:=[HeBerge:4]HB_ReferenceID:1
		va_Identité:=[HeBerge:4]HB_Nom:3+" "+[HeBerge:4]HB_Prénom:4+" "+String:C10([HeBerge:4]HB_DateNéLe:5; 7)
	Else 
		vl_RéfU_HB:=0
		va_Identité:=""
		StrAlerte(3; "")
	End if 
	P_HébergementRGFind(vl_RéfU_HB)
End if 