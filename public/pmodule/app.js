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

/*directive to invalidate the form based on studen_id inputted*/
angular.module('passProtect').directive('whitelist', function (){ 
   return {
      require: 'ngModel',
      link: function(scope, elem, attr, ngModel) {
        /*Hardcoded list of student_ids*/
          var whitelist = ['iphiri230403','pnyiro210504','ssinkh10','mnawal241299','mkaoma050400','pkombe210299','cmutin270203','kdaka080605','smaige071202','jngomb230203'];

          //For DOM -> model validation
          ngModel.$parsers.unshift(function(value) {
             var valid = whitelist.indexOf(value) > -1;
             ngModel.$setValidity('whitelist', valid);
             return valid ? value : undefined;
          });

          //For model -> DOM validation
          ngModel.$formatters.unshift(function(value) {
             ngModel.$setValidity('whitelist', whitelist.indexOf(value) > -1);
             return value;
          });
      }
   };
});