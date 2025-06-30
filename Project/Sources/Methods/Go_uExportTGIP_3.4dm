//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uExportTGIP_3
//{
//{          Jeudi 4 décembre 2003 à 10:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}




ALL RECORDS:C47([Assocs:14])
MultiSoc_Filter(->[Assocs:14])

C_TEXT:C284(vt_NomFic; vt_texte)
C_TEXT:C284(va_nbFic)
va_nbFic:=String:C10(Records in selection:C76([Assocs:14]))
vt_NomFic:=vt_DebtNomFic+"_3LesAssociations"
$ii:=0
i_Message("Export `3 - Les Associations  …")
C_TIME:C306($h_RefDoc)
$h_RefDoc:=?00:00:00?
If (Records in selection:C76([Assocs:14])>0)
	
	ORDER BY:C49([Assocs:14]; [Assocs:14]AS_Nom:2; >)
	//FIRST RECORD([Assocs])
	$h_RefDoc:=Create document:C266(vt_NomFic)
	If (OK=1)
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		SEND PACKET:C103($h_RefDoc; "Reference interne"+va_TAB+"Nom"+va_TAB+"Nom suite"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Adr1"+va_TAB+"Adr2"+va_TAB+"Adr3"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "CP"+va_TAB+"Ville"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Telephone"+va_TAB+"Telecopie"+va_TAB+"Contact"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Notes")
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		SEND PACKET:C103($h_RefDoc; <>va_LF)
		If (vb_OKTêtes)
			
			Repeat 
				$ii:=$ii+1
				i_MessageSeul("Export `3 - Les Associations  - "+va_nbFic+" / "+String:C10($ii))
				
				SEND PACKET:C103($h_RefDoc; String:C10([Assocs:14]AS_ReferenceID:1)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([Assocs:14]AS_Nom:2)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([Assocs:14]AS_Nom2:3)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([Assocs:14]AS_Adresse1:4)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([Assocs:14]AS_Adresse2:5)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([Assocs:14]AS_Adresse3:6)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([Assocs:14]AS_CP:7)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([Assocs:14]AS_Ville:8)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([Assocs:14]AS_Téléphone:9)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([Assocs:14]AS_Télécopie:10)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([Assocs:14]AS_Contact:11)+va_TAB)
				
				
				vt_texte:=[Assocs:14]AS_Notes:12
				vt_texte:=Replace string:C233(vt_texte; Char:C90(13); <>va_ForCR)
				vt_texte:=F_MacOuWindow(vt_texte)
				SEND PACKET:C103($h_RefDoc; vt_texte)
				
				SEND PACKET:C103($h_RefDoc; <>va_CR)
				SEND PACKET:C103($h_RefDoc; <>va_LF)
				
				NEXT RECORD:C51([Assocs:14])
			Until (End selection:C36([Assocs:14]))
		End if 
		
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267($h_RefDoc)
		
	End if 
End if 
CLOSE WINDOW:C154