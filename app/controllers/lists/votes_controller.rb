class Lists::VotesController < ApplicationController

  before_action :set_list
  before_action :authenticate_user!

  def create
    @list.votes.where(user_id: current_user.id).first_or_create if current_user
    redirect_to user_lists_path(@list.user.id)
  end

  def destroy
    @list.votes.where(user_id: current_user.id).destroy_all if current_user
    redirect_to user_lists_path(@list.user.id)
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end
end
