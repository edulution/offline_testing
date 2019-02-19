angular.module('coachDashBoard',['ngAnimate', 'ngSanitize', 'ui.bootstrap','smart-table','angular.filter'])
.controller('MainCtrl', function ($scope,$uibModal, $log, $document,$http) {
  var $ctrl = this;

  /*placeholder value used in smart-table because users are loaded asynchorously*/
  $scope.users_placeholder = [];  

  /*placeholder value used in smart-table because results are loaded asynchorously*/
  $scope.results_placeholder = [];

  /*pagination - items to display on each page*/
  $scope.itemsByPage = 15;

  $ctrl.animationsEnabled = true;

  $ctrl.openModal = function (parentSelector) {
    var parentElem = parentSelector ? 
      angular.element($document[0].querySelector('.modal-demo ' + parentSelector)) : undefined;
    var modalInstance = $uibModal.open({
      animation: $ctrl.animationsEnabled,
      ariaLabelledBy: 'modal-title',
      ariaDescribedBy: 'modal-body',
      templateUrl: 'passwordModalContent.html',
      controller: 'ModalInstanceCtrl',
      controllerAs: '$ctrl',
      backdrop: 'static',
      keyboard: false,
      appendTo: parentElem
    });

    console.log("modal loaded");
  };

  $http.get( "/get_users").then(function(response) {
         $scope.users = response.data;
         console.log($scope.users);
    }); 

  $http.get( "/get_test_count").then(function(response) {
         $scope.tests_count = response.data;
         console.log($scope.tests_count);
    });

  $http.get( "/get_test_count").then(function(response) {
         $scope.tests_count = response.data;
         console.log($scope.tests_count);
    });

  $http.get( "/get_responses").then(function(response) {
        /*Convert test dates to javascript dates to enable search by alphanumeric characters*/
        for (var i = response.data.length - 1; i >= 0; i--) {
           response.data[i]["test_date"] = new Date(response.data[i]["test_date"])
         };

         $scope.results = response.data;
         console.log($scope.results);
    }); 
})
.controller('ModalInstanceCtrl', function ($scope,$uibModalInstance) {
  $scope.coachPassword ="Ctrib3";
  $scope.wrongPassword = false;

  var $ctrl = this;


  $ctrl.cancel = function () {
    $uibModalInstance.dismiss();
  };

  $ctrl.checkPassword = function (password) {
    if (password == $scope.coachPassword) {
      $scope.wrongPassword = false;
      $uibModalInstance.dismiss();
    }
    else{
      $scope.wrongPassword = true;
    }
  };
})
/*element directive for navigation bar*/
.directive('navigation', function(){
    return {
      restrict: 'E',
      templateUrl: 'navigation.html',
      controller: function ($window) {
          this.tab = 0; /* initially set tab to 1*/
          this.selectTab = function (setTab) { /* Set tab to whatever tab user clicks*/
            this.tab = setTab;
            console.log(this.tab);
          };
          this.isSelected = function (checkTab) {/* Check which tab is selected to trigger show of selected tab */
            return this.tab === checkTab;

          };

          /*function to refresh page when button clicked*/
          this.refresh = function(){
            $window.location.reload();
          }
        },
      controllerAs: 'menu'
    };
  })
/*element directive for learners tab*/
.directive('learners', function(){
    return {
      restrict: 'E',
      templateUrl: 'learners.html',
      link: function(scope, element, attributes){
        /*class for all elements in directive. used for scoped styling*/
              element.addClass('learners');
            }
    };
  })
/*element directive for responses tab*/
.directive('responses', function(){
    return {
      restrict: 'E',
      templateUrl: 'responses.html',
      link: function(scope, element, attributes){
        /*class for all elements in directive. used for scoped styling*/
              element.addClass('responses');
            }
    };
  })
/*element directive for responses by question tab(development only)*/
.directive('questresponses', function(){
    return {
      restrict: 'E',
      templateUrl: 'responses_q.html',
      link: function(scope, element, attributes){
        /*class for all elements in directive. used for scoped styling*/
              element.addClass('questresponses');
            }
    };
  })
/*element directive for tests count tab*/
.directive('testscount', function(){
    return {
      restrict: 'E',
      templateUrl: 'testscount.html',
      link: function(scope, element, attributes){
        /*class for all elements in directive. used for scoped styling*/
              element.addClass('testscount');
            }
    };
  })
;
