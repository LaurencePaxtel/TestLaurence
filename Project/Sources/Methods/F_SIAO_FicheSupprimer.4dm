//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Fonction : F_SIAO_FicheSupprimer
//{
//{          Lundi 28 février 2011 à 10:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
$0:=True:C214


i_Message("Suppression en cours…")

READ WRITE:C146([SIAO:50])
READ WRITE:C146([SIAO_Personnes:51])
READ WRITE:C146([Adresses:53])
READ WRITE:C146([SIAO_Situations:52])

QUERY:C277([SIAO:50]; [SIAO:50]Si_RéférenceID:1=$1)
MultiSoc_Filter(->[SIAO:50])
If (Records in selection:C76([SIAO:50])=1)
	If (i_NonVerrou(->[SIAO:50]))
		//•1 - Personnes
		//•2 - ADRESSE 
		//•3 - SITUATIONS
		i_MessageSeul("Suppression en cours : 1/4")
		
		QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1)
		MultiSoc_Filter(->[SIAO_Personnes:51])
		If (Records in selection:C76([SIAO_Personnes:51])>0)
			DELETE SELECTION:C66([SIAO_Personnes:51])
		End if 
		i_MessageSeul("Suppression en cours : 2/4")
		QUERY:C277([Adresses:53]; [Adresses:53]AD_SIAO_ID:3=[SIAO:50]Si_RéférenceID:1)
		MultiSoc_Filter(->[Adresses:53])
		If (Records in selection:C76([Adresses:53])>0)
			DELETE SELECTION:C66([Adresses:53])
		End if 
		i_MessageSeul("Suppression en cours : 3/4")
		QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1)
		MultiSoc_Filter(->[SIAO_Situations:52])
		If (Records in selection:C76([SIAO_Situations:52])>0)
			DELETE SELECTION:C66([SIAO_Situations:52])
		End if 
		i_MessageSeul("Suppression en cours : 4/4")
		DELETE RECORD:C58([SIAO:50])
		UNLOAD RECORD:C212([SIAO:50])
	End if 
End if 


UNLOAD RECORD:C212([SIAO:50])
UNLOAD RECORD:C212([SIAO_Personnes:51])
UNLOAD RECORD:C212([Adresses:53])
UNLOAD RECORD:C212([SIAO_Situations:52])
READ ONLY:C145([SIAO:50])
READ ONLY:C145([SIAO_Personnes:51])
READ ONLY:C145([Adresses:53])
READ ONLY:C145([SIAO_Situations:52])
CLOSE WINDOW:C154