//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementDécoupageFamille
//{
//{          Lundi 28 décembre 2009 à 16:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_DATE:C307($1)
C_LONGINT:C283($2)

tb_ColFamClé{$2}:=False:C215

C_LONGINT:C283($vl_moins; $vl_plus)
$vl_moins:=0
$vl_plus:=0

USE SET:C118("E_Perimetre")
QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_FamClé:104=ta_ColFamClé{$2})
If (Records in selection:C76([HeberGement:5])>0)
	//FIRST RECORD([HeberGement])
	Repeat 
		If (F_EtatCivilEnfant([HeberGement:5]HG_EtatCivil:20))
			If (Add to date:C393([HeberGement:5]HG_DateNéLe:24; 3; 0; 0)<$1)
				$vl_plus:=$vl_plus+1
			Else 
				$vl_moins:=$vl_moins+1
			End if 
		End if 
		NEXT RECORD:C51([HeberGement:5])
	Until (End selection:C36([HeberGement:5]))
End if 
If ($vl_moins>0) & ($vl_plus=0)
	tb_ColFamClé{$2}:=True:C214
End if 