class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = %i[admin moderator]

  has_many :pictures

  def admin?
    role && role == 'admin'
  end
end
