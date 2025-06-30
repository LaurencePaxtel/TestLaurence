//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Rec_Fax
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

ARRAY TEXT:C222(ta_ValFam; 1)
ta_ValFam{1}:="Toutes"
ta_ValFam:=1
ta_ValFam{0}:=ta_ValFam{1}
va_Titre:="Recherche des télécopies : "+("Matin"*Num:C11(<>Vb_Nuit=False:C215))+("Soir"*Num:C11(<>Vb_Nuit=True:C214))

i_Message(va_Titre)

va_CléFax:=Uut_FaxClé($1; $2; $3)  //+"@"

QUERY:C277([HeberGement:5]; [HeberGement:5]HG_CléFax:69=va_CléFax; *)
QUERY:C277([HeberGement:5];  | ; [HeberGement:5]HG_CléFax:69=(Substring:C12(va_CléFax; 1; 11)+"0E"))
MultiSoc_Filter(->[HeberGement:5])
CREATE SET:C116([HeberGement:5]; "E_Hébergé")
vl_NbHB:=Records in selection:C76([HeberGement:5])
RELATE MANY SELECTION:C340([LesCentres:9]LC_RéférenceID:1)
vl_NbCT:=Records in selection:C76([LesCentres:9])
CREATE SET:C116([LesCentres:9]; "E_Centres")
ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; tl_CTRéf; [LesCentres:9]LC_Nom:4; ta_CTNom; [LesCentres:9]LC_Lieu:5; ta_CTLieu; [LesCentres:9]LC_Téléphone:29; ta_CTTél; [LesCentres:9]LC_Télécopie2:31; ta_CTFax; [LesCentres:9]LC_DispoNuit:22; tl_CTCH; [LesCentres:9]LC_Restantes:23; tl_CTCHAt; [LesCentres:9]LC_Répertoire:54; ta_CTRépertoire)
ARRAY INTEGER:C220(tl_CTSél; Size of array:C274(ta_CTNom))
ta_CTNom:=0

C_LONGINT:C283($ii)
For ($ii; 1; Size of array:C274(ta_CTNom))
	USE SET:C118("E_Hébergé")
	QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_LC_ID:61=tl_CTRéf{$ii})
	tl_CTCHAt{$ii}:=Records in selection:C76([HeberGement:5])
	tl_CTSél{$ii}:=0
End for 
USE SET:C118("E_Hébergé")

ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3; >)
SORT ARRAY:C229(ta_CTNom; ta_CTLieu; ta_CTTél; ta_CTFax; tl_CTCH; tl_CTCHAt; ta_CTRépertoire; tl_CTRéf; >)
CLOSE WINDOW:C154


OBJECT SET ENABLED:C1123(b_VoirNotes; False:C215)
OBJECT SET ENABLED:C1123(b_VoirSP; False:C215)
OBJECT SET ENABLED:C1123(b_VoirTexte; False:C215)
OBJECT SET ENABLED:C1123(b_VoirTextef; False:C215)
OBJECT SET ENABLED:C1123(b_DSOui; False:C215)
OBJECT SET ENABLED:C1123(b_DSNon; False:C215)
If (Records in selection:C76([HeberGement:5])>0)
	OBJECT SET ENABLED:C1123(b_DSVoir; True:C214)
	DISTINCT VALUES:C339([HeberGement:5]HG_FamClé:104; ta_ValFam)
	INSERT IN ARRAY:C227(ta_ValFam; Size of array:C274(ta_ValFam)+1)
	ta_ValFam{Size of array:C274(ta_ValFam)}:="Toutes"
	ta_ValFam:=Size of array:C274(ta_ValFam)
	ta_ValFam{0}:=ta_ValFam{ta_ValFam}
Else 
	OBJECT SET ENABLED:C1123(b_DSVoir; False:C215)
End if 
If (Size of array:C274(ta_CTNom)>0)
	OBJECT SET ENABLED:C1123(b_FaxDist; True:C214)
	OBJECT SET ENABLED:C1123(b_FaxDExp; True:C214)
	OBJECT SET ENABLED:C1123(b_FaxHBH; True:C214)
	OBJECT SET ENABLED:C1123(b_FaxHBS; True:C214)
	OBJECT SET ENABLED:C1123(b_FaxHB; True:C214)
	OBJECT SET ENABLED:C1123(b_PrintHB; True:C214)
Else 
	OBJECT SET ENABLED:C1123(b_FaxDist; False:C215)
	OBJECT SET ENABLED:C1123(b_FaxDExp; False:C215)
	OBJECT SET ENABLED:C1123(b_FaxHBH; False:C215)
	OBJECT SET ENABLED:C1123(b_FaxHBS; False:C215)
	OBJECT SET ENABLED:C1123(b_FaxHB; False:C215)
	OBJECT SET ENABLED:C1123(b_PrintHB; False:C215)
End if 