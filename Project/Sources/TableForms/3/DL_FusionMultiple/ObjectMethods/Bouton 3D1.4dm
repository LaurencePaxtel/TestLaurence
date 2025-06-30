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
If (Macintosh control down:C544) | (Windows Ctrl down:C562)
	va_IDT_Typ1:=""
	vl_IDT_Réf1:=0
	OBJECT SET ENABLED:C1123(b_Fuse; False:C215)
	OBJECT SET ENABLED:C1123(b_CléEffacer; False:C215)
Else 
	If ([HeBerge:4]HB_ReferenceID:1>0)
		$ii:=Find in array:C230(tl_Fu_Référence; [HeBerge:4]HB_ReferenceID:1)
		If ($ii>0)
			ALERT:C41("Cette clé "+[HeBerge:4]HB_Clé:2+" se trouve déja dans la liste à fusionner !")
			Tab_Fusion(1; $ii; 0)
			P_FusionBt(Num:C11((Size of array:C274(ta_FU_Clé)>0) & (ta_FU_Clé>0)))
		Else 
			va_IDT_Typ1:=[HeBerge:4]HB_Clé:2
			vl_IDT_Réf1:=[HeBerge:4]HB_ReferenceID:1
			OBJECT SET ENABLED:C1123(b_CléEffacer; True:C214)
			If (va_IDT_Typ1>"") & (Size of array:C274(tl_Fu_Référence)>0)
				OBJECT SET ENABLED:C1123(b_Fuse; True:C214)
			Else 
				OBJECT SET ENABLED:C1123(b_Fuse; False:C215)
			End if 
		End if 
	Else 
		StrAlerte(22; "")
	End if 
End if 