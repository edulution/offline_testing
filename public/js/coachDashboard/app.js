angular.module('coachDashBoard',['ngAnimate', 'ngSanitize', 'ui.bootstrap'])
.controller('MainCtrl', function ($scope,$uibModal, $log, $document,$http) {
  var $ctrl = this;

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

  $http.get( "/get_responses").then(function(response) {
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
});
