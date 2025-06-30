//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_Planning_HB
//{
//{          Mercredi 12 janvier 2011 à 12:06:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_DATE:C307($3)
C_LONGINT:C283($4)

C_LONGINT:C283($vl_CléU)
C_BOOLEAN:C305($vb_YaFiche)

If (Windows Ctrl down:C562 | Macintosh control down:C544)
	
	If ($1>0)
		vp_Pointeur:=Get pointer:C304("va_Nom_"+$2)
		
		If (i_Confirmer("Confirme-vous la suppression de la réservation de"+<>va_CR+"  "+vp_Pointeur->+<>va_CR+"le "+String:C10($3)))
			READ WRITE:C146([Objets_Planification:57])
			QUERY:C277([Objets_Planification:57]; [Objets_Planification:57]OP_Référence:1=$1)
			
			MultiSoc_Filter(->[Objets_Planification:57])
			If (Records in selection:C76([Objets_Planification:57])=1)
				
				If (i_NonVerrou(->[Objets_Planification:57]))
					DELETE RECORD:C58([Objets_Planification:57])
					
					vp_Pointeur:=Get pointer:C304("vl_NomID_"+$2)
					vp_Pointeur->:=0
					
					vp_Pointeur:=Get pointer:C304("va_Nom_"+$2)
					vp_Pointeur->:=""
					
					vp_Pointeur:=Get pointer:C304("va_OPEat_"+$2)
					vp_Pointeur->:=""
					
					OBJECT SET VISIBLE:C603(*; "b_Cadre_V_"+$2; False:C215)
					OBJECT SET VISIBLE:C603(*; "i_Trou_"+$2; True:C214)
				End if 
				
			End if 
			
			UNLOAD RECORD:C212([Objets_Planification:57])
			READ ONLY:C145([Objets_Planification:57])
		End if 
		
	End if 
	
Else 
	QUERY:C277([Objets_Planification:57]; [Objets_Planification:57]OP_Référence:1=$1)
	MultiSoc_Filter(->[Objets_Planification:57])
	
	If (Records in selection:C76([Objets_Planification:57])=1)
		$vl_CléU:=[Objets_Planification:57]OP_Hébergé_ID:6
		$vb_YaFiche:=True:C214
	Else 
		$vl_CléU:=0
		$vb_YaFiche:=False:C215
	End if 
	
	If (F_CléUnique_Sel(3; ->vl_CleUnique_ID; False:C215; False:C215; 0; ->va_UnLib45))
		
		If (vl_CleUnique_ID=$vl_CléU)  //C'est le même
		Else 
			READ WRITE:C146([Objets_Planification:57])
			If ($vb_YaFiche)
				vp_Pointeur:=Get pointer:C304("vl_NomID_"+$2)
				QUERY:C277([Objets_Planification:57]; [Objets_Planification:57]OP_Référence:1=vp_Pointeur->)
				If (Records in selection:C76([Objets_Planification:57])=1)
					If (i_NonVerrou(->[Objets_Planification:57]))
						[Objets_Planification:57]OP_Hébergé_ID:6:=vl_CleUnique_ID
						[Objets_Planification:57]OP_Hébergé_Clé:7:="???"
						QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Objets_Planification:57]OP_Hébergé_ID:6)
						MultiSoc_Filter(->[HeBerge:4])
						If (Records in selection:C76([HeBerge:4])=1)
							[Objets_Planification:57]OP_Hébergé_Clé:7:=[HeBerge:4]HB_Clé:2
						End if 
						[Objets_Planification:57]OP_Etat:8:="R"
						SAVE RECORD:C53([Objets_Planification:57])
						vp_Pointeur:=Get pointer:C304("vl_NomID_"+$2)
						vp_Pointeur->:=[Objets_Planification:57]OP_Référence:1
						vp_Pointeur:=Get pointer:C304("va_Nom_"+$2)
						vp_Pointeur->:=[Objets_Planification:57]OP_Hébergé_Clé:7
						vp_Pointeur:=Get pointer:C304("va_OPEat_"+$2)
						vp_Pointeur->:=[Objets_Planification:57]OP_Etat:8
						
						OBJECT SET VISIBLE:C603(*; "b_Cadre_V_"+$2; True:C214)
						OBJECT SET VISIBLE:C603(*; "i_Trou_"+$2; False:C215)
						
						
					End if 
				End if 
			Else 
				CREATE RECORD:C68([Objets_Planification:57])
				MultiSoc_Init_Structure(->[Objets_Planification:57])
				[Objets_Planification:57]OP_Référence:1:=Uut_Numerote(->[Objets_Planification:57])
				[Objets_Planification:57]OP_Objet_ID:2:=tl_LesObjets_ID{0}
				[Objets_Planification:57]OP_Date:3:=$3
				[Objets_Planification:57]OP_Semaine:4:=$4
				[Objets_Planification:57]OP_Rang:5:=Num:C11($2[[1]])
				[Objets_Planification:57]OP_Hébergé_ID:6:=vl_CleUnique_ID
				[Objets_Planification:57]OP_Hébergé_Clé:7:="???"
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Objets_Planification:57]OP_Hébergé_ID:6)
				MultiSoc_Filter(->[HeBerge:4])
				If (Records in selection:C76([HeBerge:4])=1)
					[Objets_Planification:57]OP_Hébergé_Clé:7:=[HeBerge:4]HB_Clé:2
				End if 
				[Objets_Planification:57]OP_Etat:8:="R"
				SAVE RECORD:C53([Objets_Planification:57])
				vp_Pointeur:=Get pointer:C304("vl_NomID_"+$2)
				vp_Pointeur->:=[Objets_Planification:57]OP_Référence:1
				vp_Pointeur:=Get pointer:C304("va_Nom_"+$2)
				vp_Pointeur->:=[Objets_Planification:57]OP_Hébergé_Clé:7
				vp_Pointeur:=Get pointer:C304("va_OPEat_"+$2)
				vp_Pointeur->:=[Objets_Planification:57]OP_Etat:8
				
				OBJECT SET VISIBLE:C603(*; "b_Cadre_V_"+$2; True:C214)
				OBJECT SET VISIBLE:C603(*; "i_Trou_"+$2; False:C215)
				
			End if 
			
			UNLOAD RECORD:C212([Objets_Planification:57])
			READ ONLY:C145([Objets_Planification:57])
		End if 
	End if 
End if 