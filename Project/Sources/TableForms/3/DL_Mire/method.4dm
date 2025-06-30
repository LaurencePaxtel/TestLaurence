C_TEXT:C284($T_Path_resource; $T_Path_svg; $T_Path_jpg; $T_Path_jpeg)
C_LONGINT:C283($vl_eventForm)
C_PICTURE:C286($G_Dummy)
C_POINTER:C301($P_Picture)

$vl_eventForm:=Form event code:C388

Case of 
	: ($vl_eventForm=Sur chargement:K2:1)
		$T_Path_resource:=Get 4D folder:C485(Dossier Resources courant:K5:16)+"img"+Séparateur dossier:K24:12
		$P_Picture:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "logo")
		
		$T_Path_svg:=$T_Path_resource+"logo.svg"
		$T_Path_jpg:=$T_Path_resource+"logo.jpg"
		$T_Path_jpeg:=$T_Path_resource+"logo.jpeg"
		
		Case of 
			: (Test path name:C476($T_Path_svg)=Est un document:K24:1)
				READ PICTURE FILE:C678($T_Path_svg; $P_Picture->; *)
			: (Test path name:C476($T_Path_jpg)=Est un document:K24:1)
				READ PICTURE FILE:C678($T_Path_jpg; $P_Picture->; *)
			: (Test path name:C476($T_Path_jpeg)=Est un document:K24:1)
				READ PICTURE FILE:C678($T_Path_jpeg; $P_Picture->; *)
			Else 
				$P_Picture->:=$G_Dummy
		End case 
		
		$P_Picture:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "logo_paxtel")
		
		$T_Path_svg:=$T_Path_resource+"logo_paxtel.svg"
		$T_Path_jpg:=$T_Path_resource+"logo_paxtel.jpg"
		$T_Path_jpeg:=$T_Path_resource+"logo_paxtel.jpeg"
		
		Case of 
			: (Test path name:C476($T_Path_svg)=Est un document:K24:1)
				READ PICTURE FILE:C678($T_Path_svg; $P_Picture->; *)
			: (Test path name:C476($T_Path_jpg)=Est un document:K24:1)
				READ PICTURE FILE:C678($T_Path_jpg; $P_Picture->; *)
			: (Test path name:C476($T_Path_jpeg)=Est un document:K24:1)
				READ PICTURE FILE:C678($T_Path_jpeg; $P_Picture->; *)
			Else 
				$P_Picture->:=$G_Dummy
		End case 
		
	: ($vl_eventForm=Sur appel extérieur:K2:11)
		
		// Modifié par : Scanu Rémy (20/10/2022)
		Case of 
			: (<>vt_AProposMes="Quitter")
				<>PR_Mire:=0
				CANCEL:C270
			: (<>vt_AProposMesMes="Message")
				REDRAW:C174(<>vt_APropos)
		End case 
		
End case 