//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uExportTGIP_7
//{
//{          Lundi 15 décembre 2003 à 23:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}




ALL RECORDS:C47([MemO:30])
MultiSoc_Filter(->[MemO:30])

C_TEXT:C284(vt_NomFic; vt_texte)
C_TEXT:C284(va_nbFic)
va_nbFic:=String:C10(Records in selection:C76([MemO:30]))
vt_NomFic:=vt_DebtNomFic+"_9LesMemo"
$ii:=0
i_Message("Export `9 - Les memo …")
C_TIME:C306($h_RefDoc)
$h_RefDoc:=?00:00:00?
If (Records in selection:C76([MemO:30])>0)
	
	ORDER BY:C49([MemO:30]; [MemO:30]MO_Heure:3; >; *)
	ORDER BY:C49([MemO:30]; [MemO:30]MO_Date:2; >)
	// FIRST RECORD([MemO])
	
	$h_RefDoc:=Create document:C266(vt_NomFic)
	If (OK=1)
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		SEND PACKET:C103($h_RefDoc; "Reference Utilisateur"+va_TAB+"Utilisateur"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Date"+va_TAB+"Heure"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Note")
		
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		SEND PACKET:C103($h_RefDoc; <>va_LF)
		If (vb_OKTêtes)
			
			Repeat 
				$ii:=$ii+1
				i_MessageSeul("Export `9 - Les mémos  - "+va_nbFic+" / "+String:C10($ii))
				QUERY:C277([INtervenants:10]; [INtervenants:10]IN_RéférenceID:1=[MemO:30]MO_UserID:1)
				MultiSoc_Filter(->[INtervenants:10])
				If (Records in selection:C76([INtervenants:10])=1)
					vt_texte:=[INtervenants:10]IN_Nom:4+" "+[INtervenants:10]IN_Prénom:5
				Else 
					vt_texte:=""
				End if 
				SEND PACKET:C103($h_RefDoc; String:C10([MemO:30]MO_UserID:1)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow(vt_texte)+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([MemO:30]MO_Date:2; Interne date court:K1:7)+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([MemO:30]MO_Heure:3; h mn s:K7:1)+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Jour"*Num:C11([MemO:30]MO_Nuit:4=False:C215))+("Nuit"*Num:C11([MemO:30]MO_Nuit:4=True:C214)))+va_TAB)
				
				
				vt_texte:=[MemO:30]MO_Note:5
				vt_texte:=Replace string:C233(vt_texte; Char:C90(13); <>va_ForCR)
				vt_texte:=F_MacOuWindow(vt_texte)
				SEND PACKET:C103($h_RefDoc; vt_texte)
				
				
				SEND PACKET:C103($h_RefDoc; <>va_CR)
				SEND PACKET:C103($h_RefDoc; <>va_LF)
				
				
				NEXT RECORD:C51([MemO:30])
			Until (End selection:C36([MemO:30]))
		End if 
		
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267($h_RefDoc)
		
	End if 
End if 
CLOSE WINDOW:C154