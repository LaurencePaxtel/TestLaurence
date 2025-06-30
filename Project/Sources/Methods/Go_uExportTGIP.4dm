//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uExportTGIP
//{
//{          Jeudi 4 décembre 2003 à 10:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
READ ONLY:C145(*)
SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 
i_Message("Chargement en cours…")

C_BOOLEAN:C305(vb_OK)
vb_OK:=False:C215

C_BOOLEAN:C305(vb_OKTêtes)
vb_OKTêtes:=True:C214

C_TEXT:C284(vt_DebtNomFic)
C_DATE:C307($vd_Date)
C_TIME:C306($vh_Heure)

C_TEXT:C284($va_DebDate; $va_DebHeure)
C_TEXT:C284(va_TAB)
va_TAB:=Char:C90(9)

CLOSE WINDOW:C154

va_Titre:="Export N°RG 03/12770"


va_Titre:="Export"
$vl_Fenetre:=i_FenêtreNo(466; 262; 16; va_Titre; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_uExport03")
CLOSE WINDOW:C154($vl_Fenetre)
If (OK=1)
	CONFIRM:C162("Exporter les données en mode texte sur disque."+Char:C90(13)+"Confirmez-vous ?")
	If (OK=1)
		$vd_Date:=Current date:C33
		$vh_Heure:=Current time:C178
		$va_DebDate:=String:C10(Current date:C33; Interne date court:K1:7)
		$va_DebHeure:=String:C10(Current time:C178; h mn:K7:2)
		$va_DebHeure:=Replace string:C233($va_DebHeure; ":"; "")
		
		vt_DebtNomFic:=String:C10(Year of:C25($vd_Date); "0000")+String:C10(Month of:C24($vd_Date); "00")+String:C10(Day of:C23($vd_Date); "00")+$va_DebHeure
		vt_DebtNomFic:=""
		//1 - L'hébergé et sa note, sa note action et SP
		//2 - Les hébergements
		//3 - Les associations
		//4 - Les centres
		//5 - Demandes de prestation
		//6 - Adresses utiles
		//7 - Situations particulieres
		//8 - AD : les appels
		//9 - Les memo
		<>va_ForCR:="__"
		
		//UTILISER FILTRE("ExportFiltre";0)
		Go_uExportTGIP_1
		Go_uExportTGIP_2
		Go_uExportTGIP_3
		Go_uExportTGIP_4
		Go_uExportTGIP_5(1)
		
		Go_uExportTGIP_5(2)
		
		Go_uExportTGIP_5(3)
		Go_uExportTGIP_6
		Go_uExportTGIP_7
		
		//UTILISER FILTRE(*;0)
	End if 
	
End if 

<>PR_Export0312770:=0
If (vb_Show)
	Général_Show
End if 