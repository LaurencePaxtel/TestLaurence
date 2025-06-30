//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 20/11/18, 11:07:28
// ----------------------------------------------------
// Méthode : Web_Form_SP
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($0)

C_TEXT:C284($html)
C_LONGINT:C283($o)

ARRAY TEXT:C222($TB_HTML; 150; 15)

$html:=$html+"<div id=\"iw_notes_sp\">"

$html:=$html+"<div id=\"iw_notes_sp_child\">"

$html:=$html+"<div class=\"portlet box red iw_notes_sp\" >"
$html:=$html+"<div class=\"portlet-title\">"
$html:=$html+"<div class=\"caption\">"
$html:=$html+"<i class=\"fa fa-commenting-o\"></i>Note SP</div>"
$html:=$html+"</div>"
$html:=$html+"<div class=\"portlet-body form\">"
$html:=$html+"<form enctype=\"multipart/form-data\" action=\"#\" method=\"post\" name=\"form_notes_sp\" id=\"form_notes_sp\" class=\"fdp_form\">"

$html:=$html+"<div class=\"clearfix\">"
$html:=$html+"<div class=\"fdp_line\">"

$html:=$html+"<div class=\"fdp_resp_table  iw-alternance-only\" >"
$html:=$html+"<div class=\"table\">"

$html:=$html+"<div class=\"row header\">"
$html:=$html+"<div class=\"cell iw_text_align_center\">N°</div>"
$html:=$html+"<div class=\"cell \">SP</div>"
$html:=$html+"<div class=\"cell \">Date</div>"
$html:=$html+"<div class=\"cell \">Commentaires</div>"
$html:=$html+"</div>"

//---------------------------------------------------------------------------------------------------//
$html:=$html+"<div class=\"row body \">"

