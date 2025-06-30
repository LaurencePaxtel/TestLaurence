//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 07-03-19, 19:00:12
// ----------------------------------------------------
// Method: WebAGL_Table_Liste
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_TEXT:C284($3)

C_POINTER:C301($html; $tb_headers_th)
C_TEXT:C284($table_id; $html_content)

$html:=$1
$tb_headers_th:=$2
$table_id:=$3

$html_content:=$html_content+"<div id=\""+$table_id+"_parent\">"
$html_content:=$html_content+"<table id=\""+$table_id+"\" class=\"iw_data_table table table-striped table-advance table-hover\">"

$html_content:=$html_content+"<thead>"
$html_content:=$html_content+"<tr>"

For ($i; 1; Size of array:C274($tb_headers_th->))
	$html_content:=$html_content+"<th>"
	$html_content:=$html_content+Replace string:C233($tb_headers_th->{$i}; " "; "&nbsp;")
	$html_content:=$html_content+"</th>"
End for 

$html_content:=$html_content+"</tr>"
$html_content:=$html_content+"</thead>"

$html_content:=$html_content+"<tfoot>"
$html_content:=$html_content+"</tfoot>"

$html_content:=$html_content+"<tbody>"
$html_content:=$html_content+"</tbody>"

$html_content:=$html_content+"</table>"

//Pagination
$html_content:=$html_content+"<div id=\"pager\" class=\"pager tablesorterPager\">"

$html_content:=$html_content+"<i class=\"btn btn-sm defaul fa  fa-angle-double-left\"></i>"
$html_content:=$html_content+"<i class=\"btn btn-sm default fa fa-angle-left fa fa-angle-left\"></i>"

$html_content:=$html_content+"<input type=\"text\" class=\"pagedisplay\" id=\""+$table_id+"_pager_info\" disabled/>"

$html_content:=$html_content+"<i class=\"btn btn-sm default fa fa-angle-right\"></i>"
$html_content:=$html_content+"<i class=\"btn btn-sm default fa fa-angle-double-right\"></i>"

$html_content:=$html_content+"<select class=\"pagesize\" style=\"width:100px;display:inline;\">"
$html_content:=$html_content+"<option value=\"5\">5</option>"
$html_content:=$html_content+"<option value=\"10\">10</option>"
$html_content:=$html_content+"<option value=\"20\">20</option>"
$html_content:=$html_content+"<option value=\"50\">50</option>"
$html_content:=$html_content+"<option value=\"100\">100</option>"
$html_content:=$html_content+"<option value=\"100000\">Tout</option>"
$html_content:=$html_content+"</select>"

$html_content:=$html_content+"</div>"
$html_content:=$html_content+"</div>"

$html->:=$html->+$html_content