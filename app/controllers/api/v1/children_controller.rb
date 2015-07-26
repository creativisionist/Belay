class Api::V1::ChildrenController < ApplicationController
  def index
    @children = User.where(role_id: 2)
  end
end
