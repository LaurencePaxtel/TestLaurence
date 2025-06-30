C_LONGINT:C283($ii; $vl_Fenetre)
C_BOOLEAN:C305($vb_OK)
$vb_OK:=False:C215

If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(ta_LesObjets)>0)
		If (ta_LesObjets>0)
			$vb_OK:=True:C214
		End if 
	End if 
End if 

If ($vb_OK)
	
	If (tl_LesObjets_ID{ta_LesObjets}>0)
		tl_LesObjets_ID{0}:=tl_LesObjets_ID{ta_LesObjets}
		vl_MachineLe_ID:=tl_LesObjets_ID{ta_LesObjets}
		va_MachineLib:=ta_LesObjets{ta_LesObjets}
		va_MachineLibAbrev:=ta_LesObjetsCourt{ta_LesObjets}
		$vb_OK:=F_Planning_OB(6; ta_LesObjets)
		P_Planing_Charger(vd_DateJour; tl_LesObjets_ID{ta_LesObjets}; 1)
	Else 
		Case of 
			: (tl_LesObjets_ID{ta_LesObjets}=-1)  //"Ajouter un objet"
				READ WRITE:C146([Objets:56])
				FORM SET INPUT:C55([Objets:56]; "OB_EcranSaisie")
				$vl_Fenetre:=i_FenêtreNo(632; 426; 4; "Objet de planning :  nouveau"; 1; "Quit_Objet")
				ADD RECORD:C56([Objets:56]; *)
				If (OK=1)
					$ii:=[Objets:56]OB_RéférenceID:1
				Else 
					$ii:=0
				End if 
				UNLOAD RECORD:C212([Objets:56])
				CLOSE WINDOW:C154($vl_Fenetre)
				READ ONLY:C145([Objets:56])
				vb_OK:=F_Planning_OB(3; $ii)
				
			: (tl_LesObjets_ID{ta_LesObjets}=-2)  //"Modifier  l'objet courant"
				$ii:=0
				READ WRITE:C146([Objets:56])
				QUERY:C277([Objets:56]; [Objets:56]OB_RéférenceID:1=tl_LesObjets_ID{0})
				If (Records in selection:C76([Objets:56])=1)
					If (i_NonVerrou(->[Objets:56]))
						FORM SET INPUT:C55([Objets:56]; "OB_EcranSaisie")
						$vl_Fenetre:=i_FenêtreNo(632; 426; 4; "Objet de planning :  modifier"; 1; "Quit_Objet")
						MODIFY RECORD:C57([Objets:56]; *)
						If (OK=1)
							$ii:=[Objets:56]OB_RéférenceID:1
						End if 
					End if 
				End if 
				UNLOAD RECORD:C212([Objets:56])
				CLOSE WINDOW:C154($vl_Fenetre)
				READ ONLY:C145([Objets:56])
				vb_OK:=F_Planning_OB(4; $ii)
				
			: (tl_LesObjets_ID{ta_LesObjets}=-3)  //"Supprimer l'objet courant"
				$ii:=0
				If (tl_LesObjets_ID{0}>0)
					If (i_Confirmer("Confirmez vous la suppression de l'objet : "+va_MachineLib+" et de son planning ?"))
						READ WRITE:C146([Objets:56])
						QUERY:C277([Objets:56]; [Objets:56]OB_RéférenceID:1=tl_LesObjets_ID{0})
						If (Records in selection:C76([Objets:56])=1)
							If (i_NonVerrou(->[Objets:56]))
								$ii:=[Objets:56]OB_RéférenceID:1
								DELETE RECORD:C58([Objets:56])
								READ WRITE:C146([Objets_Planification:57])
								QUERY:C277([Objets_Planification:57]; [Objets_Planification:57]OP_Objet_ID:2=$ii)
								If (Records in selection:C76([Objets_Planification:57])>0)
									DELETE SELECTION:C66([Objets_Planification:57])
								End if 
								UNLOAD RECORD:C212([Objets_Planification:57])
								READ ONLY:C145([Objets_Planification:57])
							End if 
						End if 
					End if 
				End if 
				vb_OK:=F_Planning_OB(5; $ii)
				
		End case 
	End if 
End if 

