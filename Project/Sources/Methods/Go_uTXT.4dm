//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uTXT
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305(vb_Show)

// Modifié par : Scanu Rémy (25/01/2023)
/*
READ ONLY(*)
SET MENU BAR(1)

vb_Show:=False

i_Message("Chargement en cours…")
TableTXT(0; 0)

CLOSE WINDOW

READ WRITE([DiaLogues])
FORM SET INPUT([DiaLogues]; "DL_TXT")

va_Titre:="Libellé des ressources TXT"
$vl_Fenetre:=i_FenêtreNo(462; 436; 4; va_Titre; 2; "")

ADD RECORD([DiaLogues]; *)
CLOSE WINDOW($vl_Fenetre)

READ ONLY([DiaLogues])

◊PR_TXT:=0

If (vb_Show)
Général_Show
End if */

ALERT:C41("Fonction indisponible pour le moment")