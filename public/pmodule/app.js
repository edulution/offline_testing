/*Angular module to display password modal and make sure correct password is entered*/
angular.module('passProtect', ['ngAnimate', 'ngSanitize', 'ui.bootstrap']);
angular.module('passProtect').controller('ModalDemoCtrl', function ($scope,$uibModal, $log, $document) {
  var $ctrl = this;

  $ctrl.animationsEnabled = true;

  $ctrl.openModal = function (parentSelector) {
    var parentElem = parentSelector ? 
      angular.element($document[0].querySelector('.modal-demo ' + parentSelector)) : undefined;
    var modalInstance = $uibModal.open({
      animation: $ctrl.animationsEnabled,
      ariaLabelledBy: 'modal-title',
      ariaDescribedBy: 'modal-body',
      templateUrl: 'testModalContent.html',
      controller: 'ModalInstanceCtrl',
      controllerAs: '$ctrl',
      backdrop: 'static',
      keyboard: false,
      appendTo: parentElem
    });

    console.log("modal loaded");
  };
});

angular.module('passProtect').controller('ModalInstanceCtrl', function ($scope,$uibModalInstance) {
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


