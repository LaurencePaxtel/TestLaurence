//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 12-04-19, 15:31:01
// ----------------------------------------------------
// Method: Web_GL_Save_Inventaire
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($id; $1; $p; $num_ordre)

$id:=$1
$num_ordre:=0

READ ONLY:C145([Inventaire_Pieces_Lignes:100])


//=========================================================================//
// ENTRÉE
//=========================================================================//

QUERY:C277([Inventaire_Pieces_Lignes:100]; [Inventaire_Pieces_Lignes:100]IPL_ID_Inventaire:2=$id; *)
QUERY:C277([Inventaire_Pieces_Lignes:100];  & ; [Inventaire_Pieces_Lignes:100]IPL_Type:3="entrée")
MultiSoc_Filter(->[Inventaire_Pieces_Lignes:100])

$num_ordre:=$num_ordre+1

If (Records in selection:C76([Inventaire_Pieces_Lignes:100])=0)
	
	READ WRITE:C146([Inventaire_Pieces_Lignes:100])
	
	CREATE RECORD:C68([Inventaire_Pieces_Lignes:100])
	MultiSoc_Init_Structure(->[Inventaire_Pieces_Lignes:100])
	[Inventaire_Pieces_Lignes:100]IPL_ID_Inventaire:2:=[Inventaire_Pieces:96]ID:1
	[Inventaire_Pieces_Lignes:100]IPL_Type:3:="entrée"
	[Inventaire_Pieces_Lignes:100]IPL_Num_Ordre:5:=$num_ordre
	[Inventaire_Pieces_Lignes:100]IPL_Libelle:6:="Pièce à vivre 1"
	SAVE RECORD:C53([Inventaire_Pieces_Lignes:100])
	
	UNLOAD RECORD:C212([Inventaire_Pieces_Lignes:100])
	
End if 

//=========================================================================//
// SALON
//=========================================================================//

QUERY:C277([Inventaire_Pieces_Lignes:100]; [Inventaire_Pieces_Lignes:100]IPL_ID_Inventaire:2=$id; *)
QUERY:C277([Inventaire_Pieces_Lignes:100];  & ; [Inventaire_Pieces_Lignes:100]IPL_Type:3="salon")
MultiSoc_Filter(->[Inventaire_Pieces_Lignes:100])

$num_ordre:=$num_ordre+1

If (Records in selection:C76([Inventaire_Pieces_Lignes:100])=0)
	
	READ WRITE:C146([Inventaire_Pieces_Lignes:100])
	
	CREATE RECORD:C68([Inventaire_Pieces_Lignes:100])
	MultiSoc_Init_Structure(->[Inventaire_Pieces_Lignes:100])
	[Inventaire_Pieces_Lignes:100]IPL_ID_Inventaire:2:=[Inventaire_Pieces:96]ID:1
	[Inventaire_Pieces_Lignes:100]IPL_Type:3:="salon"
	[Inventaire_Pieces_Lignes:100]IPL_Num_Ordre:5:=$num_ordre
	[Inventaire_Pieces_Lignes:100]IPL_Libelle:6:="Pièce à vivre 2"
	SAVE RECORD:C53([Inventaire_Pieces_Lignes:100])
	
	UNLOAD RECORD:C212([Inventaire_Pieces_Lignes:100])
	
End if 


//=========================================================================//
// SALLE À MANGER
//=========================================================================//

QUERY:C277([Inventaire_Pieces_Lignes:100]; [Inventaire_Pieces_Lignes:100]IPL_ID_Inventaire:2=$id; *)
QUERY:C277([Inventaire_Pieces_Lignes:100];  & ; [Inventaire_Pieces_Lignes:100]IPL_Type:3="salle a manger")
MultiSoc_Filter(->[Inventaire_Pieces_Lignes:100])

If (Records in selection:C76([Inventaire_Pieces_Lignes:100])=0)
	
	READ WRITE:C146([Inventaire_Pieces_Lignes:100])
	
	$num_ordre:=$num_ordre+1
	
	CREATE RECORD:C68([Inventaire_Pieces_Lignes:100])
	MultiSoc_Init_Structure(->[Inventaire_Pieces_Lignes:100])
	[Inventaire_Pieces_Lignes:100]IPL_ID_Inventaire:2:=[Inventaire_Pieces:96]ID:1
	[Inventaire_Pieces_Lignes:100]IPL_Type:3:="salle a manger"
	[Inventaire_Pieces_Lignes:100]IPL_Num_Ordre:5:=$num_ordre
	[Inventaire_Pieces_Lignes:100]IPL_Libelle:6:="Pièce à vivre 3"
	SAVE RECORD:C53([Inventaire_Pieces_Lignes:100])
	
	UNLOAD RECORD:C212([Inventaire_Pieces_Lignes:100])
	
End if 

//=========================================================================//
// Chambres
//=========================================================================//

