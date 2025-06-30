
var $left_i : Integer
var $top_i : Integer
var $right_i : Integer
var $bottom_i : Integer
var $file_f : 4D:C1709.File
var $SVG_t : Text


If (Form event code:C388=On Load:K2:1)
	// Gestion de l'affichage
	OBJECT SET RGB COLORS:C628(*; "notificationBackground"; Form:C1466.borderColor; Form:C1466.backgroudColor)
	
	OBJECT SET TITLE:C194(*; "notificationTitle"; Form:C1466.title)
	OBJECT SET RGB COLORS:C628(*; "notificationTitle"; Form:C1466.titleColor; "transparent")
	
	OBJECT SET TITLE:C194(*; "notificationMessage"; Form:C1466.message)
	OBJECT SET RGB COLORS:C628(*; "notificationMessage"; Form:C1466.messageColor; "transparent")
	
	
	// Icone
	$file_f:=Folder:C1567(fk resources folder:K87:11).file("fontawesome-svg/"+Form:C1466.iconFile)
	$SVG_t:=SVG_Open_file($file_f.platformPath)
	
	// On charge la couleur
	SVG_SET_FILL_BRUSH($SVG_t; Form:C1466.iconColor)
	OBJECT Get pointer:C1124(Object named:K67:5; "notificationIcon")->:=SVG_Export_to_picture($SVG_t; 0)
	SVG_CLEAR($SVG_t)
	
	
	//Barre de progression
	OBJECT SET RGB COLORS:C628(*; "notificationProgressBar"; "transparent"; Form:C1466.progressBarColor)
	OBJECT GET COORDINATES:C663(*; "notificationProgressBar"; $left_i; $top_i; $right_i; $bottom_i)
	Form:C1466.progressBarLeft_i:=$left_i
	Form:C1466.progressBarTop_i:=$top_i
	Form:C1466.progressBarRight_i:=$right_i
	Form:C1466.progressBarBottom_i:=$bottom_i
	
	
	// Timers
	// Calcul du moment de fermeture du formulaire
	Form:C1466.delayOpen_ms:=Milliseconds:C459
	Form:C1466.delayClose_ms:=Form:C1466.delayOpen_ms+(Form:C1466.delay*1000)
	
	// Timer au minimun, c'est plus jolie...
	SET TIMER:C645(1)
End if 


If (Form event code:C388=On Timer:K2:25)
	Form:C1466.progressBarRatio_r:=1-((Milliseconds:C459-Form:C1466.delayOpen_ms)/(Form:C1466.delay*1000))
	// Mise à jour de la barre de défilement.
	$right_i:=Round:C94(Form:C1466.progressBarRight_i*Form:C1466.progressBarRatio_r; 0)
	
	OBJECT SET COORDINATES:C1248(*; "notificationProgressBar"; Form:C1466.progressBarLeft_i; Form:C1466.progressBarTop_i; $right_i; Form:C1466.progressBarBottom_i)
	
	
	If (Milliseconds:C459>Form:C1466.delayClose_ms)
		ACCEPT:C269
	End if 
End if 
