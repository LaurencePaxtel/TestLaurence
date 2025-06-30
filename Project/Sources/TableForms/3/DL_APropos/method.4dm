
Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		C_PICTURE:C286($G_Dummy)
		
		C_TEXT:C284($T_Path_resource)
		$T_Path_resource:=Get 4D folder:C485(Dossier Resources courant:K5:16)+"img"+Séparateur dossier:K24:12
		
		
		C_POINTER:C301($P_Picture)
		$P_Picture:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "logo")
		
		C_TEXT:C284($T_Path_svg; $T_Path_jpg; $T_Path_jpeg)
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
		C_TEXT:C284($T_Path_svg; $T_Path_jpg; $T_Path_jpeg)
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
		
		
		
End case 