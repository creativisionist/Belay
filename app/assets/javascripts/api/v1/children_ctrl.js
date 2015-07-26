(function() {
  "use strict";
 
  angular.module("app").controller("childrenCtrl", function($scope, $http) {
    $scope.setup = function() {
      $http.get("/api/v1/children.json").then(function(response) {
        $scope.children = response.data;
      });
    };
  });
 
}());