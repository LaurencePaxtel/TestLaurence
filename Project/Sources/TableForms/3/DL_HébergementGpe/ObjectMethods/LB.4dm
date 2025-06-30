// Method [DiaLogues].DL_HébergementGpe.LB  
// 
// 
// #SYNTAX: $L_Erreur:=[DiaLogues].DL_HébergementGpe.LB(param_1;->param_N) 
// #PARAMETERS:
//     None
//     $0 Long            : error code. 1 = OK
//     $1 Text            : 
//     $2 Pointer         : 
//     $3 Date            : 
//     $4 Time            : 
//     $5 BLOB            : 
//     $6 Picture         : 
//     $7 Object          :
//     $8 real            :
//     $9 Boolean         :

// #DATE CREATION: 10/06/2016  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2
C_LONGINT:C283($ii)
C_POINTER:C301($P_Col)

$P_Col:=OBJECT Get pointer:C1124

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If ($P_Col=(-><>ta_GpClé))
			
			If (Size of array:C274(<>te_GpCheck)>0)
				
				If (<>ta_GpClé>0)
					
					If (Macintosh control down:C544 | Windows Ctrl down:C562)
						
						If (i_Confirmer("Inscrire "+<>ta_GpClé{<>ta_GpClé}+" comme responsable (chef de groupe ou de famille)"))
							$ii:=<>tl_GpRéfi{<>ta_GpClé}
							P_Tab_GP(9; $ii)
						End if 
						
					Else 
						va_FrappeClavier:=""
						va_IDT_Nom:=""
						va_IDT_Pré:=""
						vd_IDT_NéLe:=!00-00-00!
						ve_IDT_Age:=0
						ve_IDT_PCAge:=0
						va_IDT_Clé:=<>ta_GpClé{<>ta_GpClé}
						va_IDT_Nom:=Substring:C12(va_IDT_Clé; 1; 30)
						
						va_IDT_Nom:=Substring:C12(va_IDT_Clé; 1; 29)
						va_FrappeClavier:=va_IDT_Nom
						
						If (va_FrappeClavier="")
							REDUCE SELECTION:C351([HeBerge:4]; 0)
						Else 
							QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=(va_FrappeClavier+"@"))
						End if 
						
						vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
						ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
						
						REDUCE SELECTION:C351([HeberGement:5]; 0)
						
						vL_Nb_HG_F:=0
						va_NNN:=""
						P_HébergementNotesBt(0)
						
						Rec_Hébergements1(->vL_Nb_HG_F)
						va_NNN:=F_AfficheCléHébergé
						
						P_HébergementNotesBt(1)
						
						If (wresMulti=0)
							OBJECT SET ENABLED:C1123(b_ValHBnew; True:C214)
						End if 
						
						//GÉNÉRER CLIC(290; 62)
					End if 
					
				End if 
				
			End if 
			
		End if 
		
	: (Form event code:C388=Sur double clic:K2:5)
		
		If ($P_Col=(-><>te_GpCheck))
			
			If (Size of array:C274(<>te_GpCheck)>0)
				
				If (<>te_GpCheck>0)
					
					If (<>te_GpCheck{<>te_GpCheck}=1)
						<>te_GpCheck{<>te_GpCheck}:=0
					Else 
						<>te_GpCheck{<>te_GpCheck}:=1
					End if 
					
					va_GPmembres:=F_HébergementGroupeTitre([GrouPe:36]GP_Intitulé:4)
				End if 
				
			End if 
			
		End if 
		
End case 