//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 12/07/21, 17:29:34
// ----------------------------------------------------
// Méthode : DébutInitPointage
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)

C_TEXT:C284($vt_Dummy)
C_LONGINT:C283($vl_Ref)

// Modifié par : Scanu Rémy - remy@onnect-io.fr (12/07/2021)
If (Count parameters:C259<2)
	$vl_Ref:=-57
Else 
	$vl_Ref:=-58
End if 

Case of 
	: ($1=0)
		READ WRITE:C146([DePart:1])
		
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$vl_Ref)
		MultiSoc_Filter(->[DePart:1])
		
		If (Records in selection:C76([DePart:1])=1)
			$vt_Dummy:=[DePart:1]DP_Texte:7
			<>vl_PointeCtrRéf:=Num:C11(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
			
			$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
			<>va_PointeCtrNom:=Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1)
			
			$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
			<>va_PointeCtrCP:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
			
			$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
			<>vl_PointeCtrMéd:=Num:C11(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
			<>vb_PointeCtrMéd:=(<>vl_PointeCtrMéd=1)
			
			$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
			<>va_PointeFMGroupe:=$vt_Dummy
			
			UNLOAD RECORD:C212([DePart:1])
		Else 
			<>va_PointeCtrNom:=""
			<>va_PointeCtrCP:=""
			<>va_PointeCtrPlateF:=""
			<>va_PointeFMGroupe:=""
			
			<>vl_PointeCtrRéf:=0
			<>vl_PointeCtrMéd:=0
			
			<>vb_PointeCtrMéd:=False:C215
			
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			
			[DePart:1]DP_ReferenceID:1:=$vl_Ref
			
			// Modifié par : Scanu Rémy - remy@onnect-io.fr (12/07/2021)
			If (Count parameters:C259<2)
				[DePart:1]DP_Libelle:6:="Prestation par défaut pour Pointage"
			Else 
				[DePart:1]DP_Libelle:6:="Prestation par défaut pour Pointage hébergement"
			End if 
			
			[DePart:1]DP_Texte:7:=String:C10(<>vl_PointeCtrRéf)+";"+<>va_PointeCtrNom+";"+<>va_PointeCtrCP+";"+String:C10(<>vl_PointeCtrMéd)+";"+<>va_PointeFMGroupe
			
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		
		READ ONLY:C145([DePart:1])
	: ($1=1)
		READ WRITE:C146([DePart:1])
		
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$vl_Ref)
		MultiSoc_Filter(->[DePart:1])
		
		If (Records in selection:C76([DePart:1])=1)
			
			Repeat 
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			
			[DePart:1]DP_Texte:7:=String:C10(<>vl_PointeCtrRéf)+";"+<>va_PointeCtrNom+";"+<>va_PointeCtrCP+";"+String:C10(<>vl_PointeCtrMéd)+";"+<>va_PointeFMGroupe
			
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		
		READ ONLY:C145([DePart:1])
End case 