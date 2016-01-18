class User < ActiveRecord::Base
  devise :omniauthable, :omniauth_providers => [ :google_oauth2 ]
  has_many :comments, dependent: :destroy

  def self.find_for_google_oauth2(auth, signed_in_resource=nil)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email    = auth.info.email
      user.name     = auth.info.name
    end
  end
end
