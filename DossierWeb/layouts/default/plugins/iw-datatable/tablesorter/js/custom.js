$(function() {

	// simple reflow widget (table with 1 header row)
	$(".iw_data_table").tablesorter({
		theme: 'blue',
		widgets: ['zebra', 'reflow'],
		widgetOptions : {
			// class name added to make it responsive (class name within media query)
			reflow_className    : 'ui-table-reflow',
			// header attribute containing modified header name
			reflow_headerAttrib : 'data-name',
			// data attribute added to each tbody cell
			// it contains the header cell text, visible upon reflow
			reflow_dataAttrib   : 'data-title'
		}
	});
	
});