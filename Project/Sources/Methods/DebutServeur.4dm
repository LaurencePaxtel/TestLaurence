//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DebutServeur
//{          Mardi 31 mai 2005 à 10:24:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($ve_Coordination)
$ve_Coordination:=-24
C_TEXT:C284($va_VersionApplication)
C_TEXT:C284($va_NomDeLaBase)
C_TEXT:C284($va_Libellé)
$va_Libellé:=""
$va_NomDeLaBase:=""

C_BOOLEAN:C305($vb_OK)
$vb_OK:=False:C215

READ ONLY:C145(*)
If (Application type:C494=4D Server:K5:6)
	$va_VersionApplication:=Application version:C493
	If (Num:C11(Substring:C12($va_VersionApplication; 1; 2))>=8)
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$ve_Coordination)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			$va_Libellé:=[DePart:1]DP_Texte:7
		End if 
		QUERY:C277([SOciete:18]; [SOciete:18]SO_ReferenceID:1=1)
		MultiSoc_Filter(->[SOciete:18])
		If (Records in selection:C76([SOciete:18])=1)
			$va_NomDeLaBase:=[SOciete:18]SO_CléSite:10
		End if 
		$vb_OK:=($va_Libellé#$va_NomDeLaBase)
		$vb_OK:=$vb_OK | ($va_Libellé="")
		$vb_OK:=$vb_OK | ($va_NomDeLaBase="")
		If ($vb_OK)
			QUIT 4D:C291
		End if 
	End if 
End if 
