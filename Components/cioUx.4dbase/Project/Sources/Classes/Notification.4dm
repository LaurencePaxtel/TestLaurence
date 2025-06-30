/*------------------------------------------------------------------------------
Class : Notification

------------------------------------------------------------------------------*/

Class constructor
/*------------------------------------------------------------------------------
Fonction : Notification.new()
	
Génére la structure des notifications
	
Historique
08/04/22 - Grégory Fromain <gregory@connect-io.fr> - Création
------------------------------------------------------------------------------*/
	
	var $widthForm_i : Integer
	var $heightForm_i : Integer
	var $model_o : Object
	
	This:C1470.marginTop:=10
	This:C1470.formUxName:="Notification"
	This:C1470.formUx:=New object:C1471()
	
	// On récupére la taille du formulaire de notification.
	FORM GET PROPERTIES:C674(String:C10(This:C1470.formUxName); $widthForm_i; $heightForm_i)
	This:C1470.formUx.width:=$widthForm_i
	This:C1470.formUx.height:=$heightForm_i
	
	This:C1470.models:=New collection:C1472()
	$model_o:=New object:C1471()
	
	// Config pour le pop-up success
	$model_o:=This:C1470.modelGenerate("#effaf5"; "#257953")
	$model_o.iconFile:="solid/circle-check.svg"
	This:C1470.modelUpdate("success"; $model_o)
	
	// Config pour le pop-up information
	$model_o:=This:C1470.modelGenerate("#eff5fb"; "#296fa8")
	$model_o.iconFile:="solid/circle-info.svg"
	This:C1470.modelUpdate("information"; $model_o)
	
	// Config pour le pop-up warning
	$model_o:=This:C1470.modelGenerate("#fffaeb"; "#946c00")
	$model_o.iconFile:="solid/circle-exclamation.svg"
	$model_o.progressBarColor:="#946c00"
	This:C1470.modelUpdate("warning"; $model_o)
	
	// Config pour le pop-up error
	$model_o:=This:C1470.modelGenerate("#feecf0"; "#cc0f35")
	$model_o.delay:=20
	$model_o.iconFile:="solid/circle-xmark.svg"
	This:C1470.modelUpdate("error"; $model_o)
	
	This:C1470.endTime:=Milliseconds:C459
	
	
	
Function modelGenerate($backgroundColor_t : Text; $othersColor_t : Text)->$model_o : Object
/*------------------------------------------------------------------------------
Fonction : Notification.modelGenerate()
	
Facilite la création des modeles.
	
Paramètres
$backgroundColor_t -> Code RGB de la couleur du fond (#000000)
$othersColor_t     -> Code RGB des autres éléments (#000000)
$model_o           <- Elément complet d'un model
	
Historique
08/04/22 - Grégory Fromain <gregory@connect-io.fr> - Création
------------------------------------------------------------------------------*/
	
	$model_o:=New object:C1471()
	$model_o.delay:=5  // Délais d'affichage en seconde.
	$model_o.backgroudColor:=$backgroundColor_t
	$model_o.borderColor:="transparent"
	$model_o.titleColor:=$othersColor_t
	$model_o.messageColor:=$othersColor_t
	$model_o.iconFile:="solid/circle-user.svg"
	$model_o.iconColor:=$othersColor_t
	$model_o.progressBarColor:=$othersColor_t
	
	
	
Function modelUpdate($model_t : Text; $model_o : Object)
/*------------------------------------------------------------------------------
Fonction : Notification.modelUpdate()
	
Mettre à jour les modéles.
	
Paramètres
$model_t -> Nom du model
$model_o -> modéle à mettre à jour
	
Historique
08/04/22 - Grégory Fromain <gregory@connect-io.fr> - Création
------------------------------------------------------------------------------*/
	
	var $model_c : Collection
	
	$model_c:=This:C1470.models.query("lib IS :1"; $model_t)
	
	If ($model_c.length=0)
		$model_o.lib:=$model_t
		This:C1470.models.push($model_o)
	Else 
		$model_c[0]:=OB Copy:C1225($model_o)
	End if 
	
	
	
Function popUp($model_t : Text; $title_t : Text; $message_t : Text)
/*------------------------------------------------------------------------------
Fonction : Notification.popUp()
	
Affiche un pop-up à l'ecran.
	
Paramètres
$model_t -> Nom du model
$title_t-> Titre du pop up
$message_t-> Message du pop up
	
Historique
08/04/22 - Grégory Fromain <gregory@connect-io.fr> - Création
------------------------------------------------------------------------------*/
	
	var $model_c : Collection
	var $model_o : Object
	
	$model_c:=This:C1470.models.query("lib IS :1"; $model_t)
	
	For each ($model_o; $model_c)
		$model_o.title:=$title_t
		$model_o.message:=$message_t
		
		This:C1470.windowsOpen($model_o)
	End for each 
	
	
	
Function windowsOpen($model_o : Object)
/*------------------------------------------------------------------------------
Fonction : Notification.windowsOpen()
	
Gére la partie graphique pour afficher une fenétre.
	
Paramètre
$model_o -> Le model à afficher
	
Historique
08/04/22 - Grégory Fromain <gregory@connect-io.fr> - Création
------------------------------------------------------------------------------*/
	
	var $formMainLeft_i : Integer
	var $formMainTop_i : Integer
	var $formMainRight_i : Integer
	var $formMainBottom_i : Integer
	var $formMainWidth_i : Integer
	var $formUxleft_i : Integer
	var $formUxTop_i : Integer
	var $formUxRight_i : Integer
	var $formUxBottom_i : Integer
	var $refFen_i : Integer
	
	// Mise en place de l'alerte multiple
	If (This:C1470.endTime<Milliseconds:C459)
		This:C1470.numberPopUp:=0
	End if 
	
	This:C1470.endTime:=Milliseconds:C459+($model_o.delay*1000)
	This:C1470.numberPopUp:=This:C1470.numberPopUp+1
	
	GET WINDOW RECT:C443($formMainLeft_i; $formMainTop_i; $formMainRight_i; $formMainBottom_i; Frontmost window:C447)
	
	$formMainWidth_i:=$formMainRight_i-$formMainLeft_i
	$formUxleft_i:=$formMainLeft_i+($formMainWidth_i/2)-(This:C1470.formUx.width/2)
	$formUxTop_i:=$formMainTop_i+This:C1470.marginTop+((This:C1470.formUx.height+This:C1470.marginTop)*(This:C1470.numberPopUp-1))
	$formUxRight_i:=$formUxleft_i+This:C1470.formUx.width
	$formUxBottom_i:=$formMainTop_i+This:C1470.formUx.height+This:C1470.marginTop+((This:C1470.formUx.height+This:C1470.marginTop)*(This:C1470.numberPopUp-1))
	
	This:C1470.formUx.refFen_i:=Open window:C153($formUxleft_i; $formUxTop_i; $formUxRight_i; $formUxBottom_i; Pop up window:K34:14)
	
	DIALOG:C40(This:C1470.formUxName; $model_o)