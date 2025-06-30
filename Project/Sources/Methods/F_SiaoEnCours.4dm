//%attributes = {}
C_LONGINT:C283($0)
C_LONGINT:C283($1)

QUERY:C277([SIAO:50]; [SIAO:50]Si_Demandeur_ID:21=$1; *)
QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_DemandeAnnulee_Date:30=!00-00-00!; *)
QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Fermeture:46=!00-00-00!)

$0:=Records in selection:C76([SIAO:50])