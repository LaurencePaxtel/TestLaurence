//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uExportTGIP_5
//{
//{          Jeudi 4 décembre 2003 à 10:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)


C_TEXT:C284(vt_NomFic; vt_texte)
C_TEXT:C284(va_nbFic)
Case of 
	: ($1=1)
		vt_NomFic:=vt_DebtNomFic+"_5DemPrests"
		i_Message("Export `5 - Demandes Prestations …")
		QUERY:C277([GIP:13]; [GIP:13]GI_Rubrique:2=<>Va_DemP)
		MultiSoc_Filter(->[GIP:13])
	: ($1=2)
		vt_NomFic:=vt_DebtNomFic+"_6AdrUtiles"
		i_Message("Export `6 - Adresses Utiles …")
		QUERY:C277([GIP:13]; [GIP:13]GI_Rubrique:2=<>Va_AdUtil)
		MultiSoc_Filter(->[GIP:13])
	: ($1=3)
		vt_NomFic:=vt_DebtNomFic+"_7SitParts"
		i_Message("Export `7 - Situations Particulieres …")
		QUERY:C277([GIP:13]; [GIP:13]GI_Rubrique:2=<>Va_SitPar)
		MultiSoc_Filter(->[GIP:13])
End case 
va_nbFic:=String:C10(Records in selection:C76([GIP:13]))
$ii:=0
C_TIME:C306($h_RefDoc)
$h_RefDoc:=?00:00:00?
If (Records in selection:C76([GIP:13])>0)
	ORDER BY:C49([GIP:13]; [GIP:13]GI_Theme:3; >; *)
	ORDER BY:C49([GIP:13]; [GIP:13]GI_SousTheme:4; >; *)
	ORDER BY:C49([GIP:13]; [GIP:13]GI_Nom:5; >)
	//FIRST RECORD([GIP])
	$h_RefDoc:=Create document:C266(vt_NomFic)
	If (OK=1)
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		SEND PACKET:C103($h_RefDoc; "Reference interne"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Rubrique"+va_TAB+"Theme"+va_TAB+"Sous theme"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Nom"+va_TAB+"Nom suite"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Adr1"+va_TAB+"Adr2"+va_TAB+"Adr3"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "CP"+va_TAB+"Ville"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Arr"+va_TAB+"Metro"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Telephone"+va_TAB+"Telecopie"+va_TAB+"Contact"+va_TAB)
		
		SEND PACKET:C103($h_RefDoc; "Conditions"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Horaires"+va_TAB)
		SEND PACKET:C103($h_RefDoc; "Notes")
		
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		SEND PACKET:C103($h_RefDoc; <>va_LF)
		
		If (vb_OKTêtes)
			
			Repeat 
				$ii:=$ii+1
				Case of 
					: ($1=1)
						i_MessageSeul("Export `5 - Demandes de prestations  - "+va_nbFic+" / "+String:C10($ii))
					: ($1=2)
						i_MessageSeul("Export `6 - Adresses utiles  - "+va_nbFic+" / "+String:C10($ii))
					: ($1=3)
						i_MessageSeul("Export `7 - Situations particulières  - "+va_nbFic+" / "+String:C10($ii))
				End case 
				
				SEND PACKET:C103($h_RefDoc; String:C10([GIP:13]GI_ReferenceID:1)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([GIP:13]GI_Rubrique:2)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([GIP:13]GI_Theme:3)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([GIP:13]GI_SousTheme:4)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([GIP:13]GI_Nom:5)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([GIP:13]GI_Nom2:6)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([GIP:13]GI_Adresse1:7)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([GIP:13]GI_Adresse2:8)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([GIP:13]GI_Adresse3:9)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([GIP:13]GI_CP:10)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([GIP:13]GI_Ville:11)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([GIP:13]GI_Arr:12)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([GIP:13]GI_Metro:13)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([GIP:13]GI_Téléphone:14)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([GIP:13]GI_Télécopie:15)+va_TAB)
				SEND PACKET:C103($h_RefDoc; F_MacOuWindow([GIP:13]GI_Contact:16)+va_TAB)
				
				vt_texte:=[GIP:13]GI_Conditions:17
				vt_texte:=Replace string:C233(vt_texte; Char:C90(13); <>va_ForCR)
				vt_texte:=F_MacOuWindow(vt_texte)
				SEND PACKET:C103($h_RefDoc; vt_texte+va_TAB)
				
				vt_texte:=[GIP:13]GI_Horaires:18
				vt_texte:=Replace string:C233(vt_texte; Char:C90(13); <>va_ForCR)
				vt_texte:=F_MacOuWindow(vt_texte)
				SEND PACKET:C103($h_RefDoc; vt_texte+va_TAB)
				
				vt_texte:=[GIP:13]GI_Notes:19
				vt_texte:=Replace string:C233(vt_texte; Char:C90(13); <>va_ForCR)
				vt_texte:=F_MacOuWindow(vt_texte)
				SEND PACKET:C103($h_RefDoc; vt_texte)
				
				SEND PACKET:C103($h_RefDoc; <>va_CR)
				SEND PACKET:C103($h_RefDoc; <>va_LF)
				
				NEXT RECORD:C51([GIP:13])
			Until (End selection:C36([GIP:13]))
		End if 
		
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267($h_RefDoc)
		
	End if 
End if 
CLOSE WINDOW:C154