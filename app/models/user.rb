class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  #-----------Class methods------------
  def self.connections(auth, signed_in_resource=nil)
    User.where(provider: auth.provider, uid: auth.uid).first ||
      User.where(email: auth.info.email).first ||
      User.create(provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0,20])
  end
end
