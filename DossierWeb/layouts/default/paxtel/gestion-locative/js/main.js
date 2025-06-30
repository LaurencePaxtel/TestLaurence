$(document).ready(function(){  
   var action = getUrlParameter('action');
   var url_base = window.location.origin;

   $("#btn_sb_toggle").click(function(ev){ 
      SB_ToggleMenu();

      $.ajax({
         type: "GET",
         url: "/4DACTION/Web_Manage_User_Preferences",
         data: {
            "intervenantID": intervenantID,
            "action": "sauvegarder",
            "propriete": "toolbar.display",
            "valeur": (!$(".iw_btns_sidebar").hasClass("sb_hide"))
         },
         success: function (response) {
            
         }
      });

      return false;
   });  
   
   function SB_ToggleMenu(){
      $('.iw_btns_sidebar').toggleClass('sb_hide');
      $('#btn_sb_toggle').toggleClass('sb_pushed');
      $('#btn_sb_toggle i').toggleClass("fa-angle-double-left fa-angle-double-right");
   }

   switch(action){
         case 'interventions':
            SB_ToggleMenu();

            break;
         case 'factures':
            SB_ToggleMenu();

            break;
         default:

            if (userPreferences.toolbar.display == "false") {
               SB_ToggleMenu();
            }
            
         break;
   }

   /**********************************************************************************/
   /* Sidebar menu actions
   /**********************************************************************************/
   $('#btn_sb_gi_locataire_a').click(function (e) {
      e.preventDefault();
      
      $(location).attr('href', '/GL?action=usager-list&sbaction=new');
   });

   $('#btn_sb_gi_locataire_l').click(function (e) {
      e.preventDefault();

      $(location).attr('href', '/GL?action=usager-list');
   });

   $('#btn_sb_gi_equipement_a').click(function (e) {
      e.preventDefault();

      $(location).attr('href', '/GL?action=equipements_biens&sbaction=new');
   });

   $('#btn_sb_gi_equipement_l').click(function (e) {
      e.preventDefault();

      $(location).attr('href', '/GL?action=equipements_biens');
   });
      
   $('#btn_sb_gi_intervention_a').click(function (e) {
      e.preventDefault();

      $(location).attr('href', '/GL?action=intervention');
   });

   $('#btn_sb_gi_intervention_l').click(function (e) {
      e.preventDefault();

      $(location).attr('href', '/GL?action=interventions');
   });

   $('#btn_sb_gi_sinistre_a').click(function (e) {
      e.preventDefault();

      $(location).attr('href', '/GL?action=sinistres&sbaction=new');
   });

   $('#btn_sb_gi_sinistre_l').click(function (e) {
      e.preventDefault();

      $(location).attr('href', '/GL?action=sinistres');
   });

   $('#btn_sb_gi_charge_a').click(function (e) {
      e.preventDefault();

      $(location).attr('href', '/GL?action=charges&sbaction=new');
   });

   $('#btn_sb_gi_charge_l').click(function (e) {
      e.preventDefault();

      $(location).attr('href', '/GL?action=charges');
   });

   $('#btn_sb_gi_location_a').click(function (e) {
      e.preventDefault();
      
      $(location).attr('href', '/GL?action=location'); 
   });

   $('#btn_sb_gi_location_l').click(function (e) {
      e.preventDefault();

      $(location).attr('href', '/GL?action=locations');
   });

   $('#btn_sb_gi_bien_a').click(function (e) {
      e.preventDefault();

      //$(location).attr('href', '/GL?action=bien'); 
   });

   $('#btn_sb_gi_bien_l').click(function (e) {
      e.preventDefault();

      $(location).attr('href', '/GL?action=biens');
   });
   
   $('#btn_sb_gi_proprietaire_a').click(function (e) {
      e.preventDefault();

      $(location).attr('href', '/GL?action=proprietaires&sbaction=new');
   });

   $('#btn_sb_gi_proprietaire_l').click(function (e) {
      e.preventDefault();

      $(location).attr('href', '/GL?action=proprietaires');
   });

   $('#btn_sb_gi_facture_a').click(function (e) {
      e.preventDefault();

      $(location).attr('href', '/GL?action=facture');
   });

   $('#btn_sb_gi_facture_l').click(function (e) {
      e.preventDefault();

      $(location).attr('href', '/GL?action=factures');
   });

   $('#btn_sb_gi_reglement_a').click(function (e) {
      e.preventDefault();

      $(location).attr('href', '/GL?action=factures');
   });

   $('#btn_sb_gi_reglement_l').click(function (e) {
      e.preventDefault();

      $(location).attr('href', '/GL?action=reglements');
   });

/*****************************************************************************************************/
   var id_record = '';
   var id_table = '';

   function Checkboxes_Manage($id_record,$init){

      $('#list_table input[type=checkbox]').each(function () {

         if($id_record==this.id.substring(4)){
               $(this).prop( "checked", true );
         }

         if($init){
            $(this).prop( "checked", false );	
         }        

      });

   } 

   $(document).on('change', '#list_table .iw_select', function() {	
      id_record = $('#id_record_'+this.id.substring(4)).val();
      id_table = $('#table_'+this.id.substring(4)).val();

      if(this.checked){
         Checkboxes_Manage(id_record,false);
      }else{
         Checkboxes_Manage(id_record,true);

         id_record='';
      }

         $('#record_id').val(id_record);
   });

/****************************************************************************************************/
});  