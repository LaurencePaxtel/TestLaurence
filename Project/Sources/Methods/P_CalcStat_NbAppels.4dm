//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CalcStat_NbAppels
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

//Nombre d'appels
vl_AP_Nb:=0
vl_AP_NbOui:=0
vl_Lit_Oui:=0

If (vd_Date1=vd_Date2)
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_Date1; *)
Else 
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_Date1; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_Date2; *)
End if 
If ((rJourNuit1=1) & (rJourNuit2=1))
Else 
	If (rJourNuit1=1)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
	End if 
	If (rJourNuit2=1)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214; *)
	End if 
End if 
If (rReport=0)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92=1; *)
End if 
//Sans les inconnus
If (u2=1)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nom:21#"X0@"; *)
End if 

QUERY:C277([HeberGement:5])

MultiSoc_Filter(->[HeberGement:5])

C_LONGINT:C283($oo; $kk)
If (Size of array:C274(ta_xGroupe)>0)
	$oo:=0
	For ($kk; 1; Size of array:C274(ta_xGroupe))
		If (te_xGroupe{$kk}=1)
			$oo:=$oo+1
		End if 
	End for 
	Case of 
		: ($oo=0)
		: ($oo>=Size of array:C274(ta_xGroupe))
		: ($oo<Size of array:C274(ta_xGroupe))
			If (Records in selection:C76([HeberGement:5])>0)
				
				C_LONGINT:C283($pipi)
				$pipi:=0
				For ($kk; 1; Size of array:C274(ta_xGroupe))
					If (te_xGroupe{$kk}=1)
						If ($pipi=0)
							$pipi:=1
							If (ta_xGroupe{$kk}="115")
								QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_FamGroupe:102=""; *)
								QUERY SELECTION:C341([HeberGement:5];  | ; [HeberGement:5]HG_FamGroupe:102="115"; *)
							Else 
								QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_FamGroupe:102=ta_xGroupe{$kk}; *)
							End if 
						Else 
							If (ta_xGroupe{$kk}="115")
								QUERY SELECTION:C341([HeberGement:5];  | ; [HeberGement:5]HG_FamGroupe:102=""; *)
								QUERY SELECTION:C341([HeberGement:5];  | ; [HeberGement:5]HG_FamGroupe:102="115"; *)
							Else 
								QUERY SELECTION:C341([HeberGement:5];  | ; [HeberGement:5]HG_FamGroupe:102=ta_xGroupe{$kk}; *)
							End if 
						End if 
					End if 
				End for 
				QUERY SELECTION:C341([HeberGement:5])
				MultiSoc_Filter(->[HeberGement:5])
			End if 
	End case 
End if 



vl_AP_Nb:=Records in selection:C76([HeberGement:5])
If (vl_AP_Nb>0)
	CREATE SET:C116([HeberGement:5]; "E_HGStat")
Else 
	CREATE EMPTY SET:C140([HeberGement:5]; "E_HGStat")
End if 
QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Cloturée:67=True:C214)
vl_AP_NbOui:=Records in selection:C76([HeberGement:5])
If (vl_AP_NbOui>0)
	CREATE SET:C116([HeberGement:5]; "E_HGStatClôt")
Else 
	CREATE EMPTY SET:C140([HeberGement:5]; "E_HGStatClôt")
End if 
vl_Lit_Oui:=vl_AP_NbOui
If (vl_AP_Nb>0)
	vl_AP_Pc:=(vl_AP_NbOui/vl_AP_Nb)*100
Else 
	vl_AP_Pc:=0
End if 