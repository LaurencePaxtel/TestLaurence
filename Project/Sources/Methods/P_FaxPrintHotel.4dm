//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_FaxPrintHotel
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Procédure : P_PrintFaxPlus
vd_DtJF:=Current date:C33
vh_HrJF:=Current time:C178
vi_Signatur:=vi_Vide
QUERY:C277([INtervenants:10]; [INtervenants:10]IN_RéférenceID:1=<>vl_UserRéfU)
MultiSoc_Filter(->[INtervenants:10])
If (Records in selection:C76([INtervenants:10])=1)
	vi_Signatur:=[INtervenants:10]IN_Signature:9
End if 
_O_PAGE SETUP:C299([HeberGement:5]; "HG_PrtFaxHotel")

C_LONGINT:C283($ii)
For ($ii; 1; Size of array:C274(ta_CTNom))
	If (tl_CTSél{$ii}=1)
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=tl_CTRéf{$ii})
		MultiSoc_Filter(->[LesCentres:9])
		If (Records in selection:C76([LesCentres:9])=1)
			va_LC_Nom:=[LesCentres:9]LC_Nom:4
			va_LC_Ad1:=[LesCentres:9]LC_Adr1:24
			va_LC_Ad2:=[LesCentres:9]LC_Adr2:25
			va_LC_CP:=[LesCentres:9]LC_CP:27
			va_LC_Ville:=[LesCentres:9]LC_Ville:28
			va_LC_Fax1:=[LesCentres:9]LC_Télécopie1:30
			va_LC_Tel:=[LesCentres:9]LC_Téléphone:29
			va_LC_Fax:=[LesCentres:9]LC_Télécopie2:31
			va_LC_Pers:=[LesCentres:9]LC_Responsable:32
			READ ONLY:C145([DePart:1])
			QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-1)
			MultiSoc_Filter(->[DePart:1])
			If (Records in selection:C76([DePart:1])=1)
				vt_Texte:=[DePart:1]DP_Texte:7
			Else 
				vt_Texte:=""
			End if 
			QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-13)
			MultiSoc_Filter(->[DePart:1])
			If (Records in selection:C76([DePart:1])=1)
				vt_TexteH:=[DePart:1]DP_Texte:7
			Else 
				vt_TexteH:=""
			End if 
			
			C_LONGINT:C283($vl_Fenetre)
			$vl_Fenetre:=i_FenêtreNo(500; 20; 5; ""; 8; "")
			MESSAGE:C88("Centre : "+[LesCentres:9]LC_Nom:4+" - "+[LesCentres:9]LC_Lieu:5+" / Télécopie : "+[LesCentres:9]LC_Télécopie2:31)
			PRINT SETTINGS:C106
			CLOSE WINDOW:C154($vl_Fenetre)
			If (OK=1)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_FamClé:104; >; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >)
				vl_NbHB:=Records in selection:C76([HeberGement:5])
				FIRST RECORD:C50([HeberGement:5])
				FORM SET OUTPUT:C54([HeberGement:5]; "HG_PrtFaxHotel")
				PRINT SELECTION:C60([HeberGement:5]; *)
			End if 
		End if 
	End if 
End for 
FIRST RECORD:C50([HeberGement:5])
vl_NbHB:=Records in selection:C76([HeberGement:5])

