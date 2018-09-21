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

/*directive to invalidate the form based on student_id inputted*/
angular.module('passProtect').directive('whitelist', function ($http,$rootScope){ 
   return {
      require: 'ngModel',
      scope:true,
      link: function(scope, elem, attr, ngModel) {
        /*global variables to store list of users objects and usernames*/
        var usernames = [];
        var users = [];

        /*Send get request to endpoint to return all user objects*/
        $http.get( "/get_users").then(function( response) {
          users = response.data; 
          /*console.log(users);*/
          /*Loop through objects in list and add to usernames list*/
          for (var i=0, item; item = users[i]; i++) {
            usernames.push(item["username"].toString());
          }
          /*console.log(usernames);*/
        });
          var whitelist = usernames;

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