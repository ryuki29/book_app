class Reviews::ActionPlansController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @plans = []
    @not_started_plans = []
    @completed_plans = []

    @reviews.each do |r|
      r.action_plans.each do |p|
        if p.plan?
          p.progress == 0 ? @not_started_plans << p : @completed_plans << p
          @plans << p
        end
      end
    end

    @remind_plans = []
    today = Date.today

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
