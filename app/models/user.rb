class User < ActiveRecord::Base
  acts_as_token_authenticatable
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  #include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable
         
  def as_json(options={})
    {
      id: self.id,
      email: self.email
      #auth_token: self.auth_token
    }
  end       
  has_many :articles
end
