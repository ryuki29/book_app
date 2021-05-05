class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers:[:twitter]

  has_many :sns_credentials, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :user_books, dependent: :destroy
  has_many :books, through: :user_books,
            dependent: :destroy

  has_one_attached :image

  def self.find_for_oauth(auth)
    sns_credentials = SnsCredential.where(uid: auth.uid, provider: auth.provider).first

    if sns_credentials.present?
      user = sns_credentials.user
    elsif auth.provider == 'twitter'
      user = User.create_user_with_twitter(auth)
    else
      user = User.where(email: auth.info.email).first
    end

    user
  end

  def self.create_user_with_twitter(auth)
    user = User.new(
      email: User.dummy_email(auth),
      username: auth.info.nickname,
      password: Devise.friendly_token[0, 20]
    )
    sns_credentials = SnsCredential.new(
      uid: auth.uid,
      provider: auth.provider,
      user: user
    )

    return user if user.save && sns_credentials.save
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

end
