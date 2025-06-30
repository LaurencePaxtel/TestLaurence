$(document).ready(function () {

	/*****************************************************************************/
	/*L'INVENTAIRE*/
	/*****************************************************************************/
	var inventaire_post_action = $("#inventaire_post_action").val();
	var inventaire_get_action = $("#inventaire_get_action").val();

	var mandatory_fields_ligne = $("#mandatory_ligne_inventaire").val().split(';');

	$("#btn_inventaire_pieces").click(function (ev) {
		Popup_Fiche_Inventaire(ev);
		return false;
	});

	function Popup_Fiche_Inventaire() {
		$('#titre_popup_inventaire').html('L\'inventaire des pièces');
		Get_Record_Data_Inventaire($('#record_id').val());

		var var_popup = $('#iw_form_popup_inventaire').html();
		$('#iw_form_popup_inventaire').html('');

		$.confirm({
			title: '',
			content: '' +
				'<div>' + var_popup +
				'</div>',
			buttons: {
				formSubmit: {
					text: 'Enregistrer',
					btnClass: 'btn-blue',
					action: function () {


						if (Check_Required_Fields(mandatory_fields_ligne)) {

							Mark_All_Required_Fields(mandatory_fields_ligne);


							$.alert({
								title: 'Champs obligatoires!',
								content: 'Vous devez remplir tous les champs obligatoires!',
								icon: 'fa fa-warning',
								animation: 'scale',
								closeAnimation: 'scale',
								columnClass: 'iw_alert',
								buttons: {
									okay: {
										text: 'Ok',
										btnClass: 'btn-blue'
									}
								}
							});

							return false;


						} else {

							Save_Record_Line_Pieces();

							$('#iw_form_popup_inventaire').html(var_popup);

							return true;

						}


					}
				},
				cancel: {
					text: 'Fermer',
					action: function () {

						$('#iw_form_popup_inventaire').html(var_popup);


					}
				},
			},
			onContentReady: function () {
				// bind to events
				var jc = this;
				this.$content.find('form').on('submit', function (e) {
					// if the user submits the form by pressing enter in the field.
					e.preventDefault();
					jc.$$formSubmit.trigger('click'); // reference the button and click it


				});



			}
		});

	}

	function Get_Record_Data_Inventaire($id) {
		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");
		$('#titre_popup_inventaire').html('L\'inventaire des pièces');

		var data_module = {
			"id": $id
		};

		var data = {
			"zone": "gl",
			"action": "get_inventaire_pieces_ligne",
			"data": {
				"ligne": data_module
			}
		};

		var data_json = '&json=' + JSON.stringify(data);

		$.getJSON("/GL?action=get_inventaire_pieces", data_json, function (data) {

			$.each(data, function (key, value) {
				$("#ligne_id_inventaire").attr('value', value.id);
				$("#inv_type").attr('value', value.inv_type);
				$("#inv_surface").attr('value', iw_round(value.inv_surface));
				$("#inv_pieces_principales").attr('value', value.inv_pieces_principales);
				$("#inv_chambres").attr('value', value.inv_chambres);
				$("#inv_salle_de_bain").attr('value', value.inv_salle_de_bain);
				$("#inv_wc").attr('value', value.inv_wc);
				$("#inv_electricite_no_compteur").attr('value', value.inv_electricite_no_compteur);
				$("#inv_gaz_naturel_no_compteur").attr('value', value.inv_gaz_naturel_no_compteur);
				$("#inv_eau_no_compteur").attr('value', value.inv_eau_no_compteur);
			});

		}).done(function () {//success
		})
		.fail(function () { //error
		})
		.always(function () { //complete
			$.LoadingOverlay("hide");
		});

	}

	function Save_Record_Line_Pieces() {
		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");

		var data_ligne = {
			"id_piece": $("#record_id").val(),
			"id_ligne": $("#ligne_id_inventaire").val(),
			"inv_type": $("#inv_type").val(),
			"inv_surface": $("#inv_surface").val(),
			"inv_pieces_principales": $("#inv_pieces_principales").val(),
			"inv_chambres": $("#inv_chambres").val(),
			"inv_salle_de_bain": $("#inv_salle_de_bain").val(),
			"inv_wc": $("#inv_wc").val(),
			"inv_electricite_no_compteur": $("#inv_electricite_no_compteur").val(),
			"inv_gaz_naturel_no_compteur": $("#inv_gaz_naturel_no_compteur").val(),
			"inv_eau_no_compteur": $("#inv_eau_no_compteur").val()
		}

		var data = {
			"zone": "gl",
			"action": "set_bien_ligne",
			"data": {
				"ligne": data_ligne
			}
		};

		var data_json = '&json=' + JSON.stringify(data);
		var save_status = '';

		$.getJSON("/GL?action=" + inventaire_post_action, data_json, function (data) {

			$.each(data, function (key, value) {
				save_status = value;
			});

		}).done(function () {//success
		})
		.fail(function () { //error
		})
		.always(function () { //complete
			$.LoadingOverlay("hide");

			if (save_status == 'Failed') {

				$.alert({
					title: 'Erreur',
					content: 'Erreur',
					icon: 'fa fa-remove',
					animation: 'scale',
					closeAnimation: 'scale',
					columnClass: 'iw_alert',
					buttons: {
						okay: {
							text: 'Ok',
							btnClass: 'btn-blue'
						}
					}
				});
			}

		});

	}

});