class UserHistoriesController < ApplicationController

  def create_history_for_new_user(user)
    @user_history = UserHistory.new(
      activity_title: 'Created EnableID account',
      description: 'Account creation, time to fill in your particulars, seek verification from NGOs, and seek services and support!',
      activity_type: 'Account',
      user: user
    )
    @user_history.save
  end

  private

  def user_history_params
    params.require(:user_history).permit(:activity_title, :description, :activity_type)
  end
end
