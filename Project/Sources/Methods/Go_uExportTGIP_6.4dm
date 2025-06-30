//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uExportTGIP_6
//{
//{          Jeudi 4 décembre 2003 à 10:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}




ALL RECORDS:C47([APpels:19])
MultiSoc_Filter(->[APpels:19])

C_TEXT:C284(vt_NomFic; vt_texte)
C_TEXT:C284(va_nbFic)
va_nbFic:=String:C10(Records in selection:C76([APpels:19]))
vt_NomFic:=vt_DebtNomFic+"_8LesAppels"
$ii:=0
i_Message("Export `8- Les Appels …")
C_TIME:C306($h_RefDoc)
$h_RefDoc:=?00:00:00?

If (Records in selection:C76([APpels:19])>0)
	
	ORDER BY:C49([APpels:19]; [APpels:19]AP_Date:2; >)
	ORDER BY:C49([APpels:19]; [APpels:19]AP_Heure:3; <)
	// FIRST RECORD([APpels])
	
	$h_RefDoc:=Create document:C266(vt_NomFic)
	If (OK=1)
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		SEND PACKET:C103($h_RefDoc; "Reference user"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Jour ou Nuit"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Date"+va_TAB+"Heure"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Libellé")
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		SEND PACKET:C103($h_RefDoc; <>va_LF)
		If (vb_OKTêtes)
			
			Repeat 
				$ii:=$ii+1
				i_MessageSeul("Export `8 - Les appels   - "+va_nbFic+" / "+String:C10($ii))
				
				SEND PACKET:C103($h_RefDoc; String:C10([APpels:19]AP_UserID:1)+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Jour"*Num:C11([APpels:19]AP_Nuit:4=False:C215))+("Nuit"*Num:C11([APpels:19]AP_Nuit:4=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([APpels:19]AP_Date:2; Interne date court:K1:7)+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([APpels:19]AP_Heure:3; h mn s:K7:1)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([APpels:19]AP_Libellé:5))
				
				SEND PACKET:C103($h_RefDoc; <>va_CR)
				SEND PACKET:C103($h_RefDoc; <>va_LF)
				
				NEXT RECORD:C51([APpels:19])
			Until (End selection:C36([APpels:19]))
		End if 
		
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267($h_RefDoc)
		
	End if 
End if 
CLOSE WINDOW:C154
