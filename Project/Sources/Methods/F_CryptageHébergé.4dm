//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_CryptageHébergé
//{
//{          Mardi 27 octobre 2009 à 14:47:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215

C_LONGINT:C283($1)  //Référence Hébergé

If (<>vb_T_ModeCHRS)  //Si c'est un fonctionnement de type CHRS
	If (<>vb_T_CryptageHébergé)  //Option de cryptage activé
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$1)
		If (Records in selection:C76([HeBerge:4])=1)
			$0:=[HeBerge:4]HB_CléCodée_Etat:61
		End if 
	End if 
End if 