//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CentreCouleurNiveau
//{
//{          Mercredi 28 octobre 2009 à 17:32:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)
C_LONGINT:C283($2)

Case of 
	: ($2=1)
		_O_OBJECT SET COLOR:C271($1->; -(Noir:K11:16+(256*Blanc:K11:1)))
	: ($2=2)
		_O_OBJECT SET COLOR:C271($1->; -(Marron:K11:14+(256*Blanc:K11:1)))
	: ($2=3)
		_O_OBJECT SET COLOR:C271($1->; -(Rouge:K11:4+(256*Blanc:K11:1)))
	: ($2=4)
		_O_OBJECT SET COLOR:C271($1->; -(Bleu:K11:7+(256*Blanc:K11:1)))
	Else 
		_O_OBJECT SET COLOR:C271($1->; -(Gris:K11:15+(256*Blanc:K11:1)))
End case 