//%attributes = {}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_LONGINT:C283($ve_NoJour)
C_DATE:C307($vd_Date)
C_TIME:C306($vh_Heure)

C_TEXT:C284(vt_StTexte)

$vd_Date:=Current date:C33
$vh_Heure:=Current time:C178

$ve_NoJour:=Day number:C114($vd_Date)

Case of 
	: ($1=-3)
		vt_StTexte:=""
		
		P_ParamNumérotation(-1; <>ve_ParamNum; ->vt_StTexte)
	: ($1=-2)
		vt_StTexte:=""
		
		P_ParamNumérotation(0; <>ve_ParamNum; ->vt_StTexte)
	: ($1=-1)
		
		If ($ve_NoJour#Dimanche:K10:19) & ((User in group:C338(Current user:C182; <>Groupe_DEVELOP)) | (User in group:C338(Current user:C182; <>Groupe_Coordinateur))\
			 | (User in group:C338(Current user:C182; <>Groupe_Régulateur)) | (User in group:C338(Current user:C182; <>Groupe_Permanencier)))
			P_ParamNumérotation(1; <>ve_ParamNum; ->vt_StTexte)
			
			If (vt_StTexte>"")
			Else 
				
				If (<>vl_T_ErrorJours=0)
					<>vl_T_ErrorJours:=7
				End if 
				
				Case of 
					: (($ve_NoJour=Lundi:K10:13) | ($ve_NoJour=Jeudi:K10:16))
						vt_StTexte:="01;"+<>Groupe_Coordinateur+";"+String:C10($vd_Date+<>vl_T_ErrorJours)+";"+String:C10($vh_Heure)
					: (($ve_NoJour=Mardi:K10:14) | ($ve_NoJour=Mercredi:K10:15))
						vt_StTexte:="01;"+<>Groupe_Régulateur+";"+String:C10($vd_Date+<>vl_T_ErrorJours)+";"+String:C10($vh_Heure)
					: (($ve_NoJour=Vendredi:K10:17) | ($ve_NoJour=Samedi:K10:18))
						vt_StTexte:="01;"+<>Groupe_Permanencier+";"+String:C10($vd_Date+<>vl_T_ErrorJours)+";"+String:C10($vh_Heure)
				End case 
				
				P_ParamNumérotation(0; <>ve_ParamNum; ->vt_StTexte)
			End if 
			
		End if 
		
	: ($1=0)
		vt_StTexte:=""
		
		P_ParamNumérotation(1; <>ve_ParamNum; ->vt_StTexte)
		<>vb_ParamNum:=False:C215
		
		If (vt_StTexte>"")
			<>vb_ParamNum:=(vt_StTexte[[2]]="1")
			vt_StTexte:=Substring:C12(vt_StTexte; 4)
			
			<>va_ParamNum:=Substring:C12(vt_StTexte; 1; Position:C15(";"; vt_StTexte)-1)
			vt_StTexte:=Substring:C12(vt_StTexte; Position:C15(";"; vt_StTexte)+1)
			
			<>vd_ParamNum:=Date:C102(Substring:C12(vt_StTexte; 1; Position:C15(";"; vt_StTexte)-1))
			vt_StTexte:=Substring:C12(vt_StTexte; Position:C15(";"; vt_StTexte)+1)
			
			<>vh_ParamNum:=Time:C179(vt_StTexte)
		End if 
		
	: ($1=1)
		$0:=((<>vb_ParamNum=True:C214) & ($vd_Date>=<>vd_ParamNum) & ($vh_Heure>=<>vh_ParamNum))
End case 