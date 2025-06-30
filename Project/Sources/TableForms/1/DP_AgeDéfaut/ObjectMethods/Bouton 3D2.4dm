
READ WRITE:C146([LesRubriques:21])
QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubFichier:3=-1)
MultiSoc_Filter(->[LesRubriques:21])
If (Records in selection:C76([LesRubriques:21])=1)
	LOAD RECORD:C52([LesRubriques:21])
	[LesRubriques:21]NuméroTri:1:=ve_AgeHNew
	[LesRubriques:21]RubNuméro:4:=ve_AgeFNew
	SAVE RECORD:C53([LesRubriques:21])
	UNLOAD RECORD:C212([LesRubriques:21])
	<>ve_ageHom:=ve_AgeHNew
	<>ve_ageFem:=ve_AgeFNew
Else 
	ALERT:C41("Age par défaut des inconnus : Veuillez consulter le service informatique !")
End if 
READ ONLY:C145([LesRubriques:21])