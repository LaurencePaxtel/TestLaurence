//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 09/06/2020, 07:29:38
// ----------------------------------------------------
// Method: Web_Form_GI_Stock
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($o)

C_TEXT:C284(SCRIPT)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

RECORD_ACT_EDIT:=True:C214
FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="gl_equipement"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="gl_equipement"
$TB_FORM{0}{6}:="iw_piece_ligne"

PARAM_MANDATORY_FIELDS:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="equ_nom"
$TB_HTML{$o}{4}:=[Equipement:107]EQU_Nom:4
$TB_HTML{$o}{5}:="Équipement"
$TB_HTML{$o}{6}:="equ_nom"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third readonly"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="equ_type"
$TB_HTML{$o}{4}:=[Equipement:107]EQU_Type:5
$TB_HTML{$o}{5}:="Type"
$TB_HTML{$o}{6}:="equ_type"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third readonly "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="equ_reference_fabricant"
$TB_HTML{$o}{4}:=[Equipement:107]EQU_Reference_Fabricant:6
$TB_HTML{$o}{5}:="Référence fabricant"
$TB_HTML{$o}{6}:="equ_reference_fabricant"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_third readonly"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="stk_stock"
$TB_HTML{$o}{4}:=String:C10([Stock:113]STK_Stock:4)
$TB_HTML{$o}{5}:="Quantité en stock"
$TB_HTML{$o}{6}:="stk_stock"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_third readonly"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="stk_stock_reserve"
$TB_HTML{$o}{4}:=String:C10([Stock:113]STK_Stock_Reserve:6)
$TB_HTML{$o}{5}:="Quantité réservée"
$TB_HTML{$o}{6}:="stk_stock_reserve"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_third readonly"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="stk_stock_disponible"
$TB_HTML{$o}{4}:=String:C10([Stock:113]STK_Stock_Disponible:5)
$TB_HTML{$o}{5}:="Quantité disponible"
$TB_HTML{$o}{6}:="stk_stock_disponible"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_third readonly"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="stk_stock_sortant"
$TB_HTML{$o}{4}:=String:C10([Stock:113]STK_Stock_Sortant:8)
$TB_HTML{$o}{5}:="Quantité sortante"
$TB_HTML{$o}{6}:="stk_stock_sortant"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_third readonly"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="equ_stock_min"
$TB_HTML{$o}{4}:=String:C10([Equipement:107]EQU_Stock_Min:13)
$TB_HTML{$o}{5}:="Le stock minimum"
$TB_HTML{$o}{6}:="equ_stock_min"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_third readonly"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="equ_stock_emplacement"
$TB_HTML{$o}{4}:=[Stock:113]STK_Emplacement:7
$TB_HTML{$o}{5}:="Emplacement actuel"
$TB_HTML{$o}{6}:="equ_stock_emplacement"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_third readonly"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="record_id"
$TB_HTML{$o}{4}:=String:C10([Equipement:107]ID:1)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="record_id"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="id_selected"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="id_selected"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)
$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)