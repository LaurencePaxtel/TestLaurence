//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Méthode :  F_Report_Doublons 
//{          Vendredi Vendredi 9 juillet 2010 à 12:20:00
//{          Modifiée : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215

C_BOOLEAN:C305($vb_OK; $vb_OKPlus)
C_LONGINT:C283($vl_Fenetre; $ii; $vl_Fiches; $vl_Doublons; $vl_Position)
C_TEXT:C284($vt_Doublons)
$vb_OKPlus:=True:C214
ARRAY LONGINT:C221($tl_HG_IDSup; 0)


ARRAY LONGINT:C221($tl_HG_ID; 0)
ARRAY DATE:C224($td_HG_Date; 0)
ARRAY LONGINT:C221($tl_HG_IDHB; 0)
ARRAY LONGINT:C221($tl_HG_IDLC; 0)

C_DATE:C307($vd_HG_Date)
C_LONGINT:C283($vl_HG_IDHB)
C_LONGINT:C283($vl_HG_IDLC)

$vl_Fenetre:=i_FenêtreNo(466; 232; 16; "Suppression des fiches doubles"; 4; "")
DIALOG:C40([DiaLogues:3]; "DL_ReportDoublons")
$vb_OK:=(OK=1)
CLOSE WINDOW:C154($vl_Fenetre)
If ($vb_OK)
	CREATE SET:C116([HeberGement:5]; "$E_Temp")
	i_Message("Doublons : traitement en cours…")
	QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Cloturée:67=True:C214)
	$vl_Fiches:=Records in selection:C76([HeberGement:5])
	If ($vl_Fiches>0)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HB_ID:19; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_LC_ID:61; >)
		SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; $tl_HG_ID; [HeberGement:5]HG_Date:4; $td_HG_Date; [HeberGement:5]HG_HB_ID:19; $tl_HG_IDHB; [HeberGement:5]HG_LC_ID:61; $tl_HG_IDLC)
		
		$vl_HG_ID:=0
		$vd_HG_Date:=!00-00-00!
		$vl_HG_IDHB:=0
		$vl_HG_IDLC:=0
		
		$vl_Doublons:=0
		$vt_Doublons:=""
		For ($ii; 1; $vl_Fiches)
			i_MessageSeul("Doublons : traitement en cours  "+String:C10($vl_Fiches)+"/"+String:C10($ii))
			$vb_OK:=($vd_HG_Date=$td_HG_Date{$ii})
			$vb_OK:=$vb_OK & ($vl_HG_IDHB=$tl_HG_IDHB{$ii})
			If (<>vb_REPORT_DOUBLONS)  //Centres identiques
				$vb_OK:=$vb_OK & ($vl_HG_IDLC=$tl_HG_IDLC{$ii})
			End if 
			If ($vb_OK)
				$vl_Doublons:=$vl_Doublons+1
				$vl_Position:=Size of array:C274($tl_HG_IDSup)+1
				INSERT IN ARRAY:C227($tl_HG_IDSup; $vl_Position)
				$tl_HG_IDSup{$vl_Position}:=$tl_HG_ID{$ii}
			End if 
			$vd_HG_Date:=$td_HG_Date{$ii}
			$vl_HG_IDHB:=$tl_HG_IDHB{$ii}
			$vl_HG_IDLC:=$tl_HG_IDLC{$ii}
		End for 
		$vb_OK:=True:C214
		If (Size of array:C274($tl_HG_IDSup)>0)
			
			If (i_Confirmer("Fiches d'hébergement en doublons : "+String:C10($vl_Doublons)+<>va_CR+<>va_CR+"Confirmez-vous la suppression ?"))
				READ WRITE:C146([HeberGement:5])
				QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; $tl_HG_IDSup)
				QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Facture:172=False:C215)
				If (Records in selection:C76([HeberGement:5])>0)
					DELETE SELECTION:C66([HeberGement:5])
				End if 
				UNLOAD RECORD:C212([HeberGement:5])
				READ ONLY:C145([HeberGement:5])
			Else 
				$vb_OKPlus:=False:C215
			End if 
		Else 
			ALERT:C41("Fiches d'hébergement en doublons : "+"aucune fiche")
		End if 
	End if 
	CLOSE WINDOW:C154
	If ($vb_OKPlus)
		USE SET:C118("$E_Temp")
	Else 
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; $tl_HG_IDSup)
	End if 
	
	vr_TotalDistri:=Sum:C1([HeberGement:5]HG_FamDistri5M:122)
	vL_NbFiches:=Records in selection:C76([HeberGement:5])
	If (vL_NbFiches>0)
		P_HébergementVeilleSort(2)
		OBJECT SET ENABLED:C1123(b_VoirPrtL; True:C214)
		OBJECT SET ENABLED:C1123(b_VoirPrt; True:C214)
	Else 
		OBJECT SET ENABLED:C1123(b_VoirPrtL; False:C215)
		OBJECT SET ENABLED:C1123(b_VoirPrt; False:C215)
	End if 
	P_HébergementNotesBt(0)
	OBJECT SET ENABLED:C1123(b_ModCléHG; False:C215)
	OBJECT SET ENABLED:C1123(b_PrtAct; False:C215)
	OBJECT SET ENABLED:C1123(b_PrtActF; False:C215)
	OBJECT SET ENABLED:C1123(b_Excuse; False:C215)
	
	
End if 