//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_TroisFoisRienCentre
//{
//{          Lundi 1 février 2010 à 15:30:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_LONGINT:C283($ii; $jj)


DISTINCT VALUES:C339([HeberGement:5]HG_LC_ID:61; $2->)
$jj:=Size of array:C274($2->)
ARRAY INTEGER:C220($1->; $jj)
ARRAY TEXT:C222($3->; $jj)
For ($ii; 1; $jj)
	$1->{$ii}:=1
	$3->{$ii}:=""
	QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=$2->{$ii})
	MultiSoc_Filter(->[LesCentres:9])
	If (Records in selection:C76([LesCentres:9])=1)
		$3->{$ii}:=[LesCentres:9]LC_Nom:4
	End if 
End for 
SORT ARRAY:C229($3->; $2->; $1->; >)