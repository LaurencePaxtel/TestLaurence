//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_Report_FullPlateForme 
//{
//{          Mardi 4 novembre 2008 à 17:33
//{          Modifiée : 4 novembre 2008 à 17:33
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)  //Pointeur sur le  champ booleen DDASS
C_TEXT:C284($2)  //Intitulé de la plateforme

C_BOOLEAN:C305($vb_OK)

$1->:=False:C215

If (Length:C16($2)>0)
	
	If (Character code:C91($2)=64)
		$1->:=True:C214
	Else 
		$vb_OK:=($2[[Length:C16($2)]]=")")
		
		If ($vb_OK)
			$vb_OK:=($2[[Length:C16($2)-2]]="(")
			
			If ($vb_OK)
				
				If ($2[[Length:C16($2)-1]]="D")
					$1->:=True:C214
				End if 
				
			End if 
			
		End if 
		
	End if 
	
End if 