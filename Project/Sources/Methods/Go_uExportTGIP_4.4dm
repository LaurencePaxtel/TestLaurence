//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uExportTGIP_4
//{
//{          Jeudi 4 décembre 2003 à 10:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}




ALL RECORDS:C47([LesCentres:9])
MultiSoc_Filter(->[LesCentres:9])

C_TEXT:C284(vt_NomFic; vt_texte)
C_TEXT:C284(va_nbFic)
va_nbFic:=String:C10(Records in selection:C76([LesCentres:9]))
vt_NomFic:=vt_DebtNomFic+"_4LesCentres"
$ii:=0
i_Message("Export `4 - Les centres …")
C_TIME:C306($h_RefDoc)
$h_RefDoc:=?00:00:00?
If (Records in selection:C76([LesCentres:9])>0)
	
	ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
	//FIRST RECORD([LesCentres])
	
	$h_RefDoc:=Create document:C266(vt_NomFic)
	If (OK=1)
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		SEND PACKET:C103($h_RefDoc; "Reference interne"+va_TAB+"Type"+va_TAB+"Nom"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Lieu"+va_TAB+"Adr1"+va_TAB+"Adr2"+va_TAB+"Adr3"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "CP"+va_TAB+"Ville"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Telephone 1"+va_TAB+"Telephone 2"+va_TAB+"Telecopie"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Responsable"+va_TAB+"Responsable regul"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Associaion"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Envoi"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Homme"+va_TAB+"Femme"+va_TAB+"Marie"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Enfant"+va_TAB+"Famille"+va_TAB+"16 a 24"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "18 a 25"+va_TAB+"18 a 40"+va_TAB+"28 et plus"+va_TAB+"18 a 55"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Toxicomane"+va_TAB+"Alcool"+va_TAB+"HIV"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Prostitue"+va_TAB+"Violent"+va_TAB+"Prison"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Traitement psy"+va_TAB+"Irregulier"+va_TAB+"Lit medicalise"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Capacite lit jour"+va_TAB+"Capacite lit nuit"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "System com"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Public concerne"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Capacite d'accueil"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Fonctionnement"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Particularite"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Capacite d'accueil en regulation"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Service medical"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Notes")
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		SEND PACKET:C103($h_RefDoc; <>va_LF)
		If (vb_OKTêtes)
			
			Repeat 
				$ii:=$ii+1
				i_MessageSeul("Export `4 - Les centres  - "+va_nbFic+" / "+String:C10($ii))
				
				SEND PACKET:C103($h_RefDoc; String:C10([LesCentres:9]LC_RéférenceID:1)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([LesCentres:9]LC_Type:2)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([LesCentres:9]LC_Nom:4)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([LesCentres:9]LC_Lieu:5)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([LesCentres:9]LC_Adr1:24)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([LesCentres:9]LC_Adr2:25)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([LesCentres:9]LC_Adr3:26)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([LesCentres:9]LC_CP:27)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([LesCentres:9]LC_Ville:28)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([LesCentres:9]LC_Téléphone:29)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([LesCentres:9]LC_Télécopie1:30)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([LesCentres:9]LC_Télécopie2:31)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([LesCentres:9]LC_Responsable:32)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([LesCentres:9]LC_RespRegul:33)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([LesCentres:9]LC_AS_Nom:35)+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; (("Tel"*Num:C11([LesCentres:9]LC_Mod_Fax_Tel:42=False:C215))+("Fax"*Num:C11([LesCentres:9]LC_Mod_Fax_Tel:42=True:C214)))+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([LesCentres:9]LC_H:6=False:C215))+("Oui"*Num:C11([LesCentres:9]LC_H:6=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([LesCentres:9]LC_F:7=False:C215))+("Oui"*Num:C11([LesCentres:9]LC_F:7=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([LesCentres:9]LC_M:8=False:C215))+("Oui"*Num:C11([LesCentres:9]LC_M:8=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([LesCentres:9]LC_E:9=False:C215))+("Oui"*Num:C11([LesCentres:9]LC_E:9=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([LesCentres:9]LC_FA:10=False:C215))+("Oui"*Num:C11([LesCentres:9]LC_FA:10=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([LesCentres:9]LC_16à24:11=False:C215))+("Oui"*Num:C11([LesCentres:9]LC_16à24:11=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([LesCentres:9]LC_18à25:12=False:C215))+("Oui"*Num:C11([LesCentres:9]LC_18à25:12=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([LesCentres:9]LC_18à40:13=False:C215))+("Oui"*Num:C11([LesCentres:9]LC_18à40:13=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([LesCentres:9]LC_28etPlus:14=False:C215))+("Oui"*Num:C11([LesCentres:9]LC_28etPlus:14=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([LesCentres:9]LC_18à55:15=False:C215))+("Oui"*Num:C11([LesCentres:9]LC_18à55:15=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([LesCentres:9]LC_Toxico:16=False:C215))+("Oui"*Num:C11([LesCentres:9]LC_Toxico:16=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([LesCentres:9]LC_Alcool:45=False:C215))+("Oui"*Num:C11([LesCentres:9]LC_Alcool:45=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([LesCentres:9]LC_HIV:46=False:C215))+("Oui"*Num:C11([LesCentres:9]LC_HIV:46=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([LesCentres:9]LC_Prostitué:17=False:C215))+("Oui"*Num:C11([LesCentres:9]LC_Prostitué:17=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([LesCentres:9]LC_Violent:18=False:C215))+("Oui"*Num:C11([LesCentres:9]LC_Violent:18=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([LesCentres:9]LC_Prison:19=False:C215))+("Oui"*Num:C11([LesCentres:9]LC_Prison:19=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([LesCentres:9]LC_TraitPsy:20=False:C215))+("Oui"*Num:C11([LesCentres:9]LC_TraitPsy:20=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([LesCentres:9]LC_Irrégulier:21=False:C215))+("Oui"*Num:C11([LesCentres:9]LC_Irrégulier:21=True:C214)))+va_TAB)
				SEND PACKET:C103($h_RefDoc; (("Non"*Num:C11([LesCentres:9]LC_LitMédicalis:47=False:C215))+("Oui"*Num:C11([LesCentres:9]LC_LitMédicalis:47=True:C214)))+va_TAB)
				
				SEND PACKET:C103($h_RefDoc; String:C10([LesCentres:9]LC_DispoJour:48)+va_TAB)
				SEND PACKET:C103($h_RefDoc; String:C10([LesCentres:9]LC_DispoNuit:22)+va_TAB)
				
				vt_texte:=[LesCentres:9]LC_SystemeCom:43
				vt_texte:=Replace string:C233(vt_texte; Char:C90(13); <>va_ForCR)
				vt_texte:=F_MacOuWindow(vt_texte)
				SEND PACKET:C103($h_RefDoc; vt_texte+va_TAB)
				
				vt_texte:=[LesCentres:9]LC_PubCon:36
				vt_texte:=Replace string:C233(vt_texte; Char:C90(13); <>va_ForCR)
				vt_texte:=F_MacOuWindow(vt_texte)
				SEND PACKET:C103($h_RefDoc; vt_texte+va_TAB)
				
				vt_texte:=[LesCentres:9]LC_Capacité:38
				vt_texte:=Replace string:C233(vt_texte; Char:C90(13); <>va_ForCR)
				vt_texte:=F_MacOuWindow(vt_texte)
				SEND PACKET:C103($h_RefDoc; vt_texte+va_TAB)
				
				vt_texte:=[LesCentres:9]LC_Fonctionem:39
				vt_texte:=Replace string:C233(vt_texte; Char:C90(13); <>va_ForCR)
				vt_texte:=F_MacOuWindow(vt_texte)
				SEND PACKET:C103($h_RefDoc; vt_texte+va_TAB)
				
				vt_texte:=[LesCentres:9]LC_Particularit:37
				vt_texte:=Replace string:C233(vt_texte; Char:C90(13); <>va_ForCR)
				vt_texte:=F_MacOuWindow(vt_texte)
				SEND PACKET:C103($h_RefDoc; vt_texte+va_TAB)
				
				vt_texte:=[LesCentres:9]LC_CapacitéRegu:41
				vt_texte:=Replace string:C233(vt_texte; Char:C90(13); <>va_ForCR)
				vt_texte:=F_MacOuWindow(vt_texte)
				SEND PACKET:C103($h_RefDoc; vt_texte+va_TAB)
				
				vt_texte:=[LesCentres:9]LC_ServMed:40
				vt_texte:=Replace string:C233(vt_texte; Char:C90(13); <>va_ForCR)
				vt_texte:=F_MacOuWindow(vt_texte)
				SEND PACKET:C103($h_RefDoc; vt_texte+va_TAB)
				
				vt_texte:=[LesCentres:9]LC_Notes:44
				vt_texte:=Replace string:C233(vt_texte; Char:C90(13); <>va_ForCR)
				vt_texte:=F_MacOuWindow(vt_texte)
				SEND PACKET:C103($h_RefDoc; vt_texte)
				
				
				SEND PACKET:C103($h_RefDoc; <>va_CR)
				SEND PACKET:C103($h_RefDoc; <>va_LF)
				
				
				NEXT RECORD:C51([LesCentres:9])
			Until (End selection:C36([LesCentres:9]))
		End if 
		
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267($h_RefDoc)
		
	End if 
End if 
CLOSE WINDOW:C154