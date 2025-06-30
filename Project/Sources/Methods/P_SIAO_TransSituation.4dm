//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_SIAO_TransSituation
//{          Lundi 6 juin 2011 à 12:50
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TIME:C306($1)  //RéfDoc
C_BOOLEAN:C305($2)  //Plateforme
C_LONGINT:C283($3)  //Rang
C_TEXT:C284($4)  //$vaTheme
C_TEXT:C284($5)  //$va_SousTheme

C_TEXT:C284($vt_Block)
C_LONGINT:C283($ii; $jj; $kk)



For ($kk; 1; $3)
	For ($ii; 1; Get last field number:C255(->[SIAO_Situations:52]))
		$vt_Block:=Substring:C12(Field name:C257(Table:C252(->[SIAO_Situations:52]); $ii); 4)+<>va_Tab+String:C10(Table:C252(->[SIAO_Situations:52]))+<>va_Tab+String:C10($ii)
		For ($jj; 1; Size of array:C274(tl_RefPers))
			QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=tl_RefPers{$jj}; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=$4; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6=$5; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Rang:7=$kk)
			MultiSoc_Filter(->[SIAO_Situations:52])
			$vt_Block:=$vt_Block+<>va_Tab+F_ChampEnChaine(Table:C252(->[SIAO_Situations:52]); $ii)
		End for 
		$vt_Block:=$vt_Block+<>va_CR
		If ($2)
			SEND PACKET:C103($1; _O_Mac to Win:C463($vt_Block))
		Else 
			SEND PACKET:C103($1; $vt_Block)
		End if 
	End for 
	$vt_Block:="SIAO SIAO SITUATIONS : "+<>va_Tab+String:C10(Table:C252(->[SIAO_Situations:52]))+<>va_Tab+"0"+<>va_Tab+"0"+<>va_Tab+"0"+<>va_CR
	If ($2)
		SEND PACKET:C103($1; _O_Mac to Win:C463($vt_Block))
	Else 
		SEND PACKET:C103($1; $vt_Block)
	End if 
	
End for 