class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable, and :registerable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable  

  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :problem_types, :foreign_key => "owner_id"
  has_many :lessons, :foreign_key => "owner_id"
end
