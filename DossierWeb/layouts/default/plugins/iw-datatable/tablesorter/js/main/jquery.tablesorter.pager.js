/*!
 * tablesorter (FORK) pager plugin
 * updated 8/19/2015 (v2.23.1)
 */
/*jshint browser:true, jquery:true, unused:false */
;(function($) {
	'use strict';
	/*jshint supernew:true */
	var ts = $.tablesorter;

	$.extend({ tablesorterPager: new function() {

		this.defaults = {
			// target the pager markup
			container: null,

			// use this format: "http://mydatabase.com?page={page}&size={size}&{sortList:col}&{filterList:fcol}"
			// where {page} is replaced by the page number, {size} is replaced by the number of records to show,
			// {sortList:col} adds the sortList to the url into a "col" array, and {filterList:fcol} adds
			// the filterList to the url into an "fcol" array.
			// So a sortList = [[2,0],[3,0]] becomes "&col[2]=0&col[3]=0" in the url
			// and a filterList = [[2,Blue],[3,13]] becomes "&fcol[2]=Blue&fcol[3]=13" in the url
			ajaxUrl: null,

			// modify the url after all processing has been applied
			customAjaxUrl: function(table, url) { return url; },

			// ajax error callback from $.tablesorter.showError function
			// ajaxError: function( config, xhr, settings, exception ){ return exception; };
			// returning false will abort the error message
			ajaxError: null,

			// modify the $.ajax object to allow complete control over your ajax requests
			ajaxObject: {
				dataType: 'json'
			},

			// set this to false if you want to block ajax loading on init
			processAjaxOnInit: true,

			// process ajax so that the following information is returned:
			// [ total_rows (number), rows (array of arrays), headers (array; optional) ]
			// example:
			// [
			//   100,  // total rows
			//   [
			//     [ "row1cell1", "row1cell2", ... "row1cellN" ],
			//     [ "row2cell1", "row2cell2", ... "row2cellN" ],
			//     ...
			//     [ "rowNcell1", "rowNcell2", ... "rowNcellN" ]
			//   ],
			//   [ "header1", "header2", ... "headerN" ] // optional
			// ]
			ajaxProcessing: function(ajax){ return [ 0, [], null ]; },

			// output default: '{page}/{totalPages}'
			// possible variables: {page}, {totalPages}, {filteredPages}, {startRow}, {endRow}, {filteredRows} and {totalRows}
			output: '{startRow} to {endRow} of {totalRows} rows', // '{page}/{totalPages}'

			// apply disabled classname to the pager arrows when the rows at either extreme is visible
			updateArrows: true,

			// starting page of the pager (zero based index)
			page: 0,

			// reset pager after filtering; set to desired page #
			// set to false to not change page at filter start
			pageReset: 0,

			// Number of visible rows
			size: 10,

			// Number of options to include in the pager number selector
			maxOptionSize: 20,

			// Save pager page & size if the storage script is loaded (requires $.tablesorter.storage in jquery.tablesorter.widgets.js)
			savePages: true,

			// defines custom storage key
			storageKey: 'tablesorter-pager',

			// if true, the table will remain the same height no matter how many records are displayed. The space is made up by an empty
			// table row set to a height to compensate; default is false
			fixedHeight: false,

			// count child rows towards the set page size? (set true if it is a visible table row within the pager)
			// if true, child row(s) may not appear to be attached to its parent row, may be split across pages or
			// may distort the table if rowspan or cellspans are included.
			countChildRows: false,

			// remove rows from the table to speed up the sort of large tables.
			// setting this to false, only hides the non-visible rows; needed if you plan to add/remove rows with the pager enabled.
			removeRows: false, // removing rows in larger tables speeds up the sort

			// css class names of pager arrows
			cssFirst: '.first', // go to first page arrow
			cssPrev: '.prev', // previous page arrow
			cssNext: '.next', // next page arrow
			cssLast: '.last', // go to last page arrow
			cssGoto: '.gotoPage', // go to page selector - select dropdown that sets the current page
			cssPageDisplay: '.pagedisplay', // location of where the "output" is displayed
			cssPageSize: '.pagesize', // page size selector - select dropdown that sets the "size" option
			cssErrorRow: 'tablesorter-errorRow', // error information row

			// class added to arrows when at the extremes (i.e. prev/first arrows are "disabled" when on the first page)
			cssDisabled: 'disabled', // Note there is no period "." in front of this class name

			// stuff not set by the user
			totalRows: 0,
			totalPages: 0,
			filteredRows: 0,
			filteredPages: 0,
			ajaxCounter: 0,
			currentFilters: [],
			startRow: 0,
			endRow: 0,
			$size: null,
			last: {}

		};

		var pagerEvents = 'filterInit filterStart filterEnd sortEnd disablePager enablePager destroyPager updateComplete ' +
			'pageSize pageSet pageAndSize pagerUpdate refreshComplete ',

		$this = this,

		// hide arrows at extremes
		pagerArrows = function(p, disable) {
			var a = 'addClass',
			r = 'removeClass',
			d = p.cssDisabled,
			dis = !!disable,
			first = ( dis || p.page === 0 ),
			tp = Math.min( p.totalPages, p.filteredPages ),
			last = ( dis || (p.page === tp - 1) || tp === 0 );
			if ( p.updateArrows ) {
				p.$container.find(p.cssFirst + ',' + p.cssPrev)[ first ? a : r ](d).attr('aria-disabled', first);
				p.$container.find(p.cssNext + ',' + p.cssLast)[ last ? a : r ](d).attr('aria-disabled', last);
			}
		},

		calcFilters = function(table, p) {
			var normalized, indx, len,
				c = table.config,
				hasFilters = c.$table.hasClass('hasFilters');
			if (hasFilters && !p.ajaxUrl) {
				if (ts.isEmptyObject(c.cache)) {
					// delayInit: true so nothing is in the cache
					p.filteredRows = p.totalRows = c.$tbodies.eq(0).children('tr').not( p.countChildRows ? '' : '.' + c.cssChildRow ).length;
				} else {
					p.filteredRows = 0;
					normalized = c.cache[0].normalized;
					len = normalized.length;
					for (indx = 0; indx < len; indx++) {
						p.filteredRows += p.regexRows.test(normalized[indx][c.columns].$row[0].className) ? 0 : 1;
					}
				}
			} else if (!hasFilters) {
				p.filteredRows = p.totalRows;
			}
		},

		updatePageDisplay = function(table, p, completed) {
			if ( p.initializing ) { return; }
			var s, t, $out, indx, len, options,
				c = table.config,
				namespace = c.namespace + 'pager',
				sz = p.size || p.settings.size || 10; // don't allow dividing by zero
			if (p.countChildRows) { t.push(c.cssChildRow); }
			p.totalPages = Math.ceil( p.totalRows / sz ); // needed for "pageSize" method
			c.totalRows = p.totalRows;
			calcFilters(table, p);
			c.filteredRows = p.filteredRows;
			p.filteredPages = Math.ceil( p.filteredRows / sz ) || 0;
			if ( Math.min( p.totalPages, p.filteredPages ) >= 0 ) {
				t = (p.size * p.page > p.filteredRows) && completed;
				p.page = (t) ? p.pageReset || 0 : p.page;
				p.startRow = (t) ? p.size * p.page + 1 : (p.filteredRows === 0 ? 0 : p.size * p.page + 1);
				p.endRow = Math.min( p.filteredRows, p.totalRows, p.size * ( p.page + 1 ) );
				$out = p.$container.find(p.cssPageDisplay);
				// form the output string (can now get a new output string from the server)
				s = ( p.ajaxData && p.ajaxData.output ? p.ajaxData.output || p.output : p.output )
					// {page} = one-based index; {page+#} = zero based index +/- value
					.replace(/\{page([\-+]\d+)?\}/gi, function(m, n){
						return p.totalPages ? p.page + (n ? parseInt(n, 10) : 1) : 0;
					})
					// {totalPages}, {extra}, {extra:0} (array) or {extra : key} (object)
					.replace(/\{\w+(\s*:\s*\w+)?\}/gi, function(m){
						var len, indx,
							str = m.replace(/[{}\s]/g, ''),
							extra = str.split(':'),
							data = p.ajaxData,
							// return zero for default page/row numbers
							deflt = /(rows?|pages?)$/i.test(str) ? 0 : '';
						if (/(startRow|page)/.test(extra[0]) && extra[1] === 'input') {
							len = ('' + (extra[0] === 'page' ? p.totalPages : p.totalRows)).length;
							indx = extra[0] === 'page' ? p.page + 1 : p.startRow;
							return '<input type="text" class="ts-' + extra[0] + '" style="max-width:' + len + 'em" value="' + indx + '"/>';
						}
						return extra.length > 1 && data && data[extra[0]] ? data[extra[0]][extra[1]] : p[str] || (data ? data[str] : deflt) || deflt;
					});
				if ( p.$goto.length ) {
					t = '';
					options = buildPageSelect(p);
					len = options.length;
					for (indx = 0; indx < len; indx++) {
						t += '<option value="' + options[indx] + '">' + options[indx] + '</option>';
					}
					// innerHTML doesn't work in IE9 - http://support2.microsoft.com/kb/276228
					p.$goto.html(t).val( p.page + 1 );
				}
				if ($out.length) {
					$out[ ($out[0].nodeName === 'INPUT') ? 'val' : 'html' ](s);
					// rebind startRow/page inputs
					$out.find('.ts-startRow, .ts-page').unbind('change' + namespace).bind('change' + namespace, function(){
						var v = $(this).val(),
							pg = $(this).hasClass('ts-startRow') ? Math.floor( v / p.size ) + 1 : v;
						c.$table.trigger('pageSet' + namespace, [ pg ]);
					});
				}
			}
			pagerArrows(p);
			fixHeight(table, p);
			if (p.initialized && completed !== false) {
				if (c.debug) {
					console.log('Pager: Triggering pagerComplete');
				}
				c.$table.trigger('pagerComplete', p);
				// save pager info to storage
				if (p.savePages && ts.storage) {
					ts.storage(table, p.storageKey, {
						page : p.page,
						size : p.size
					});
				}
			}
		},

		buildPageSelect = function(p) {
			// Filter the options page number link array if it's larger than 'maxOptionSize'
			// as large page set links will slow the browser on large dom inserts
			var i, central_focus_size, focus_option_pages, insert_index, option_length, focus_length,
				pg = Math.min( p.totalPages, p.filteredPages ) || 1,
				// make skip set size multiples of 5
				skip_set_size = Math.ceil( ( pg / p.maxOptionSize ) / 5 ) * 5,
				large_collection = pg > p.maxOptionSize,
				current_page = p.page + 1,
				start_page = skip_set_size,
				end_page = pg - skip_set_size,
				option_pages = [ 1 ],
				// construct default options pages array
				option_pages_start_page = (large_collection) ? skip_set_size : 1;

			for ( i = option_pages_start_page; i <= pg; ) {
				option_pages.push(i);
				i = i + ( large_collection ? skip_set_size : 1 );
			}
			option_pages.push(pg);
			if (large_collection) {
				focus_option_pages = [];
				// don't allow central focus size to be > 5 on either side of current page
				central_focus_size = Math.max( Math.floor( p.maxOptionSize / skip_set_size ) - 1, 5 );

				start_page = current_page - central_focus_size;
				if (start_page < 1) { start_page = 1; }
				end_page = current_page + central_focus_size;
				if (end_page > pg) { end_page = pg; }
				// construct an array to get a focus set around the current page
				for (i = start_page; i <= end_page ; i++) {
					focus_option_pages.push(i);
				}

				// keep unique values
				option_pages = $.grep(option_pages, function(value, indx) {
					return $.inArray(value, option_pages) === indx;
				});

				option_length = option_pages.length;
				focus_length = focus_option_pages.length;

				// make sure at all option_pages aren't replaced
				if (option_length - focus_length > skip_set_size / 2 && option_length + focus_length > p.maxOptionSize ) {
					insert_index = Math.floor(option_length / 2) - Math.floor(focus_length / 2);
					Array.prototype.splice.apply(option_pages, [ insert_index, focus_length ]);
				}
				option_pages = option_pages.concat(focus_option_pages);

			}

			// keep unique values again
			option_pages = $.grep(option_pages, function(value, indx) {
				return $.inArray(value, option_pages) === indx;
			})
			.sort(function(a, b) { return a - b; });

			return option_pages;
		},

		fixHeight = function(table, p) {
			var d, h,
				c = table.config,
				$b = c.$tbodies.eq(0);
			$b.find('tr.pagerSavedHeightSpacer').remove();
			if (p.fixedHeight && !p.isDisabled) {
				h = $.data(table, 'pagerSavedHeight');
				if (h) {
					d = h - $b.height();
					if ( d > 5 && $.data(table, 'pagerLastSize') === p.size && $b.children('tr:visible').length < p.size ) {
						$b.append('<tr class="pagerSavedHeightSpacer ' + c.selectorRemove.slice(1) + '" style="height:' + d + 'px;"></tr>');
					}
				}
			}
		},

		changeHeight = function(table, p) {
			var h,
				c = table.config,
				$b = c.$tbodies.eq(0);
			$b.find('tr.pagerSavedHeightSpacer').remove();
			if (!$b.children('tr:visible').length) {
				$b.append('<tr class="pagerSavedHeightSpacer ' + c.selectorRemove.slice(1) + '"><td>&nbsp</td></tr>');
			}
			h = $b.children('tr').eq(0).height() * p.size;
			$.data(table, 'pagerSavedHeight', h);
			fixHeight(table, p);
			$.data(table, 'pagerLastSize', p.size);
		},

		hideRows = function(table, p){
			if (!p.ajaxUrl) {
				var i,
				lastIndex = 0,
				c = table.config,
				rows = c.$tbodies.eq(0).children('tr'),
				l = rows.length,
				s = ( p.page * p.size ),
				e =  s + p.size,
				f = c.widgetOptions && c.widgetOptions.filter_filteredRow || 'filtered',
				last = 0, // for cache indexing
				j = 0; // size counter
				p.cacheIndex = [];
				for ( i = 0; i < l; i++ ){
					if ( !rows[i].className.match(f) ) {
						if (j === s && rows[i].className.match(c.cssChildRow)) {
							// hide child rows @ start of pager (if already visible)
							rows[i].style.display = 'none';
						} else {
							rows[i].style.display = ( j >= s && j < e ) ? '' : 'none';
							if (last !== j && j >= s && j < e) {
								p.cacheIndex.push(i);
								last = j;
							}
							// don't count child rows
							j += rows[i].className.match(c.cssChildRow + '|' + c.selectorRemove.slice(1)) && !p.countChildRows ? 0 : 1;
							if ( j === e && rows[i].style.display !== 'none' && rows[i].className.match(ts.css.cssHasChild) ) {
								lastIndex = i;
							}
						}
					}
				}
				// add any attached child rows to last row of pager. Fixes part of issue #396
				if ( lastIndex > 0 && rows[lastIndex].className.match(ts.css.cssHasChild) ) {
					while ( ++lastIndex < l && rows[lastIndex].className.match(c.cssChildRow) ) {
						rows[lastIndex].style.display = '';
					}
				}
			}
		},

		hideRowsSetup = function(table, p){
			p.size = parseInt( p.$size.val(), 10 ) || p.size || p.settings.size || 10;
			$.data(table, 'pagerLastSize', p.size);
			pagerArrows(p);
			if ( !p.removeRows ) {
				hideRows(table, p);
				$(table).bind('sortEnd filterEnd '.split(' ').join(table.config.namespace + 'pager '), function(){
					hideRows(table, p);
				});
			}
		},

		renderAjax = function(data, table, p, xhr, settings, exception){
			// process data
			if ( typeof p.ajaxProcessing === 'function' ) {
				// ajaxProcessing result: [ total, rows, headers ]
				var i, j, t, hsh, $f, $sh, $headers, $h, icon, th, d, l, rr_count, len,
					c = table.config,
					$table = c.$table,
					tds = '',
					result = p.ajaxProcessing(data, table, xhr) || [ 0, [] ],
					hl = $table.find('thead th').length;

				// Clean up any previous error.
				ts.showError( table );

				if ( exception ) {
					if (c.debug) {
						console.error('Pager: >> Ajax Error', xhr, settings, exception);
					}
					ts.showError( table, xhr, settings, exception );
					c.$tbodies.eq(0).children('tr').detach();
					p.totalRows = 0;
				} else {
					// process ajax object
					if (!$.isArray(result)) {
						p.ajaxData = result;
						c.totalRows = p.totalRows = result.total;
						c.filteredRows = p.filteredRows = typeof result.filteredRows !== 'undefined' ? result.filteredRows : result.total;
						th = result.headers;
						d = result.rows || [];
					} else {
						// allow [ total, rows, headers ]  or [ rows, total, headers ]
						t = isNaN(result[0]) && !isNaN(result[1]);
						// ensure a zero returned row count doesn't fail the logical ||
						rr_count = result[t ? 1 : 0];
						p.totalRows = isNaN(rr_count) ? p.totalRows || 0 : rr_count;
						// can't set filtered rows when returning an array
						c.totalRows = c.filteredRows = p.filteredRows = p.totalRows;
						// set row data to empty array if nothing found - see http://stackoverflow.com/q/30875583/145346
						d = p.totalRows === 0 ? [] : result[t ? 0 : 1] || []; // row data
						th = result[2]; // headers
					}
					l = d && d.length;
					if (d instanceof jQuery) {
						if (p.processAjaxOnInit) {
							// append jQuery object
							c.$tbodies.eq(0).children('tr').detach();
							c.$tbodies.eq(0).append(d);
						}
					} else if (l) {
						// build table from array
						for ( i = 0; i < l; i++ ) {
							tds += '<tr>';
							for ( j = 0; j < d[i].length; j++ ) {
								// build tbody cells; watch for data containing HTML markup - see #434
								tds += /^\s*<td/.test(d[i][j]) ? $.trim(d[i][j]) : '<td>' + d[i][j] + '</td>';
							}
							tds += '</tr>';
						}
						// add rows to first tbody
						if (p.processAjaxOnInit) {
							c.$tbodies.eq(0).html( tds );
						}
					}
					p.processAjaxOnInit = true;
					// only add new header text if the length matches
					if ( th && th.length === hl ) {
						hsh = $table.hasClass('hasStickyHeaders');
						$sh = hsh ? c.widgetOptions.$sticky.children('thead:first').children('tr').children() : '';
						$f = $table.find('tfoot tr:first').children();
						// don't change td headers (may contain pager)
						$headers = c.$headers.filter( 'th ' );
						len = $headers.length;
						for ( j = 0; j < len; j++ ) {
							$h = $headers.eq( j );
							// add new test within the first span it finds, or just in the header
							if ( $h.find('.' + ts.css.icon).length ) {
								icon = $h.find('.' + ts.css.icon).clone(true);
								$h.find('.tablesorter-header-inner').html( th[j] ).append(icon);
								if ( hsh && $sh.length ) {
									icon = $sh.eq(j).find('.' + ts.css.icon).clone(true);
									$sh.eq(j).find('.tablesorter-header-inner').html( th[j] ).append(icon);
								}
							} else {
								$h.find('.tablesorter-header-inner').html( th[j] );
								if (hsh && $sh.length) {
									$sh.eq(j).find('.tablesorter-header-inner').html( th[j] );
								}
							}
							$f.eq(j).html( th[j] );
						}
					}
				}
				if (c.showProcessing) {
					ts.isProcessing(table); // remove loading icon
				}
				// make sure last pager settings are saved, prevents multiple server side calls with
				// the same parameters
				p.totalPages = Math.ceil( p.totalRows / ( p.size || p.settings.size || 10 ) );
				p.last.totalRows = p.totalRows;
				p.last.currentFilters = p.currentFilters;
				p.last.sortList = (c.sortList || []).join(',');
				updatePageDisplay(table, p, false);
				$table.trigger('updateCache', [ function(){
					if (p.initialized) {
						// apply widgets after table has rendered & after a delay to prevent
						// multiple applyWidget blocking code from blocking this trigger
						setTimeout(function(){
							if (c.debug) {
								console.log('Pager: Triggering pagerChange');
							}
							$table
								.trigger('applyWidgets')
								.trigger('pagerChange', p);
							updatePageDisplay(table, p, true);
						}, 0);
					}
				} ]);

			}
			if (!p.initialized) {
				p.initialized = true;
				p.initializing = false;
				if (table.config.debug) {
					console.log('Pager: Triggering pagerInitialized');
				}
				$(table)
					.trigger('applyWidgets')
					.trigger('pagerInitialized', p);
				updatePageDisplay(table, p);
			}
		},

		getAjax = function(table, p) {
			var url = getAjaxUrl(table, p),
				$doc = $(document),
				counter,
				c = table.config,
				namespace = c.namespace + 'pager';
			if ( url !== '' ) {
				if (c.showProcessing) {
					ts.isProcessing(table, true); // show loading icon
				}
				$doc.bind('ajaxError' + namespace, function(e, xhr, settings, exception) {
					renderAjax(null, table, p, xhr, settings, exception);
					$doc.unbind('ajaxError' + namespace);
				});

				counter = ++p.ajaxCounter;

				p.last.ajaxUrl = url; // remember processed url
				p.ajaxObject.url = url; // from the ajaxUrl option and modified by customAjaxUrl
				p.ajaxObject.success = function(data, status, jqxhr) {
					// Refuse to process old ajax commands that were overwritten by new ones - see #443
					if (counter < p.ajaxCounter){
						return;
					}
					renderAjax(data, table, p, jqxhr);
					$doc.unbind('ajaxError' + namespace);
					if (typeof p.oldAjaxSuccess === 'function') {
						p.oldAjaxSuccess(data);
					}
				};
				if (c.debug) {
					console.log('Pager: Ajax initialized', p.ajaxObject);
				}
				$.ajax(p.ajaxObject);
			}
		},

		getAjaxUrl = function(table, p) {
			var indx, len,
				c = table.config,
				url = (p.ajaxUrl) ? p.ajaxUrl
				// allow using "{page+1}" in the url string to switch to a non-zero based index
				.replace(/\{page([\-+]\d+)?\}/, function(s, n){ return p.page + (n ? parseInt(n, 10) : 0); })
				.replace(/\{size\}/g, p.size) : '',
			sortList = c.sortList,
			filterList = p.currentFilters || $(table).data('lastSearch') || [],
			sortCol = url.match(/\{\s*sort(?:List)?\s*:\s*(\w*)\s*\}/),
			filterCol = url.match(/\{\s*filter(?:List)?\s*:\s*(\w*)\s*\}/),
			arry = [];
			if (sortCol) {
				sortCol = sortCol[1];
				len = sortList.length;
				for (indx = 0; indx < len; indx++) {
					arry.push(sortCol + '[' + sortList[indx][0] + ']=' + sortList[indx][1]);
				}
				// if the arry is empty, just add the col parameter... "&{sortList:col}" becomes "&col"
				url = url.replace(/\{\s*sort(?:List)?\s*:\s*(\w*)\s*\}/g, arry.length ? arry.join('&') : sortCol );
				arry = [];
			}
			if (filterCol) {
				filterCol = filterCol[1];
				len = filterList.length;
				for (indx = 0; indx < len; indx++) {
					if (filterList[indx]) {
						arry.push(filterCol + '[' + indx + ']=' + encodeURIComponent(filterList[indx]));
					}
				}
				// if the arry is empty, just add the fcol parameter... "&{filterList:fcol}" becomes "&fcol"
				url = url.replace(/\{\s*filter(?:List)?\s*:\s*(\w*)\s*\}/g, arry.length ? arry.join('&') : filterCol );
				p.currentFilters = filterList;
			}
			if ( typeof p.customAjaxUrl === 'function' ) {
				url = p.customAjaxUrl(table, url);
			}
			if (c.debug) {
				console.log('Pager: Ajax url = ' + url);
			}
			return url;
		},

		renderTable = function(table, rows, p) {
			var $tb, index, count, added,
				$t = $(table),
				c = table.config,
				f = c.$table.hasClass('hasFilters'),
				l = rows && rows.length || 0, // rows may be undefined
				s = ( p.page * p.size ),
				e = p.size;
			if ( l < 1 ) {
				if (c.debug) {
					console.warn('Pager: >> No rows for pager to render');
				}
				// empty table, abort!
				return;
			}
			if ( p.page >= p.totalPages ) {
				// lets not render the table more than once
				moveToLastPage(table, p);
			}
			p.cacheIndex = [];
			p.isDisabled = false; // needed because sorting will change the page and re-enable the pager
			if (p.initialized) {
				if (c.debug) {
					console.log('Pager: Triggering pagerChange');
				}
				$t.trigger('pagerChange', p);
			}

			if ( !p.removeRows ) {
				hideRows(table, p);
			} else {
				ts.clearTableBody(table);
				$tb = ts.processTbody(table, c.$tbodies.eq(0), true);
				// not filtered, start from the calculated starting point (s)
				// if filtered, start from zero
				index = f ? 0 : s;
				count = f ? 0 : s;
				added = 0;
				while (added < e && index < rows.length) {
					if (!f || !/filtered/.test(rows[index][0].className)){
						count++;
						if (count > s && added <= e) {
							added++;
							p.cacheIndex.push(index);
							$tb.append(rows[index]);
						}
					}
					index++;
				}
				ts.processTbody(table, $tb, false);
			}
			updatePageDisplay(table, p);
			if (table.isUpdating) {
				if (c.debug) {
					console.log('Pager: Triggering updateComplete');
				}
				$t.trigger('updateComplete', [ table, true ]);
			}
		},

		showAllRows = function(table, p) {
			var index, $controls, len;
			if ( p.ajax ) {
				pagerArrows(p, true);
			} else {
				p.isDisabled = true;
				$.data(table, 'pagerLastPage', p.page);
				$.data(table, 'pagerLastSize', p.size);
				p.page = 0;
				p.size = p.totalRows;
				p.totalPages = 1;
				$(table)
					.addClass('pagerDisabled')
					.removeAttr('aria-describedby')
					.find('tr.pagerSavedHeightSpacer').remove();
				renderTable(table, table.config.rowsCopy, p);
				$(table).trigger('applyWidgets');
				if (table.config.debug) {
					console.log('Pager: Disabled');
				}
			}
			// disable size selector
			$controls = p.$size
				.add( p.$goto )
				.add( p.$container.find( '.ts-startRow, .ts-page' ) );
			len = $controls.length;
			for ( index = 0; index < len; index++ ) {
				$controls.eq( index )
					.attr( 'aria-disabled', 'true' )
					.addClass( p.cssDisabled )[0].disabled = true;
			}
		},

		// updateCache if delayInit: true
		updateCache = function(table) {
			var c = table.config,
				p = c.pager;
			c.$table.trigger('updateCache', [ function(){
				var i,
					rows = [],
					n = table.config.cache[0].normalized;
				p.totalRows = n.length;
				for (i = 0; i < p.totalRows; i++) {
					rows.push(n[i][c.columns].$row);
				}
				c.rowsCopy = rows;
				moveToPage(table, p, true);
			} ]);
		},

		moveToPage = function(table, p, pageMoved) {
			if ( p.isDisabled ) { return; }
			var pg, c = table.config,
				$t = $(table),
				l = p.last;
			if ( pageMoved !== false && p.initialized && ts.isEmptyObject(c.cache)) {
				return updateCache(table);
			}
			// abort page move if the table has filters and has not been initialized
			if (p.ajax && ts.hasWidget(table, 'filter') && !c.widgetOptions.filter_initialized) { return; }
			calcFilters(table, p);
			pg = Math.min( p.totalPages, p.filteredPages );
			if ( p.page < 0 ) { p.page = 0; }
			if ( p.page > ( pg - 1 ) && pg !== 0 ) { p.page = pg - 1; }
			// fixes issue where one currentFilter is [] and the other is ['','',''],
			// making the next if comparison think the filters are different (joined by commas). Fixes #202.
			l.currentFilters = (l.currentFilters || []).join('') === '' ? [] : l.currentFilters;
			p.currentFilters = (p.currentFilters || []).join('') === '' ? [] : p.currentFilters;
			// don't allow rendering multiple times on the same page/size/totalRows/filters/sorts
			if ( l.page === p.page && l.size === p.size && l.totalRows === p.totalRows &&
				(l.currentFilters || []).join(',') === (p.currentFilters || []).join(',') &&
				// check for ajax url changes see #730
				(l.ajaxUrl || '') === (p.ajaxObject.url || '') &&
				// & ajax url option changes (dynamically add/remove/rename sort & filter parameters)
				(l.optAjaxUrl || '') === (p.ajaxUrl || '') &&
				l.sortList === (c.sortList || []).join(',') ) { return; }
			if (c.debug) {
				console.log('Pager: Changing to page ' + p.page);
			}
			p.last = {
				page : p.page,
				size : p.size,
				// fixes #408; modify sortList otherwise it auto-updates
				sortList : (c.sortList || []).join(','),
				totalRows : p.totalRows,
				currentFilters : p.currentFilters || [],
				ajaxUrl : p.ajaxObject.url || '',
				optAjaxUrl : p.ajaxUrl || ''
			};
			if (p.ajax) {
				getAjax(table, p);
			} else if (!p.ajax) {
				renderTable(table, c.rowsCopy, p);
			}
			$.data(table, 'pagerLastPage', p.page);
			if (p.initialized && pageMoved !== false) {
				if (c.debug) {
					console.log('Pager: Triggering pageMoved');
				}
				$t
					.trigger('pageMoved', p)
					.trigger('applyWidgets');
				if (table.isUpdating) {
					if (c.debug) {
						console.log('Pager: Triggering updateComplete');
					}
					$t.trigger('updateComplete', [ table, true ]);
				}
			}
		},

		setPageSize = function(table, size, p) {
			p.size = size || p.size || p.settings.size || 10;
			p.$size.val(p.size);
			$.data(table, 'pagerLastPage', p.page);
			$.data(table, 'pagerLastSize', p.size);
			p.totalPages = Math.ceil( p.totalRows / p.size );
			p.filteredPages = Math.ceil( p.filteredRows / p.size );
			moveToPage(table, p);
		},

		moveToFirstPage = function(table, p) {
			p.page = 0;
			moveToPage(table, p);
		},

		moveToLastPage = function(table, p) {
			p.page = ( Math.min( p.totalPages, p.filteredPages ) - 1 );
			moveToPage(table, p);
		},

		moveToNextPage = function(table, p) {
			p.page++;
			if ( p.page >= ( Math.min( p.totalPages, p.filteredPages ) - 1 ) ) {
				p.page = ( Math.min( p.totalPages, p.filteredPages ) - 1 );
			}
			moveToPage(table, p);
		},

		moveToPrevPage = function(table, p) {
			p.page--;
			if ( p.page <= 0 ) {
				p.page = 0;
			}
			moveToPage(table, p);
		},

		destroyPager = function(table, p) {
			var c = table.config,
				namespace = c.namespace + 'pager',
				ctrls = [ p.cssFirst, p.cssPrev, p.cssNext, p.cssLast, p.cssGoto, p.cssPageSize ].join( ',' );
			showAllRows(table, p);
			p.$container
				// hide pager controls
				.hide()
				// unbind
				.find( ctrls )
				.unbind( namespace );
			c.appender = null; // remove pager appender function
			c.$table.unbind( namespace );
			if (ts.storage) {
				ts.storage(table, p.storageKey, '');
			}
			delete c.pager;
			delete c.rowsCopy;
		},

		enablePager = function(table, p, triggered) {
			var info,
				c = table.config;
			p.$size.add(p.$goto).add(p.$container.find('.ts-startRow, .ts-page'))
				.removeClass(p.cssDisabled)
				.removeAttr('disabled')
				.attr('aria-disabled', 'false');
			p.isDisabled = false;
			p.page = $.data(table, 'pagerLastPage') || p.page || 0;
			p.size = $.data(table, 'pagerLastSize') || parseInt(p.$size.find('option[selected]').val(), 10) || p.size || p.settings.size || 10;
			p.$size.val(p.size); // set page size
			p.totalPages = Math.ceil( Math.min( p.totalRows, p.filteredRows ) / p.size );
			// if table id exists, include page display with aria info
			if ( table.id ) {
				info = table.id + '_pager_info';
				//p.$container.find(p.cssPageDisplay).attr('id', info); updt kev 06-2020
				c.$table.attr('aria-describedby', info);
			}
			changeHeight(table, p);
			if ( triggered ) {
				c.$table.trigger('updateRows');
				setPageSize(table, p.size, p);
				hideRowsSetup(table, p);
				if (c.debug) {
					console.log('Pager: Enabled');
				}
			}
		};

		$this.appender = function(table, rows) {
			var c = table.config,
				p = c.pager;
			if ( !p.ajax ) {
				c.rowsCopy = rows;
				p.totalRows = p.countChildRows ? c.$tbodies.eq(0).children('tr').length : rows.length;
				p.size = $.data(table, 'pagerLastSize') || p.size || p.settings.size || 10;
				p.totalPages = Math.ceil( p.totalRows / p.size );
				renderTable(table, rows, p);
				// update display here in case all rows are removed
				updatePageDisplay(table, p, false);
			}
		};

		$this.construct = function(settings) {
			return this.each(function() {
				// check if tablesorter has initialized
				if (!(this.config && this.hasInitialized)) { return; }
				var t, ctrls, fxn,
					table = this,
					c = table.config,
					wo = c.widgetOptions,
					p = c.pager = $.extend( true, {}, $.tablesorterPager.defaults, settings ),
					$t = c.$table,
					namespace = c.namespace + 'pager',
					// added in case the pager is reinitialized after being destroyed.
					pager = p.$container = $(p.container).addClass('tablesorter-pager').show();
				// save a copy of the original settings
				p.settings = $.extend( true, {}, $.tablesorterPager.defaults, settings );
				if (c.debug) {
					console.log('Pager: Initializing');
				}
				p.oldAjaxSuccess = p.oldAjaxSuccess || p.ajaxObject.success;
				c.appender = $this.appender;
				p.initializing = true;
				if (p.savePages && ts.storage) {
					t = ts.storage(table, p.storageKey) || {}; // fixes #387
					p.page = isNaN(t.page) ? p.page : t.page;
					p.size = ( isNaN(t.size) ? p.size : t.size ) || p.settings.size || 10;
					$.data(table, 'pagerLastSize', p.size);
				}

				// skipped rows
				p.regexRows = new RegExp('(' + (wo.filter_filteredRow || 'filtered') + '|' + c.selectorRemove.slice(1) + '|' + c.cssChildRow + ')');

				$t
					// .unbind( namespace ) adding in jQuery 1.4.3 ( I think )
					.unbind( pagerEvents.split(' ').join(namespace + ' ').replace(/\s+/g, ' ') )
					.bind('filterInit filterStart '.split(' ').join(namespace + ' '), function(e, filters) {
						p.currentFilters = $.isArray(filters) ? filters : c.$table.data('lastSearch');
						// don't change page if filters are the same (pager updating, etc)
						if (e.type === 'filterStart' && p.pageReset !== false && (c.lastCombinedFilter || '') !== (p.currentFilters || []).join('')) {
							p.page = p.pageReset; // fixes #456 & #565
						}
					})
					// update pager after filter widget completes
					.bind('filterEnd sortEnd '.split(' ').join(namespace + ' '), function() {
						p.currentFilters = c.$table.data('lastSearch');
						if (p.initialized || p.initializing) {
							if (c.delayInit && c.rowsCopy && c.rowsCopy.length === 0) {
								// make sure we have a copy of all table rows once the cache has been built
								updateCache(table);
							}
							updatePageDisplay(table, p, false);
							moveToPage(table, p, false);
							c.$table.trigger('applyWidgets');
						}
					})
					.bind('disablePager' + namespace, function(e){
						e.stopPropagation();
						showAllRows(table, p);
					})
					.bind('enablePager' + namespace, function(e){
						e.stopPropagation();
						enablePager(table, p, true);
					})
					.bind('destroyPager' + namespace, function(e){
						e.stopPropagation();
						destroyPager(table, p);
					})
					.bind('updateComplete' + namespace, function(e, table, triggered){
						e.stopPropagation();
						// table can be unintentionally undefined in tablesorter v2.17.7 and earlier
						// don't recalculate total rows/pages if using ajax
						if ( !table || triggered || p.ajax ) { return; }
						var $rows = c.$tbodies.eq(0).children('tr').not(c.selectorRemove);
						p.totalRows = $rows.length - ( p.countChildRows ? 0 : $rows.filter('.' + c.cssChildRow).length );
						p.totalPages = Math.ceil( p.totalRows / p.size );
						if ($rows.length && c.rowsCopy && c.rowsCopy.length === 0) {
							// make a copy of all table rows once the cache has been built
							updateCache(table);
						}
						if ( p.page >= p.totalPages ) {
							moveToLastPage(table, p);
						}
						hideRows(table, p);
						changeHeight(table, p);
						updatePageDisplay(table, p, true);
					})
					.bind('pageSize refreshComplete '.split(' ').join(namespace + ' '), function(e, v){
						e.stopPropagation();
						setPageSize(table, parseInt(v, 10) || p.settings.size || 10, p);
						hideRows(table, p);
						updatePageDisplay(table, p, false);
					})
					.bind('pageSet pagerUpdate '.split(' ').join(namespace + ' '), function(e, v){
						e.stopPropagation();
						// force pager refresh
						if (e.type === 'pagerUpdate') {
							v = typeof v === 'undefined' ? p.page + 1 : v;
							p.last.page = true;
						}
						p.page = (parseInt(v, 10) || 1) - 1;
						moveToPage(table, p, true);
						updatePageDisplay(table, p, false);
					})
					.bind('pageAndSize' + namespace, function(e, page, size){
						e.stopPropagation();
						p.page = (parseInt(page, 10) || 1) - 1;
						setPageSize(table, parseInt(size, 10) || p.settings.size || 10, p);
						moveToPage(table, p, true);
						hideRows(table, p);
						updatePageDisplay(table, p, false);
					});

				// clicked controls
				ctrls = [ p.cssFirst, p.cssPrev, p.cssNext, p.cssLast ];
				fxn = [ moveToFirstPage, moveToPrevPage, moveToNextPage, moveToLastPage ];
				if (c.debug && !pager.length) {
					console.warn('Pager: >> Container not found');
				}
				pager.find(ctrls.join(','))
					.attr('tabindex', 0)
					.unbind('click' + namespace)
					.bind('click' + namespace, function(e){
						e.stopPropagation();
						var i, $t = $(this), l = ctrls.length;
						if ( !$t.hasClass(p.cssDisabled) ) {
							for (i = 0; i < l; i++) {
								if ($t.is(ctrls[i])) {
									fxn[i](table, p);
									break;
								}
							}
						}
					});

				// goto selector
				p.$goto = pager.find(p.cssGoto);
				if ( p.$goto.length ) {
					p.$goto
						.unbind('change' + namespace)
						.bind('change' + namespace, function(){
							p.page = $(this).val() - 1;
							moveToPage(table, p, true);
							updatePageDisplay(table, p, false);
						});
				} else if (c.debug) {
					console.warn('Pager: >> Goto selector not found');
				}
				// page size selector
				p.$size = pager.find(p.cssPageSize);
				if ( p.$size.length ) {
					// setting an option as selected appears to cause issues with initial page size
					p.$size.find('option').removeAttr('selected');
					p.$size.unbind('change' + namespace).bind('change' + namespace, function() {
						p.$size.val( $(this).val() ); // in case there are more than one pagers
						if ( !$(this).hasClass(p.cssDisabled) ) {
							setPageSize(table, parseInt( $(this).val(), 10 ), p);
							changeHeight(table, p);
						}
						return false;
					});
				} else if (c.debug) {
					console.warn('Pager: >> Size selector not found');
				}

				// clear initialized flag
				p.initialized = false;
				// before initialization event
				$t.trigger('pagerBeforeInitialized', p);

				enablePager(table, p, false);
				if ( typeof p.ajaxUrl === 'string' ) {
					// ajax pager; interact with database
					p.ajax = true;
					// When filtering with ajax, allow only custom filtering function, disable default
					// filtering since it will be done server side.
					c.widgetOptions.filter_serversideFiltering = true;
					c.serverSideSorting = true;
					moveToPage(table, p);
				} else {
					p.ajax = false;
					// Regular pager; all rows stored in memory
					$(this).trigger('appendCache', true);
					hideRowsSetup(table, p);
				}

				// pager initialized
				if (!p.ajax && !p.initialized) {
					p.initializing = false;
					p.initialized = true;
					moveToPage(table, p);
					if (c.debug) {
						console.log('Pager: Triggering pagerInitialized');
					}
					c.$table.trigger('pagerInitialized', p);
					if ( !( c.widgetOptions.filter_initialized && ts.hasWidget(table, 'filter') ) ) {
						updatePageDisplay(table, p, false);
					}
				}

				// make the hasWidget function think that the pager widget is being used
				c.widgetInit.pager = true;
			});
		};

	}() });

	// see #486
	ts.showError = function( table, xhr, settings, exception ) {
		var $row,
			$table = $( table ),
			c = $table[0].config,
			wo = c && c.widgetOptions,
			errorRow = c.pager && c.pager.cssErrorRow ||
				wo && wo.pager_css && wo.pager_css.errorRow ||
				'tablesorter-errorRow',
			typ = typeof xhr,
			valid = true,
			message = '',
			removeRow = function(){
				c.$table.find( 'thead' ).find( '.' + errorRow ).remove();
			};

		if ( !$table.length ) {
			console.error('tablesorter showError: no table parameter passed');
			return;
		}

		// ajaxError callback for plugin or widget - see #992
		if ( typeof c.pager.ajaxError === 'function' ) {
			valid = c.pager.ajaxError( c, xhr, settings, exception );
			if ( valid === false ) {
				return removeRow();
			} else {
				message = valid;
			}
		} else if ( typeof wo.pager_ajaxError === 'function' ) {
			valid = wo.pager_ajaxError( c, xhr, settings, exception );
			if ( valid === false ) {
				return removeRow();
			} else {
				message = valid;
			}
		}

		if ( message === '' ) {
			if ( typ === 'object' ) {
				message =
					xhr.status === 0 ? 'Not connected, verify Network' :
					xhr.status === 404 ? 'Requested page not found [404]' :
					xhr.status === 500 ? 'Internal Server Error [500]' :
					exception === 'parsererror' ? 'Requested JSON parse failed' :
					exception === 'timeout' ? 'Time out error' :
					exception === 'abort' ? 'Ajax Request aborted' :
					'Uncaught error: ' + xhr.statusText + ' [' + xhr.status + ']';
			} else if ( typ === 'string'  ) {
				// keep backward compatibility (external usage just passes a message string)
				message = xhr;
			} else {
				// remove all error rows
				return removeRow();
			}
		}

		// allow message to include entire row HTML!
		$row = ( /tr\>/.test(message) ? $(message) : $('<tr><td colspan="' + c.columns + '">' + message + '</td></tr>') )
			.click( function() {
				$( this ).remove();
			})
			// add error row to thead instead of tbody, or clicking on the header will result in a parser error
			.appendTo( c.$table.find( 'thead:first' ) )
			.addClass( errorRow + ' ' + c.selectorRemove.slice(1) )
			.attr({
				role : 'alert',
				'aria-live' : 'assertive'
			});

	};

	// extend plugin scope
	$.fn.extend({
		tablesorterPager: $.tablesorterPager.construct
	});

})(jQuery);
