/*Angular module to display password modal and make sure correct password is entered*/
angular.module('passProtect', ['ngAnimate', 'ngSanitize', 'ui.bootstrap', 'ui', 'ui.filters', 'angular-md5'])
    .controller('MainCtrl', ($scope, $timeout, $http, $uibModal, $location, $log, $document, md5) => {

        /*Alias for controller*/
        const $ctrl = this;

        $ctrl.animationsEnabled = true;

        /*Initalize function when page is loaded*/
        $scope.init = () => {
            /*Empty object for form*/
            /*Gives more flexibility and control over the form from the controller*/
            $scope.form = {};

            /*Empty object for testResponse*/
            $scope.testResponse = {};

            /*Empty users array*/
            $scope.users = [];

            /*Empty usernames array used in whitelist for validation*/
            $scope.usernames = [];

            $scope.existingResponses = [];

            /*learner grades*/

            $scope.learner_grades = ['3', '4', '5', '6', '7'];


            /*learner sexes used on selection*/
            $scope.learner_sexes = [{ label: 'Male', value: 'M' }, { label: 'Female', value: 'F' }]

            /*Send get request to endpoint to return all user objects*/
            $http.get("/api/get_users").then((response) => {
                $scope.users = response.data;
                /*Loop through objects in list and add to usernames list*/
                for (let i = 0, item; item = $scope.users[i]; i++) {
                    $scope.usernames.push(item.username.toString());
                }

            })

            /*get server date from enpoint*/
            $http.get("/api/get_server_date").then((response) => {
                /*set to scope variable serverDate*/
                $scope.serverDate = response.data;
            })

            /*get server date from enpoint*/
            $http.get("/api/get_responses").then((response) => {
                /*get list of concatenated props for all existing test responses*/
                $scope.existingResponses = get_responses_concat_list(response.data)
            })

            /*variables for validating coach_id*/
            $scope.testSubmitPassword = "fc49a594c8d54de357ad7b5f2addab9f";
            $scope.wrongPassword = false;
            $scope.wrongCoachID = false;


            /*Open password modal when page loads*/
            $ctrl.openPasswordModal();
        }

        /*Function to open password modal*/
        $ctrl.openPasswordModal = (parentSelector) => {
            let parentElem = parentSelector ?
                /*parent element of the modal set to body*/
                angular.element($document[0].querySelector('body ' + parentSelector)) : undefined;
            let modalInstance = $uibModal.open({
                animation: $ctrl.animationsEnabled,
                ariaLabelledBy: 'modal-title',
                ariaDescribedBy: 'modal-body',
                templateUrl: '/pmodule/templates/pmodal_content.html',
                controller: 'ModalInstanceCtrl',
                controllerAs: '$password_modal_ctrl',
                backdrop: 'static',
                keyboard: false,
                appendTo: parentElem
            });

            /*console.log("modal loaded");*/
        };

        /*Function to open confirm submission modal*/
        /*share scope with main scope*/
        $ctrl.openConfirmSubmitModal = (parentSelector) => {
            let parentElem = parentSelector ?
                /*parent element of the modal set to body*/
                angular.element($document[0].querySelector('body ' + parentSelector)) : undefined;
            let modalInstance = $uibModal.open({
                animation: $ctrl.animationsEnabled,
                ariaLabelledBy: 'modal-title',
                ariaDescribedBy: 'modal-body',
                templateUrl: '/pmodule/templates/confirm_overwrite_test.html',
                controller: 'MainCtrl',
                scope: $scope,
                backdrop: 'static',
                keyboard: false,
                appendTo: parentElem
            });

            /*console.log("modal loaded");*/
        };

        $scope.validate_coach_id_and_password = (coach_id, password) => {
            if (coach_id.length <= 5 && md5.createHash(password) == $scope.testSubmitPassword) {
                $scope.wrongPassword = false;
                $scope.wrongCoachID = false;

                /*If the username and password are valid, check if the test submitted already exists*/
                $scope.check_reponse_before_submit()
            } else if (coach_id.length > 5) {
                $scope.wrongCoachID = true;
                console.log('Invalid coach ID');
            } else if (md5.createHash(password) != $scope.testSubmitPassword) {
                $scope.wrongPassword = true;
                console.log('Wrong password');
            } else {
                $scope.wrongPassword = true;
                $scope.wrongCoachID = true;
            }
        };

        /*Helper functions to check for duplicated tests*/
        /*i.e same learner has done the same test on the same day*/
        /*function to concatenate the properities of the a single response object which we need to check for duplicates*/
        /*the default properites used are - user_id  course module test_date*/
        /*this can be overidden with an any array of properties that the testResponse object contains*/
        function concat_props(response, response_props) {
            response_props = (typeof response_props !== 'undefined') ? response_props : ["user_id", "test", "course", "module", "test_date"];
            var response_concat = ""
            for (var i in response_props) {
                response_concat = response_concat.concat(response[response_props[i]])
            }

            return response_concat
        };

        /*turn the list of response objects into a list of strings of concatenated values*/
        const get_responses_concat_list = (responses) => {
            /*initialize empty array to hold list of concatenated props for each already existing response*/
            responses_list = []
            /*TODO: Use array instead of direct string comparison in case other courses need this functionality*/
            /*For each response, get the response props*/
            for (var i in responses) {
                /*Get the responses concat list with only the props needed for the tests*/
                var response_cat = concat_props(responses[i])
                /*push string of concatenated props into the array defined at the beginning of the function*/
                responses_list.push(response_cat)
            }
            /*return the list of concatenated props for all existing tests*/
            return responses_list
        };

        const check_response_already_exists = (testResponse) => {
            /*Same logic as get_responses_concat_list, but applied to the current test being submitted*/
            /*The concatenated props of the current test are compared to the list of concatenated props for all existing tests*/

            var testResponse_concat = concat_props(testResponse)

            /*check if the response submitted exists in list of existing responses*/
            if ($scope.existingResponses.indexOf(testResponse_concat) >= 0) {
                /*if the response already exists, open the confirm submit dialog*/
                $ctrl.openConfirmSubmitModal()
            } else {
                /*if the response does not exist, submit it*/
                $scope.submit()
            }
        }

        $scope.check_reponse_before_submit = () => {
            /*Get user_id of user that filled in the test, from the users array*/
            let currentUser = $scope.users.find(user => { return user.username == $scope.testResponse.username })

            /*add the user_id as an attribute to the testResponse object*/
            $scope.testResponse.user_id = currentUser.user_id

            /*set the test date of the response to the server date*/
            $scope.testResponse.test_date = $scope.serverDate

            /*check if the response already exists*/
            check_response_already_exists($scope.testResponse)
        }

        /*function to return the first name and last name of a user when they have entered their username on the test*/
        $scope.display_username = () => {
            if ($scope.testResponse.username) {
                let currentUser = $scope.users.find(user => { return user.username == $scope.testResponse.username })
                return currentUser.first_name + ' ' + currentUser.last_name
            }
        }


        /*Test submission function*/
        $scope.submit = () => {
            $http.post("/api/submit_test", $scope.testResponse).then(success =>
                /*redirect to sucessful submission page*/
                window.location = '/api/sucessful_submit')
        }

        /*Test submission function*/
        $scope.overwrite_test = () => {
            $http.post("/api/overwrite_test", $scope.testResponse).then(res => {
                /*redirect to sucessful submission page*/
                if (res.status == 200) {
                    console.log('Recieved status of 200')
                    $scope.submit()
                }
            });
        }


        /*Wait 1000 miliseconds before checking for changes to the username input*/
        /*This is to allow the DOM to load and scope to be defined*/
        $timeout(() => {
            /*Watch the username input until it is valid*/
            $scope.$watch('form.testForm.username.$error.whitelist', () => {

                if (!$scope.form.testForm.username.$error.whitelist) {
                    /*console.log('username:', $scope.form.testForm.username)*/
                    /*$scope.form.testForm.username.$setPristine()*/
                    let currentUser = $scope.users.find(user => { return user.username == $scope.testResponse.username })
                    /*var currentTest = { $scope.testResponse.test, $scope.testResponse.course, $scope.testResponse.course }*/
                    /*Get the test, course and module of the testResponse object as an object*/
                    let currentTest = (({ test, course, module }) => ({ test, course, module }))($scope.testResponse)

                    /*Variable that determines whether or not the loading spinner is visible on the front end*/
                    $scope.testcheck_loading = true;
                    /*Send request to api to check if the user is elligible to write the test that they are on
                     */
                    $http.get('/api/user_testcheck', {
                        /*send the user_id, test , course and module as request params*/
                        params: { user_id: currentUser.user_id, test: currentTest.test, course: currentTest.course, module: currentTest.module }
                    }).then(function onSuccess(response) {
                        /*store the response in $scope.testcheck variable*/
                        $scope.testcheck = response.data;
                        if ($scope.testcheck.can_write_test) {

                            /*If the user CAN write the test
                            Make testcheck_result valid*/
                            $scope.form.testForm.testcheck_result.$setValidity("testcheck_result", true)
                        } else {

                            /*If the user CANNOT write the test
                            Make testcheck_result invalid*/
                            /*$scope.form.testForm.testcheck_result.$valid = false;*/
                            $scope.form.testForm.testcheck_result.$setValidity("testcheck_result", false)
                        }

                    }).catch(function onReject(errorResponse) {
                        /*Log any errors to the console*/
                        console.log(errorResponse.status);
                    }).finally(function() {
                        $scope.testcheck_loading = false;
                    });
                } else {
                    console.log("Username is not valid.")
                }

            }, true);

        }, 1000)






        /*end MainCtrl*/


    })
    /*Controller for password modal*/
    .controller('ModalInstanceCtrl', function($scope, $uibModalInstance, md5) {
        $scope.coachPassword = "fc49a594c8d54de357ad7b5f2addab9f";
        $scope.wrongPassword = false;

        var $PasswordModalCtrl = this;


        $PasswordModalCtrl.cancel = function() {
            $uibModalInstance.dismiss();
        };

        $PasswordModalCtrl.checkPassword = function(password) {
            if (md5.createHash(password) == $scope.coachPassword) {
                $scope.wrongPassword = false;
                $uibModalInstance.dismiss();
            } else {
                $scope.wrongPassword = true;
            }
        };


        /*end ModalInstanceCtrl*/
    })
    /*Element directive for username input partial
    Better than using ng-include because problems with relative paths are avoided
    And can take advantage of other features of directives like isolated scope if needed*/
    .directive('usernameinput', function() {
        return {
            restrict: 'E',
            templateUrl: "/pmodule/templates/username_input.html"
        };
    })
    /*Element directive for coach section*/
    .directive('coachsection', function() {
        return {
            restrict: 'E',
            templateUrl: "/pmodule/templates/validate_coach_id_and_password.html"
        };
    })
    /*Element directive for gr7 exam number input */
    .directive('gr7numberinput', function() {
        return {
            restrict: 'E',
            templateUrl: "/pmodule/templates/gr7_exam_number.html"
        };
    })




    /*directive to invalidate the form based on student_id inputted*/
    .directive('whitelist', function() {
        return {
            require: 'ngModel',
            scope: true,
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
    })

    /*directive to capture the keypress of the Enter key*/
    .directive('pressEnter', function() {
        return function(scope, element, attrs) {
            element.bind("keydown keypress", function(event) {
                if (event.which === 13) {
                    scope.$apply(function() {
                        scope.$eval(attrs.pressEnter);
                    });

                    event.preventDefault();
                }
            });
        };
    })
    /*Directive to check if user input is an integer. Used to validate grade 7 examination numbers*/
    .directive('integer', function() {
        return {
            require: 'ngModel',
            link: function(scope, elm, attrs, ctrl) {
                ctrl.$validators.integer = function(modelValue, viewValue) {
                    /*regular expression used to check if a grade 7 examination number is an integer*/
                    var INTEGER_REGEXP = /^-?\d+$/;

                    if (ctrl.$isEmpty(modelValue)) {
                        // consider empty models to be valid
                        return true;
                    }

                    if (INTEGER_REGEXP.test(viewValue)) {
                        // it is valid
                        return true;
                    }

                    // it is invalid
                    return false;
                };
            }
        };
    });