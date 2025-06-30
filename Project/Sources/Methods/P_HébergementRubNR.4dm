//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementRubNR
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_LONGINT:C283($ii; $ij)
C_LONGINT:C283(ve_Type)
C_LONGINT:C283(vl_Long)
C_BOOLEAN:C305(vb_Index)
C_BOOLEAN:C305($vb_OK)

$ij:=Size of array:C274(<>te_RdsRub{$1})
For ($ii; 1; $ij)
	If (<>tb_RdsObli{$1}{$ii})
		$vb_OK:=False:C215
		GET FIELD PROPERTIES:C258(Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii}); ve_Type; vl_Long; vb_Index)
		Case of 
			: (ve_Type=Est un champ alpha:K8:1)
				If (Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->>"")
				Else 
					$vb_OK:=True:C214
				End if 
			: (ve_Type=Est un texte:K8:3)
				If (Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->>"")
				Else 
					$vb_OK:=True:C214
				End if 
			: (ve_Type=Est un numérique:K8:4)
				If (Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->>0)
					
				End if 
			: (ve_Type=Est un entier:K8:5)
				If (Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->>0)
					
				End if 
			: (ve_Type=Est un entier long:K8:6)
				If (Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->>0)
					
				End if 
			: (ve_Type=Est une date:K8:7)
				If (Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->>!00-00-00!)
					
				End if 
			: (ve_Type=Est une heure:K8:8)
				If (Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->>?00:00:00?)
					
				End if 
			: (ve_Type=Est un booléen:K8:9)
				
			: (ve_Type=Est une image:K8:10)
				
			: (ve_Type=Est une sous table:K8:11)
				
			: (ve_Type=Est un BLOB:K8:12)
				
		End case 
		If ($vb_OK)
			If (<>tb_RdsPopVis{$1}{$ii})  //18/7/2008
				Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->:="NR"
			End if 
		End if 
		
		If (7=8)
			If ((Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->)>"")
			Else 
				If ($ii=5) | ($ii=62)  //Signalement | Fam Groupe
				Else 
					Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->:="NR"
				End if 
			End if 
		End if 
		
	End if 
End for 