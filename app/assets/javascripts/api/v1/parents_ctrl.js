(function() {
  "use strict";
  
  angular.module("app").controller("parentsCtrl", function($scope, $http) {
    $scope.total_investments = 0;
    $scope.setup = function(user_id) {
      $scope.current_user = user_id;
      $http.get("/api/v1/parents.json").then(function(response) {
        setParents(response);
      });
    };

    var setParents = function(response){
      $scope.parents = response.data;
        for (var i = 0; i < $scope.parents.length; i++) {
          if ($scope.parents[i].id === $scope.current_user) {
            $scope.current_parent = $scope.parents[i];
            $scope.first_name = $scope.current_parent.first_name;
            $scope.childrens_incomplete_tasks = $scope.current_parent.all_childrens_incomplete_tasks;
            $scope.tasks_needing_approval = $scope.current_parent.all_childrens_tasks_needing_approval;
            $scope.rewards_needing_approval = $scope.current_parent.all_rewards_needing_approval;
            $scope.children = $scope.current_parent.children;
          }
        }
      };

    $scope.toggleOrder = function(attribute) {
      $scope.orderAttribute = attribute;
      $scope.descending = !$scope.descending;
    };

    $scope.hoverIn=function() {
        this.hoverTask = true;
        this.hoverReward = true;
    };

    $scope.hoverOut=function() {
        this.hoverTask = false;
        this.hoverReward = false;
    };

    $scope.addTask=function(toDo, amountEarned, child){
      $http.post('api/v1/task/new.json', {child_id: child.id, to_do: toDo, amount_earned: amountEarned});
      $scope.to_do = null;
    };

    $scope.addReward=function(rewardDescription, amountCost, image, child){
      $http.post('api/v1/reward/new.json', {child_id: child.id, description: rewardDescription, image_url: image, amount_cost: amountCost});
      $scope.rewardDescription = null;
      $scope.amountCost = null;
      $scope.image = null;
    };

    $scope.approveTask=function(task_id){
      $http.patch('api/v1/parents/update_task/' + task_id + '.json', {
        status: "complete"
      }).success(function(response){
        for(var i = 0; i < $scope.tasks_needing_approval.length; i++){
          if(task_id === $scope.tasks_needing_approval[i].id){
            self.location.reload($scope.tasks_needing_approval);
          }
        }
      }).error(function(response){
        alert("ERROR");
      });
    };

    $scope.incompleteTask=function(task_id){
      $http.patch('api/v1/parents/update_task/' + task_id + '.json', {
        status: "incomplete"
      }).success(function(response){
        for(var i = 0; i < $scope.tasks_needing_approval.length; i++){
          if(task_id === $scope.tasks_needing_approval[i].id){
            self.location.reload($scope.tasks_needing_approval);
          }
        }
      }).error(function(response){
        alert("ERROR");
      });
    };

    $scope.approveOrder=function(reward_id){
      $http.patch('api/v1/parents/update_reward/' + reward_id + '.json', {
        status: "bought"
      }).success(function(response){
        for(var i = 0; i < $scope.rewards_needing_approval.length; i++){
          console.log("asdf");
          if(reward_id === $scope.rewards_needing_approval[i].id){
            self.location.reload($scope.rewards_needing_approval);
          }
        }
      }).error(function(response){
        alert("ERROR");
      });
    };

    $scope.cancelOrder=function(reward_id){
      $http.patch('api/v1/parents/update_reward/' + reward_id + '.json', {
        status: "not bought"
      }).success(function(response){
        for(var i = 0; i < $scope.rewards_needing_approval.length; i++){
          console.log("asdf");
          if(reward_id === $scope.rewards_needing_approval[i].id){
            self.location.reload($scope.rewards_needing_approval);
          }
        }
      }).error(function(response){
        alert("ERROR");
      });
    };


    $scope.addInterestRate=function(interestRate, child){
      $http.patch('api/v1/interest_rate.json', {child_id: child.id, interest_rate: interestRate});
      $scope.interest_rate = null;
    };

    window.scope = $scope;
  });
 
}());