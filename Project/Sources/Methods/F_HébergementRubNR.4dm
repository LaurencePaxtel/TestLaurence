//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : F_HébergementRubNR
//{
//{          Lundi 9 mars 2009 à 15:08
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($0)
C_LONGINT:C283($1)

C_LONGINT:C283($ii; $L_Table; $L_Field)
C_BOOLEAN:C305($vb_OK)

C_LONGINT:C283(ve_Type; vl_Long)
C_BOOLEAN:C305(vb_Index)

For ($ii; 1; Size of array:C274(<>te_RdsRub{$1}))
	
	If (<>tb_RdsObli{$1}{$ii})
		$L_Table:=<>te_RdsFic{$1}{$ii}
		$L_Field:=<>te_RdsRub{$1}{$ii}
		
		GET FIELD PROPERTIES:C258(Field:C253($L_Table; $L_Field); ve_Type; vl_Long; vb_Index)
		
		$vb_OK:=((ve_Type=Est un champ alpha:K8:1) | (ve_Type=Est un texte:K8:3))
		
		If ($vb_OK)
			
			If (<>tb_RdsPopVis{$1}{$ii})  //18/7/2008 
				
				If (Field:C253($L_Table; $L_Field)->="NR")
					$0:=$0+1
				End if 
				
			End if 
			
		End if 
		
	End if 
	
End for 