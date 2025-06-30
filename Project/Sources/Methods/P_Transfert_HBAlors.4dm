//%attributes = {}
C_TEXT:C284($1)

C_BOOLEAN:C305($vb_OK)

Case of 
	: ($1="Libelle")
		va_Transfert_HBAlors:=""
		var $vl_T_CentreCodeDebut_i; $vl_T_CentreCodeFin_i : Integer
		P_CodeCentre(->$vl_T_CentreCodeDebut_i; ->$vl_T_CentreCodeFin_i)
		$vb_OK:=False:C215
		$vb_OK:=$vb_OK & ([HeberGement:5]HG_Nuit:2=False:C215)
		$vb_OK:=$vb_OK & ([HeberGement:5]HG_LC_ID:61>0)
		$vb_OK:=$vb_OK & ([HeberGement:5]HG_LC_ID:61>=$vl_T_CentreCodeDebut_i)
		$vb_OK:=$vb_OK & ([HeberGement:5]HG_LC_ID:61<=$vl_T_CentreCodeFin_i)
		
		If ($vb_OK)
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[HeberGement:5]HG_LC_ID:61)
			
			If (Records in selection:C76([LesCentres:9])=1)
				
				If ([LesCentres:9]LC_Répertoire:54#"115")
					
					If ([HeberGement:5]HG_1_TransHeure:70=?00:00:00?)
						va_Transfert_HBAlors:="Fiche non tranférée au centre !"
					End if 
					
				End if 
				
			End if 
			
		End if 
		
	: ($1="Transfert")
		var $vl_T_CentreCodeDebut_i; $vl_T_CentreCodeFin_i : Integer
		P_CodeCentre(->$vl_T_CentreCodeDebut_i; ->$vl_T_CentreCodeFin_i)
		$vb_OK:=False:C215
		$vb_OK:=$vb_OK & ([HeberGement:5]HG_Nuit:2=False:C215)
		$vb_OK:=$vb_OK & ([HeberGement:5]HG_LC_ID:61>0)
		$vb_OK:=$vb_OK & ([HeberGement:5]HG_LC_ID:61>=$vl_T_CentreCodeDebut_i)
		$vb_OK:=$vb_OK & ([HeberGement:5]HG_LC_ID:61<=$vl_T_CentreCodeFin_i)
		
		If ($vb_OK)
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[HeberGement:5]HG_LC_ID:61)
			
			If (Records in selection:C76([LesCentres:9])=1)
				
				If ([LesCentres:9]LC_Répertoire:54#"115")
					[HeberGement:5]HG_TransCentreID:155:=[HeberGement:5]HG_LC_ID:61
				End if 
				
			End if 
			
		End if 
		
	: ($1="Centre")
		var $vl_T_CentreCodeDebut_i; $vl_T_CentreCodeFin_i : Integer
		P_CodeCentre(->$vl_T_CentreCodeDebut_i; ->$vl_T_CentreCodeFin_i)
		$vb_OK:=False:C215
		$vb_OK:=$vb_OK & ([HeberGement:5]HG_Nuit:2=False:C215)
		$vb_OK:=$vb_OK & ([HeberGement:5]HG_TransCentreID:155>0)
		$vb_OK:=$vb_OK & ([HeberGement:5]HG_TransCentreID:155>=$vl_T_CentreCodeDebut_i)
		$vb_OK:=$vb_OK & ([HeberGement:5]HG_TransCentreID:155<=$vl_T_CentreCodeFin_i)
		
		If ($vb_OK)
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[HeberGement:5]HG_TransCentreID:155)
			
			If (Records in selection:C76([LesCentres:9])=1)
				
				If ([LesCentres:9]LC_Répertoire:54#"115")
					va_Transfert_Centre:="Centre de transfert : "+[LesCentres:9]LC_Nom:4
				End if 
				
			End if 
			
		End if 
		
End case 