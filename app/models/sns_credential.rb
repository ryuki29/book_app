class SnsCredential < ApplicationRecord
  belongs_to :user

  validates :provider, presence: true,
                       inclusion: { in: %w[twitter] }
  validates :uid, presence: true

  def self.create_twitter_client(oauth_token, oauth_token_secret)
    client = Twitter::REST::Client.new do |config|
      config.access_token = oauth_token
      config.access_token_secret = oauth_token_secret
      config.consumer_key = Rails.application.credentials.twitter[:twitter_api_key]
      config.consumer_secret = Rails.application.credentials.twitter[:twitter_api_secret]
    end

    client
  end

end
