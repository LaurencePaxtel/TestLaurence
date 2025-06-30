If (Form event code:C388=Sur clic:K2:4)
	If (Accès_Groupe(<>Groupe_VeilleExport))
		If (Records in selection:C76([HeberGement:5])>0)
			va_VeilleExpStatLib:=""
			$vl_Fenetre:=i_FenêtreNo(352; 245; 16; "Export"; 4; "")
			DIALOG:C40([DiaLogues:3]; "DL_VeilleExport")
			CLOSE WINDOW:C154($vl_Fenetre)
			If (OK=1)
				Case of 
					: (e1=1)
						P_ExportHG_4D
					: (e2=1)
						P_ExportHG_PC
					: (e3=1)
						P_ExportHG_Liste(True:C214)
					: (e4=1)
						P_ExportHG_Liste(False:C215)
					: (e5=1)
						P_ExportHG_Regional
				End case 
			End if 
			
		Else 
			StrAlerte(23; "")
		End if 
	End if 
End if 