QUERY:C277([Inventaire_Pieces_Lignes:100]; [Inventaire_Pieces_Lignes:100]IPL_ID_Inventaire:2=$id; *)
QUERY:C277([Inventaire_Pieces_Lignes:100];  & ; [Inventaire_Pieces_Lignes:100]IPL_Type:3="chambre")
MultiSoc_Filter(->[Inventaire_Pieces_Lignes:100])

If (Records in selection:C76([Inventaire_Pieces_Lignes:100])=0)
	
	READ WRITE:C146([Inventaire_Pieces_Lignes:100])
	
	For ($p; 1; [Inventaire_Pieces:96]INV_Chambres:2)
		$num_ordre:=$num_ordre+1
		CREATE RECORD:C68([Inventaire_Pieces_Lignes:100])
		MultiSoc_Init_Structure(->[Inventaire_Pieces_Lignes:100])
		[Inventaire_Pieces_Lignes:100]IPL_ID_Inventaire:2:=[Inventaire_Pieces:96]ID:1
		[Inventaire_Pieces_Lignes:100]IPL_Type:3:="chambre"
		[Inventaire_Pieces_Lignes:100]IPL_Num_Ordre:5:=$num_ordre
		[Inventaire_Pieces_Lignes:100]IPL_Libelle:6:="Chambre "+String:C10($p)
		SAVE RECORD:C53([Inventaire_Pieces_Lignes:100])
	End for 
	
	UNLOAD RECORD:C212([Inventaire_Pieces_Lignes:100])
	
End if 

//=========================================================================//
// WC
//=========================================================================//

QUERY:C277([Inventaire_Pieces_Lignes:100]; [Inventaire_Pieces_Lignes:100]IPL_ID_Inventaire:2=$id; *)
QUERY:C277([Inventaire_Pieces_Lignes:100];  & ; [Inventaire_Pieces_Lignes:100]IPL_Type:3="wc")
MultiSoc_Filter(->[Inventaire_Pieces_Lignes:100])

$num_ordre:=$num_ordre+1

If (Records in selection:C76([Inventaire_Pieces_Lignes:100])=0)
	
	READ WRITE:C146([Inventaire_Pieces_Lignes:100])
	
	For ($p; 1; [Inventaire_Pieces:96]INV_Chambres:2)
		$num_ordre:=$num_ordre+1
		CREATE RECORD:C68([Inventaire_Pieces_Lignes:100])
		MultiSoc_Init_Structure(->[Inventaire_Pieces_Lignes:100])
		[Inventaire_Pieces_Lignes:100]IPL_ID_Inventaire:2:=[Inventaire_Pieces:96]ID:1
		[Inventaire_Pieces_Lignes:100]IPL_Type:3:="wc"
		[Inventaire_Pieces_Lignes:100]IPL_Num_Ordre:5:=$num_ordre
		[Inventaire_Pieces_Lignes:100]IPL_Libelle:6:="WC "+String:C10($p)
		SAVE RECORD:C53([Inventaire_Pieces_Lignes:100])
	End for 
	
	UNLOAD RECORD:C212([Inventaire_Pieces_Lignes:100])
	
End if 

//=========================================================================//
// SALLE DE BAIN
//=========================================================================//

QUERY:C277([Inventaire_Pieces_Lignes:100]; [Inventaire_Pieces_Lignes:100]IPL_ID_Inventaire:2=$id; *)
QUERY:C277([Inventaire_Pieces_Lignes:100];  & ; [Inventaire_Pieces_Lignes:100]IPL_Type:3="salle de bain")
MultiSoc_Filter(->[Inventaire_Pieces_Lignes:100])

If (Records in selection:C76([Inventaire_Pieces_Lignes:100])=0)
	
	READ WRITE:C146([Inventaire_Pieces_Lignes:100])
	
	For ($p; 1; [Inventaire_Pieces:96]INV_Chambres:2)
		$num_ordre:=$num_ordre+1
		CREATE RECORD:C68([Inventaire_Pieces_Lignes:100])
		MultiSoc_Init_Structure(->[Inventaire_Pieces_Lignes:100])
		[Inventaire_Pieces_Lignes:100]IPL_ID_Inventaire:2:=[Inventaire_Pieces:96]ID:1
		[Inventaire_Pieces_Lignes:100]IPL_Type:3:="salle de bain"
		[Inventaire_Pieces_Lignes:100]IPL_Num_Ordre:5:=$num_ordre
		[Inventaire_Pieces_Lignes:100]IPL_Libelle:6:="Salle de bain "+String:C10($p)
		SAVE RECORD:C53([Inventaire_Pieces_Lignes:100])
	End for 
	
	UNLOAD RECORD:C212([Inventaire_Pieces_Lignes:100])
	
End if 




UNLOAD RECORD:C212([Inventaire_Pieces_Lignes:100])
READ ONLY:C145([Inventaire_Pieces_Lignes:100])