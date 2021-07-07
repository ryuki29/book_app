class Reviews::ActionPlansController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @plans = []
    @not_started_plans = []
    @completed_plans = []

    @reviews.each do |r|
      r.action_plan.progress == 0 ? @not_started_plans << r.action_plan : @completed_plans << r.action_plan
      @plans << r.action_plan
    end

    @remind_plans = []
    today = Date.current

    @not_started_plans.each do |nsp|
      @remind_plans << nsp if nsp.deadline - today < 7 && nsp.deadline - today >= 0
    end

    @plan_achievement_rate = (@completed_plans.count / @plans.count.to_f * 100).round(1)
  end

  def update
    @plan = ActionPlan.find(params[:id])
    progress = @plan.progress

    progress == 1 ? progress -= 1 : progress += 1

    @plan.update(progress: progress)
  end
end