$html:=$html+"<div class=\"cell iw_text_align_center\">1</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="iw_checkbox_wt"
$TB_HTML{$o}{3}:="hb_cas1"
$TB_HTML{$o}{4}:="hb_cas1;;"+String:C10([HeBerge:4]HB_Cas1:7)+"|"
$TB_HTML{$o}{5}:="hb_cas1"
$TB_HTML{$o}{6}:="hb_cas1"
$TB_HTML{$o}{7}:="iw_bold"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$date:=""
If ([HeBerge:4]HB_CasDt1:19#!00-00-00!)
	$date:=String:C10([HeBerge:4]HB_CasDt1:19)
End if 

$html:=$html+"<div class=\"cell iw_max_width130px\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_casdt1"
$TB_HTML{$o}{4}:=$date
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_casdt1"
$TB_HTML{$o}{7}:="span7 datepicker search fdp_placeholder iw_width100p "
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
//$html:=$html+"<script>$('.datepicker').datepicker({format: 'dd/mm/yyyy'});</script>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_caslib1"
$TB_HTML{$o}{4}:=[HeBerge:4]HB_CasLib1:29
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_caslib1"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_width100p"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$html:=$html+"</div>"

//---------------------------------------------------------------------------------------------------//
$html:=$html+"<div class=\"row body \">"

$html:=$html+"<div class=\"cell iw_text_align_center\">2</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="iw_checkbox_wt"
$TB_HTML{$o}{3}:="hb_cas2"
$TB_HTML{$o}{4}:="hb_cas2;;"+String:C10([HeBerge:4]HB_Cas2:8)+"|"
$TB_HTML{$o}{5}:="hb_cas2"
$TB_HTML{$o}{6}:="hb_cas2"
$TB_HTML{$o}{7}:="iw_bold"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$date:=""
If ([HeBerge:4]HB_CasDt2:20#!00-00-00!)
	$date:=String:C10([HeBerge:4]HB_CasDt2:20)
End if 

$html:=$html+"<div class=\"cell iw_max_width130px\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_casdt2"
$TB_HTML{$o}{4}:=$date
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_casdt2"
$TB_HTML{$o}{7}:="span7 datepicker search fdp_placeholder iw_width100p "
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
//$html:=$html+"<script>$('.datepicker').datepicker({format: 'dd/mm/yyyy'});</script>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_caslib2"
$TB_HTML{$o}{4}:=[HeBerge:4]HB_CasLib2:30
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_caslib2"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_width100p"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$html:=$html+"</div>"

//---------------------------------------------------------------------------------------------------//
$html:=$html+"<div class=\"row body \">"

$html:=$html+"<div class=\"cell iw_text_align_center\">3</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="iw_checkbox_wt"
$TB_HTML{$o}{3}:="hb_cas3"
$TB_HTML{$o}{4}:="hb_cas3;;"+String:C10([HeBerge:4]HB_Cas3:9)+"|"
$TB_HTML{$o}{5}:="hb_cas3"
$TB_HTML{$o}{6}:="hb_cas3"
$TB_HTML{$o}{7}:="iw_bold"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$date:=""
If ([HeBerge:4]HB_CasDt3:21#!00-00-00!)
	$date:=String:C10([HeBerge:4]HB_CasDt3:21)
End if 

$html:=$html+"<div class=\"cell iw_max_width130px\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_casdt3"
$TB_HTML{$o}{4}:=$date
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_casdt3"
$TB_HTML{$o}{7}:="span7 datepicker search fdp_placeholder iw_width100p "
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
//$html:=$html+"<script>$('.datepicker').datepicker({format: 'dd/mm/yyyy'});</script>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_caslib3"
$TB_HTML{$o}{4}:=[HeBerge:4]HB_CasLib3:31
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_caslib3"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_width100p"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$html:=$html+"</div>"


//---------------------------------------------------------------------------------------------------//
$html:=$html+"<div class=\"row body \">"

$html:=$html+"<div class=\"cell iw_text_align_center\">4</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="iw_checkbox_wt"
$TB_HTML{$o}{3}:="hb_cas4"
$TB_HTML{$o}{4}:="hb_cas4;;"+String:C10([HeBerge:4]HB_Cas4:10)+"|"
$TB_HTML{$o}{5}:="hb_cas4"
$TB_HTML{$o}{6}:="hb_cas4"
$TB_HTML{$o}{7}:="iw_bold"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$date:=""
If ([HeBerge:4]HB_CasDt4:22#!00-00-00!)
	$date:=String:C10([HeBerge:4]HB_CasDt4:22)
End if 

$html:=$html+"<div class=\"cell iw_max_width130px\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_casdt4"
$TB_HTML{$o}{4}:=$date
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_casdt4"
$TB_HTML{$o}{7}:="span7 datepicker search fdp_placeholder iw_width100p "
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
//$html:=$html+"<script>$('.datepicker').datepicker({format: 'dd/mm/yyyy'});</script>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_caslib4"
$TB_HTML{$o}{4}:=[HeBerge:4]HB_CasLib4:32
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_caslib4"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_width100p"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$html:=$html+"</div>"


//---------------------------------------------------------------------------------------------------//
$html:=$html+"<div class=\"row body \">"

$html:=$html+"<div class=\"cell iw_text_align_center\">5</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="iw_checkbox_wt"
$TB_HTML{$o}{3}:="hb_cas5"
$TB_HTML{$o}{4}:="hb_cas5;;"+String:C10([HeBerge:4]HB_Cas5:11)+"|"
$TB_HTML{$o}{5}:="hb_cas5"
$TB_HTML{$o}{6}:="hb_cas5"
$TB_HTML{$o}{7}:="iw_bold"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$date:=""
If ([HeBerge:4]HB_CasDt5:23#!00-00-00!)
	$date:=String:C10([HeBerge:4]HB_CasDt5:23)
End if 

$html:=$html+"<div class=\"cell iw_max_width130px\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_casdt5"
$TB_HTML{$o}{4}:=$date
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_casdt5"
$TB_HTML{$o}{7}:="span7 datepicker search fdp_placeholder iw_width100p "
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
//$html:=$html+"<script>$('.datepicker').datepicker({format: 'dd/mm/yyyy'});</script>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_caslib5"
$TB_HTML{$o}{4}:=[HeBerge:4]HB_CasLib5:33
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_caslib5"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_width100p"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$html:=$html+"</div>"


//---------------------------------------------------------------------------------------------------//
$html:=$html+"<div class=\"row body \">"

$html:=$html+"<div class=\"cell iw_text_align_center\">6</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="iw_checkbox_wt"
$TB_HTML{$o}{3}:="hb_cas6"
$TB_HTML{$o}{4}:="hb_cas6;;"+String:C10([HeBerge:4]HB_Cas6:12)+"|"
$TB_HTML{$o}{5}:="hb_cas6"
$TB_HTML{$o}{6}:="hb_cas6"
$TB_HTML{$o}{7}:="iw_bold"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$date:=""
If ([HeBerge:4]HB_CasDt6:24#!00-00-00!)
	$date:=String:C10([HeBerge:4]HB_CasDt6:24)
End if 

$html:=$html+"<div class=\"cell iw_max_width130px\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_casdt6"
$TB_HTML{$o}{4}:=$date
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_casdt6"
$TB_HTML{$o}{7}:="span7 datepicker search fdp_placeholder iw_width100p "
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
//$html:=$html+"<script>$('.datepicker').datepicker({format: 'dd/mm/yyyy'});</script>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_caslib6"
$TB_HTML{$o}{4}:=[HeBerge:4]HB_CasLib6:34
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_caslib6"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_width100p"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$html:=$html+"</div>"


//---------------------------------------------------------------------------------------------------//
$html:=$html+"<div class=\"row body \">"

$html:=$html+"<div class=\"cell iw_text_align_center\">7</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="iw_checkbox_wt"
$TB_HTML{$o}{3}:="hb_cas7"
$TB_HTML{$o}{4}:="hb_cas7;;"+String:C10([HeBerge:4]HB_Cas7:13)+"|"
$TB_HTML{$o}{5}:="hb_cas7"
$TB_HTML{$o}{6}:="hb_cas7"
$TB_HTML{$o}{7}:="iw_bold"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$date:=""
If ([HeBerge:4]HB_CasDt7:25#!00-00-00!)
	$date:=String:C10([HeBerge:4]HB_CasDt7:25)
End if 

$html:=$html+"<div class=\"cell iw_max_width130px\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_casdt7"
$TB_HTML{$o}{4}:=$date
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_casdt7"
$TB_HTML{$o}{7}:="span7 datepicker search fdp_placeholder iw_width100p "
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
//$html:=$html+"<script>$('.datepicker').datepicker({format: 'dd/mm/yyyy'});</script>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_caslib7"
$TB_HTML{$o}{4}:=[HeBerge:4]HB_CasLib7:35
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_caslib7"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_width100p"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$html:=$html+"</div>"


//---------------------------------------------------------------------------------------------------//
$html:=$html+"<div class=\"row body \">"

$html:=$html+"<div class=\"cell iw_text_align_center\">8</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="iw_checkbox_wt"
$TB_HTML{$o}{3}:="hb_cas8"
$TB_HTML{$o}{4}:="hb_cas8;;"+String:C10([HeBerge:4]HB_Cas8:14)+"|"
$TB_HTML{$o}{5}:="hb_cas8"
$TB_HTML{$o}{6}:="hb_cas8"
$TB_HTML{$o}{7}:="iw_bold"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$date:=""
If ([HeBerge:4]HB_CasDt8:26#!00-00-00!)
	$date:=String:C10([HeBerge:4]HB_CasDt8:26)
End if 

$html:=$html+"<div class=\"cell iw_max_width130px\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_casdt8"
$TB_HTML{$o}{4}:=$date
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_casdt8"
$TB_HTML{$o}{7}:="span7 datepicker search fdp_placeholder iw_width100p "
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
//$html:=$html+"<script>$('.datepicker').datepicker({format: 'dd/mm/yyyy'});</script>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_caslib8"
$TB_HTML{$o}{4}:=[HeBerge:4]HB_CasLib8:36
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_caslib8"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_width100p"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$html:=$html+"</div>"


//---------------------------------------------------------------------------------------------------//
$html:=$html+"<div class=\"row body \">"

$html:=$html+"<div class=\"cell iw_text_align_center\">9</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="iw_checkbox_wt"
$TB_HTML{$o}{3}:="hb_cas9"
$TB_HTML{$o}{4}:="hb_cas9;;"+String:C10([HeBerge:4]HB_Cas9:15)+"|"
$TB_HTML{$o}{5}:="hb_cas9"
$TB_HTML{$o}{6}:="hb_cas9"
$TB_HTML{$o}{7}:="iw_bold"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$date:=""
If ([HeBerge:4]HB_CasDt9:27#!00-00-00!)
	$date:=String:C10([HeBerge:4]HB_CasDt9:27)
End if 

$html:=$html+"<div class=\"cell iw_max_width130px\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_casdt9"
$TB_HTML{$o}{4}:=$date
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_casdt9"
$TB_HTML{$o}{7}:="span7 datepicker search fdp_placeholder iw_width100p "
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
//$html:=$html+"<script>$('.datepicker').datepicker({format: 'dd/mm/yyyy'});</script>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_caslib9"
$TB_HTML{$o}{4}:=[HeBerge:4]HB_CasLib9:37
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_caslib9"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_width100p"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$html:=$html+"</div>"

//---------------------------------------------------------------------------------------------------//
$html:=$html+"<div class=\"row body \">"

$html:=$html+"<div class=\"cell iw_text_align_center\">10</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="iw_checkbox_wt"
$TB_HTML{$o}{3}:="hb_cas10"
$TB_HTML{$o}{4}:="hb_cas10;;"+String:C10([HeBerge:4]HB_Cas10:16)+"|"
$TB_HTML{$o}{5}:="hb_cas10"
$TB_HTML{$o}{6}:="hb_cas10"
$TB_HTML{$o}{7}:="iw_bold"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$date:=""
If ([HeBerge:4]HB_CasDt10:28#!00-00-00!)
	$date:=String:C10([HeBerge:4]HB_CasDt10:28)
End if 

$html:=$html+"<div class=\"cell iw_max_width130px\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_casdt10"
$TB_HTML{$o}{4}:=$date
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_casdt10"
$TB_HTML{$o}{7}:="span7 datepicker search fdp_placeholder iw_width100p "
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
//$html:=$html+"<script>$('.datepicker').datepicker({format: 'dd/mm/yyyy'});</script>"
$html:=$html+"</div>"

$html:=$html+"<div class=\"cell\">"
$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="hb_caslib10"
$TB_HTML{$o}{4}:=[HeBerge:4]HB_CasLib10:38
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="hb_caslib10"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_width100p"
$html:=$html+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
$html:=$html+"</div>"

$html:=$html+"</div>"


//********************************

$html:=$html+"</div>"
$html:=$html+"</div>"



$html:=$html+"</div>"
$html:=$html+"<div class=\"clr\"></div>"
$html:=$html+"</div>"




$html:=$html+"</form>"
$html:=$html+"</div>"
$html:=$html+"</div>"



$html:=$html+"</div>"
$html:=$html+"</div>"

$0:=$html