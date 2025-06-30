If (Form event code:C388=Sur clic:K2:4)
	C_TEXT:C284($vt_Texte)
	C_BOOLEAN:C305($vb_OK)
	If (vd_ExportReportD=vd_ExportReportF)
		$vt_Texte:=String:C10(vd_ExportReportD; Interne date court:K1:7)
	Else 
		$vt_Texte:=String:C10(vd_ExportReportD; Interne date court:K1:7)+"au "+String:C10(vd_ExportReportF; Interne date court:K1:7)
	End if 
	$vb_OK:=(vl_ExportReport>0)
	If ($vb_OK)
		If (rExport_2=1)
			If (i_Confirmer("Exportation des "+String:C10(vl_ExportReport; "# ### ##0")+" fiche(s) Prestation(s) en date du "+$vt_Texte+<>va_CR+"Confirmez-vous ?"))
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; >)
				$vb_OK:=F_Prestation_RefsTableau(0; 0)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_Presta_Réf_HG)
				$vb_OK:=F_Prestation_Transfert(->tl_Presta_Réf_HG; False:C215; "Prestations Export manuel "+$vt_Texte)
				$vb_OK:=F_Prestation_RefsTableau(0; 0)
			End if 
		Else 
			$vb_OK:=False:C215
			Case of 
				: (rExport_1=1)
					$vb_OK:=i_Confirmer("Exportation des "+String:C10(vl_ExportReport; "# ### ##0")+" fiche(s) reportée(s) en date du "+$vt_Texte+<>va_CR+"Confirmez-vous ?")
				: (rExport_3=1)
					$vb_OK:=i_Confirmer("Exportation des "+String:C10(vl_ExportReport; "# ### ##0")+" fiche(s) 1ère nuit en date du "+$vt_Texte+<>va_CR+"Confirmez-vous ?")
					
			End case 
			
			If ($vb_OK)
				Case of 
					: (rExport_1=1)
						i_Message("Report Export : "+" Transfert en cours…")
						vd_ExportReport:=vd_ExportReportD
						Repeat 
							i_MessageSeul("Report Export : "+" Transfert du"+String:C10(vd_ExportReport)+"en cours…")
							ARRAY LONGINT:C221(tl_Trans_Réf_HG; 0)
							$vb_OK:=F_Regional_RefsTableau(0)
							QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_ExportReport; *)
							QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_Nuit:2=False:C215; *)
							If (va_ExportReportPlateforme>"")
								QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_Plateforme:139=va_ExportReportPlateforme; *)
							End if 
							QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_Trans_DDASS:141=True:C214; *)
							QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_NuitenCours:92>1)
							MultiSoc_Filter(->[HeberGement:5])
							vl_ExportReport:=Records in selection:C76([HeberGement:5])
							If (vl_ExportReport>0)
								SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_Trans_Réf_HG)
								COPY ARRAY:C226(tl_Trans_Réf_HG; tl_Regional_Réf_HG)
								
								//•Est ce une base CHRS  et y a til des fiches reportées
								$vb_OK:=F_Report_FullDuplex(->tl_Trans_Réf_HG; False:C215; "Report Export manuel "+String:C10(vd_ExportReport; Interne date court:K1:7))
								$vb_OK:=F_Regional_Transfert(->tl_Regional_Réf_HG; False:C215; "Transfert régional Export manuel")
								
							End if 
							ARRAY LONGINT:C221(t_HGrepID; 0)
							ARRAY LONGINT:C221(tl_Trans_Réf_HG; 0)
							$vb_OK:=F_Regional_RefsTableau(0)
							vd_ExportReport:=Add to date:C393(vd_ExportReport; 0; 0; 1)
						Until (vd_ExportReport>vd_ExportReportF)
						CLOSE WINDOW:C154
						If (F_uExportReportRec)
						End if 
						
					: (rExport_3=1)
						i_Message("1ère nuit Export : "+" Transfert en cours…")
						vd_ExportReport:=vd_ExportReportD
						Repeat 
							i_MessageSeul("Report Export : "+" Transfert du"+String:C10(vd_ExportReport)+"en cours…")
							ARRAY LONGINT:C221(tl_Trans_Réf_HG; 0)
							$vb_OK:=F_Regional_RefsTableau(0)
							QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_ExportReport; *)
							QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_Nuit:2=False:C215; *)
							If (va_ExportReportPlateforme>"")
								QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_Plateforme:139=va_ExportReportPlateforme; *)
							End if 
							QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_Trans_DDASS:141=True:C214; *)
							QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_Cloturée:67=True:C214; *)
							QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_NuitenCours:92=1)
							MultiSoc_Filter(->[HeberGement:5])
							vl_ExportReport:=Records in selection:C76([HeberGement:5])
							If (vl_ExportReport>0)
								SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_Trans_Réf_HG)
								COPY ARRAY:C226(tl_Trans_Réf_HG; tl_Regional_Réf_HG)
								
								//•Est ce une base CHRS  et y a til des fiches reportées
								$vb_OK:=F_Report_FullDuplex(->tl_Trans_Réf_HG; False:C215; "Report Export manuel "+String:C10(vd_ExportReport; Interne date court:K1:7))
								$vb_OK:=F_Regional_Transfert(->tl_Regional_Réf_HG; False:C215; "Transfert régional Export manuel")
								
							End if 
							ARRAY LONGINT:C221(t_HGrepID; 0)
							ARRAY LONGINT:C221(tl_Trans_Réf_HG; 0)
							$vb_OK:=F_Regional_RefsTableau(0)
							vd_ExportReport:=Add to date:C393(vd_ExportReport; 0; 0; 1)
						Until (vd_ExportReport>vd_ExportReportF)
						CLOSE WINDOW:C154
						If (F_uExportReportRec)
						End if 
				End case 
			End if 
		End if 
	End if 
End if 







