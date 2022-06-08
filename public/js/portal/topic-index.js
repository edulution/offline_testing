angular.module('topicsIndex',['smart-table'])
.controller('mainCtrl', function($scope, $http){
	$scope.init = function() {

        /*placeholder value used in smart-table because users are loaded asynchorously*/
        $scope.topicCollection = [];

        $http.get("/api/index_of_topics").then(function(response) {
            $scope.topics = response.data;
            /*console.log($scope.topicCollection);*/
       	});
    }
});