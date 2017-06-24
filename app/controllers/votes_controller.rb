class VotesController < ApplicationController

  before_action :set_list

  def create
    @list.votes.where(user_id: current_user.id).first_or_create
    redirect_to user_list_path(@list, user_id: @list.user.id)
  end

  def destroy
    @list.votes.where(user_id: current_user.id).destroy_all
    redirect_to user_list_path(@list, user_id: @list.user.id)
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end
end
