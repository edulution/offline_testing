angular.module('edulutionPortal', [])
.controller('MainCtrl', ['$scope', function ($scope) {
$scope.topics = ['Fractions','Fractions','Fractions','Fractions','Fractions','Fractions','Fractions','Fractions','Fractions','Fractions','Fractions','Fractions','Decimals','Decimals','Decimals','Decimals','Decimals','Decimals','Decimals','Decimals','Decimals','Decimals','Geometry','Geometry','Geometry','Geometry','Geometry','Geometry','Geometry','Geometry','Geometry','Geometry','Geometry','Geometry','Geometry','Factors and Multiples','Factors and Multiples','Factors and Multiples','Combined Operations','Combined Operations','Combined Operations'];
console.log($scope.topics);
}]);