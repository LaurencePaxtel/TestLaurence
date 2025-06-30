//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementCorrection
//{
//{          Mercredi 9 décembre 2009 à 17:30:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($vl_Fenetre)

Case of 
	: ($1=0)
		
	: ($1=1)
		If (Records in selection:C76([HeberGement:5])>0)
			
			SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_ItemOldRéf; [HeberGement:5]HG_Date:4; td_ItemOldDate; tp_ItemRub{ta_ItemRub}->; tt_ItemOld)
			va_ItemValeur:=""
			$vl_Fenetre:=i_FenêtreNo(586; 532; 5; "Appliquer la modification"; 4; "")
			DIALOG:C40([DiaLogues:3]; "DL_CorrectionAppl")
			CLOSE WINDOW:C154($vl_Fenetre)
			
			ARRAY LONGINT:C221(tl_ItemOldRéf; 0)
			ARRAY DATE:C224(td_ItemOldDate; 0)
			ARRAY TEXT:C222(tt_ItemOld; 0)
		End if 
		
		
		
End case 