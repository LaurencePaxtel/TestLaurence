//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uSTR
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

TableSTR(0; 0)
TableSTR(3; 0)
TableSTR(1; 1)
TableSTR(4; 1)

CLOSE WINDOW

READ WRITE([DiaLogues])

FORM SET INPUT([DiaLogues]; "DL_STR")
va_Titre:="Libellé des ressources STR"

$vl_Fenetre:=i_FenêtreNo(632; 508; 4; va_Titre; 1; "")
ADD RECORD([DiaLogues]; *)

CLOSE WINDOW($vl_Fenetre)
READ ONLY([DiaLogues])

◊PR_STR:=0

If (vb_Show)
Général_Show
End if */

ALERT:C41("Fonction indisponible pour le moment")