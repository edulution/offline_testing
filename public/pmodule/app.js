/*Angular module to display password modal and make sure correct password is entered*/
angular.module('passProtect', ['ngAnimate', 'ngSanitize', 'ui.bootstrap','ui', 'ui.filters']);
angular.module('passProtect').controller('MainCtrl', function ($scope,$http,$uibModal, $location,$log, $document) {

  /*Alias for controller*/
  var $ctrl = this;

  $ctrl.animationsEnabled = true;

/*Initalize function when page is loaded*/
  $scope.init = function() {
    /*Empty object for testResponse*/
    $scope.testResponse = {};

    /*Empty users array*/
    $scope.users = [];

    /*Empty usernames array used in whitelist for validation*/
    $scope.usernames = [];

    $scope.existingResponses = []


    /*Send get request to endpoint to return all user objects*/
    $http.get( "/get_users").then(function( response) {
      $scope.users = response.data; 
      /*Loop through objects in list and add to usernames list*/
      for (var i=0, item; item = $scope.users[i]; i++) {
        $scope.usernames.push(item["username"].toString());
      }
      
    });

    /*get server date from enpoint*/
    $http.get("/get_server_date").then(function(response){
      /*set to scope variable serverDate*/
      $scope.serverDate = response.data;
    })

    /*Open password modal when page loads*/
    $ctrl.openPasswordModal();
  }

  /*Function to open password modal*/
  $ctrl.openPasswordModal = function (parentSelector) {
    var parentElem = parentSelector ? 
    /*parent element of the modal set to body*/
      angular.element($document[0].querySelector('body ' + parentSelector)) : undefined;
    var modalInstance = $uibModal.open({
      animation: $ctrl.animationsEnabled,
      ariaLabelledBy: 'modal-title',
      ariaDescribedBy: 'modal-body',
      templateUrl: 'pmodule/templates/pmodal_content.html',
      controller: 'ModalInstanceCtrl',
      controllerAs: '$password_modal_ctrl',
      backdrop: 'static',
      keyboard: false,
      appendTo: parentElem
    });

    console.log("modal loaded");
  };  

  /*Function to open confirm submission modal*/
  $ctrl.openConfirmSubmitModal = function (parentSelector) {
    var parentElem = parentSelector ? 
    /*parent element of the modal set to body*/
      angular.element($document[0].querySelector('body ' + parentSelector)) : undefined;
    var modalInstance = $uibModal.open({
      animation: $ctrl.animationsEnabled,
      ariaLabelledBy: 'modal-title',
      ariaDescribedBy: 'modal-body',
      templateUrl: 'pmodule/templates/pmodal_content.html',
      controller: 'ModalInstanceCtrl',
      controllerAs: '$password_modal_ctrl',
      backdrop: 'static',
      keyboard: false,
      appendTo: parentElem
    });

    console.log("modal loaded");
  };

  /*Helper functions to check for duplicated tests*/
  /*i.e same learner has done the same test on the same day*/
  /*function to concatenate the properities of the a single response object which we need to check for duplicates- user_id  course module test_date*/
  function concat_props(response) {
    var response_concat = ""
    var response_props = ["user_id","course","module","test_date"]
    for (var i in response_props) {
      response_concat = response_concat.concat(response[response_props[i]])
    }

    return response_concat
  };

  /*turn the list of response objects into a list of strings of concatenated values*/
  function get_responses_concat_list(responses) {
    responses_list = []
    for (var i in responses) {
      var response_cat = concat_props(responses[i])
      responses_list.push(response_cat)
    }

    return responses_list
  };

/*Test submission function*/
  $scope.submit = function() {
    /*Get user_id of user that filled in the test, from the users array*/
    var currentUser = $scope.users.find(user => {return user.username == $scope.testResponse.username})

    /*add the user_id as an attribute to the testResponse object*/
    $scope.testResponse.user_id = currentUser.user_id 

    /*set the test date of the response to the server date*/
    $scope.testResponse.test_date = $scope.serverDate

    $http.post("/submit_test", $scope.testResponse).then(function(success) {
      /*redirect to sucessful submission page*/
      window.location = '/sucessful_submit'
    });
  }


/*end MainCtrl*/
})
/*Controller for password modal*/
.controller('ModalInstanceCtrl', function ($scope,$uibModalInstance) {
  $scope.coachPassword ="Ctrib3";
  $scope.wrongPassword = false;

  var $PasswordModalCtrl = this;


  $PasswordModalCtrl.cancel = function () {
    $uibModalInstance.dismiss();
  };

  $PasswordModalCtrl.checkPassword = function (password) {
    if (password == $scope.coachPassword) {
      $scope.wrongPassword = false;
      $uibModalInstance.dismiss();
    }
    else{
      $scope.wrongPassword = true;
    }
  };


/*end ModalInstanceCtrl*/
})

/*directive to invalidate the form based on student_id inputted*/
.directive('whitelist', function (){ 
   return {
      require: 'ngModel',
      scope:true,
      link: function(scope, elem, attr, ngModel) {
        /*global variables to store list of users objects and usernames*/
          var whitelist = scope.usernames;

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

/*end whitelist directive*/
});


