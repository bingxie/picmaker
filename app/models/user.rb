class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = %w(admin moderator).freeze

  has_many :pictures

  def admin?
    role && role == 'admin'
  end
end
