//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uExportTGIP_1
//{
//{          Jeudi 4 décembre 2003 à 10:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}




ALL RECORDS:C47([HeBerge:4])
MultiSoc_Filter(->[HeBerge:4])

C_TEXT:C284(vt_NomFic; vt_texte)
C_TEXT:C284(va_nbFic)
va_nbFic:=String:C10(Records in selection:C76([HeBerge:4]))
vt_NomFic:=vt_DebtNomFic+"_1Personnes"
$ii:=0
i_Message("Export `1 - L'heberge et sa note, sa note action et SP  …")
C_TIME:C306($h_RefDoc)
$h_RefDoc:=?00:00:00?
If (Records in selection:C76([HeBerge:4])>0)
	ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
	//FIRST RECORD([HeBerge])
	
	$h_RefDoc:=Create document:C266(vt_NomFic)
	If (OK=1)
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		SEND PACKET:C103($h_RefDoc; "Reference interne"+va_TAB+"Cle"+va_TAB+"Cle famille"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Nom"+va_TAB+"Prenom"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "NeLe"+va_TAB+"Genre"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "SP01"+va_TAB+"SP01 date"+va_TAB+"SP01 commentaire"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "SP02"+va_TAB+"SP02 date"+va_TAB+"SP02 commentaire"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "SP03"+va_TAB+"SP03 date"+va_TAB+"SP03 commentaire"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "SP04"+va_TAB+"SP04 date"+va_TAB+"SP04 commentaire"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "SP05"+va_TAB+"SP05 date"+va_TAB+"SP05 commentaire"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "SP06"+va_TAB+"SP06 date"+va_TAB+"SP06 commentaire"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "SP07"+va_TAB+"SP07 date"+va_TAB+"SP07 commentaire"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "SP08"+va_TAB+"SP08 date"+va_TAB+"SP08 commentaire"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "SP09"+va_TAB+"SP09 date"+va_TAB+"SP09 commentaire"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "SP10"+va_TAB+"SP10 date"+va_TAB+"SP10 commentaire"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Persona non grata"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Note"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Action")
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		SEND PACKET:C103($h_RefDoc; <>va_LF)
		If (vb_OKTêtes)
			
			Repeat 
				$ii:=$ii+1
				i_MessageSeul("Export `1 - L'heberge et sa note, sa note action et SP  - "+va_nbFic+" / "+String:C10($ii))
				
				SEND PACKET:C103($h_RefDoc; String:C10([HeBerge:4]HB_ReferenceID:1)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeBerge:4]HB_Clé:2)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeBerge:4]HB_CléFam:47)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([HeBerge:4]HB_Nom:3)+va_TAB+F_MacOuWindow([HeBerge:4]HB_Prénom:4)+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([HeBerge:4]HB_DateNéLe:5; Interne date court:K1:7)+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Masculin"*Num:C11([HeBerge:4]HG_Genre:39=False:C215))+("Feminin"*Num:C11([HeBerge:4]HG_Genre:39=True:C214)))+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeBerge:4]HB_Cas1:7=False:C215))+("Oui"*Num:C11([HeBerge:4]HB_Cas1:7=True:C214)))+va_TAB+String:C10([HeBerge:4]HB_CasDt1:19; Interne date court:K1:7)+va_TAB+F_MacOuWindow([HeBerge:4]HB_CasLib1:29)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeBerge:4]HB_Cas2:8=False:C215))+("Oui"*Num:C11([HeBerge:4]HB_Cas2:8=True:C214)))+va_TAB+String:C10([HeBerge:4]HB_CasDt2:20; Interne date court:K1:7)+va_TAB+F_MacOuWindow([HeBerge:4]HB_CasLib2:30)+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeBerge:4]HB_Cas3:9=False:C215))+("Oui"*Num:C11([HeBerge:4]HB_Cas3:9=True:C214)))+va_TAB+String:C10([HeBerge:4]HB_CasDt3:21; Interne date court:K1:7)+va_TAB+F_MacOuWindow([HeBerge:4]HB_CasLib3:31)+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeBerge:4]HB_Cas4:10=False:C215))+("Oui"*Num:C11([HeBerge:4]HB_Cas4:10=True:C214)))+va_TAB+String:C10([HeBerge:4]HB_CasDt4:22; Interne date court:K1:7)+va_TAB+F_MacOuWindow([HeBerge:4]HB_CasLib4:32)+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeBerge:4]HB_Cas5:11=False:C215))+("Oui"*Num:C11([HeBerge:4]HB_Cas5:11=True:C214)))+va_TAB+String:C10([HeBerge:4]HB_CasDt5:23; Interne date court:K1:7)+va_TAB+F_MacOuWindow([HeBerge:4]HB_CasLib5:33)+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeBerge:4]HB_Cas6:12=False:C215))+("Oui"*Num:C11([HeBerge:4]HB_Cas6:12=True:C214)))+va_TAB+String:C10([HeBerge:4]HB_CasDt6:24; Interne date court:K1:7)+va_TAB+F_MacOuWindow([HeBerge:4]HB_CasLib6:34)+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeBerge:4]HB_Cas7:13=False:C215))+("Oui"*Num:C11([HeBerge:4]HB_Cas7:13=True:C214)))+va_TAB+String:C10([HeBerge:4]HB_CasDt7:25; Interne date court:K1:7)+va_TAB+F_MacOuWindow([HeBerge:4]HB_CasLib7:35)+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeBerge:4]HB_Cas8:14=False:C215))+("Oui"*Num:C11([HeBerge:4]HB_Cas8:14=True:C214)))+va_TAB+String:C10([HeBerge:4]HB_CasDt8:26; Interne date court:K1:7)+va_TAB+F_MacOuWindow([HeBerge:4]HB_CasLib8:36)+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeBerge:4]HB_Cas9:15=False:C215))+("Oui"*Num:C11([HeBerge:4]HB_Cas9:15=True:C214)))+va_TAB+String:C10([HeBerge:4]HB_CasDt9:27; Interne date court:K1:7)+va_TAB+F_MacOuWindow([HeBerge:4]HB_CasLib9:37)+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeBerge:4]HB_Cas10:16=False:C215))+("Oui"*Num:C11([HeBerge:4]HB_Cas10:16=True:C214)))+va_TAB+String:C10([HeBerge:4]HB_CasDt10:28; Interne date court:K1:7)+va_TAB+F_MacOuWindow([HeBerge:4]HB_CasLib10:38)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([HeBerge:4]HB_Status:18=False:C215))+("Oui"*Num:C11([HeBerge:4]HB_Status:18=True:C214)))+va_TAB)
				
				vt_texte:=[HeBerge:4]Notes:6
				vt_texte:=Replace string:C233(vt_texte; Char:C90(10); "")
				vt_texte:=Replace string:C233(vt_texte; Char:C90(13); <>va_ForCR)
				vt_texte:=F_MacOuWindow(vt_texte)
				SEND PACKET:C103($h_RefDoc; vt_texte+va_TAB)
				
				vt_texte:=[HeBerge:4]HG_Actions:40
				vt_texte:=Replace string:C233(vt_texte; Char:C90(10); "")
				vt_texte:=Replace string:C233(vt_texte; Char:C90(13); <>va_ForCR)
				vt_texte:=F_MacOuWindow(vt_texte)
				SEND PACKET:C103($h_RefDoc; vt_texte)
				
				SEND PACKET:C103($h_RefDoc; <>va_CR)
				SEND PACKET:C103($h_RefDoc; <>va_LF)
				
				NEXT RECORD:C51([HeBerge:4])
			Until (End selection:C36([HeBerge:4]))
		End if 
		
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15 
		CLOSE DOCUMENT:C267($h_RefDoc)
		
	End if 
End if 
CLOSE WINDOW:C154