class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         :confirmable

  ROLES = %i[admin moderator]

  def admin?
    role && role == 'admin'
  end
end
