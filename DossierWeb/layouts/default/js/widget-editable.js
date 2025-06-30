/*! tablesorter Editable Content widget - updated 4/12/2013
 * Requires tablesorter v2.8+ and jQuery 1.7+
 * by Rob Garrison
 */
/*jshint browser:true, jquery:true, unused:false */
/*global jQuery: false */
;(function($){
	"use strict";

	$.tablesorter.addWidget({
		id: 'editable',
		options : {
			editable_columns       : [],
			editable_enterToAccept : true,
			editable_autoResort    : false,
			editable_noEdit        : 'no-edit',
			editable_editComplete  : 'editComplete',
			editable_focus		   : 'editFocus', 
			afterChange : function(){}
		},
		init : function(table, thisWidget, c, wo){
			thisWidget.format(table, c, wo, true);
		},
		format: function(table, c, wo, init){
			if (!wo.editable_columns.length) { return; }
			var $t, cols = [];
			$.each(wo.editable_columns, function(i, col){
				cols.push('td:nth-child(' + (col + 1) + ')');
			});
			// IE does not allow making TR/TH/TD cells directly editable (issue #404)
			// so add a div or span inside ( it's faster than using wrapInner() )
			c.$tbodies.find( cols.join(',') ).not('.' + wo.editable_noEdit).each(function(){
				// test for children, if they exist, then make the children editable
				$t = $(this);
				( $t.children().length ? $t.children() : $t ).prop('contenteditable', true);
			});


				c.$tbodies
				.on('mouseleave.tseditable', function(){
					if (c.$table.data('contentFocused')) {
						//$(':focus').trigger('blur');
					}
				})
				.on('focus.tseditable', '[contenteditable]', function(e){
					$('td.change').removeClass('change');
					var $this = $(this); 
					// add by abdallah
					var tr 			= $(this).parents('tr');
					var td 			= $(this).parents('td');
					var index 		= tr.find(td).index();
					var w 			= td.width() - 14;
					var type 		= td.data('type');
					var originVal 	= $(this).text();
					var w_action 	= $(this).parents('table').data('waction');
					var id 			= td.data('id');
					var input 		= '<input data-val="" type="text" id="editInput" style="width:'+w+'px;margin-bottom:0;font-size:11px;line-height:10px;padding:1px 0;background:none;" name="T3|C2" value="'+originVal+'" class="listInput span7 search typeahead champ_t3|c2 methode[web_refresh_dos_soc;blur;refresh_object]" data-provide="typeahead" autocomplete="off" autofocus="autofocus" >'
					var _input 		= '<input data-val="" type="text" id="standardInput" style="width:'+w+'px;margin-bottom:0;font-size:11px;line-height:10px;padding:1px 0;background:none;" name="T3|C2" value="'+originVal+'" class="listInput span7 search typeahead champ_t3|c2 methode[web_refresh_dos_soc;blur;refresh_object]" data-provide="typeahead" autocomplete="off" autofocus="autofocus" >'
					
					if(type == "predictive"){
						var htmlSpan = '';
						var champEnr	= td.data('champer');
						$('.typeahead.dropdown-menu').remove();

						// Ajout d'HTML
						td.html(input);

						// Saisie prédective
						var uidFiche = $(this).parents('form:first').find('#uid').val();

						$("#editInput").typeahead({  
					 		minLength:3 ,
					 		source: function (typeahead, query) {
					 			var methodeRechercher = $("#editInput").data().methoderechercher;
					 			return $.get('/TACH?action=auto&uid='+uidFiche+'&c=soc_nom&term='+query+'&methodeRechercher='+methodeRechercher,function(data){
					   				return typeahead.process(eval(data));
					   			});
					 		},   
					 		property: 'value',
							onselect: function(obj){
					 			/*var next_element=$("#editInput").parents('.controls').next().attr('id'); 
					 			if( $('#'+next_element).is('.uid')){
					 				$('#'+next_element).val((eval(obj)).id)
					 			}*/
					 			var uid_enr;
					 			$this.find('div').remove();
					 			htmlSpan = '<span class="hide">'+obj.id+'</span>';
					 		} 
					 	});

						// fin
						$("#editInput").blur(function(){
							$('div.change').removeClass('change');
							var div 		= '<div class="change" contenteditable="true">'+$(this).val()+htmlSpan+'</div>';
							td.html(div);

							if( $(this).val() != originVal ){
								$('.change').trigger( wo.editable_editComplete );
							}

						});

						$("#editInput").focus();

					}
					else if(type == "select"){

						var val = td.find('div').text();
						var change = false;

						$('#'+id+' select').css('width',(td.width()-5)+'px')//.attr('autofocus','autofocus');

						$('#'+id+' select').val(val);

						

						var select 		= $('#'+id).html();
						// Ajout d'HTML
						td.html(select);
						td.find('select').focus();
						var type 		= td.data('type');
					
						td.find('select').change(function(){
							change = true;
						})

						td.find('select').blur(function(){
							$('div.change').removeClass('change');
							if(change){
								var div 	= '<div class="change" contenteditable="true">'+td.find('select option:selected').text()+'</div>';
								td.html(div);
								$('.change').trigger( wo.editable_editComplete );
							}else{
								var div 	= '<div class="" contenteditable="true">'+val+'</div>';
								td.html(div);
							}
							
						});
							
					}
					else{


						td.html(_input);
						$('#standardInput').focus();

						$("#standardInput").keydown(function(e){
							console.log(e.which);
							if(e.which == 40){
								if(tr.next('tr').length){
									$(this).blur();
									tr.next('tr').find('td:eq('+index+') div').focus();
								}
							}
							if(e.which == 38){
								if(tr.prev('tr').length){
									$(this).blur();
									tr.prev('tr').find('td:eq('+index+') div').focus();
								}
							}
							if(e.which == 13){
								$(this).blur();
							}


							if(e.which == 27){
								$(this).val(originVal);
								$(this).blur();
							}


						})


						$("#standardInput").blur(function(){
							$('div.change').removeClass('change');
							var div 		= '<div class="change" contenteditable="true">'+$(this).val()+'</div>';
							td.html(div);

							if( $(this).val() != originVal ){
								$('.change').trigger( wo.editable_editComplete );
							}

						})


						/*$(this).trigger( wo.editable_focus );
						c.$table.data('contentFocused', true);
						var v = $this.html();
						if (wo.editable_enterToAccept) {*/
							// prevent enter from adding into the content
						/*	$this.on('keydown.tseditable', function(e){
								if (e.which === 13) {
									e.preventDefault();
								}
							});
						}
						$this.data({ before : v, original: v });*/

					}

				})
				.on('blur focusout keyup '.split(' ').join('.tseditable '), '[contenteditable]', function(e){
					if (!c.$table.data('contentFocused')) { return; }
					var $this = $(e.target), t;
					if (e.which === 27) {
						// user cancelled
						$this.html( $this.data('original') ).trigger('blur.tseditable');
						c.$table.data('contentFocused', false);
						return false;
						if($this.data('original') != $this.html()){
							//wo.afterChange($this);
							$this.trigger( wo.editable_editComplete ); 
						}
					}

					t = e.type !== 'keyup' || (wo.editable_enterToAccept && e.which === 13);

						

					// change if new or user hits enter (if option set)
					if ($this.data('before') !== $this.html() || t) {
						$this.data('before', $this.html()).trigger('change');
						if (t) {
							c.$table
								.data('contentFocused', false)
								.trigger('updateCell', [ $this.closest('td'), wo.editable_autoResort, function(table){
									if($this.data('original') != $this.html()){
										//wo.afterChange($this);
										$this.trigger( wo.editable_editComplete );
									}
								} ]);
							$this.trigger('blur.tseditable');
							//wo.after($this);
							if($this.data('original') != $this.html()){
								wo.afterChange($this);
							}
						};
						if($this.data('original') != $this.html()){
							//wo.afterChange($this);
							//$this.trigger( wo.editable_editComplete );
						}
					}

								


					
				});

			
		}
	});

})(jQuery);
