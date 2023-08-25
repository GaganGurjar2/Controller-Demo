class SubscriptionsController < ApplicationController
	before_action :authenticate_user!

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      render json: @subscription, status: :created
    else
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:user_id, :course_id)
  end
end

