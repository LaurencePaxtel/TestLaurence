//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DébutInitReportAuto  
//{          
//{          Lundi 19 janvier 20031 à 16:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
var $2 : Text  // Ref_structure


C_TEXT:C284($vt_Dummy)

Case of 
	: ($1=-1)
		READ WRITE:C146([DePart:1])
		
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-21)
		MultiSoc_Filter(->[DePart:1])
		
		If (Records in selection:C76([DePart:1])=1)
			
			Repeat 
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			
			DELETE RECORD:C58([DePart:1])
		End if 
		
		UNLOAD RECORD:C212([DePart:1])
		READ ONLY:C145([DePart:1])
	: ($1=0)
		vb_ReportAuto:=False:C215
		vl_ReportAuto:=0
		
		vh_ReportAuto1:=?00:01:00?
		vh_ReportAuto2:=?23:58:00?
		
		vl_ReportAutoTicks:=36000
		ve_ReportAutoDi:=0
		ve_ReportAutoLu:=0
		ve_ReportAutoMa:=0
		ve_ReportAutoMe:=0
		ve_ReportAutoJe:=0
		ve_ReportAutoVe:=0
		ve_ReportAutoSa:=0
		
		READ WRITE:C146([DePart:1])
		
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-21)
		MultiSoc_Filter(->[DePart:1])
		
		If (Records in selection:C76([DePart:1])>0)
			$vt_Dummy:=Substring:C12([DePart:1]DP_Texte:7; 1; Position:C15("\\"; [DePart:1]DP_Texte:7)-1)
			
			If ($vt_Dummy>"")
				vl_ReportAuto:=Num:C11(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				vb_ReportAuto:=(vl_ReportAuto=1)
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				vh_ReportAuto1:=Time:C179(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				vh_ReportAuto2:=Time:C179(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				vl_ReportAutoTicks:=Num:C11(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				If (vl_ReportAutoTicks=0)
					vl_ReportAutoTicks:=36000
				End if 
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				
				ve_ReportAutoDi:=Num:C11($vt_Dummy[[1]])
				ve_ReportAutoLu:=Num:C11($vt_Dummy[[2]])
				ve_ReportAutoMa:=Num:C11($vt_Dummy[[3]])
				ve_ReportAutoMe:=Num:C11($vt_Dummy[[4]])
				ve_ReportAutoJe:=Num:C11($vt_Dummy[[5]])
				ve_ReportAutoVe:=Num:C11($vt_Dummy[[6]])
				ve_ReportAutoSa:=Num:C11($vt_Dummy[[7]])
			End if 
			
		Else 
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			
			[DePart:1]DP_ReferenceID:1:=-21
			[DePart:1]DP_Libelle:6:="Paramètres du report automatique"
			[DePart:1]DP_Date:2:=Current date:C33
			[DePart:1]DP_DerniereMAJ:5:=Current date:C33
			
			[DePart:1]DP_Texte:7:=""
			[DePart:1]DP_Texte:7:=String:C10(vl_ReportAuto)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(vh_ReportAuto1; h mn:K7:2)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(vh_ReportAuto2; h mn:K7:2)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(vl_ReportAutoTicks)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoDi; "0")
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoLu; "0")
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoMa; "0")
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoMe; "0")
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoJe; "0")
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoVe; "0")
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoSa; "0")
			
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+"\\"+[DePart:1]DP_Texte:7
			
			SAVE RECORD:C53([DePart:1])
		End if 
		
		UNLOAD RECORD:C212([DePart:1])
		READ ONLY:C145([DePart:1])
	: ($1=1)
		READ WRITE:C146([DePart:1])
		
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-21)
		MultiSoc_Filter(->[DePart:1])
		
		If (Records in selection:C76([DePart:1])>0)
			
			Repeat 
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			
			$vt_Dummy:=Substring:C12([DePart:1]DP_Texte:7; Position:C15("\\"; [DePart:1]DP_Texte:7)+1)
			
			[DePart:1]DP_Texte:7:=""
			[DePart:1]DP_Texte:7:=String:C10(vl_ReportAuto)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(vh_ReportAuto1; h mn:K7:2)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(vh_ReportAuto2; h mn:K7:2)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(vl_ReportAutoTicks)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoDi; "0")
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoLu; "0")
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoMa; "0")
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoMe; "0")
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoJe; "0")
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoVe; "0")
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoSa; "0")
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+"\\"+$vt_Dummy
			SAVE RECORD:C53([DePart:1])
			
			UNLOAD RECORD:C212([DePart:1])
		End if 
		
		UNLOAD RECORD:C212([DePart:1])
		READ ONLY:C145([DePart:1])
	: ($1=2)
		READ ONLY:C145([DePart:1])
		
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-21)
		MultiSoc_Filter(->[DePart:1])
		
		If (Records in selection:C76([DePart:1])=1)
			$vt_Dummy:=Substring:C12([DePart:1]DP_Texte:7; Position:C15("\\"; [DePart:1]DP_Texte:7)+1)
			
			If ($vt_Dummy>"")
				vl_ReportAuto:=Num:C11(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				vb_ReportAuto:=(vl_ReportAuto=1)
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				vh_ReportAuto1:=Time:C179(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				vh_ReportAuto2:=Time:C179(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				vl_ReportAutoTicks:=Num:C11(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				If (vl_ReportAutoTicks=0)
					vl_ReportAutoTicks:=36000
				End if 
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				
				ve_ReportAutoDi:=Num:C11($vt_Dummy[[1]])
				ve_ReportAutoLu:=Num:C11($vt_Dummy[[2]])
				ve_ReportAutoMa:=Num:C11($vt_Dummy[[3]])
				ve_ReportAutoMe:=Num:C11($vt_Dummy[[4]])
				ve_ReportAutoJe:=Num:C11($vt_Dummy[[5]])
				ve_ReportAutoVe:=Num:C11($vt_Dummy[[6]])
				ve_ReportAutoSa:=Num:C11($vt_Dummy[[7]])
			End if 
			
		End if 
		
		UNLOAD RECORD:C212([DePart:1])
		READ ONLY:C145([DePart:1])
	: ($1=3)
		READ WRITE:C146([DePart:1])
		
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-21)
		MultiSoc_Filter(->[DePart:1])
		
		If (Records in selection:C76([DePart:1])>0)
			
			Repeat 
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			
			$vt_Dummy:=Substring:C12([DePart:1]DP_Texte:7; 1; Position:C15("\\"; [DePart:1]DP_Texte:7)-1)
			
			[DePart:1]DP_Texte:7:=""
			[DePart:1]DP_Texte:7:=String:C10(vl_ReportAuto)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(vh_ReportAuto1; h mn:K7:2)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(vh_ReportAuto2; h mn:K7:2)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(vl_ReportAutoTicks)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoDi; "0")
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoLu; "0")
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoMa; "0")
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoMe; "0")
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoJe; "0")
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoVe; "0")
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(ve_ReportAutoSa; "0")
			[DePart:1]DP_Texte:7:=$vt_Dummy+"\\"+[DePart:1]DP_Texte:7
			
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		
		UNLOAD RECORD:C212([DePart:1])
		READ ONLY:C145([DePart:1])
	: ($1=4)
		vb_ReportAuto:=False:C215
		vl_ReportAuto:=0
		
		vh_ReportAuto1:=?00:01:00?
		vh_ReportAuto2:=?23:58:00?
		
		vl_ReportAutoTicks:=36000
		ve_ReportAutoDi:=0
		ve_ReportAutoLu:=0
		ve_ReportAutoMa:=0
		ve_ReportAutoMe:=0
		ve_ReportAutoJe:=0
		ve_ReportAutoVe:=0
		ve_ReportAutoSa:=0
		
		READ ONLY:C145([DePart:1])
		
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-21; *)
		QUERY:C277([DePart:1]; [DePart:1]Ref_Structure:10=$2)
		//MultiSoc_Filter(->[DePart])
		ASSERT:C1129(Records in selection:C76([DePart:1])=1; "Nombre d'enregistrement [DePart] différent de 1 pour : DP_ReferenceID=-21 et Ref_Structure="+$2)
		If (Records in selection:C76([DePart:1])=1)
			$vt_Dummy:=Substring:C12([DePart:1]DP_Texte:7; 1; Position:C15("\\"; [DePart:1]DP_Texte:7)-1)
			
			If ($vt_Dummy>"")
				vl_ReportAuto:=Num:C11(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				vb_ReportAuto:=(vl_ReportAuto=1)
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				vh_ReportAuto1:=Time:C179(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				vh_ReportAuto2:=Time:C179(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				vl_ReportAutoTicks:=Num:C11(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				If (vl_ReportAutoTicks=0)
					vl_ReportAutoTicks:=36000
				End if 
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				
				ve_ReportAutoDi:=Num:C11($vt_Dummy[[1]])
				ve_ReportAutoLu:=Num:C11($vt_Dummy[[2]])
				ve_ReportAutoMa:=Num:C11($vt_Dummy[[3]])
				ve_ReportAutoMe:=Num:C11($vt_Dummy[[4]])
				ve_ReportAutoJe:=Num:C11($vt_Dummy[[5]])
				ve_ReportAutoVe:=Num:C11($vt_Dummy[[6]])
				ve_ReportAutoSa:=Num:C11($vt_Dummy[[7]])
			End if 
			
		End if 
		
		READ ONLY:C145([DePart:1])
End case 