class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  def self.find_for_oauth(auth, signed_in_resource = nil)
   user = User.where(:email => auth.info.email).first if auth.info.email
      if user.nil?
        user = User.create(email: auth.info.email,password: Devise.friendly_token[0,20])
      end
   user
  end
end