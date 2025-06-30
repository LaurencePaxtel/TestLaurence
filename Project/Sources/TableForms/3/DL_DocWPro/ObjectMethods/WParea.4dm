C_OBJECT:C1216($WP_object)  // variable used manage to the 4D WritePro Widget
C_POINTER:C301($WP_widgetPtr; $WP_areaPtr)  // Pointers on the area and widget
C_TEXT:C284($WP_areaName; $WP_widgetName)  // "4DWritePro area" and "4DWritePro widget" object names
C_BOOLEAN:C305($WP_customise)

// Change the lines below if you change the form object names
$WP_areaName:="WParea"
$WP_widgetName:="WPtoolbar"

//-----------------------------------------------------------
$WP_areaPtr:=OBJECT Get pointer:C1124(Objet nommé:K67:5; $WP_areaName)
$WP_widgetPtr:=OBJECT Get pointer:C1124(Objet nommé:K67:5; $WP_widgetName)

$WP_customise:=False:C215
If ($WP_customise & (Not:C34(Is nil pointer:C315($WP_widgetPtr))))
	WP SwitchToolbar($WP_widgetName; "Toolbar2")  // default is Toolbar1
End if 


If ((Not:C34(Is nil pointer:C315($WP_areaPtr))) & (Not:C34(Is nil pointer:C315($WP_widgetPtr))))
	If (Not:C34(Undefined:C82($WP_areaPtr->)))
		If (Value type:C1509($WP_areaPtr->)=Est un objet:K8:27)
			If (Not:C34(OB Is empty:C1297($WP_areaPtr->)))  //
				OB SET:C1220($WP_object; "selection"; WP Selection range:C1340(*; $WP_areaName))
				OB SET:C1220($WP_object; "areaName"; $WP_areaName)  //mandatory to use ST Commands
				OB SET:C1220($WP_object; "masterTable"; Current form table:C627)  // or a pointer or any other table (for formula)
				OB SET:C1220($WP_object; "areaPointer"; Self:C308)
				OB SET:C1220($WP_object; "spellCheck"; OBJECT Get auto spellcheck:C1174(*; $WP_areaName))  // true or false according to the setting
				
				Case of 
						
					: (Form event code:C388=Sur chargement:K2:1)
						$WP_WidgetPtr->:=$WP_object
						
					: (Form event code:C388=Sur après modification:K2:43)
						$WP_WidgetPtr->:=$WP_object
						
					: (Form event code:C388=Sur nouvelle sélection:K2:29)
						$WP_WidgetPtr->:=$WP_object
						
					: (Form event code:C388=Sur gain focus:K2:7)
						$WP_WidgetPtr->:=$WP_object
						
					: (Form event code:C388=Sur perte focus:K2:8)
						$WP_WidgetPtr->:=$WP_object
						
				End case 
			Else 
				// BEEP  // [compiled mode : page 2 of form (during on load)] OR [interpreted mode with dynamic var]
			End if 
			
		Else 
			
		End if 
	Else 
		
	End if 
Else 
	// BEEP  // either $WP_areaName or $WP_widgetName is not well defined
End if 
