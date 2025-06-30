//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : P_SIAO_New
//{
//{          Lundi 24 Janvier 2011 à 11:26:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($0)

LOAD RECORD:C52([HeBerge:4])  // #BS MIGRATION 10/6/16

If ([HeBerge:4]HB_ReferenceID:1>0)
	va_IDT_Typ1:=""
	vd_IDT_NéLe:=[HeBerge:4]HB_DateNéLe:5
	ve_IDT_Age:=Uut_HébergéAge(->vd_IDT_NéLe)
	
	If (F_Tab_Pop("Type"; -><>ta_TBEtCiv; ->va_IDT_Typ1))
		
		If (F_HébergementEtatCivil(va_IDT_Typ1; ve_IDT_Age))
			P_TypeEtCv_Genre(va_IDT_Typ1; ->x_IDTG_1; ->x_IDTG_2)
			
			If ($0>0)  // Mise à jour du genre pour les nouvelles clés
				READ WRITE:C146([HeBerge:4])
				
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$0)
				MultiSoc_Filter(->[HeBerge:4])
				
				If (Records in selection:C76([HeBerge:4])=1)
					
					If (i_NonVerrou(->[HeBerge:4]))
						[HeBerge:4]HG_Genre:39:=(x_IDTG_2=1)
						SAVE RECORD:C53([HeBerge:4])
					End if 
					
				End if 
				
				UNLOAD RECORD:C212([HeBerge:4])
				READ ONLY:C145([HeBerge:4])
				
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$0)
				MultiSoc_Filter(->[HeBerge:4])
			End if 
			
			vb_Sel_CleUnique:=True:C214
			vl_Sel_CleUnique:=[HeBerge:4]HB_ReferenceID:1
			
			Process_Go10(-><>PR_SIAOFiche; "Go_SIAOFiche"; "SIAO fiche"; 128; vl_Sel_CleUnique; "X"; vl_SIAO_Action; vl_SIAO_Referent; va_IDT_Typ1)
		End if 
		
	End if 
	
Else 
	StrAlerte(3; "")
End if 