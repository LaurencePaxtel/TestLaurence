//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction:  F_DisponibilitéDate
//{
//{          Lundi 20 décembre 2004 à 17:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_DATE:C307($1)
C_LONGINT:C283($2)

$0:=($1>!00-00-00!)

If ($0)
	
	If ($2=1)
		CONFIRM:C162("Voulez-vous saisir les disponiblités pour le : "+String:C10($1))
		$0:=(OK=1)
	Else 
		$0:=True:C214
	End if 
	
End if 