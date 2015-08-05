json.array! @parents.each do |parent|
  json.id parent.id
  json.first_name parent.first_name
  json.image_url parent.image_url

  json.children parent.children.each do |child|
    json.id child.id
    json.first_name child.first_name
    json.email child.email
    json.total_balance child.total_balance
    json.interest_rate child.interest_rate
    json.incomplete_tasks child.incomplete_tasks
    json.tasks_needing_approval child.child_tasks_needing_approval
    json.rewards_needing_approval child.child_rewards_needing_approval
    json.rewards_not_bought child.rewards_not_bought
  end

  json.all_childrens_incomplete_tasks parent.childrens_incomplete_tasks
  json.all_childrens_tasks_needing_approval parent.tasks_needing_approval

  json.all_tasks parent.tasks.each do |task|
    json.id task.id
    json.user_id task.user_id
    json.child_id task.child_id
    json.to_do task.to_do
    json.amount_earned task.amount_earned
    json.status task.status
  end

  json.all_rewards_needing_approval parent.rewards_needing_approval

  json.all_rewards parent.rewards.each do |reward|
    json.id reward.id
    json.user_id reward.user_id
    json.child_id reward.child_id
    json.child_id reward.child_id
    json.description reward.description
    json.image_url reward.image_url
    json.amount_cost reward.amount_cost
    json.status reward.status
  end
end
