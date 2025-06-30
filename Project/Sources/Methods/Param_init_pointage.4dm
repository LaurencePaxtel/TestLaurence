//%attributes = {}
// Method Param_init_pointage
C_TEXT:C284($1)

C_TEXT:C284($T_Selecteur; $T_Text_error)
C_LONGINT:C283($L_Ref; $L_Erreur)
C_BOOLEAN:C305($B_RO)

$T_Selecteur:=$1
$L_Ref:=-57

Case of 
	: ($T_Selecteur="Charger")
		QUERY:C277([DePart2:76]; [DePart2:76]Reference_ID:4=$L_Ref)  // -57 c'est pour rester cohérent avec l'ancien système
		MultiSoc_Filter(->[DePart2:76])
		
		If (Records in selection:C76([DePart2:76])=0)
			CREATE RECORD:C68([DePart2:76])
			MultiSoc_Init_Structure(->[DePart2:76])
			
			[DePart2:76]Reference_ID:4:=$L_Ref
			[DePart2:76]Label:3:="Prestation par défaut pour Pointage"
			SAVE RECORD:C53([DePart2:76])
			
			Param_init_pointage("set")
		End if 
		
	: ($T_Selecteur="liberer")
		UNLOAD RECORD:C212([DePart2:76])
	: ($T_Selecteur="set") | ($T_Selecteur="get")
		
		If ([DePart2:76]Reference_ID:4#$L_Ref)
			Param_init_pointage("Charger")
		End if 
		
		If ($T_Selecteur="set")
			$B_RO:=4DTABLE_MakeRW(->[DePart2:76])
			$L_Erreur:=4DREC_Load_Record(->[DePart2:76]; ->$T_Text_error)
			
			If ($L_Erreur=1)
				OB SET:C1220([DePart2:76]Proprietes:2; "centre_ref"; <>vl_PointeCtrRéf)
				OB SET:C1220([DePart2:76]Proprietes:2; "centre_nom"; <>va_PointeCtrNom)
				OB SET:C1220([DePart2:76]Proprietes:2; "centre_cp"; <>va_PointeCtrCP)
				OB SET:C1220([DePart2:76]Proprietes:2; "centre_medicalise"; <>vl_PointeCtrMéd)
				OB SET:C1220([DePart2:76]Proprietes:2; "centre_is_medicalise"; <>vb_PointeCtrMéd)
				OB SET:C1220([DePart2:76]Proprietes:2; "centre_plateforme"; <>va_PointeCtrPlateF)
				OB SET:C1220([DePart2:76]Proprietes:2; "centre_fm_groupe"; <>va_PointeFMGroupe)
				SAVE RECORD:C53([DePart2:76])
				
				UNLOAD RECORD:C212([DePart2:76])
			End if 
			
			4DTABLE_MakeRW_Restore(->[DePart2:76]; $B_RO)
		End if 
		
	Else 
		TRACE:C157
End case 