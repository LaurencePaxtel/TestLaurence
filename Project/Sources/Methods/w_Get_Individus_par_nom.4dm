//%attributes = {}
// Method w_Get_Individus_par_nom crée une sélection de d'hébergé en cherchant sur le nom 
// retourne un objet comme dans [DiaLogues];"DL_HébergementGpe"
//
// #SYNTAX: $O_Dummy:=w_Get_Individus_par_nom ("jab@") 
// #PARAMETERS:
//     $1 Text            : critère de recherche

// #DATE CREATION: 18/08/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2



// #20170816-2

C_OBJECT:C1216($0; $O_Output)

C_TEXT:C284($1; $T_Critère)
$T_Critère:=$1

QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=($T_Critère+"@"))
MultiSoc_Filter(->[HeBerge:4])
//REDUCE SELECTION([HeBerge];10)

C_LONGINT:C283($L_Trouve)
$L_Trouve:=Records in selection:C76([HeBerge:4])

ARRAY OBJECT:C1221($rO_Output; $L_Trouve)

C_LONGINT:C283($i)
For ($i; 1; $L_Trouve)
	
	// je mets tout l'enregistrement
	// + des valeurs comme dans la méthode formulaire du sous formulaire de [HeBerge];"HB_ListeInclueD" 
	
	C_LONGINT:C283($L_NbSii)
	$L_NbSii:=F_SiaoEnCours([HeBerge:4]HB_ReferenceID:1)
	
	C_LONGINT:C283($L_NbSP)
	$L_NbSP:=Num:C11([HeBerge:4]HB_Status:18)
	
	RELATE MANY:C262([HeBerge:4]HB_ReferenceID:1)
	C_LONGINT:C283($L_NbHGi)
	$L_NbHGi:=Records in selection:C76([HeberGement:5])
	
	$rO_Output{$i}:=4DREC_Record_to_Object(->[HeBerge:4])
	OB SET:C1220($rO_Output{$i}; "$L_NbSii"; $L_NbSii)
	OB SET:C1220($rO_Output{$i}; "$L_NbSP"; $L_NbSP)
	OB SET:C1220($rO_Output{$i}; "$L_NbHGi"; $L_NbHGi)
	
	NEXT RECORD:C51([HeBerge:4])
End for 

OB SET ARRAY:C1227($O_Output; "heberges_noms"; $rO_Output)
$0:=$O_Output

// EOM


