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
            $scope.rewards_not_bought = $scope.current_parent.rewards_not_bought;
            $scope.children = $scope.current_parent.children;
          }
        }
      };

    $scope.toggleOrder = function(attribute) {
      $scope.orderAttribute = attribute;
      $scope.descending = !$scope.descending;
    };

    $scope.toggleTask = function(child){
      child.show = !child.show;     
    };

    $scope.addTask=function(toDo, amountEarned, child) {
      var task = {
        child_id: child.id,
        to_do: toDo, 
        amount_earned: amountEarned,
        status: "incomplete"
      };

      $http.post('api/v1/task/new.json', task);
      child.incomplete_tasks.push(task);
      $scope.toDo = null;
      $scope.amountEarned = null;
      $scope.myChild = null;
    };

    $scope.enableTaskEdit = function(task){
      task.enableEditor = true;
    };

    $scope.disableEditor = function(task) {
      task.enableEditor = false;
    };

    $scope.saveTask = function(task, toDo, amountEarned) {
      $http.patch('api/v1/parents/edit_task/' + task.id + '.json',{
        to_do: toDo,
        amount_earned: amountEarned
      }).success(function(response){
      });
      task.enableEditor = false;
    };

    $scope.toggleReward = function(child){
      child.show = !child.show;     
    };

    $scope.addReward=function(rewardDescription, amountCost, image, child){
      var reward = { 
        child_id: child.id,
        description: rewardDescription,
        image_url: image,
        amount_cost: amountCost,
        status: "not bought"
      };
      $http.post('api/v1/reward/new.json', reward);
      child.rewards_not_bought.push(reward);
      $scope.rewardDescription = null;
      $scope.amountCost = null;
      $scope.image = null;
      $scope.myChild = null;
    };

    $scope.enableRewardEdit = function(reward){
      reward.enableEditor = true;
    };

    $scope.disableEditor = function(reward) {
      reward.enableEditor = false;
    };

    $scope.saveReward = function(reward, description, amountCost, image) {
      $http.patch('api/v1/edit_reward/' + reward.id + '.json',{
        description: description,
        amount_cost: amountCost,
        image_url: image,
      }).success(function(response){
      });
      reward.enableEditor = false;
    };
    
    $scope.deleteReward = function(reward) {
      var reward_id = reward.id;
        for(var j=0; j < $scope.children.length; j++){
          for (var i=0; i < $scope.children[j].rewards_not_bought.length; i++){
            if (reward_id === $scope.children[j].rewards_not_bought[i].id) {
              $scope.children[j].rewards_not_bought.splice(i,1);
            }
          }
        }
      $http.delete('api/v1/reward/' + reward.id + '.json', {
      });
    };
      

    $scope.approveTask=function(task_id){
      $http.patch('api/v1/parents/update_task/' + task_id + '.json', {
        status: "complete"
      }).success(function(response){
        var task_id = response.id;
        for(var j=0; j < $scope.children.length; j++){
          for (var i=0; i < $scope.children[j].tasks_needing_approval.length; i++){
            if (task_id === $scope.children[j].tasks_needing_approval[i].id) {
              $scope.children[j].tasks_needing_approval.splice(i,1);
            }
          }
        }
      });
    };

    $scope.incompleteTask=function(task_id){
      $http.patch('api/v1/parents/update_task/' + task_id + '.json', {
        status: "incomplete"
      }).success(function(response){
        var task_id = response.id;
        for(var j=0; j < $scope.children.length; j++){
          for (var i=0; i < $scope.children[j].tasks_needing_approval.length; i++){
            if (task_id === $scope.children[j].tasks_needing_approval[i].id) {
              $scope.children[j].tasks_needing_approval.splice(i,1);
            }
          }
        }
      });
    };

    $scope.approveOrder=function(reward_id){
      $http.patch('api/v1/parents/update_reward/' + reward_id + '.json', {
        status: "bought"
      }).success(function(response){
        var reward_id = response.id;
        for(var j=0; j < $scope.children.length; j++){
          for (var i=0; i < $scope.children[j].rewards_needing_approval.length; i++){
            if (reward_id === $scope.children[j].rewards_needing_approval[i].id) {
              $scope.children[j].rewards_needing_approval.splice(i,1);
            }
          }
        }
      });
    };

    $scope.cancelOrder=function(reward_id){
      $http.patch('api/v1/parents/update_reward/' + reward_id + '.json', {
        status: "not bought"
      }).success(function(response){
        var reward_id = response.id;
        for(var j=0; j < $scope.children.length; j++){
          for (var i=0; i < $scope.children[j].rewards_needing_approval.length; i++){
            if (reward_id === $scope.children[j].rewards_needing_approval[i].id) {
              $scope.children[j].rewards_needing_approval.splice(i,1);
            }
          }
        }
      });
    };


    $scope.addInterestRate=function(interestRate, child){
      var childInterestRate = {
        child_id: child.id,
        interest_rate: interestRate
      };
      $http.patch('api/v1/interest_rate.json', childInterestRate);
      child.interest_rate = interestRate;
      $scope.interestRate = null;
      $scope.myChild = null;
    };

    window.scope = $scope;
  });
 
}());