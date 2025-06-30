var app = angular.module("app", ["ngAnimate"]);

app.directive('modalList', function () {
  var controller = ['$scope', '$http', '$filter' ,function ($scope, $http, $filter) {
    $scope.btnDelete = false;
    $scope.title = '';
    $scope.value = '';
    $scope.list  = [];
    $scope.type;

    $scope.withinIndex;
    $scope.withinTitle  = '';
    $scope.withinValue  = '';
    $scope.withinlist   = [];
    $scope.withinType;
    $scope.isWithinlist = false;

    $scope.selectedListValue     = '';
    $scope.selectedValValues     = '';
    $scope.selectedValJson       = '';
    $scope.selectedVals          = [];
    $scope.selectedValsStatus    = [];
    $scope.oldSelectedValsStatus = [];
    $scope.checkedValsStatus     = [];

    $scope.searchKeyword = '';
    $scope.isSearchAsync = false;

    $scope.baseUrl = '';
    $scope.url = $scope.baseUrl + '/INT?action=get_json_' + $scope.json;
    
    $scope.init = function() {

      if ($scope.searchZone !== undefined && $scope.searchAction !== undefined){
        $scope.isSearchAsync = true;
      }

      if (!$scope.isSearchAsync){

        if ($scope.values !== "" && $scope.values !== undefined){
          $scope.selectedValValues = angular.copy($scope.values);
        }

        $http.get($scope.url).then(function (response) {
          console.log($scope.url);
          console.log(response);

          $scope.title  = response.data.title;
          $scope.value  = response.data.value;
          $scope.type   = response.data.type;
          $scope.list   = response.data.list;

          if (window[$scope.name + "modalOnLoad"] && typeof window[$scope.name + "modalOnLoad"] === 'function') {
            window[$scope.name + "modalOnLoad"]($scope);
          }

          console.log($scope);

          if ($scope.type != 'label'){
            $scope.selectedListValue = angular.copy($scope.value);
            $scope.selectedVals[$scope.selectedListValue] = [];
          }

          if ($scope.values !== "" && $scope.values !== undefined){
            $scope.setSavedValues();
          }

        });

      }else{
        $scope.title = $scope.name;
      }

    };

    $scope.setSavedValues =  function (){

      if ($scope.values !== undefined){
        var savedValues = $scope.values.split(',');

        for (savedValue of savedValues) {

          if ($scope.type != 'label'){
            var $foundedItem_c = $filter('filter')($scope.list, {'value':savedValue});

            if ($foundedItem_c.length > 0) {
              console.log($scope.values);

              $foundedItem_c.forEach(element => {
                console.log(element.value);

                if (element.value == $scope.values) {
                  founedItem = element;
                }
                
              });

            }

            console.log(founedItem);

            if (founedItem !== undefined){

              if ($scope.type == 'checkbox'){
                $scope.checkedValsStatus[founedItem.id] = true;
                $scope.onCheckedVal(founedItem);
              }else{
                $scope.selectedValsStatus[1] = founedItem.id;
                $scope.onSelectedVal(founedItem,1);
              }

            }

          }else{

            for (item of $scope.list){
              var founedItem = $filter('filter')(item.list, {'value':savedValue})[0];

              if (founedItem !== undefined){
                $scope.openWithinlist(item);

                if (item.type == 'checkbox'){
                  $scope.checkedValsStatus[founedItem.id] = true;
                  $scope.onCheckedVal(founedItem);
                }else{
                  $scope.selectedValsStatus[$scope.withinIndex] = founedItem.id;
                  $scope.onSelectedVal(founedItem,$scope.withinIndex);
                }

                $scope.closeWithinlist();
              }
            }
          }
        }

        $scope.setSelectedVals();

        if ($scope.selectedValValues ==  ''){
          $scope.selectedValValues = angular.copy($scope.values);
        }
      }
    };

    $scope.searchFilter = function(){

      if ($scope.isSearchAsync){
        return '';
      }else{
        return $scope.searchKeyword;
      }

    };

    $scope.searchAsync = function(){

      if ($scope.isSearchAsync){
        $scope.urlSearch = $scope.baseUrl + '/INT?action=get_json_' + $scope.json+'&json={"zone":"' + $scope.searchZone + '","action":"' + $scope.searchAction + '","data":{"nom":"' + $scope.searchKeyword + '"}}';

        $http.get($scope.urlSearch).then(function (response) {
          $scope.title  = response.data.title;
          $scope.value  = response.data.value;
          $scope.type   = response.data.type;
          $scope.list   = response.data.list;

          if ($scope.type != 'label'){
            $scope.selectedListValue = angular.copy($scope.value);
            $scope.selectedVals[$scope.selectedListValue] = [];
          }

        });
      }
    };

    $scope.openWithinlist = function(item) {

      if (item != undefined) {

        if (item.list){
          $scope.withinTitle  = item.title;
          $scope.withinValue  = item.value;
          $scope.withinType   = item.type;
          $scope.withinlist   = item.list
          $scope.withinIndex  = $scope.list.indexOf(item);
          $scope.isWithinlist = true;
          $scope.selectedListValue = angular.copy($scope.withinValue);
  
          if ($scope.selectedVals[$scope.selectedListValue] == undefined){
            $scope.selectedVals[$scope.selectedListValue] = [];
          }

        }

      }
      
    };

    $scope.closeWithinlist = function() {
      $scope.withinTitle  = null;
      $scope.withinValue  = null;
      $scope.withinType   = null;
      $scope.withinlist   = [];
      $scope.isWithinlist = false;
      $scope.selectedListValue = angular.copy($scope.value);
    };

    $scope.onCheckedVal = function(item){

      if ($scope.checkedValsStatus[item.id]){
        $scope.selectedVals[$scope.selectedListValue].push(item);
      }else{
        var index = $scope.selectedVals[$scope.selectedListValue].indexOf(item);

        if (index != -1){
          $scope.selectedVals[$scope.selectedListValue].splice(index, 1);
        }
      }

    };

    $scope.onSelectedVal = function(item,idx){

      if ($scope.oldSelectedValsStatus[idx] == undefined){
        $scope.selectedVals[$scope.selectedListValue].push(item);
      }else{
        var oldItem = $filter('filter')($scope.selectedVals[$scope.selectedListValue], {'id':$scope.oldSelectedValsStatus[idx]})[0];
        var index = $scope.selectedVals[$scope.selectedListValue].indexOf(oldItem);

        if (index != -1){
          $scope.selectedVals[$scope.selectedListValue].splice(index, 1);
          $scope.selectedVals[$scope.selectedListValue].push(item);
        }
      }

      $scope.oldSelectedValsStatus[idx] = angular.copy($scope.selectedValsStatus[idx]);
    };

    $scope.setSelectedVals = function(){
      /* Modifié par : Scanu Rémy (30/06/2023) */
      var $arrayReturn_ao = [];

      $scope.selectedValJson    = '';
      $scope.selectedValValues  = '';
      $scope.selectedValIds     = '';

      console.log($scope.selectedVals);
      
      for (item in $scope.selectedVals) {
        var obj = {};

        obj[item] = [];
        $arrayReturn_ao.push(obj);
        //$scope.selectedValJson   = $scope.selectedValJson+'"'+item+'":[';

        for (withinItem of $scope.selectedVals[item]){
          $scope.selectedValValues = $scope.selectedValValues+','+withinItem.value;
          $arrayReturn_ao[$arrayReturn_ao.length - 1][item].push(withinItem.value);
          //$scope.selectedValJson   = '"'+withinItem.value+'",'+$scope.selectedValJson;
          $scope.selectedValIds    = $scope.selectedValIds+';'+withinItem.id;
        }

        //$scope.selectedValJson   = $scope.selectedValJson.substr(1);
        //$scope.selectedValJson   = $scope.selectedValJson+'],';
      }

      $scope.selectedValValues = $scope.selectedValValues.substr(1);
      $scope.selectedValJson   = $scope.selectedValJson.substr(1);
      $scope.selectedValIds    = $scope.selectedValIds.substr(1);
      //$scope.selectedValJson   = '{'+$scope.selectedValJson+'}';
      
      $scope.isWithinlist = false;
      $scope.selectedValJson = JSON.stringify($arrayReturn_ao);
      console.log($scope.selectedValJson);
    };

    $scope.clearSelectedVals = function(){

      if ($scope.isWithinlist){
        $scope.closeWithinlist();
      }

      $scope.selectedListValue     = '';
      $scope.selectedValValues     = '';
      $scope.selectedValJson       = '';
      $scope.selectedVals          = [];
      $scope.selectedValsStatus    = [];
      $scope.oldSelectedValsStatus = [];
      $scope.checkedValsStatus     = [];

      if ($scope.type != 'label'){
        $scope.selectedListValue = angular.copy($scope.value);
        $scope.selectedVals[$scope.selectedListValue] = [];
        $scope.selectedValIds = "";
      }
    };

    $scope.init();
  }],
  template = `
  <input type="text" id="{{name}}" name="{{name}}" ng-model="selectedValValues" ng-value="selectedValValues" data-toggle="modal" data-target="#{{name+'modal'}}" ng-click="openWithinlist()" class="span7" readonly>
  <input type="hidden" id="{{name+'_json'}}" name="{{name+'_json'}}" ng-model="selectedValJson" ng-value="selectedValJson">
  <input type="hidden" id="{{name+'_id'}}" name="{{name+'_id'}}" ng-model="selectedValIds" ng-value="selectedValIds">

  <div id="{{name+'modal'}}" class="modal hide fade msmodal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
      <h4 class="modal-title" id="myModalLabel" ng-show="!isWithinlist">{{ title }}</h4>
      <h4 class="modal-title" id="myModalLabel" ng-show="isWithinlist"><i class="icon-chevron-left" ng-click="closeWithinlist()"></i>{{ withinTitle }}</h4>
    </div>

    <div class="modal-body">
      <div class="form-group" ng-show="!isWithinlist">
        <input type="text" class="search form-control span7" ng-model="searchKeyword" placeholder="Search..." ng-change="searchAsync()">
      </div>

      <div class="form-group" ng-show="isWithinlist">
        <input type="text" class="search form-control span7" ng-model="searchTextWithin" placeholder="Search...">
      </div>

      <div class="animation-slide">
        <table class="table table-bordered list-group list-group1" ng-show="!isWithinlist">
          <tbody>
              <tr ng-repeat="item in list | filter:searchFilter()" ng-if="type == 'radio'">
                <td>
                  <div class="radio">
                    <label class="item-label">
                      <input type="radio" aria-label="..." value="{{ item.id }}" ng-model="selectedValsStatus[1]" ng-change="onSelectedVal(item,1)">
                      {{ item.value }}
                    </label>
                  </div>
                </td>
              </tr>

              <tr ng-repeat="item in list | filter:searchFilter()" ng-if="type == 'checkbox'">
                <td>
                  <div class="checkbox">
                    <label class="item-label">
                      <input type="checkbox" aria-label="..." value="{{ item.id }}" ng-model="checkedValsStatus[item.id]" ng-change="onCheckedVal(item)">
                      {{ item.value }}
                    </label>
                  </div>
                </td>
              </tr>

              <tr ng-repeat="item in list | filter:searchFilter()" ng-if="type == 'label'" data-id="{{ item.id }}">
                <td>
                  <label class="list-group-item item-label" ng-click="openWithinlist(item)">
                    {{ item.value }}<i class="icon-chevron-right" aria-hidden="true" ng-if="item.list"></i>
                  </label>
                </td>
              </tr>
          </tbody>
        </table>

        <table class="table table-bordered list-group list-group2" ng-show="isWithinlist">
          <tr ng-repeat="withinitem in withinlist | filter:searchTextWithin" ng-if="withinType == 'radio'">
            <td>
              <label class="item-label">
                <input type="radio" aria-label="..." value="{{ withinitem.id }}" ng-model="selectedValsStatus[withinIndex]" ng-change="onSelectedVal(withinitem,withinIndex)">
                {{ withinitem.value }}
              </label>
            </td>
          </tr>

          <tr ng-repeat="withinitem in withinlist | filter:searchTextWithin" ng-if="withinType == 'checkbox'">
            <td>
              <label class="item-label">
                <input type="checkbox" aria-label="..." value="{{ withinitem.id }}" ng-model="checkedValsStatus[withinitem.id]" ng-change="onCheckedVal(withinitem)">
                  {{ withinitem.value }}
              </label>
            </td>
          </tr>

          <tr ng-repeat="withinitem in withinlist | filter:searchTextWithin" ng-if="withinType == 'label'" data-id="{{ withinitem.id }}">
            <td>
              <label class="list-group-item item-label">
              {{ withinitem.value }}
              </label>
            </td>
          </tr>
        </table>

        <div style="clear:left;"></div>
      </div>
    </div>

    <div class="modal-footer">
      <button type="button" class="btn btn-default" data-dismiss="modal">Fermer</button>
      <button type="button" class="btn btn-danger" ng-click="clearSelectedVals()" data-dismiss="modal" ng-if="btnDelete">Effacer</button>
      <button type="button" class="btn btn-primary" ng-click="setSelectedVals()" data-dismiss="modal">Valider</button>
    </div>
  </div>`

  return {
    restrict: 'EA',
    scope: {
      name          : '@',
      values        : '@',
      json          : '@',
      searchZone    : '@',
      searchAction  : '@',
      btnDelete     : '@'
    },
    controller: controller,
    template: template,
    link: function(scope, element, attrs) {

      // Gestionnaire d'événement pour l'événement shown.bs.modal
      element.on('shown.bs.modal', function (event) {
        // Obtention de la hauteur de l'écran
        var screenHeight = window.innerHeight;

        // Calcul de la hauteur à affecter à la div
        var divHeight = screenHeight - (0.3 * screenHeight);

        // Sélection de la div par son ID et affectation de la hauteur calculée
        var divElement = document.getElementById(event.target.id);

        divElement.style.height = divHeight + 100 + "px";
        divElement.style.setProperty("max-height", divHeight + 100 + "px", "important");

        $("#" + event.target.id).find(".modal-body").removeAttr("style");
        $("#" + event.target.id).find(".modal-body").css({ "max-height": divHeight.toString() + "px" });

        // Demande de réinitialisation des éventuelles sélection précédentes dans le popup
        if (typeof firstPassage_b != 'undefined') {

          // Si l'input liée au popup n'a pas de valeur affectée et que c'est la première fois qu'on passe
          if ($("#" + event.target.id.replace("modal", "")).val() == "" && firstPassage_b == false) {
            var $stop_b = false;
            firstPassage_b = true;

            // Demande de ré-initialisation de plusieurs modal angular
            if (typeof firstPassageDetail_c != 'undefined') {

              firstPassageDetail_c.forEach(element => {

                switch (true) {
                  case (element.modalID == event.target.id && element.firstPassage == true): // Si on est déjà passé dessus on éxécute pas le code pour reset les choix précédents sinon boucle sans fin...
                    $stop_b = true;
                    break;
                  case (element.modalID == event.target.id): // Si c'est la première fois qu'on passe on indique qu'on est déjà passé et on poursuite le code
                    element.firstPassage = true;
                    break;
                  default:
                    break;
                }

                // Si au moins un élément n'a pas été ré-initialiser on demande à repasser dans le reset de la liste
                if (element.firstPassage == false) {
                  firstPassage_b = false;
                }

              });

            }
            
            console.log(firstPassageDetail_c);

            if ($stop_b == false) {
              // On clic par programmation sur le bouton "Effacer"
              $("#" + event.target.id).find(".modal-footer > button").eq(1).click();

              $.LoadingOverlaySetup({
                  background      : "rgba(0, 0, 0, 0.5)",
                  imageColor      : "#fff"
              });
          
              $.LoadingOverlay("show");

              // Deux secondes après on reclic par programmation sur l'input ce qui va redéclencler l'affichage du popup
              setTimeout(() => {
                console.log("Input cliqué par programmation : " + $("#" + event.target.id.replace("modal", "")));

                $("#" + event.target.id.replace("modal", "")).click();
                $.LoadingOverlay("hide");
              }, 2000); 
            }
            
          }

        }

        // Appel de la fonction qui créée les catégories de recherche
        if (window[event.target.id + "OnShownModal"] && typeof window[event.target.id + "OnShownModal"] === 'function') {
          window[event.target.id + "OnShownModal"]()
        }

      });

      element.on('hidden.bs.modal', function (event) {
        $("#" + scope.json).change();
      });
    }
  };
});