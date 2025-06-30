//%attributes = {}
// ----------------------------------------------------
// User name (OS): KEVIN HASSAL
// Date and time: 05/20/20, 10:22:01
// ----------------------------------------------------
// Method: HG_Rattrapage_Fiches
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)

C_COLLECTION:C1488($collection_c)
C_LONGINT:C283($NuitenCours)

ARRAY LONGINT:C221($tb_ids; 0)

COPY ARRAY:C226($1->; $tb_ids)

//====================================================//
// Report : Statut
//====================================================//

READ WRITE:C146([HeberGement:5])

QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; $tb_ids)

// Modifié par : Scanu Rémy - remy@connect-io.fr (06/05/2021)
// On rajoute le tri par hébergé comme ça on va pouvoir mieux traiter tout ça
ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; [HeberGement:5]HG_HB_ID:19; <)
//$derniere_date:=[HeberGement]HG_Date

$collection_c:=New collection:C1472

While (Not:C34(End selection:C36([HeberGement:5])))
	
	While (Locked:C147([HeberGement:5]))
		LOAD RECORD:C52([HeberGement:5])
	End while 
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (06/05/2021)
	If ($collection_c.indexOf([HeberGement:5]HG_HB_ID:19)=-1)
		[HeberGement:5]HG_Reporté:94:=""
		
		$collection_c.push([HeberGement:5]HG_HB_ID:19)
	Else 
		[HeberGement:5]HG_Reporté:94:="R"
	End if 
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (04/05/2021)
	//Si ([HeberGement]HG_Date=<>vd_RAP_Jusque)
	//[HeberGement]HG_Reporté:=""
	//Sinon 
	//[HeberGement]HG_Reporté:="R"
	//Fin de si 
	
	// Modifié par : Scanu Rémy (10/10/2023)
	[HeberGement:5]HG_TimeStamp:180:=outilsTimeStamp(Current date:C33(*); Current time:C178(*))
	
	// Modifié par : Scanu Rémy (09/11/2023)
	// Mise en place d'un booléen pour savoir si la sauvegarde provient de l'application mobile ou pas
	[HeberGement:5]importApplicationMobile:184:=False:C215
	
	SAVE RECORD:C53([HeberGement:5])
	NEXT RECORD:C51([HeberGement:5])
End while 

UNLOAD RECORD:C212([HeberGement:5])
READ ONLY:C145([HeberGement:5])

//====================================================//
// Nuit en cours
//====================================================//
READ WRITE:C146([HeberGement:5])

QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; $tb_ids)
COPY NAMED SELECTION:C331([HeberGement:5]; "hebergements")

ARRAY LONGINT:C221($tb_hb_ids; 0)
DISTINCT VALUES:C339([HeberGement:5]HG_HB_ID:19; $tb_hb_ids)

For ($i; 1; Size of array:C274($tb_hb_ids))
	USE NAMED SELECTION:C332("hebergements")
	
	QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=$tb_hb_ids{$i})
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; >)
	
	$NuitenCours:=[HeberGement:5]HG_NuitenCours:92
	
	While (Not:C34(End selection:C36([HeberGement:5])))
		
		While (Locked:C147([HeberGement:5]))
			LOAD RECORD:C52([HeberGement:5])
		End while 
		
		[HeberGement:5]HG_NuitenCours:92:=$NuitenCours
		$NuitenCours:=$NuitenCours+1
		
		SAVE RECORD:C53([HeberGement:5])
		NEXT RECORD:C51([HeberGement:5])
	End while 
	
End for 

CLEAR NAMED SELECTION:C333("hebergements")

UNLOAD RECORD:C212([HeberGement:5])
READ ONLY:C145([HeberGement:5])