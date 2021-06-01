class Reviews::ActionPlansController < ApplicationController
  def show
    user = User.find(params[:id])
    reviews = user.reviews
    @plans = []

    reviews.each do |r|
      r.action_plans.each do |p|
        if p.plan?
          @plans << p
          @review = r
        end
      end
    end
  end

  def update
    @plan = ActionPlan.find(params[:id])
    progress = @plan.progress

    if progress == 1
      progress -= 1
    else
      progress += 1
    end

    @plan.update(progress: progress)
  end
end
