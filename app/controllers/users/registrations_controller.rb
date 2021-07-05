class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: %i[update destroy]

  def ensure_normal_user
    redirect_to root_path, alert: 'ゲストユーザーの更新・削除はできません' if resource.email == 'guest@example.com'
  end
end
