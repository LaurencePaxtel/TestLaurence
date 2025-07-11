//%attributes = {}
// ----------------------------------------------------
// Developer : Codex
// Date and time : 11/07/2025, 16:30:00
// ----------------------------------------------------
// Method: MAINT_HG_Genre_Retro
// Description: Recompute HG_Genre from HG_EtatCivil
//              and sync [HeBerge] table
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($countHG)
C_LONGINT:C283($countHB)
C_BOOLEAN:C305($genre_b)

$countHG:=0
$countHB:=0

READ WRITE:C146([HeberGement:5])
ALL RECORDS:C47([HeberGement:5])
READ WRITE:C146([HeBerge:4])

While (Not:C34(End selection:C36([HeberGement:5])))

        $genre_b:=F_EtatCivilGenre([HeberGement:5]HG_EtatCivil:20)

        If ([HeberGement:5]HG_Genre:96#$genre_b)
                [HeberGement:5]HG_Genre:96:=$genre_b
                SAVE RECORD:C53([HeberGement:5])
                $countHG:=$countHG+1
        End if

        QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
        MultiSoc_Filter(->[HeBerge:4])
        If (Records in selection:C76([HeBerge:4])>0)
                LOAD RECORD:C52([HeBerge:4])
                If (Not:C34(Locked:C147([HeBerge:4])))
                        If ([HeBerge:4]HG_Genre:39#$genre_b)
                                [HeBerge:4]HG_Genre:39:=$genre_b
                                SAVE RECORD:C53([HeBerge:4])
                                $countHB:=$countHB+1
                        End if
                End if
                UNLOAD RECORD:C212([HeBerge:4])
        End if

        NEXT RECORD:C51([HeberGement:5])
End while

ALERT:C41("Opération effectuée avec succès : "+String:C10($countHG)+" hébergements et "+String:C10($countHB)+" hébergés mis à jour")
